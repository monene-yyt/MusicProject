package com.example.xm.mapper;


import com.example.xm.entity.ExamPlan;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
@Mapper

public interface ExamPlanMapper {

    int insert(ExamPlan examPlan);

    void updateById(ExamPlan examPlan);

    void deleteById(Integer id);

    @Select("select * from `examPlan` where id = #{id}")
    ExamPlan selectById(Integer id);

    List<ExamPlan> selectAll(ExamPlan examPlan);

}
