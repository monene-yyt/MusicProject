package com.example.xm.mapper;

import com.example.xm.entity.Student;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface StudentMapper {

    int insert(Student student);

    void updateById(Student student);

    void deleteById(Integer id);

    @Select("select * from `student` where id = #{id}")
    Student selectById(Integer id);

    @Select("select * from `student` where username = #{username}")
    Student selectByUsername(String username);

    List<Student> selectAll(Student student);

}
