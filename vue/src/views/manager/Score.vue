<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入试卷名称查询"></el-input>
      <el-input v-model="data.courseName" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入课程名称查询"></el-input>
      <el-input v-model="data.status" prefix-icon="Search" style="width: 240px; margin-right: 10px" placeholder="请输入阅卷状态查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData">
        <el-table-column prop="name" label="试卷名称" show-overflow-tooltip/>
        <el-table-column prop="courseName" label="课程名称" show-overflow-tooltip/>
        <el-table-column prop="teacherName" label="授课教师" show-overflow-tooltip v-if="data.user.role === 'ADMIN'"/>
        <el-table-column prop="studentName" label="学生姓名" show-overflow-tooltip/>
        <el-table-column prop="status" label="试卷状态" show-overflow-tooltip>
          <template v-slot="scope">
            <el-tag v-if="scope.row.status === '已阅卷'" type="success">{{ scope.row.status }}</el-tag>
            <el-tag v-if="scope.row.status === '待阅卷'" type="danger">{{ scope.row.status }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="score" label="分数" show-overflow-tooltip/>
        <el-table-column label="操作" width="100" fixed="right" v-if="data.user.role === 'TEACHER'">
          <template v-slot="scope">
            <el-button :disabled="scope.row.status === '已阅卷'" type="primary" @click="handleEdit(scope.row)">阅卷</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="答案信息" v-model="data.formVisible" width="85%" destroy-on-close>
      <el-table stripe :data="data.answerData">
        <el-table-column prop="questionName" label="题目" show-overflow-tooltip/><!--这个就是prop就是answerData.questionName的值，其他的不同，其他单独绑定了，因为<el-table stripe :data="data.answerData">-->
        <el-table-column prop="score" label="分数" show-overflow-tooltip width="60"/>
        <el-table-column prop="typeName" label="题型" show-overflow-tooltip width="80"/>
        <el-table-column prop="answer" label="标准答案" show-overflow-tooltip width="350">
          <template v-slot="scope">

            <el-input v-if="scope.row.typeName === '简答题'" type="textarea" :rows="8" v-model="scope.row.answer" disabled></el-input><!--disabled表示不可以修改-->
            <span v-else>{{ scope.row.answer }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="newAnswer" label="学生答案" show-overflow-tooltip width="350">
          <template v-slot="scope">
            <el-input v-if="scope.row.typeName === '简答题'" type="textarea" :rows="8" v-model="scope.row.newAnswer" disabled></el-input>
            <span v-else>{{ scope.row.newAnswer }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="result" label="得分" show-overflow-tooltip width="150">
          <template v-slot="scope">
            <el-input v-if="scope.row.typeName === '简答题'" v-model="scope.row.result" placeholder="输入分数"></el-input>
            <span v-else>{{ scope.row.result }}</span><!--列中不是纯文字渲染就用template scope划分出单独的根据每行渲染-->
          </template>
        </el-table-column>
      </el-table>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="update">提 交</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>

import {reactive} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";
import {Delete, Edit} from "@element-plus/icons-vue";


const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  tableData: [],/*因为表格中的tableData展示的数据和最后打开dialog展示的东西不是同一个东西，所以需要answerData来进行dialog的数据展示和修改*/
  pageNum: 1,
  pageSize: 10,
  total: 0,
  name: null,
  courseName: null,
  status: null,
  answerData: [],
  form: {}/*todo form不是指的是那个element-plus里面的form表单什么的，而是自己命名的对象，对象的内容是前端form表单里面的选中的某一条行row的记录对象，这里的数据类型的对象为score*/
})

const load = () => {
  request.get('/score/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      courseName: data.courseName,
      status: data.status
    }
  }).then(res => {
    if (res.code === '200') {
      data.tableData = res.data?.list || []
      data.total = res.data?.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const handleEdit = (row) => {
  /*那一行的数据，对象answerdata的那一行的对象score某一条的数据记录，然后传递到了upate提交那里去*/
  data.form = JSON.parse(JSON.stringify(row))/*深拷贝：直接赋值 data.form = row 会导致 data.form 和 row 共享同一个内存地址（修改一个会影响另一个）。而 JSON.parse(JSON.stringify(row)) 会创建一个全新的对象，避免引用问题。

适用场景：

表单编辑时，避免修改原始数据，直到用户点击“保存”。

需要完全独立的数据副本时。先将row对象转为json字符串，后将json字符串键“”转换为js对象键“”‘’没有都可以的，js对象能存函数，json不能*/
  request.get('/score/selectAnswer/' + row.id).then(res => {
    if (res.code === '200') {
      data.answerData = res.data/*这里的data就是返回的数据，即是list，也就是List<Answer>类型的*/
      data.formVisible = true
    } else {
      ElMessage.error(res.msg)
    }
  })
}
/*TODO form是选中的那一行row的score数据类型，form初始化见handleEdit，request.update对应的是更新操作，这里提交就是把form里的result绑定填入，同时更新score字段，score字段的score总分数字段，其他的不变*/
const update = () => {
  data.form.answerData = data.answerData
  request.put('/score/update', data.form).then(res => {
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    }
  })
}

const reset = () => {
  data.name = null
  data.courseName = null
  data.status = null
  load()
}

load()
</script>
<!--可以先写vue方法service逻辑，f12查看对应的浏览器中的数据有没有得到，最后再写前端渲染的页面-->