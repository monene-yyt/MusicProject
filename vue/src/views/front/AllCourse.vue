<template>
  <div class="main-content">
    <div style="margin: 30px 0; display: flex; align-items: center; justify-content: space-between; width: 100%;">
      <!-- 难度分类部分（现在放在前面） -->
      <div style="display: flex; align-items: center; min-width: 400px;">
        <span style="margin-right: 10px; font-weight: 500;">按难度分类：</span>
        <el-button size="large" type="warning" @click="loada">基础</el-button>
        <el-button size="large" type="info" @click="loadb">中等</el-button>
        <el-button size="large" type="danger" @click="loadc">困难</el-button>
        <el-button size="large" type="success" @click="load">全部</el-button>
      </div>

      <!-- 间隔（可选，增加更大的间距） -->
      <div style="flex: 1;"></div>

      <!-- 课程查询部分（现在放在后面） -->
      <div style="display: flex; align-items: center; min-width: 400px; justify-content: flex-end;">
        <el-input size="large" clearable @clear="reset" style="width: 300px; margin-right: 10px;" v-model="data.name"
          placeholder="请输入课程名称查询">
        </el-input>
        <el-button size="large" type="primary" @click="load">查询</el-button>
      </div>
    </div>
    <div>
      <el-row :gutter="10">
        <el-col :span="6" v-for="item in data.courseData" style="margin-bottom: 15px">
          <div class="card" style="cursor: pointer; position: relative;"
            @click="navTo('/front/CourseDetail?id=' + item.id)">
            <img :src="item.img" alt="" style="width: 100%; height: 150px">

            <div class="overflowShow" style="margin-top: 5px; font-size: 15px; color: #333333">{{ item.name }}</div>

            <div style="margin-top: 10px; display: flex; align-items: center">
              <img :src="item.teacherAvatar" alt="" style="width: 25px; height: 25px; border-radius: 50%">
              <div style="flex: 1; margin: 0 10px">{{ item.teacherName }}</div>
              <div style="width: 150px; text-align: right">
                <el-tag v-if="item.level === '基础'" type="warning">{{ item.level }}</el-tag>
                <el-tag v-if="item.level === '中等'" type="info">{{ item.level }}</el-tag>
                <el-tag v-if="item.level === '困难'" type="danger">{{ item.level }}</el-tag>
              </div>
            </div>

            <!-- 学习人数固定在右下角 -->
            <div style="position: absolute; bottom: 40px; right: 10px; font-size: 13px; color: #666;">
              👥 {{ item.studyCount || 0 }} 人学习
            </div>
          </div>
        </el-col>


      </el-row>
    </div>
    <div v-if="data.total" style="margin: 20px 0">
      <el-pagination @current-change="load" background layout="prev, pager, next" :page-size="data.pageSize"
        v-model:current-page="data.pageNum" :total="data.total" />
    </div>
  </div>
</template>
<script setup>
import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage } from "element-plus";
import { useRoute, useRouter } from "vue-router";
const router = useRouter();

const data = reactive({
  level: null,
  pageNum: 1,
  pageSize: 8,
  total: 0,
  courseData: [],
  name: null
})

const loada = () => {
  request.get('/course/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      level: '基础'
    }
  }).then(res => {
    if (res.code === '200') {
      data.courseData = res.data.list
      data.total = res.data.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const loadb = () => {
  request.get('/course/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      level: '中等'
    }
  }).then(res => {
    if (res.code === '200') {
      data.courseData = res.data.list
      data.total = res.data.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const loadc = () => {
  request.get('/course/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      level: '困难'
    }
  }).then(res => {
    if (res.code === '200') {
      data.courseData = res.data.list
      data.total = res.data.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const load = () => {
  request.get('/course/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name
    }
  }).then(res => {
    if (res.code === '200') {
      data.courseData = res.data.list
      data.total = res.data.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const reset = () => {
  data.level = null
  load()
}

/*const navTo = (item) => {
  if (item.status === '未开始') {
    ElMessage.warning('该考试还未开放')
    return
  }
  if (item.status === '已结束') {
    ElMessage.warning('该考试已结束')
    return;
  }
  request.get('/course/check/' + item.id).then(res => {
    if (res.code === '200') {
      location.href = '/front/course?id=' + item.id
    } else {
      ElMessage.error(res.msg)
    }
  })

}*/

const navTo = (url) => {
  console.log("点了")
  const id = url.split('=')[1];
  router.push({ path: '/front/CourseDetail', query: { id } });
}

load()

</script>
<style scope>
.overflowShow {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>