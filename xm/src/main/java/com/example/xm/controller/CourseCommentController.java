package com.example.xm.controller;

import com.example.xm.common.Result;
import com.example.xm.entity.CourseComment;
import com.example.xm.entity.LikeRequest;
import com.example.xm.service.CourseCommentService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comments")
public class CourseCommentController {
    @Autowired
    private CourseCommentService commentService;

    @PostMapping
    public Result addComment(@RequestBody CourseComment comment) {
        commentService.addComment(comment);
        return Result.success();
    }

    @GetMapping("/course/{courseId}")
    public Result getComments(@PathVariable Long courseId) {
        return Result.success(commentService.getCommentsByCourseId(courseId));
    }

    @DeleteMapping("/{commentId}")
    public Result deleteComment(@PathVariable Long commentId, @RequestParam Long userId) {
        commentService.deleteComment(commentId, userId);
        return Result.success();
    }

    @PostMapping("/like")
    public Result likeComment(@RequestBody LikeRequest likeRequest) {
        try {
            return commentService.likeComment(likeRequest.getCommentId(), likeRequest.getUserId());
        } catch (Exception e) {
            // 如果发生异常，返回错误信息
            return Result.error("点赞失败");
        }
    }

    @GetMapping("/course/{courseId}/comments")
    public Result getPagedComments(
            @PathVariable Long courseId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {

        PageInfo<CourseComment> pageInfo = commentService.getPagedComments(courseId, pageNum, pageSize);
        return Result.success(pageInfo);
    }

    @PostMapping("/reply")
    public Result replyComment(@RequestBody CourseComment reply) {
        commentService.addComment(reply);  // 复用添加评论逻辑
        return Result.success();
    }

}
