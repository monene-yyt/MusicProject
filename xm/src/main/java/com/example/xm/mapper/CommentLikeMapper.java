package com.example.xm.mapper;

import com.example.xm.entity.CommentLike;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CommentLikeMapper {
    int insertLike(CommentLike like);

    boolean existsByCommentIdAndUserId(@Param("commentId") Long commentId, @Param("userId") Long userId);
}
