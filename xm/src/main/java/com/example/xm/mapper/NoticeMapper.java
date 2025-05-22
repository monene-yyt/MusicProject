package com.example.xm.mapper;


import com.example.xm.entity.Notice;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface NoticeMapper {

    int insert(Notice notice);

    void updateById(Notice notice);

    void deleteById(Integer id);

    @Select("select * from `notice` where id = #{id}")
    Notice selectById(Integer id);

    List<Notice> selectAll(Notice notice);

}
