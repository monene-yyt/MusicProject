<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" prefix-icon="Search" style="width: 240px; margin-right: 10px"
        placeholder="请输入课程名称查询"></el-input>
      <el-button type="info" plain @click="load">查询</el-button>
      <el-button type="warning" plain style="margin: 0 10px" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button v-if="data.user.role === 'TEACHER'" type="primary" plain @click="handleAdd">新增</el-button>
      <el-button type="danger" plain @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table stripe :data="data.tableData" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="img" label="课程封面">
          <template v-slot="scope">
            <el-image style="width: 60px; height: 40px; border-radius: 5px; display: block" v-if="scope.row.img"
              :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="name" label="课程名称" />
        <el-table-column prop="teacherName" label="授课教师" />
        <el-table-column prop="score" label="课程学分" />
        <el-table-column prop="level" label="课程难度" />
        <el-table-column label="操作" width="100" fixed="right">
          <template v-slot="scope">
            <el-button v-if="data.user.role === 'TEACHER'" type="primary" circle :icon="Edit"
              @click="handleEdit(scope.row)"></el-button>
            <el-button type="danger" circle :icon="Delete" @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="prev, pager, next" :page-size="data.pageSize"
        v-model:current-page="data.pageNum" :total="data.total" />
    </div>

    <el-dialog title="课程信息" v-model="data.formVisible" width="40%" destroy-on-close>
      <el-form ref="refForm" :model="data.form" :rules="rules" label-width="100px" style="padding: 20px">
        <el-form-item prop="img" label="课程封面">
          <el-upload :action="baseUrl + '/files/upload'" :on-success="handleFileUpload" list-type="picture">
            <el-button type="primary">上传封面</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item prop="video" label="课程视频">
          <el-upload :action="baseUrl + '/files/uploadVideo'" :on-success="handleVideoUpload"
            :before-upload="beforeVideoUpload" :on-progress="onVideoUploading" :show-file-list="true" accept="video/*"
            list-type="text">
            <el-button type="success">上传视频</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="预览视频" v-if="data.form.videoUrl">
          <video :src="data.form.videoUrl" controls style="width: 100%; border-radius: 8px"></video>
        </el-form-item>

        <el-form-item prop="name" label="课程名称">
          <el-input v-model="data.form.name" placeholder="请输入课程名称"></el-input>
        </el-form-item>
        <el-form-item prop="score" label="课程学分">
          <el-input v-model="data.form.score" placeholder="请输入课程学分"></el-input>
        </el-form-item>

        <el-form-item prop="level" label="课程难度">
          <el-select size="large" v-model="data.form.level" placeholder="请选择课程难度">
            <el-option value="基础" label="基础"></el-option>
            <el-option value="中等" label="中等"></el-option>
            <el-option value="困难" label="困难"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="desp" label="课程简介">
          <el-input v-model="data.form.desp" type="textarea" :rows="4" placeholder="请输入课程简介" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="save" :disabled="data.videoUploading">确 定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>

import { reactive } from "vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";
import { Delete, Edit } from "@element-plus/icons-vue";
import { ref } from 'vue'
const refForm = ref(null)

const baseUrl = import.meta.env.VITE_BASE_URL

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
  formVisible: false,
  form: {},
  tableData: [],
  pageNum: 1,
  pageSize: 10,
  total: 0,
  name: null,
  ids: [],
  videoUploading: false // 视频是否正在上传

})
const rules = {
  name: [{ required: true, message: '请输入课程名称', trigger: 'blur' }],
  score: [{ required: true, message: '请输入课程学分', trigger: 'blur' }],
  level: [{ required: true, message: '请选择课程难度', trigger: 'change' }],
  desp: [{ required: true, message: '请输入课程简介', trigger: 'blur' }],
  img: [{ required: true, message: '请上传课程封面', trigger: 'change' }],
  videoUrl: [{ required: true, message: '请上传课程视频', trigger: 'change' }]
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
      data.tableData = res.data?.list || []
      data.total = res.data?.total
    } else {
      ElMessage.error(res.msg)
    }
  })
}
const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}
const handleVideoUpload = (res) => {
  data.videoUploading = false  // 上传成功，解除禁用

  data.form.videoUrl = res.data
  ElMessage.success('视频上传完成！')

}

const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))
  console.log(row)
  // 如果有封面和视频，确保其链接能正确显示
  data.form.img = row.img || ''
  console.log(row.img)
  data.form.videoUrl = row.videoUrl || ''
  data.formVisible = true
}
const add = () => {
  request.post('/course/add', data.form).then(res => {
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const update = () => {
  request.put('/course/update', data.form).then(res => {
    if (res.code === '200') {
      ElMessage.success('操作成功')
      data.formVisible = false
      load()
    }
  })
}

const save = () => {
  const formRef = refForm.value
  formRef.validate((valid) => {
    if (valid) {
      data.form.id ? update() : add()
    } else {
      ElMessage.warning('请完整填写表单后再提交')
    }
  })
}

const beforeVideoUpload = () => {
  data.videoUploading = true  // 开始上传，禁用按钮
  ElMessage.info('视频正在上传中，请稍候...')

  return true
}
const onVideoUploading = () => {
  data.videoUploading = true  // 上传中状态
}
const del = (id) => {
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
    request.delete('/course/delete/' + id).then(res => {
      if (res.code === '200') {
        ElMessage.success("删除成功")
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {
    console.error(err)
  })
}
const delBatch = () => {
  if (!data.ids.length) {
    ElMessage.warning("请选择数据")
    return
  }
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗？', '删除确认', { type: 'warning' }).then(res => {
    request.delete("/course/delete/batch", { data: data.ids }).then(res => {
      if (res.code === '200') {
        ElMessage.success('操作成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {
    console.error(err)
  })
}
const handleSelectionChange = (rows) => {
  data.ids = rows.map(v => v.id)
}

const reset = () => {
  data.name = null
  load()
}

const handleFileUpload = (res) => {
  data.form.img = res.data
}

load()
</script>