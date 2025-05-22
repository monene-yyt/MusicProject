package com.example.xm.mapper;

import com.example.xm.entity.TestPaper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface TestPaperMapper {

    int insert(TestPaper testPaper);

    void updateById(TestPaper testPaper);

    void deleteById(Integer id);

    @Select("select * from `test_paper` where id = #{id}")
    TestPaper selectById(Integer id);

    List<TestPaper> selectAll(TestPaper testPaper);

}
