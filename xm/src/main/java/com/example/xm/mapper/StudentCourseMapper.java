package com.example.xm.mapper;

import com.example.xm.entity.StudentCourse;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StudentCourseMapper {
    int insert(StudentCourse studentCourse);

    int delete(@Param("studentId") Long studentId, @Param("courseId") Long courseId);

    List<StudentCourse> selectByStudentId(@Param("studentId") Long studentId);

    int exists(@Param("studentId") Long studentId, @Param("courseId") Long courseId);
}
