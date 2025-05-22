<template>
  <div style="min-height: 1000px">
    <el-carousel height="300px">
      <el-carousel-item v-for="item in data.carouselData" :key="item">
        <img :src="item" alt="" style="width: 100%; height: 300px">
      </el-carousel-item>
    </el-carousel>
    <div style="width: 80%; margin: 20px auto">
      <div style="font-size: 18px; display: flex">
        <div style="flex: 1">正在进行中的考试</div>
        <div style="width: 100px; text-align: right; color: #666666; font-size: 15px; cursor: pointer" @click="navTo('/front/exam')">查看更多</div>
      </div>
      <div style="margin-top: 15px">
        <el-row :gutter="10">
          <el-col :span="6" v-for="item in data.examData" style="margin-bottom: 15px">
            <div class="card" style="cursor: pointer" @click="navToTestPaper(item)">
              <img :src="item.courseImg" alt="" style="width: 100%; height: 150px">
              <div class="overflowShow" style="margin-top: 5px; font-size: 15px; color: #333333">{{ item.name }} </div>
              <div style="margin-top: 10px; display: flex; align-items: center">
                <img :src="item.teacherAvatar" alt="" style="width: 25px; height: 25px; border-radius: 50%">
                <div style="flex: 1; margin: 0 10px">{{ item.teacherName }}</div>
                <div style="width: 150px; text-align: right">
                  <el-tag v-if="item.status === '进行中'" type="success">{{ item.status }}</el-tag>
                  <el-tag v-if="item.status === '未开始'" type="warning">{{ item.status }}</el-tag>
                  <el-tag v-if="item.status === '已结束'" type="danger">{{ item.status }}</el-tag>
                </div>
              </div>
            </div>
          </el-col>
        </el-row>
      </div>
      <div style="display: flex; margin-top: 30px">
        <div style="flex: 1">
          <div style="font-size: 18px; display: flex; margin-bottom: 15px">
            <div style="flex: 1">看看大家都在分享什么</div>
            <div style="width: 100px; color: #666666; text-align: right; font-size: 15px; cursor: pointer;" @click="navTo('/front/forum')">查看更多</div>
          </div>
          <el-row :gutter="10">
            <el-col :span="8" v-for="item in data.articleData" style="margin-bottom: 15px">
              <div class="card" style="cursor: pointer" @click="navTo('/front/forumDetail?id=' + item.id)">
                <img :src="item.img" alt="" style="width: 100%; height: 150px">
                <div class="overflowShow" style="margin-top: 5px; font-size: 15px; color: #333333">{{ item.title }} </div>
                <div style="margin-top: 10px; display: flex; align-items: center">
                  <img :src="item.studentAvatar" alt="" style="width: 25px; height: 25px; border-radius: 50%">
                  <div style="flex: 1; margin: 0 10px">{{ item.studentName }}</div>
                  <div style="width: 150px; text-align: right">{{ item.time }}</div>
                </div>
              </div>
            </el-col>
          </el-row>
        </div>
        <div style="width: 300px; margin-left: 30px">
          <div style="font-size: 18px; margin-bottom: 15px">考试安排</div>
          <div class="card">
            <div @click="viewContent(item)" style="line-height: 43px; padding: 0 10px; cursor: pointer" v-for="item in data.examPlanData">{{ item.title }}</div>
          </div>
        </div>
      </div>
    </div>

    <el-dialog title="详细信息" v-model="data.dialogVisible" width="40%" destroy-on-close>
      <div style="line-height: 30px">{{ data.form.content }}</div>
      <div style="margin-top: 15px">发布时间：{{ data.form.time }}</div>
    </el-dialog>
  </div>
</template>
<script setup>

import {reactive} from "vue";
import carousel_1 from "@/assets/imgs/carousel-1.jpg";
import carousel_2 from "@/assets/imgs/carousel-2.jpg";
import carousel_3 from "@/assets/imgs/carousel-3.jpg";
import carousel_4 from "@/assets/imgs/carousel-4.jpg";
import carousel_5 from "@/assets/imgs/carousel-5.png";
import carousel_6 from "@/assets/imgs/carousel-6.png";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";

const data = reactive({
  carouselData: [carousel_5, carousel_6],
  examData: [],
  articleData: [],
  examPlanData: [],
  dialogVisible: false,
  form: {}
})

const loadTestPaper = () => {
  request.get('/testPaper/selectRandom').then(res => {
    if (res.code === '200') {
      data.examData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const loadArticle = () => {
  request.get('/article/selectRandom').then(res => {
    if (res.code === '200') {
      data.articleData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const loadExamPlan = () => {
  request.get('/examPlan/selectAll').then(res => {
    if (res.code === '200') {
      if (res.data.length > 5) {
        data.examPlanData = res.data.slice(0, 5)
      } else {
        data.examPlanData = res.data
      }
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const viewContent = (item) => {
  data.form = JSON.parse(JSON.stringify(item))
  data.dialogVisible = true
}
const navTo = (url) => {
  location.href = url
}
const navToTestPaper = (item) => {
  if (item.status === '未开始') {
    ElMessage.warning('该考试还未开放')
    return
  }
  if (item.status === '已结束') {
    ElMessage.warning('该考试已结束')
    return;
  }
  request.get('/testPaper/check/' + item.id).then(res => {
    if (res.code === '200') {
      location.href = '/front/testPaper?id=' + item.id
    } else {
      ElMessage.error(res.msg)
    }
  })
}
loadTestPaper()
loadArticle()
loadExamPlan()
</script>
<style scope>
.overflowShow {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>