package com.example.xm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseComment {
    private Long id;
    private Long courseId;
    private Long userId;
    private String username;
    private String avatar;
    private String content;
    private Long parentId;
    private Integer likeCount;
    private String role;
    private LocalDateTime createTime;
    private Boolean isDeleted;
    private List<CourseComment> children;
}