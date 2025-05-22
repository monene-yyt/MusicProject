package com.example.xm.mapper;

import com.example.xm.entity.Score;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface ScoreMapper {

    int insert(Score score);

    void updateById(Score score);

    void deleteById(Integer id);

    @Select("select * from `score` where id = #{id}")
    Score selectById(Integer id);

    List<Score> selectAll(Score score);

}
