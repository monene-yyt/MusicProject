package com.example.xm.service;

import cn.hutool.core.date.DateUtil;

import com.example.xm.common.enums.RoleEnum;
import com.example.xm.entity.Account;
import com.example.xm.entity.Course;
import com.example.xm.mapper.CourseMapper;
import com.example.xm.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 课程信息业务层方法
 */
@Service
public class CourseService {

    @Resource
    private CourseMapper courseMapper;

    public void add(Course course) {
        Account currentUser = TokenUtils.getCurrentUser();
        course.setTeacherId(currentUser.getId());
       courseMapper.insert(course);
    }

    public void updateById(Course course) {
        courseMapper.updateById(course);
    }

    public void deleteById(Integer id) {

        courseMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            courseMapper.deleteById(id);
        }
    }

    public Course selectById(Integer id) {
        return courseMapper.selectById(id);
    }

    public List<Course> selectAll(Course course) {
        return courseMapper.selectAll(course);
    }
    /*这里的course作为参数传递的作用是这个，允许前端通过不同字段组合筛选课程（如按名称、状态、时间等），无需为每个条件单独写接口。*/
    public PageInfo<Course> selectPage(Course course, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.TEACHER.name().equals(currentUser.getRole())) {
            course.setTeacherId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Course> list = courseMapper.selectAll(course);
        return PageInfo.of(list);
    }
    // 4. 动态查询（根据course对象的字段生成WHERE条件）
    public void addStudyCount(Long courseId) {
         courseMapper.addStudyCount(courseId);
    }

    public void removeStudyCount(Long courseId) {
         courseMapper.removeStudyCount(courseId);
    }
}
