package com.pzy.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.http.HttpUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.pzy.common.core.domain.controller.BaseController;
import com.pzy.entity.Blog;
import com.pzy.entity.BlogVO;
import com.pzy.mapper.BlogMapper;
import com.pzy.mapper.UserMapper;
import com.pzy.service.BlogService;
import com.pzy.service.TagService;
import com.pzy.utils.MarkDownUtils;
import com.pzy.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.pzy.utils.UploadGiteeImgBed;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author nice
 * @since 2021-07-07
 */
@RestController
@RequestMapping("/blog")
public class BlogController extends BaseController {

    @Autowired
        private BlogService blogService;

    @Autowired
    private TagService tagService;

    @Autowired(required = false)
    private BlogMapper blogMapper;

    @Autowired(required = false)
    private UserMapper userMapper;

    @PostMapping("/saveBlog")
    public Result saveBlog(@Validated @RequestBody Blog blog){
        System.out.println(blog);
        blogService.save(blog);
        return Result.succ("发表成功");
    }

    /**
     * @author : pangzy
     * @date : 2021/8/16 17:41
     * @return : com.pzy.util.Result
     * 主页推荐列表
     */
    @GetMapping("/blogs")
    public Result blogList() {
        Page<Blog> list = blogService.ShowHomeBlogList(getPage());

        return Result.succ(list);
    }

    /**
     * 根据ID获取对应博客
     * */
    @GetMapping("/getBlog/{blogId}")
    public Result getBlogById(@PathVariable Long blogId){
        Blog blog = blogService.getBlogById(blogId);
        blog.setContent(MarkDownUtils.markdownToHtmlExtensions(blog.getContent()));
        return Result.succ(blog);
    }

/**
* @author : pangzy
* @date : 2021/9/16 13:33
* @return : com.pzy.util.Result
* 删除博客 Long id（博客ID）
*/
    @GetMapping("/deleteBlog")
    public Result deleteBlog(@RequestParam("id") Long id){
        boolean b = blogService.removeById(id);
        if(b){
            System.out.println("删除成功");
        }else{
            System.out.println("删除失败");
        }
        return Result.succ("");
    }

    /**
     * @author : pangzy
     * @date : 2021/9/16 13:34
     * @return : com.pzy.util.Result
     * 博客详情
     */
    @GetMapping("/detail")
    public Result detail(@RequestParam("id") String id){
        Blog blog = blogService.getOne(new QueryWrapper<Blog>().eq("id",id));
        Blog b = new Blog();
        BeanUtil.copyProperties(blog,b);
        String content = b.getContent();
        b.setContent(MarkDownUtils.markdownToHtmlExtensions(content));
        return Result.succ(b);
    }

/**
 * @author : pangzy
 * @date : 2021/9/16 13:38
 * @return : com.pzy.util.Result
 * 博客图片上传
 */
    @PostMapping("/uploadImg")
//    @CrossOrigin(origins = {"*","null"})
    public Result upload(@RequestParam("files") MultipartFile file) throws IOException {
        String originalFilname = file.getOriginalFilename();
        if (originalFilname == null){
            System.out.println("上传文件为空");
        }
        //创建新的路径
        String targetURL = UploadGiteeImgBed.createUploadFileUrl(originalFilname);

        //请求体封装
        Map<String, Object> uploadBodyMap = UploadGiteeImgBed.getUploadBodyMap(file.getBytes());
        //借助HttpUtil工具类发送POST请求
        String JSONResult = HttpUtil.post(targetURL, uploadBodyMap);
        //解析响应JSON字符串
        JSONObject jsonObj = JSONUtil.parseObj(JSONResult);
//        cn.hutool.json.JSONObject jsonObj = JSONUtil.parseObj(JSONResult);

        JSONObject content = JSONUtil.parseObj(jsonObj.getObj("content"));
//        cn.hutool.json.JSONObject content = JSONUtil.parseObj(jsonObj.getObj("content"));

        String url = (String) content.getObj("download_url");
        return Result.succ(content.getObj("download_url"));
    }
}


