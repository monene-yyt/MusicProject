package com.example.xm.mapper;


import com.example.xm.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface AdminMapper {

    int insert(Admin admin);

    void updateById(Admin admin);

    void deleteById(Integer id);

    @Select("select * from `admin` where id = #{id}")
    Admin selectById(Integer id);

    @Select("select * from `admin` where username = #{username}")
    Admin selectByUsername(String username);

    List<Admin> selectAll(Admin admin);

}
