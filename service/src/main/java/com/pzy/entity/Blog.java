package com.pzy.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author nice
 * @since 2021-07-07
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("tb_blog")
public class Blog implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 博客id
     */
    @TableId(value = "blog_id" ,type = IdType.AUTO)
    private Long blogId;

    /**
     * 博客标题
     */
    private String title;

    /**
     * 博客内容
     */
    private String content;

    /**
     * 博客创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 博客修改时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 博客浏览数
     */
    private Integer views;

    /**
     * 点赞次数
     */
    private Long clickLike;

    /**
     * 发表博客描述
     */
    private String description;

    /**
     * 是否公开博客(1:为公开、0：私密)
     */
    private int published;

    /**
     * 博客题材（翻译 / 转载 / 原创）
     */
    private String flag;

    /**
     * 外键分类表
     */
    private Long typeId;

    /**
     * 外键用户表
     */
    @TableField("user_id")
    private String userId;

    /**
     * 外键标签表
     */
    private Long tagId;

    /**
     * 文章状态 1: 发布 0：保存
     */
    private int status;


    /**
     * 博客首图
     */
    private String cover;

    @TableField(exist = false)
    User user;

}
