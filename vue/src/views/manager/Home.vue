<template>
  <div>
    <div class="card" style="margin-bottom: 5px">您好！{{ data.user?.name }}，欢迎使用本系统！</div>
    <div style="display: flex">
      <div class="card" style="flex: 50%; height: 350px; margin-right: 5px">
        <div style="font-weight: bold; font-size: 18px; padding: 10px 0 30px 10px">系统公告</div>
        <el-timeline style="max-width: 600px">
          <el-timeline-item
              v-for="(item, index) in data.noticeData"
              :key="index"
              :timestamp="item.time"
          >
            {{ item.content }}
          </el-timeline-item>
        </el-timeline>
      </div>
      <div class="card" style="flex: 50%; height: 350px; margin-left: 5px">
        <div style="font-weight: bold; font-size: 18px; padding: 10px 0 30px 10px">考试安排</div>
        <el-timeline style="max-width: 600px">
          <el-timeline-item
              v-for="(item, index) in data.planData"
              :key="index"
              :timestamp="item.time"
          >
            {{ item.content }}
          </el-timeline-item>
        </el-timeline>
      </div>
    </div>
    <div class="card" style="margin-top:10px;width:50%" v-if="data.user.role ==='ADMIN'">
      <div style="height:400px" id="pie"></div>
    </div>
  </div>
</template>

<script setup>

import {reactive,onMounted} from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";
import * as echarts from "echarts";

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  noticeData: [],
  planData: [],
  pieOptions:[]
})
const loadPie=()=>{
  request.get('/echarts/pie').then(res=>{
    if(res.code==='200'){
      let chartDom=document.getElementById('pie')
      let myChart=echarts.init(chartDom)
      pieOptions.series[0].data=res.data
      myChart.setOption(pieOptions)
    }
    else
    {
      ElMessage.error(res)
    }
  })
}

const loadNotice = () => {
  request.get('/notice/selectAll').then(res => {
    if (res.code === '200') {
      data.noticeData = res.data
      if (data.noticeData.length > 4) {
        data.noticeData = data.noticeData.slice(0, 4)
      }
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const loadExamPlan = () => {
  request.get('/examPlan/selectAll').then(res => {
    if (res.code === '200') {
      data.planData = res.data
      if (data.planData.length > 4) {
        data.planData = data.planData.slice(0, 4)
      }
    } else {
      ElMessage.error(res.msg)
    }
  })
}
loadNotice()
loadExamPlan()
onMounted(()=>{
  loadPie()

})
let pieOptions = {
  title: {
    text: '不同状态下学生用户的数量',
    subtext: '统计维度：学生审核状态',
    left: 'center'
  },
  color: ['#91cc75','#ee6666','#ffdc60' ],
  tooltip: {
    trigger: 'item'
  },
  legend: {
    orient: 'vertical',
    left: 'left'
  },
  series: [
    {
      name: 'Access From',
      type: 'pie',
      radius: '50%',
      data:[],
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.5)'
        }
      }
    }
  ]
};



</script>