<template>
  <div class="course-detail">
    <!-- 标题区 -->
    <div class="header">
      <h1>{{ course.name }}</h1>
      <p>
        讲师：<span>{{ course.teacherName }}</span>
        <el-tag :type="getLevelType(course.level)" style="margin-left: 10px">{{ course.level }}</el-tag>
      </p>
      <p class="learning-count">共学习人数：{{ studyCount }}</p>

      <!-- 加入学习计划按钮 -->
      <el-button type="success" @click="togglePlan" class="plan-button">
        {{ isInPlan ? '从我的学习计划中移除' : '加入我的学习计划' }}
      </el-button>
    </div>

    <!-- 视频和描述 -->
    <div class="content">
      <div class="left">
        <video v-if="course.videoUrl" controls class="video-player">
          <source :src="course.videoUrl" type="video/mp4" />
          您的浏览器不支持 video 标签。
        </video>
      </div>
      <div class="right">
        <h3 style="text-align: center;">课程详情</h3>
<!--        <p>{{ course.desp }}</p>-->
        <div style="margin-top: 50px" v-html="course.desp"></div>
      </div>
    </div>

    <!-- 评论区 -->
    <div class="comment-section">
      <h3>课程评论</h3>

      <!-- 输入框 -->
      <el-input type="textarea" v-model="newComment" placeholder="写下你的评论..." rows="3" />
      <el-button type="primary" style="margin: 10px 0" @click="submitComment">评论</el-button>

      <!-- 评论列表 -->
      <div class="comment-list">
        <div v-for="comment in commentPage.list" :key="comment.id" class="comment-item">
          <div class="comment-header">
            <div class="avatar-name">
              <img class="avatar" :src="comment.avatar || defaultAvatar" alt="avatar" />
              <span>{{ comment.username }}（{{ formatRole(comment.role) }}）</span>
            </div>
            <span class="time">{{ formatDate(comment.createTime) }}</span>
          </div>

          <div class="comment-content">{{ comment.content }}</div>
          <div class="comment-actions">
            <el-button size="small" @click="toggleReply(comment.id)">回复</el-button>
            <el-button size="small" @click="likeComment(comment.id)">👍 {{ comment.likeCount || 0 }}</el-button>
            <el-button size="small" type="danger" v-if="comment.userId === user.id"
              @click="deleteComment(comment.id)">删除</el-button>
          </div>

          <!-- 回复输入 -->
          <div v-if="replyVisibleId === comment.id" class="reply-box">
            <el-input v-model="replyContent" placeholder="写下你的回复..." size="small" style="height: 40px;width: 200px;" />
            <el-button size="small" type="success" style="margin-top: 5px;margin-left: 30px;"
              @click="submitReply(comment.id)">提交回复</el-button>
          </div>

          <!-- 回复列表 -->
          <div v-for="reply in comment.children || []" :key="reply.id" class="reply-item">
            <div class="avatar-name">
              <img class="avatar" :src="reply.avatar || defaultAvatar" alt="avatar" />
              <span>{{ reply.username }}（{{ formatRole(reply.role) }}）</span>：<span>{{ reply.content }}</span>

              <span v-if="reply.userId === user.id" class="delete-comment" @click="deleteComment(reply.id)">
                删除
              </span>
            </div>
          </div>

        </div>
      </div>

      <!-- 分页 -->
      <el-pagination background layout="prev, pager, next" :total="commentPage.total" :page-size="commentPage.pageSize"
        :current-page="commentPage.pageNum" @current-change="handlePageChange" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import request from '@/utils/request';
import { ElMessage } from 'element-plus';

const isInPlan = ref(false);

const route = useRoute();
const courseId = route.query.id;
const user = JSON.parse(localStorage.getItem('xm-user') || '{}');

const course = reactive({ name: '', level: '', teacherName: '', desp: '', videoUrl: '' });
const newComment = ref('');
const replyVisibleId = ref(null);
const replyContent = ref('');
const commentPage = reactive({ list: [], pageNum: 1, pageSize: 5, total: 0 });
const studyCount = ref(0); // 学习人数

const checkMyPlan = () => {
  request.get(`/studentcourse/is-added`, {
    params: { courseId, studentId: user.id }
  }).then(res => {
    if (res.code === '200') {
      isInPlan.value = res.data;
    } else {
      ElMessage.error(res.msg);
    }
  });
};

const togglePlan = () => {
  const url = isInPlan.value ? '/studentcourse/remove' : '/studentcourse/add';
  request.post(url, {
    courseId,
    studentId: user.id
  }).then(res => {
    if (res.code === '200') {
      isInPlan.value = !isInPlan.value;
      ElMessage.success(isInPlan.value ? '已加入学习计划' : '已从学习计划移除');
    } else {
      ElMessage.error(res.msg);
    }
    window.location.reload();
  });
};

const loadCourse = () => {
  request.get(`/course/selectById/${courseId}`).then(res => {
    if (res.code === '200') {
      Object.assign(course, res.data);
      studyCount.value = res.data.studyCount || 0;
    } else ElMessage.error(res.msg);
  });
};

const formatDate = (dateStr) => {
  const date = new Date(dateStr);
  return date.toLocaleString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit' });
};

const loadComments = () => {
  request.get(`/comments/course/${courseId}/comments`, { params: { pageNum: commentPage.pageNum, pageSize: commentPage.pageSize } })
    .then(res => {
      if (res.code === '200') {
        console.log(res.data)
        commentPage.list = buildCommentTree(res.data.list);
        commentPage.total = res.data.total;   // 总数用于分页器
      } else {
        ElMessage.error(res.msg);
      }
    });
};

