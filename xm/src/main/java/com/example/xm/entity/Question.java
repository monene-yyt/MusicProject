package com.example.xm.entity;

import java.util.ArrayList;
import java.util.List;

public class Question {
    private Integer id;
    private String name;
    private Integer courseId;
    private Integer teacherId;
    private Integer typeId;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String answer;

    private String courseName;
    private String teacherName;
    private String typeName;
    private Integer typeScore;

    private String newAnswer;/*answer是该问题的标准答案数据库里面的，newanswer是该生的答案*/
    private List<String> checkList = new ArrayList<>();/*因为在vue的reactive里面不知道是数组，只有checklist:[]才知道是数组，所以在entity是初始化告诉是数组，也是newanswer，但是因为element用法是数组，多选题特殊*/

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getOptionA() {
        return optionA;
    }

    public void setOptionA(String optionA) {
        this.optionA = optionA;
    }

    public String getOptionB() {
        return optionB;
    }

    public void setOptionB(String optionB) {
        this.optionB = optionB;
    }

    public String getOptionC() {
        return optionC;
    }

    public void setOptionC(String optionC) {
        this.optionC = optionC;
    }

    public String getOptionD() {
        return optionD;
    }

    public void setOptionD(String optionD) {
        this.optionD = optionD;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getTypeScore() {
        return typeScore;
    }

    public void setTypeScore(Integer typeScore) {
        this.typeScore = typeScore;
    }

    public String getNewAnswer() {
        return newAnswer;
    }

    public void setNewAnswer(String newAnswer) {
        this.newAnswer = newAnswer;
    }

    public List<String> getCheckList() {
        return checkList;
    }

    public void setCheckList(List<String> checkList) {
        this.checkList = checkList;
    }
}
