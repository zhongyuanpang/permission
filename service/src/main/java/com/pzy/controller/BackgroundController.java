package com.pzy.controller;

import com.pzy.utils.RandomBgUtils;
import com.pzy.utils.Result;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author Nice
 * @Date 2021/8/14 8:56
 */
@RestController
public class BackgroundController {
    @GetMapping("/getBC")
    public Result getBC(){
        String imgUrl = RandomBgUtils.randomBackground();
        return Result.succ(200,"操作成功",imgUrl);
    }
}
