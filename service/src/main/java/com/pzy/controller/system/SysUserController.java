package com.pzy.controller.system;


import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.pzy.common.constant.UserConstants;
import com.pzy.common.core.domain.controller.BaseController;
import com.pzy.entity.SysRole;
import com.pzy.entity.SysUser;
import com.pzy.entity.SysUserRole;
import com.pzy.service.SysRoleService;
import com.pzy.service.SysUserRoleService;
import com.pzy.service.SysUserService;
import com.pzy.utils.Result;
import com.pzy.utils.SecurityUtils;
import com.pzy.utils.StringUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author pzy
 * @since 2022-01-21
 */
@RestController
@RequestMapping("/system/user")
public class SysUserController extends BaseController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysRoleService rolesService;

    @Autowired
    private SysUserRoleService userRoleService;

    /**
     * @param
     * @return 获取全部管理员
     * @author pzy
     * <br/>date 2021-11-01
     */
    @GetMapping("/list")
    public Result getAdminList(String username, String email, String statu) {

        Page<SysUser> pageData = sysUserService.page(getPage(), new QueryWrapper<SysUser>()
                .like(StrUtil.isNotBlank(username), "username", username)
                .like(StrUtil.isNotBlank(email), "email", email)
                .like(StrUtil.isNotBlank(statu), "statu", statu));

        pageData.getRecords().forEach(u -> {
            u.setRoles(rolesService.listRolesByUserId(u.getUserId()));
        });
        return Result.succ(pageData);
    }

    /**
     * 根据用户编号获取详细信息
     */
    @GetMapping(value = {"/", "/{userId}"})
    public Result getInfo(@PathVariable(value = "userId", required = false) Long userId) {
//        userService.checkUserDataScope(userId);
        Map<String, Object> ajax = new HashMap<>();
        List<SysRole> roles = rolesService.list(new QueryWrapper<SysRole>().eq("status", "0"));
        ajax.put("roles", SysUser.isAdmin(userId) ? roles : roles.stream().filter(r -> !r.isAdmin()).collect(Collectors.toList()));
        if (StringUtils.isNotNull(userId)) {
            ajax.put("data", sysUserService.selectUserById(userId));
            ajax.put("roleIds", rolesService.selectRoleListByUserId(userId));
        }
        return Result.succ(ajax);
    }

    /**
     * 新增用户
     */
    @PostMapping("/add")
    @PreAuthorize("@ss.hasAnyPermi('system:user:add')")
    public Result add(@RequestBody SysUser user) {
        System.out.println(user);
        if (UserConstants.NOT_UNIQUE.equals(sysUserService.checkUserNameUnique(user.getUserName()))) {
            return Result.fail("新增用户'" + user.getUserName() + "'失败，登录账号已存在");
        } else if (StringUtils.isNotEmpty(user.getEmail())
                && UserConstants.NOT_UNIQUE.equals(sysUserService.checkEmailUnique(user))) {
            return Result.fail("新增用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        user.setAvatar(UserConstants.DEFULT_AVATAR);
        // 保存用户
        boolean saveUser = sysUserService.save(user);
        if (saveUser) {
            Long userId = user.getUserId();
            List<Long> roleIds = Arrays.asList(user.getRoleIds());
            List<SysUserRole> list = new ArrayList<SysUserRole>();
            for (Long roleId : roleIds) {
                SysUserRole ur = new SysUserRole();
                ur.setUserId(userId);
                ur.setRoleId(roleId);
                list.add(ur);
            }
            //执行批量插入
            if (list.size() > 0) {
                userRoleService.saveBatch(list);
            }
            return Result.succ("");
        }
        return Result.fail("");
    }

    /**
     * 修改用户
     */

    @PutMapping("/update")
    @PreAuthorize("@ss.hasAnyPermi('system:user:edit')")
    public Result edit(@Validated @RequestBody SysUser user) {
        if (StringUtils.isNotEmpty(user.getEmail()) && UserConstants.NOT_UNIQUE.equals(sysUserService.checkEmailUnique(user))) {
            return Result.fail("修改用户'" + user.getUserName() + "'失败，邮箱账号已存在");
        }
        // 删除用户角色表
        userRoleService.remove(new QueryWrapper<SysUserRole>().eq("user_id", user.getUserId()));
        // 执行更新
        boolean b = sysUserService.updateById(user);
        if (b) {
            Long userId = user.getUserId();
            List<Long> roleIds = Arrays.asList(user.getRoleIds());
            List<SysUserRole> list = new ArrayList<SysUserRole>();
            for (Long roleId : roleIds) {
                SysUserRole ur = new SysUserRole();
                ur.setUserId(userId);
                ur.setRoleId(roleId);
                list.add(ur);
            }
            //执行批量插入
            if (list.size() > 0) {
                userRoleService.saveBatch(list);
            }
            return Result.succ("");
        }
        return Result.fail("");
    }

    /**
     * @param ids
     * @return 单个或者批量删除
     * @author pzy
     * <br/>date 2021-11-01
     */
    @PostMapping("/delete")
    @PreAuthorize("@ss.hasAnyPermi('system:user:remove')")
    public Result deleteAdmin(@RequestBody Long[] ids) {
        if (ArrayUtils.contains(ids, 1L)) {
            return Result.fail("不可删除管理员");
        }
        boolean del = sysUserService.removeByIds(Arrays.asList(ids));
        userRoleService.remove(new QueryWrapper<SysUserRole>().in("user_id", ids));
        if (!del) {
            return Result.fail("删除失败");
        } else {
            return Result.succ("删除成功");
        }
    }

    /**
     * 重置密码
     */
    @PutMapping("/resetPwd")
    @PreAuthorize("@ss.hasAnyPermi('system:user:resetPwd')")
    public Result resetPwd(@RequestBody SysUser user) {
        sysUserService.checkUserAllowed(user);
        user.setPassword(SecurityUtils.encryptPassword(user.getPassword()));
        sysUserService.updateById(user);
        return Result.succ("");
    }

    /**
     * 状态修改
     */
    @PutMapping("/changeStatus")
    @PreAuthorize("@ss.hasAnyPermi('system:user:changeStatus')")
    public Result changeStatus(@RequestBody SysUser user) {
        sysUserService.checkUserAllowed(user);
        user.setStatus(user.getStatus());
        sysUserService.updateById(user);
        return Result.succ("");
    }
}
