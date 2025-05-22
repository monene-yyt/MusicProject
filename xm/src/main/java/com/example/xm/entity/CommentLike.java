package com.example.xm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentLike {
    private Long id;
    private Long commentId;
    private Long userId;
    private LocalDateTime createTime;
}
