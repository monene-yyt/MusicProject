package com.example.xm.mapper;


import com.example.xm.entity.CourseComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CourseCommentMapper {
    void insertComment(CourseComment comment);

    List<CourseComment> getCommentsByCourseId(@Param("courseId") Long courseId);

    void deleteComment(@Param("commentId") Long commentId, @Param("userId") Long userId);

    void incrementLike(@Param("commentId") Long commentId);

    CourseComment getCommentById(@Param("commentId") Long commentId);
    List<CourseComment> getPagedCommentsByCourseId(@Param("courseId") Long courseId);

    List<CourseComment> getRepliesByParentId(Long id);

}
