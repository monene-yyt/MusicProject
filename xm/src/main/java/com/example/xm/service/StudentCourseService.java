package com.example.xm.service;

import com.example.xm.entity.Course;
import com.example.xm.entity.StudentCourse;
import com.example.xm.mapper.StudentCourseMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class StudentCourseService {

    @Autowired
    private StudentCourseMapper studentCourseMapper;
    @Autowired
    private CourseService courseService;

    public boolean addCourse(Long studentId, Long courseId) {
        if (studentCourseMapper.exists(studentId, courseId) > 0) return false;
        StudentCourse sc = new StudentCourse();
        sc.setStudentId(studentId);
        sc.setCourseId(courseId);
        //给对应课程的学习人数加一
        courseService.addStudyCount(courseId);
        return studentCourseMapper.insert(sc) > 0;
    }

    public boolean removeCourse(Long studentId, Long courseId) {
        courseService.removeStudyCount(courseId);
        return studentCourseMapper.delete(studentId, courseId) > 0;
    }

    public Object getStudentCourses(Long studentId) {
        return studentCourseMapper.selectByStudentId(studentId);
    }

    public boolean isCourseAdded(Long studentId, Long courseId) {
        return studentCourseMapper.exists(studentId, courseId) > 0;
    }

    public PageInfo<Course> selectMyCoursePage(Long studentId,Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<StudentCourse> studentCourses = studentCourseMapper.selectByStudentId(studentId);
        List<Course> courses = new ArrayList<>();
        for (StudentCourse studentCours : studentCourses) {
            Course course = courseService.selectById(Math.toIntExact(studentCours.getCourseId()));
            courses.add(course);
        }
        PageInfo<Course> pageInfo = new PageInfo<>(courses);
        return pageInfo;
    }

}
