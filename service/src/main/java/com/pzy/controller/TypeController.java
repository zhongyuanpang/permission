package com.pzy.controller;


import com.pzy.entity.BlogVO;
import com.pzy.entity.Type;
import com.pzy.service.TypeService;
import com.pzy.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author nice
 * @since 2021-07-07
 */
@RestController
@RequestMapping("/type")
public class TypeController {

    @Autowired
    private TypeService typeService;

/**
 * @author : pangzy
 * @date : 2021/8/23 10:40
 * @return : com.pzy.util.Result
 * 分类列表
 */
    @GetMapping("/getTypes")
    public Result getTypes(){
        List<Type> type = typeService.list();
        return Result.succ(type);
    }
/**
 * @author : pangzy
 * @date : 2021/8/23 10:40
 * @return : com.pzy.util.Result
 * 新增分类
 */
    @PatchMapping("/addTypes")
    public Result addTypes(@RequestParam("name") String name , @RequestParam("icon") String icon,Type type){
        System.out.println(name + "  " + icon + " ");
        System.out.println(type);
        typeService.save(type);
        return Result.succ("保存成功");
    }

/**
 * @author : pangzy
 * @date : 2021/8/23 10:42
 * @return : com.pzy.util.Result
 * 根据id查找分类所包含的所有文章
 */
    @GetMapping("/getTypesById")
    public Result getTypesById(@RequestParam("id") Long id){
        System.out.println(id);
        List<BlogVO> list = typeService.getTypesById(id);
        return Result.succ(list);
    }

}
