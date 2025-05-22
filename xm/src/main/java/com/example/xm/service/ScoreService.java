package com.example.xm.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;

import com.example.xm.common.enums.RoleEnum;
import com.example.xm.entity.*;
import com.example.xm.mapper.QuestionMapper;
import com.example.xm.mapper.ScoreMapper;
import com.example.xm.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

/**
 * 成绩信息业务层方法
 */
@Service
public class ScoreService {

    @Resource
    private ScoreMapper scoreMapper;
    @Resource
    private QuestionMapper questionMapper;
    /*add操作就是添加到数据库中的insert操作*/
/*按照现实场景，就是再把用来的试卷放回去，不一定add的参数是score，其他的参数都可以，但是最后返回的参数是score（即调用的是score层的mapper的语句）。answer是一个数据结构对象{}，最后封装的answer的list放入到score的answer中去*/
    public void add(TestPaper testPaper) {

        // 封装一下用户提交的试卷信息
        List<Answer> list = new ArrayList<>();
        for (Question question : testPaper.getQuestions()) {
            Answer answer = new Answer();
            answer.setTypeName(question.getTypeName());
            answer.setScore(question.getTypeScore());
            answer.setQuestionId(question.getId());
            if ("多选题".equals(question.getTypeName())) {
                List<String> checkList = question.getCheckList();
                answer.setNewAnswer(String.join(",", checkList));
            } else {
                answer.setNewAnswer(question.getNewAnswer());
            }
            answer.setAnswer(question.getAnswer());
            list.add(answer);
        }
/*根据question设置answer，再根据answer设置score的值存到数据库的表中，注意数据库中的表中是没有*/
        Score score = new Score();
        Account currentUser = TokenUtils.getCurrentUser();
        score.setStudentId(currentUser.getId());
        score.setTeacherId(testPaper.getTeacherId());
        score.setCourseId(testPaper.getCourseId());
        score.setName(testPaper.getName());
        score.setPaperId(testPaper.getId());
        score.setStatus("待阅卷");
        score.setAnswer(JSONUtil.toJsonStr(list));/*这个就是将数组java对象变成string才行*/
        scoreMapper.insert(score);
    }

    public void updateById(Score score) {
        List<Answer> answerData = score.getAnswerData();/*TODO */
        int total = 0;
        for (Answer answer : answerData) {
            if (ObjectUtil.isNotEmpty(answer.getResult())) {
                total += answer.getResult();
            }
        }
        score.setScore(total);
        score.setAnswer(JSONUtil.toJsonStr(answerData));/*TODO 66行的对比不是一样的吗？？不一样！！因为传入的score参数里面有了新的绑定的输入的data.anwserData里面对应row的result绑定了，前端输入时这个简答题的result被更新，所以最后的answerdata和原来的不一样*/
        /*todo 虽然绑定了form.answerdata但是没有存入数据库中啊，只是前端和java后端绑定了同步的变化，所以这一行不是多余的！！！*/
        score.setStatus("已阅卷");
        scoreMapper.updateById(score);
    }

    public void deleteById(Integer id) {
        scoreMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            scoreMapper.deleteById(id);
        }
    }

    public Score selectById(Integer id) {
        List<Score> scores = scoreMapper.selectAll(new Score());
        Score score = scores.stream().filter(x -> x.getId().equals(id)).findFirst().get();
        String answer = score.getAnswer();
        List<Answer> list = JSONUtil.toList(answer, Answer.class);

        List<Question> questions = new ArrayList<>();
        for (Answer ans : list) {
            Question question = questionMapper.selectById(ans.getQuestionId());
            if (ObjectUtil.isNotEmpty(question)) {
                if ("多选题".equals(ans.getTypeName())) {
                    String newAnswer = ans.getNewAnswer(); // A,B,C
                    List<String> checkList = Arrays.asList(newAnswer.split(","));
                    question.setCheckList(checkList);
                } else {
                    question.setNewAnswer(ans.getNewAnswer());
                }
                questions.add(question);
            }
        }
        score.setQuestions(questions);
        return score;
    }

    public List<Score> selectAll(Score score) {
        return scoreMapper.selectAll(score);
    }

    public PageInfo<Score> selectPage(Score score, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.STUDENT.name().equals(currentUser.getRole())) {
            score.setStudentId(currentUser.getId());
        }
        if (RoleEnum.TEACHER.name().equals(currentUser.getRole())) {
            score.setTeacherId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Score> list = scoreMapper.selectAll(score);
        return PageInfo.of(list);
    }

/*TODO 答案如何展示的问题，将score的页面对应的id的那个score拿出来，因为要打分，所以将后面的answer1string变为list<Answer>2再将list<Answer>层的对象给拿出来，然后给list，即即对里面的Answer属性里面的result属性赋值，同时最后返回的类型是list
*  List<Answer>的数组，然后展示到了前台dialog里面，注意这里只是数据的渲染，没有老师客观题打分的操作，客观题打分的操作是在最后保存的时候现实的*/
    public List<Answer> selectAnswer(Integer id) {
        Score score = scoreMapper.selectById(id);
        List<Answer> list = JSONUtil.toList(score.getAnswer(), Answer.class);/*TODO 一般的根据id转对象可以用stream流，利用hutool的库string转数组对象的集合*/
        // 客观题自动阅卷功能
        for (Answer answer : list) {
            Question question = questionMapper.selectById(answer.getQuestionId());/*TODO 根据id还原对应的对象类型，一般selectbyid返回的是该对应的对象*/
            answer.setQuestionName(question.getName());
            // 客观题自动打分
            if (!"简答题".equals(answer.getTypeName())) {
                if (!"多选题".equals(answer.getTypeName())) {
                    if (answer.getAnswer().equals(answer.getNewAnswer())) {
                        answer.setResult(answer.getScore());
                    } else {
                        answer.setResult(0);
                    }
                } else {
                    // 多选题只要选项都对就行 顺序没有关系；A,B,C 和 B,A,C 是一样的
                    List<String> standardList = Arrays.asList(answer.getAnswer().split(",")); // [A, B, C]/*原来是“A,B,C”*/
                    List<String> studentList = Arrays.asList(answer.getNewAnswer().split(",")); // [B, A, C]
                    for (String s : standardList) {/*在student中找是否有标准答案，不仅仅有而且是数量是一样的*/
                        if (!studentList.contains(s)) {
                            answer.setResult(0);
                            break;/*break只是for循环结束，若下面的ObjectUtil.isEmpty(answer.getResult())没有的话再次判断数量一样执行answer.setResult(answer.getScore())了，重置分数了，错误*/
                        }
                    }/*用boolean设置标志位true，false判断==0不可以，因为都符合要求是null用!0==answer.getResult()是不可以的，为空的的话也！==0*/
                    if (ObjectUtil.isEmpty(answer.getResult())) {
                        if (studentList.size() == standardList.size()) {
                            answer.setResult(answer.getScore());
                        } else {
                            answer.setResult(0);
                        }
                    }
                }
            }
        }
        return list;
    }
}
