package com.example.xm.controller;


import com.example.xm.common.Result;
import com.example.xm.entity.QuestionType;
import com.example.xm.service.QuestionTypeService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 题型信息前端请求接口
 */
@RestController
@RequestMapping("/questionType")
public class QuestionTypeController {
/*对应的注解增删改查也是不一样的，注意对应的参数里的注解也是不一样的对象的话就是@RequestBody，变量就是@PathVariable，统一的类型Result，返回的参数也是不一样的Result，如果是查询返回数据就是里面有东西*/
    @Resource
    private QuestionTypeService questionTypeService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody QuestionType questionType) {
        questionTypeService.add(questionType);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody QuestionType questionType) {
        questionTypeService.updateById(questionType);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        questionTypeService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        questionTypeService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        QuestionType questionType = questionTypeService.selectById(id);
        return Result.success(questionType);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(QuestionType questionType) {
        List<QuestionType> list = questionTypeService.selectAll(questionType);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(QuestionType questionType,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<QuestionType> pageInfo = questionTypeService.selectPage(questionType, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
