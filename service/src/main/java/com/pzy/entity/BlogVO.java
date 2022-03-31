package com.pzy.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;
import java.util.Date;

/**
 * @Author Nice
 * @Date 2021/8/17 15:31
 */
@Data
public class BlogVO{

    private String id;

    private String title;

    private String content;

    private Date createTime;

    private Date updateTime;

    private Integer views;

    private Long clickLike;

    private String description;

    private Integer published;

    private String flag;

    private Long typeId;

    @TableField("user_id")
    private String userId;

    private Long tagId;

    private Integer status;

    private Long comments;

    private String firstPicture;

//    @TableField(exist = false)
    private String nickname;

//    @TableField(exist = false)
    private String avatar;



}
