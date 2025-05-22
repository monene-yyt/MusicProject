package com.example.xm.service;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;

import com.example.xm.common.enums.RoleEnum;
import com.example.xm.entity.*;
import com.example.xm.exception.CustomException;
import com.example.xm.mapper.*;
import com.example.xm.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
/*TODO service里面是实现的主要的逻辑，1对于不同用户*/
/**
 * 试卷信息业务层方法
 */
@Service
public class TestPaperService {

    @Resource
    private TestPaperMapper testPaperMapper;
    @Resource
    private QuestionMapper questionMapper;
    @Resource
    private CourseMapper courseMapper;
    @Resource
    private TeacherMapper teacherMapper;
    @Resource
    private ScoreMapper scoreMapper;
/*service层的作用就是将需要的值给到后端，然后通过sql语句插入等，这里因为里面的check是有抛出异常的，所以add也需要抛出异常在最上面try catch和throws有什么区别吗，add增加的是questionid这个属性，teacher*/
    public void add(TestPaper testPaper) throws ParseException {
        // 先要校验前台传过来的数据
        check(testPaper);/*add前添加校验的函数*/
        Account currentUser = TokenUtils.getCurrentUser();
        testPaper.setTeacherId(currentUser.getId());
        // 手动选题
        if ("手动选题".equals(testPaper.getType())) {
            /*转成json性质的字符串string存到数据库varchar中，idList是数组类型*/
            List<Integer> idList = testPaper.getIdList();
            testPaper.setQuestionIds(JSONUtil.toJsonStr(idList));/*TODO entity增加 private List<Integer> idList的意义，java转json字符串*/
        }
        if ("自动组卷".equals(testPaper.getType())) {
            List<Integer> list = new ArrayList<>();/*同一个list重复利用，每种题型打乱往里面加，list开始是空，慢慢的往里面赋值*/
            // 自动选取每个题型的题目
            randomQuestionIds(testPaper, testPaper.getChoiceNum(), list, 1, "单选题");
            randomQuestionIds(testPaper, testPaper.getMultiChoiceNum(), list, 2, "多选题");
            randomQuestionIds(testPaper, testPaper.getCheckNum(), list, 3, "判断题");
            randomQuestionIds(testPaper, testPaper.getFillInNum(), list, 4, "填空题");
            randomQuestionIds(testPaper, testPaper.getAnswerNum(), list, 5, "简答题");

            testPaper.setQuestionIds(JSONUtil.toJsonStr(list));/*最后数组转化为string类型即可塞入questionids*/
        }

        testPaperMapper.insert(testPaper);
    }

    private void randomQuestionIds(TestPaper testPaper, Integer choiceNum, List<Integer> list, Integer typeId, String typeName) {
        List<Question> choiceList = questionMapper.selectByCouserIdAndTypeId(testPaper.getCourseId(), typeId);
        if (choiceList.size() < choiceNum) {
            throw new CustomException("-1", "您的题库里该课程的" + typeName + "数量不足，请减少出题的" + typeName + "数量或者增加题库里该课程的" + typeName + "数量");
        }
        Collections.shuffle(choiceList); // 打乱
        List<Integer> questions = choiceList.subList(0, choiceNum).stream().map(Question::getId).toList();
        list.addAll(questions);
    }
/*这个是对于teacher功能来说的，先进行校验，校验的话就是前台校验，后台校验都可以的，这里是后台的校验，是否为空，符合规范等校验*/
    public void check (TestPaper testPaper) throws ParseException {
        if (ObjectUtil.isEmpty(testPaper.getName())
                || ObjectUtil.isEmpty(testPaper.getCourseId())
                || ObjectUtil.isEmpty(testPaper.getStart())
                || ObjectUtil.isEmpty(testPaper.getEnd())
                || ObjectUtil.isEmpty(testPaper.getTime())
                || ObjectUtil.isEmpty(testPaper.getType())
        ) {
            throw new CustomException("-1", "请填写完整您要提交的试卷信息");/*就是自己自定义的异常抛出的信息*/
        }
        // 开始时间要早于结束时间
        long start = new SimpleDateFormat("yyyy-MM-dd").parse(testPaper.getStart()).getTime();
        long end = new SimpleDateFormat("yyyy-MM-dd").parse(testPaper.getEnd()).getTime();
        if (start >= end) {
            throw new CustomException("-1", "开始时间必须早于结束时间");
        }
        // 校验手动选题
        if ("手动选题".equals(testPaper.getType())) {
            if (CollectionUtil.isEmpty(testPaper.getIdList())) {
                throw new CustomException("-1", "手动选题方式，您需要选择具体的题目");
            }
        }
        // 自动组卷校验
        if ("自动组卷".equals(testPaper.getType())) {
            if (ObjectUtil.isEmpty(testPaper.getChoiceNum())
                    || ObjectUtil.isEmpty(testPaper.getMultiChoiceNum())
                    || ObjectUtil.isEmpty(testPaper.getFillInNum())
                    || ObjectUtil.isEmpty(testPaper.getCheckNum())
                    || ObjectUtil.isEmpty(testPaper.getAnswerNum())
            ) {
                throw new CustomException("-1", "请填写题型的数量，如果不需要某个题型，请输入0");
            }
            if (testPaper.getChoiceNum() < 0
                    || testPaper.getMultiChoiceNum() < 0
                    || testPaper.getFillInNum() < 0
                    || testPaper.getCheckNum() < 0
                    || testPaper.getAnswerNum() < 0
            ) {
                throw new CustomException("-1", "题型的数量不能小于0");
            }
        }
    }

