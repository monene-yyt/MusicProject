package com.example.xm.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentCoursePojo {
    private  Long studentId;
    private  Long courseId;
}
