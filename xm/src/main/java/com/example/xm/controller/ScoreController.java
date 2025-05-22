package com.example.xm.controller;


import com.example.xm.common.Result;
import com.example.xm.entity.Answer;
import com.example.xm.entity.Score;
import com.example.xm.entity.TestPaper;
import com.example.xm.service.ScoreService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 试卷信息前端请求接口
 */
@RestController
@RequestMapping("/score")
public class ScoreController {

    @Resource
    private ScoreService scoreService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody TestPaper testPaper) {
        scoreService.add(testPaper);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result update(@RequestBody Score score) {
        scoreService.updateById(score);
        return Result.success();
    }

    /**
     * 单个删除
     */
    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        scoreService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除
     */
    @DeleteMapping("/delete/batch")
    public Result delete(@RequestBody List<Integer> ids) {
        scoreService.deleteBatch(ids);
        return Result.success();
    }

    /**
     * 单个查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Score score = scoreService.selectById(id);
        return Result.success(score);
    }
    @GetMapping("/selectAnswer/{id}")
    public Result selectAnswer(@PathVariable Integer id) {
        List<Answer> list = scoreService.selectAnswer(id);
        return Result.success(list);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Score score) {
        List<Score> list = scoreService.selectAll(score);
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Score score,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Score> pageInfo = scoreService.selectPage(score, pageNum, pageSize);
        return Result.success(pageInfo);
    }

}
