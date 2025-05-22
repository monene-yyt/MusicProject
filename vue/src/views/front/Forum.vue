<template>
  <div class="forum-page-wrapper">
    <div class="forum-container">
      <!-- 搜索区域 -->
      <div class="search-bar">
        <el-input v-model="data.title" clearable @clear="reset" placeholder="搜索帖子标题" size="large"
          class="search-input" />
        <el-button type="primary" size="large" @click="load">查询</el-button>
      </div>

       时间线展示
      <el-timeline class="post-timeline" style="margin: 20px 0">
        <el-timeline-item v-for="item in data.articleData" :key="item.id" :timestamp="item.time" placement="top">
          <div class="timeline-content" @click="navTo(item.id)">
            <div class="timeline-header">
              <el-avatar :src="item.studentAvatar" size="small" />
              <span class="author-name">{{ item.studentName }}</span>
            </div>
            <div class="timeline-body">
              <h3 class="post-title">{{ item.title }}</h3>
              <!-- 文本截断展示 -->
              <div class="post-html text-center">{{ truncateContent(item.content) }}</div>
            </div>
          </div>
        </el-timeline-item>
      </el-timeline>
<!--      <div>
        <el-row :gutter="10">
          <el-col :span="6" v-for="item in data.articleData" style="margin-bottom: 15px">
            <div class="card" style="cursor: pointer" @click="navTo('/front/forumDetail?id=' + item.id)">&lt;!&ndash;在整个大的divcard上面去点击point一个事件，用于展示详细页面，路由的跳转&ndash;&gt;
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
      </div>-->
<!--      <div v-if="data.total" style="margin: 20px 0">
        <el-pagination @current-change="load" background layout="prev, pager, next" :page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total" />
      </div>-->

      <div v-if="data.total" class="pagination-container">
        <el-pagination background layout="prev, pager, next" :page-size="data.pageSize" @current-change="load"
          v-model:current-page="data.pageNum" :total="data.total" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue';
import request from '@/utils/request.js';
import { ElMessage } from 'element-plus';

const data = reactive({
  title: '',
  pageNum: 1,
  pageSize: 8,
  total: 0,
  articleData: []
});

const load = () => {
  request.get('/article/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      title: data.title
    }
  })
    .then(res => {
      if (res.code === '200') {
        data.articleData = res.data.list.reverse();
        data.total = res.data.total;
      } else {
        ElMessage.error(res.msg);
      }
    })
    .catch(() => ElMessage.error('加载失败'));
};

const reset = () => {
  data.title = '';
  load();
};

const navTo = id => {
  window.location.href = `/front/forumDetail?id=${id}`;
};

// 截断内容函数：提取纯文本并限制在200字符
const truncateContent = (html, maxLength = 200) => {
  const text = html.replace(/<[^>]+>/g, '');
  return text.length > maxLength ? text.slice(0, maxLength) + '...' : text;
};

// 初始加载
load();
</script>

<style scoped>
.forum-page-wrapper {
  display: flex;
  justify-content: center;
  background-color: #f5f7fa;

}

.forum-container {
  padding: 20px;
  background-color: #f5f7fa;
  width: 100%;
  max-width: 900px;
}

.search-bar {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.search-input {
  width: 400px;
  margin-right: 10px;
}

.post-timeline {
  max-width: 800px;
  margin: 0 auto;
}

.timeline-content {
  cursor: pointer;
  background: #fff;
  padding: 16px;
  border-radius: 8px;
  transition: box-shadow 0.2s;
}

.timeline-content:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.timeline-header {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.author-name {
  margin: 0 8px;
  color: #303133;
  font-weight: 500;
}

.timeline-body .post-title {
  margin: 0 0 6px;
  font-size: 18px;
  color: #303133;
  text-align: center;
}

.post-html {
  color: #606266;
  font-size: 14px;
  line-height: 1.6;
  text-align: center;
}

.pagination-container {
  text-align: center;
  padding: 20px 0;
}
</style>
