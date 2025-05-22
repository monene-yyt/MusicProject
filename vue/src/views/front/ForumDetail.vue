<template>
  <div style="width: 60%; margin: 30px auto">
    <div style="font-size: 20px; font-weight: bold; text-align: center">{{ data.articleData.title }}</div>
    <div style="margin-top: 15px; color: #666666; text-align: center">
      <span>发布人：{{ data.articleData.studentName }}</span>
      <span style="margin-left: 30px">发布时间：{{ data.articleData.time }}</span>
    </div>
    <div style="margin-top: 50px" v-html="data.articleData.content"></div>
  </div>
</template>
<script setup>
import { reactive, onMounted } from "vue";
import request from "@/utils/request.js";
import router from "@/router/index.js";
import { ElMessage } from "element-plus";

const data = reactive({
  articleId: router.currentRoute.value.query.id,
  articleData: {}
})

const loadArticle = () => {
  data.articleId = router.currentRoute.value.query.id
  request.get('/article/selectById/' + data.articleId).then(res => {
    if (res.code === '200') {
      data.articleData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}
onMounted(() => {
  loadArticle()
})
</script>