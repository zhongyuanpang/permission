package com.pzy.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.pzy.entity.Blog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.pzy.entity.BlogVO;

/**
 * <p>
 *  服务类
 * </p>
 * @author nice
 * @since 2021-07-07
 */
public interface BlogService extends IService<Blog> {

    Page<Blog> ShowHomeBlogList(Page<Blog> page);

    Blog getBlogById(Long blogId);
}