    public void updateById(TestPaper testPaper) {
        testPaperMapper.updateById(testPaper);
    }

    public void deleteById(Integer id) {
        testPaperMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            testPaperMapper.deleteById(id);
        }
    }
    /*这里的selectbyid是对于student的功能来的，要进行展示，将要展示的数值（entity和数据库里面不一样的要单独设置好）都给设置好即可*/
/*entity里面（前端展示用到的，关联查询什么的）》数据库里面的所有的信息，在service或者mapper里面回将用到的前端的值传递到前端（）entity，1用逻辑去做2用sql数据库去做实现关联查询，把对应的要展示的信息都展示出来，老师名字（连接查询），具体的问题的信息（根据string->listint->listquestion->setquestion到前端）*/
    public TestPaper selectById(Integer id) {
        TestPaper testPaper = testPaperMapper.selectById(id);
        Course course = courseMapper.selectById(testPaper.getCourseId());
        if (ObjectUtil.isNotEmpty(course)) {
            testPaper.setCourseName(course.getName());
        }
        Teacher teacher = teacherMapper.selectById(testPaper.getTeacherId());
        if (ObjectUtil.isNotEmpty(teacher)) {
            testPaper.setTeacherName(teacher.getName());
        }
        // 开始组装该试卷里所有的题目数据
        String questionIds = testPaper.getQuestionIds();
        List<Integer> idList = JSONUtil.toList(questionIds, Integer.class);/*string对象变为整数(值是对应的question的标号)数组的list*/
        List<Question> questions = new ArrayList<>();/*将对应整数数组的标号转换成对应的questions*/
        for (Integer questionId : idList) {
            Question question = questionMapper.selectById(questionId);
            questions.add(question);/*在list里面添加question，即将id转换成对应的对象question*/
        }
        /*List<Question> questions = JSONUtil.toList(testPaper.getQuestionIds(), Integer.class)
                .stream()
                .map(questionMapper::selectById)
                .collect(Collectors.toList());  */
        testPaper.setQuestions(questions);/*前端只有数组列表是不行的，还要增加questions的类型的展现试卷信息在前台展示*/
        /*TODO 对象都是这样的 将stringquestionids变成数组id对象，id对象数组变成对应的对象question数组collect回收*/
        testPaper.setMaxTime(testPaper.getTime() * 60);
        return testPaper;
    }

    public List<TestPaper> selectAll(TestPaper testPaper) {
        return testPaperMapper.selectAll(testPaper);
    }
/*在分页查询里面实现对应的角色，王老师只能查看王老师的信息，因为分页查询是动态sql*/
    public PageInfo<TestPaper> selectPage(TestPaper testPaper, Integer pageNum, Integer pageSize) throws ParseException {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.TEACHER.name().equals(currentUser.getRole())) {
            testPaper.setTeacherId(currentUser.getId());/*查询teacherid不为空了这里！所以对应的mapper里面的selectall查出来的都是对应老师的试卷信息，动态sql查询*/
        }
        PageHelper.startPage(pageNum, pageSize);
        List<TestPaper> list = testPaperMapper.selectAll(testPaper);
        // 初始化每个考试的状态
        initStatus(list);
        return PageInfo.of(list);
    }

/*初始状态问题，根据start,now,end等设置时间，注意是在service里面实现的，套在selectPage里面的*/
    private static void initStatus(List<TestPaper> list) throws ParseException {
        for (TestPaper paper : list) {
            long now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(DateUtil.now()).getTime();
            long start = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(paper.getStart() + " 00:00:00").getTime();
            long end = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(paper.getEnd() + " 23:59:59").getTime();
            if (now < start) {
                paper.setStatus("未开始");
            } else if (now > end) {
                paper.setStatus("已结束");
            } else {
                paper.setStatus("进行中");
            }
        }
    }

    public void checkTestPaper(Integer id) {
        Account currentUser = TokenUtils.getCurrentUser();
        Score score = new Score();
        score.setPaperId(id);/*设置，或者是生效用于参数条件查询*/
        score.setStudentId(currentUser.getId());
        List<Score> scores = scoreMapper.selectAll(score);/*两个条件查询，即既满足于studentid和paperid的试卷有没有集合是CollectionUtil.isNotEmpty,若是单独的对象就是ObjectUtil.isNotEmpty*/
        if (CollectionUtil.isNotEmpty(scores)) {
            throw new CustomException("-1", "该门考试您已经提交过试卷了，入口已关闭");
        }
    }

    public List<TestPaper> selectRandom() throws ParseException {
        List<TestPaper> list = testPaperMapper.selectAll(new TestPaper());
        Collections.shuffle(list);
        // 初始化每个考试的状态
        initStatus(list);
        if (list.size() > 4) {
            return list.subList(0, 4);
        }
        return list;
    }
}
