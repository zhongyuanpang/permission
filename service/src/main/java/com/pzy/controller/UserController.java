package com.pzy.controller;


import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.lang.UUID;
import cn.hutool.crypto.SecureUtil;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.pzy.common.core.domain.model.LoginTbBody;
import com.pzy.common.core.domain.model.RegisterTbBody;
import com.pzy.dto.UserDto;
import com.pzy.entity.Blog;
import com.pzy.entity.User;
import com.pzy.service.BlogService;
import com.pzy.service.UserService;
import com.pzy.utils.*;

import com.pzy.utils.email.EmailSendUtil;
import com.pzy.utils.uuid.IdUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author nice
 * @since 2021-07-07
 */
@RestController
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;

    @Autowired
    private BlogService blogService;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private EmailSendUtil emailSendUtil;

    @Autowired
    private RedisUtil redisUtill;

    /**
     * @author : pangzy
     * @date : 2021/7/3 14:02
     * @return : java.lang.Object
     * 发送邮箱验证码
     */
    @PostMapping(value = "/sendCode")
    public Result sendEmail(@RequestParam("email") String receiver) {
        User user = userService.getOne(new QueryWrapper<User>().eq("username", receiver));
        if(user!=null){
            return Result.fail("该邮箱已注册");
        }else {
            String code = CodeGenerateUtil.generateVerCode();
            redisUtill.set(receiver,code,5000);
            try {
                // 调用发送邮件
                emailSendUtil.sendEmailVerCode(receiver, code);
                return Result.succ("code发送成功");
            } catch (Exception e) {
                return Result.fail("验证码发送失败");
            }
        }
    }

    /**
     * @author : pangzy
     * @date : 2021/7/3 14:02
     * @return : com.pzy.util.Result
     * 用户注册传来得code码比对，正确的话则注册成功，否则验证码错误，
     * 并判断用户是否存在，
     */
    @PostMapping("/register")
    public Result register(@RequestBody RegisterTbBody registerTbBody, User user){
//        User username = userService.getOne(new QueryWrapper<User>().eq("username", registerTbBody.getUsername()));
        // 判断验证码是否正确
        if(redisUtill.get(registerTbBody.getUsername()).equals(registerTbBody.getCode())){
            user.setUserId(IdUtils.fastUUID());
            user.setUsername(registerTbBody.getUsername());
            user.setNickname(registerTbBody.getNickname());
            user.setPassword(SecurityUtils.encryptPassword(registerTbBody.getPassword()));
            //默认背景图片
            user.setEmail(registerTbBody.getUsername());
            user.setBackground("http://p8.qhimg.com/bdm/1024_768_85/t01a9e376952238ea53.jpg");
            // 判断邮箱是否为qq邮箱，设置用户头像为qq头像
            if (registerTbBody.getUsername().trim().toLowerCase().contains("@qq.com")){
                String regEx = "[^0-9]";
                Pattern p = Pattern.compile(regEx);
                Matcher m = p.matcher(registerTbBody.getUsername());
                user.setAvatar("http://q1.qlogo.cn/g?b=qq&nk="+m.replaceAll("").trim()+"&s=100");
            }
            boolean save = userService.save(user);
            if(!save){
                return Result.fail("注册失败!");
            }
            return Result.succ("注册成功");
        }else{
            return Result.fail("验证码错误!");
        }
    }

    /**
     * @author : pangzy
     * @date : 2021/7/6 18:22
     * @return : com.pzy.util.Result
     * 用户登录，判断用户是否已存在及密码是否正确
     */
    @PostMapping("/login")
    public Result login(@RequestBody LoginTbBody loginTbBody, HttpServletResponse response){
        User user = userService.getOne(new QueryWrapper<User>().eq("username", loginTbBody.getUsername()));
        if (user != null){
            if(SecurityUtils.matchesPassword(loginTbBody.getPassword(),user.getPassword())){
                UserDto userDto = new UserDto();
                //将user的复值给UserDto一样的字段
                BeanUtils.copyProperties(user,userDto);
//                System.out.println(JSON);
                String jwt = jwtUtil.generateToken(userDto);
                response.setHeader("Authorization",jwt);
                response.setHeader("Access-control-Expose-Headers","Authorization");
//                //UserDto 用来存储返回给前端的部分信息，不包含重要信息
                return Result.succ(200,"登录成功",jwt);
            }else {
                return Result.fail("密码不正确");
            }
        }else{
            return Result.fail("该用户不存在");
        }
    }
//
//
///**
// * @author : pangzy
// * @date : 2021/7/8 18:03
// * @return : com.pzy.util.Result
// * 退出登录
// */
//    //该注解作用为，必须登录才能进行访问
//    @RequiresAuthentication
//    @GetMapping("/logout")
//    public Result logout(){
//        SecurityUtils.getSubject().logout();
//        return Result.succ(null);
//    }


    @GetMapping("/getUser/{id}")
    public Result getUser(@PathVariable String id){
        System.out.println(id);
        User user = userService.getById(id);
        System.out.println(user);
        return Result.succ(user);
    }


    @PostMapping("/save")
    public Result save(@Validated @RequestBody User user){
        return Result.succ(user);
    }

/**
 * @author : pangzy
 * @date : 2021/8/18 17:00
 * @return : com.pzy.util.Result
 * 修改个人页面背景图片
 */
    @GetMapping("/editBG")
    public Result editBG(@RequestParam("bg") String bg,@RequestParam("id") String id){
        UpdateWrapper<User> wrapper = new UpdateWrapper<>();
        wrapper.eq("id",id).set("background",bg);
        boolean result = userService.update(null,wrapper);
        if (result){
            User user= userService.getById(id);
            return Result.succ(200,"更新成功",user);
        }else{
            return Result.fail("更新失败");
        }
    }

/**
 * @author : pangzy
 * @date : 2021/8/23 14:39
 * @return : com.pzy.util.Result
 * 根据ID获取用户基本信息
 */
    @GetMapping("/getUserBaseInfo/{userId}")
    public Result getUserBaseInfo(@PathVariable String userId){
        System.out.println(userId+"userid");
        JSONObject result = new JSONObject();
        User user = userService.getOne(new QueryWrapper<User>().eq("user_id",userId));
//        UserDto userDto = new UserDto();
//        BeanUtil.copyProperties(user,userDto);
        Integer count = blogService.count(new QueryWrapper<Blog>().eq("user_id",userId));
        result.put("user",user);
        result.put("blogCount",count);
        System.out.println(result+"/////////////////////////");
        return Result.succ(result);
    }
/**
 * @author : pangzy
 * @date : 2021/10/14 16:21
 * @return : com.pzy.util.Result
 * 根据ID获取用户作品 已发布及草稿
 */
    public Result getUserWorks(@RequestParam("uid") String id){
        JSONObject result = new JSONObject();
//        QueryWrapper wrapper =


        return Result.succ("");
    }

}
