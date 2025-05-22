package com.example.xm.mapper;


import com.example.xm.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface ArticleMapper {

    int insert(Article article);

    void updateById(Article article);

    void deleteById(Integer id);

    @Select("select article.*, student.name as studentName from `article` " +
            "left join student on article.student_id = student.id " +
            "where article.id = #{id}")
    Article selectById(Integer id);

    List<Article> selectAll(Article article);

}
