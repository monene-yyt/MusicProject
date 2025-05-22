package com.example.xm.controller;


import com.example.xm.common.Result;
import com.example.xm.entity.Course;
import com.example.xm.entity.StudentCoursePojo;
import com.example.xm.service.StudentCourseService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/studentcourse")
public class StudentCourseController {
    @Autowired
    private StudentCourseService studentCourseService;
    @PostMapping("/add")
    public Result addCourse(@RequestBody StudentCoursePojo studentCoursePojo) {
        boolean success = studentCourseService.addCourse(studentCoursePojo.getStudentId(), studentCoursePojo.getCourseId());
        return success ? Result.success() : Result.error("已添加或失败");
    }

    @PostMapping("/remove")
    public Result removeCourse(@RequestBody StudentCoursePojo studentCoursePojo) {
        boolean success = studentCourseService.removeCourse(studentCoursePojo.getStudentId(), studentCoursePojo.getCourseId());
        return success ? Result.success() : Result.error("移除失败");
    }

    @GetMapping("/list")
    public Result list(@RequestParam Long studentId) {
        return Result.success(studentCourseService.getStudentCourses(studentId));
    }

    @GetMapping("/getMyCourse")
    public Result getMyCourse(@RequestParam Long studentId,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Course> pageInfo = studentCourseService.selectMyCoursePage(studentId, pageNum, pageSize);
        return  Result.success(pageInfo);

    }

    @GetMapping("/is-added")
    public Result isAdded(@RequestParam Long studentId, @RequestParam Long courseId) {
        return Result.success(studentCourseService.isCourseAdded(studentId, courseId));
    }
}