function buildCommentTree(list) {
  const map = {};
  const tree = [];
  console.log(list)
  list.forEach(item => { item.replies = []; map[item.id] = item; });
  list.forEach(item => {
    if (item.parentId) {
      const parent = map[item.parentId];
      if (parent) { parent.replies.push(item); }
    } else { tree.push(item); }
    console.log("tree", tree)
  });
  return tree;
}

const formatRole = (role) => {
  if (role === 'STUDENT') return '学生';
  if (role === 'TEACHER') return '老师';
  if (role === 'ADMIN') return '管理员';
  return '未知';
};

const submitComment = () => {
  if (!newComment.value.trim()) return ElMessage.warning('评论不能为空');
  request.post('/comments', {
    courseId,
    userId: user.id,
    username: user.name,
    content: newComment.value,
    role: user.role,
  }).then(res => {
    if (res.code === '200') {
      newComment.value = '';
      ElMessage.success('评论成功');
      loadComments();
    } else ElMessage.error(res.msg);
  });
};

const deleteComment = (id) => {
  ElMessageBox.confirm('确定要删除这条评论吗？', '删除确认', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    request.delete(`/comments/${id}`, { params: { userId: user.id } }).then(res => {
      if (res.code === '200') {
        ElMessage.success('删除成功');
        loadComments();
      } else {
        ElMessage.error(res.msg);
      }
    });
  }).catch(() => { });
};

const likeComment = (commentId) => {
  request.post(`/comments/like`, {
    commentId: commentId,
    userId: user.id
  }).then(res => {
    if (res.code === '200') {
      ElMessage.success('点赞成功');
      loadComments();
    } else {
      ElMessage.error(res.msg);
    }
  }).catch(error => {
    ElMessage.error('点赞失败，请重试');
  });
};

const submitReply = (parentId) => {
  if (!replyContent.value.trim()) return ElMessage.warning('回复不能为空');
  request.post('/comments/reply', {
    parentId, courseId, userId: user.id, username: user.name,
    role: user.role, content: replyContent.value,
  }).then(res => {
    if (res.code === '200') {
      replyContent.value = '';
      replyVisibleId.value = null;
      ElMessage.success('回复成功');
      loadComments();
    } else ElMessage.error(res.msg);
  });
};

const toggleReply = (id) => {
  replyVisibleId.value = replyVisibleId.value === id ? null : id;
  replyContent.value = '';
};

const handlePageChange = (page) => {
  commentPage.pageNum = page;
  loadComments();
};

const getLevelType = (level) => {
  if (level === '基础') return 'warning';
  if (level === '中等') return 'info';
  if (level === '困难') return 'danger';
  return 'default';
};

onMounted(() => {
  loadCourse();
  loadComments();
  checkMyPlan();
});
</script>

<style scoped>
.course-detail {
  background-color: #f2f6fc;
  padding-bottom: 60px;
}

/* 标题区 */
.header {
  text-align: center;
  margin: 30px 0;
  position: relative;
}

.header h1 {
  font-size: 28px;
  color: #333;
  margin-bottom: 10px;
}

.learning-count {
  font-size: 16px;
  color: #888;
  margin-top: 10px;
}

.plan-button {
  position: absolute;
  right: 20px;
  top: 10px;
}

/* 内容布局 */
.content {
  display: flex;
  gap: 30px;
  padding: 0 60px;
  margin-bottom: 40px;
}

.left {
  flex: 8;
}

.right {
  flex: 4;
  background: #ffffff;
  padding: 25px;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

/* 视频 */
.video-player {
  width: 100%;
  height: 420px;
  border-radius: 12px;
  background-color: #000;
}

/* 评论区 */
.comment-section {
  margin: 0 60px;
  background: #ffffff;
  padding: 30px;
  border-radius: 16px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
}

.comment-section h3 {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 16px;
}

/* 评论列表 */
.comment-list {
  display: flex;
  flex-direction: column;
  gap: 24px;
  margin-top: 20px;
}

/* 评论卡片 */
.comment-item {
  background: #fafafa;
  border-left: 4px solid #409EFF;
  padding: 16px 20px;
  border-radius: 12px;
  transition: background 0.3s;
}

.comment-item:hover {
  background: #f0f3f7;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
  color: #999;
  margin-bottom: 6px;
}

.avatar-name {
  display: flex;
  align-items: center;
  gap: 10px;
}

.avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #ccc;
}

.comment-content {
  font-size: 16px;
  color: #333;
  margin-bottom: 12px;
}

.comment-actions {
  display: flex;
  gap: 12px;
}

.comment-actions .el-button {
  font-size: 13px;
  padding: 4px 10px;
  transition: all 0.2s ease;
}

.comment-actions .el-button:hover {
  transform: scale(1.05);
}

/* 回复框 */
.reply-box {
  margin-top: 10px;
  padding-left: 40px;
}

/* 回复项 */
.reply-item {
  margin-top: 8px;
  margin-left: 40px;
  padding: 10px 14px;
  background: #edf1f7;
  border-left: 3px solid #67c23a;
  border-radius: 8px;
  font-size: 14px;
  color: #333;
}

/* 删除按钮 */
.delete-comment {
  color: red;
  cursor: pointer;
  font-size: 14px;
}
</style>
