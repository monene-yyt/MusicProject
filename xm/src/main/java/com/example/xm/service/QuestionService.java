package com.example.xm.service;

import cn.hutool.core.date.DateUtil;

import com.example.xm.common.enums.RoleEnum;
import com.example.xm.entity.Account;
import com.example.xm.entity.Question;
import com.example.xm.mapper.QuestionMapper;
import com.example.xm.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 题目信息业务层方法
 */
@Service
public class QuestionService {

    @Resource
    private QuestionMapper questionMapper;

    public void add(Question question) {
        Account currentUser = TokenUtils.getCurrentUser();
        question.setTeacherId(currentUser.getId());
        questionMapper.insert(question);
    }

    public void updateById(Question question) {
        questionMapper.updateById(question);
    }

    public void deleteById(Integer id) {
        questionMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            questionMapper.deleteById(id);
        }
    }

    public Question selectById(Integer id) {
        return questionMapper.selectById(id);
    }

    public List<Question> selectAll(Question question) {
        return questionMapper.selectAll(question);
    }

    public PageInfo<Question> selectPage(Question question, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.TEACHER.name().equals(currentUser.getRole())) {
            question.setTeacherId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Question> list = questionMapper.selectAll(question);
        return PageInfo.of(list);
    }

}
