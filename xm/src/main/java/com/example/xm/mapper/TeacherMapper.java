package com.example.xm.mapper;

import com.example.xm.entity.Teacher;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface TeacherMapper {

    int insert(Teacher teacher);

    void updateById(Teacher teacher);

    void deleteById(Integer id);

    @Select("select * from `teacher` where id = #{id}")
    Teacher selectById(Integer id);

    @Select("select * from `teacher` where username = #{username}")
    Teacher selectByUsername(String username);

    List<Teacher> selectAll(Teacher teacher);

}
