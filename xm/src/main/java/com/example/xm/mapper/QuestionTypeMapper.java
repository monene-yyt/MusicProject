package com.example.xm.mapper;

import com.example.xm.entity.QuestionType;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface QuestionTypeMapper {

    int insert(QuestionType questionType);

    void updateById(QuestionType questionType);

    void deleteById(Integer id);

    @Select("select * from `question_type` where id = #{id}")
    QuestionType selectById(Integer id);

    List<QuestionType> selectAll(QuestionType questionType);

    @Select("select * from question_type where name = #{name}")
    List<QuestionType> selectByName(String name);
}
