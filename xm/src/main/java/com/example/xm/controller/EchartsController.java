package com.example.xm.controller;

import com.example.xm.common.Result;
import com.example.xm.common.enums.RoleEnum;
import com.example.xm.entity.Account;
import com.example.xm.entity.Course;
import com.example.xm.entity.Student;
import com.example.xm.mapper.CourseMapper;
import com.example.xm.service.CourseService;
import com.example.xm.service.StudentService;
import com.example.xm.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/echarts")
public class EchartsController {
    @Resource
    public StudentService studentService;


    @GetMapping("/pie")
    public Result pie() {
        List<Map<String, Object>> list = new ArrayList<>();

        // 1. 查询所有学生列表
        List<Student> students = studentService.selectAll(new Student());

        // 2. 按状态分组统计数量
        Map<String, Long> statusCountMap = students.stream()
                .collect(Collectors.groupingBy(
                        Student::getStatus,  // 直接使用String类型的status字段分组
                        Collectors.counting()
                ));

        // 3. 确保所有状态都有默认值（即使数量为0）
        List<String> allStatus = Arrays.asList("待审核", "审核通过", "审核不通过");
        allStatus.forEach(status -> {
            statusCountMap.putIfAbsent(status, 0L);
        });

        // 4. 构造ECharts需要的格式
        statusCountMap.forEach((status, count) -> {
            Map<String, Object> map = new HashMap<>();
            map.put("name", status);
            map.put("value", count);
            list.add(map);
        });

        return Result.success(list);
    }
}

