package com.pzy.common.core.domain.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.pzy.common.core.domain.model.LoginUser;
import com.pzy.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;

public class BaseController {

    @Autowired
    HttpServletRequest req;

    /**
     * 获取页面
     * @return
     */
    public Page getPage() {
        int current = ServletRequestUtils.getIntParameter(req, "pageNum", 1);
        int size = ServletRequestUtils.getIntParameter(req, "pageSize", 10);

        return new Page(current, size);
    }


    /**
     * 获取用户缓存信息
     */
    public LoginUser getLoginUser()
    {
        return SecurityUtils.getLoginUser();
    }

    /**
     * 获取登录用户id
     */
    public Long getUserId()
    {
        return getLoginUser().getId();
    }

    /**
     * 获取登录用户名
     */
    public String getUsername()
    {
        return getLoginUser().getUsername();
    }
}
