package com.example.xm.mapper;


import com.example.xm.entity.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface CourseMapper {

    int insert(Course course);

    void updateById(Course course);

    void deleteById(Integer id);

    @Select("select c.*,t.name as teacherName,t.avatar as teacherAvatar from course c left join teacher t on c.teacher_id=t.id where c.id = #{id}")
    Course selectById(Integer id);

    List<Course> selectAll(Course course);

    void addStudyCount(Long courseId);
    void removeStudyCount(Long courseId);
}
