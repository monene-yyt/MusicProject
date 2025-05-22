package com.example.xm.service;

import com.example.xm.common.Result;
import com.example.xm.entity.CommentLike;
import com.example.xm.entity.CourseComment;
import com.example.xm.mapper.CommentLikeMapper;
import com.example.xm.mapper.CourseCommentMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.yaml.snakeyaml.tokens.CommentToken;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CourseCommentService {

    @Autowired
    private AdminService adminService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private TeacherService teacherService;
    @Autowired
    private CourseCommentMapper courseCommentMapper;

    @Autowired
    private CommentLikeMapper commentLikeMapper;

    public void addComment(CourseComment comment) {
        comment.setLikeCount(0);
        courseCommentMapper.insertComment(comment);
    }

    public List getCommentsByCourseId(Long courseId) {
        return courseCommentMapper.getCommentsByCourseId(courseId);
    }

    public void deleteComment(Long commentId, Long userId) {
        CourseComment comment = courseCommentMapper.getCommentById(commentId);
        if (comment != null && comment.getUserId().equals(userId)) {
            courseCommentMapper.deleteComment(commentId, userId);
        }
    }

    public Result likeComment(Long commentId, Long userId) {
        if (!commentLikeMapper.existsByCommentIdAndUserId(commentId, userId)) {
            commentLikeMapper.insertLike(new CommentLike(null, commentId, userId, LocalDateTime.now()));
            //评论的点赞数加1
            courseCommentMapper.incrementLike(commentId);
            return  Result.success("点赞成功");
        }else{
            return Result.error("您已经点过赞啦！");
        }
    }

    public PageInfo<CourseComment> getPagedComments(Long courseId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        // 获取一级评论
        List<CourseComment> comments = courseCommentMapper.getPagedCommentsByCourseId(courseId);
        for (CourseComment comment : comments) {
            Long userId = comment.getUserId();

            // 设置头像
            switch (comment.getRole()) {
                case "STUDENT":
                    comment.setAvatar(studentService.selectById(userId.intValue()).getAvatar());
                    break;
                case "TEACHER":
                    comment.setAvatar(teacherService.selectById(userId.intValue()).getAvatar());
                    break;
                case "ADMIN":
                    comment.setAvatar(adminService.selectById(userId.intValue()).getAvatar());
                    break;
            }

            // 设置子评论（非分页）
            List<CourseComment> children = courseCommentMapper.getRepliesByParentId(comment.getId());
            for (CourseComment reply : children) {
                Long replyUserId = reply.getUserId();
                switch (reply.getRole()) {
                    case "STUDENT":
                        reply.setAvatar(studentService.selectById(replyUserId.intValue()).getAvatar());
                        break;
                    case "TEACHER":
                        reply.setAvatar(teacherService.selectById(replyUserId.intValue()).getAvatar());
                        break;
                    case "ADMIN":
                        reply.setAvatar(adminService.selectById(replyUserId.intValue()).getAvatar());
                        break;
                }
            }
            comment.setChildren(children); // 给一级评论绑定子评论
        }

        return new PageInfo<>(comments);
    }
}
