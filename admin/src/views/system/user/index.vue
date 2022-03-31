<template>
  <div class="admin-container">
    <!-- 操作栏 -->
    <el-form :model="queryParams" ref="queryForm" v-show="showSearch" :inline="true">
      <el-form-item label="用户名称" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入用户名称"
          clearable
          size="small"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="邮箱" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入邮箱"
          clearable
          size="small"
          style="width: 240px"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="状态" prop="statu">
        <el-select
          v-model="queryParams.statu"
          placeholder="角色状态"
          clearable
          size="small"
          style="width: 240px"
        >
          <el-option label="正常" value="0"/>
          <el-option label="禁用" value="1"/>
        </el-select>
      </el-form-item>
      
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:user:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:user:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:user:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 用户列表展示 -->
    <el-table v-loading="loading" :data="userList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="50" align="center"/>
          <el-table-column label="用户编号" align="center" key="userId" prop="userId" />
          <el-table-column label="头像" align="center" width="100">
            <template slot-scope="scope">
              <el-avatar
                size="medium"
                :src="httpURL + scope.row.avatar"
              ></el-avatar>
            </template>
          </el-table-column>
          <el-table-column label="用户名称" align="center" key="userName" prop="userName" :show-overflow-tooltip="true" />
          <el-table-column label="用户昵称" align="center" key="nickName" prop="nickName" :show-overflow-tooltip="true" />
          <el-table-column label="邮箱" align="center" key="email" prop="email"  />
          <el-table-column label="性别" align="center" key="sex" prop="sex" width="120" />
          <el-table-column prop="roles" label="角色名称">
              <template slot-scope="scope">
                <el-tag size="small" type="warning" v-for="(item,index) in scope.row.roles" :key="index">
                  {{ item.roleName }} 
                </el-tag>
              </template>
          </el-table-column>
          <el-table-column label="状态" align="center" key="status">
            <template slot-scope="scope" v-if="scope.row.id !== 1">
              <el-switch
                v-model="scope.row.status"
                active-value="0"
                inactive-value="1"
                @change="handleStatusChange(scope.row)"
              ></el-switch>
            </template>
          </el-table-column>
          <el-table-column label="创建时间" align="center" prop="createTime"  width="160">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="操作"
            align="center"
            class-name="small-padding fixed-width"
          >
            <template slot-scope="scope" v-if="scope.row.userId !== 1">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
                v-hasPermi="['system:user:edit']"
              >修改</el-button>
              <el-button
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
                v-hasPermi="['system:user:remove']"
              >删除</el-button>
              <el-dropdown size="mini" @command="(command) => handleCommand(command, scope.row)"  v-hasPermi="['system:user:resetPwd']">
                <el-button
                size="mini"
                class="el-dropdown-link"
                type="text"
              ><i class="el-icon-d-arrow-right el-icon--right"></i>更多</el-button>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item command="handleResetPwd" icon="el-icon-key" v-hasPermi="['system:user:resetPwd']">重置密码</el-dropdown-item>
                  <!-- <el-dropdown-item command="handleAuthRole" icon="el-icon-circle-check">分配角色</el-dropdown-item> -->
                </el-dropdown-menu>
              </el-dropdown>
            </template>
          </el-table-column>
        </el-table>


    <!-- 添加或修改用户配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="用户昵称" prop="nickName">
              <el-input v-model="form.nickName" placeholder="请输入用户昵称" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱" maxlength="50" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item v-if="form.id == undefined" label="用户名称" prop="userName">
              <el-input v-model="form.userName" placeholder="请输入用户名称" maxlength="30" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item v-if="form.id == undefined" label="用户密码" prop="password">
              <el-input v-model="form.password" placeholder="请输入用户密码" type="password" maxlength="20" show-password/>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="用户性别">
              <el-select v-model="form.sex" placeholder="请选择">
                <el-option label="男" value="男"/>
                <el-option label="女" value="女"/>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="角色">
              <el-select v-model="form.roleIds" multiple placeholder="请选择">
                <el-option
                  v-for="item in role_list"
                  :key="item.id"
                  :label="item.roleName"
                  :value="item.id"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="状态" prop="statu">
              <el-radio-group v-model="form.statu">
                <el-radio label="0">正常</el-radio>
                <el-radio label="1">禁用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="备注">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>


    <pagination
      class="text_r"
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import { Message } from "element-ui";
import { listUser,getUser,addUser, updateUser,delUser,resetUserPwd,changeUserStatus,sendCode,resetPwd } from "@/api/system/user";
export default {
  name: "user",
  computed: {
    ...mapGetters([]),
  },
  // 注册组件引用
  components: {},
  filters: {
    formatDate(time) {
      // 秒处理为毫秒
      let date = new Date(time);
      return formatDate(date, "yyyy-MM-dd hh:mm");
    },
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      //http资源地址
      httpURL: this.$store.state.user.httpURL,
      //用户列表
      userList: [],
      // 是否显示弹出层
      open: false,
      // 弹出层标题
      title: "",
      // 选中数组
      ids: [],
      //角色列表
      role_list:[],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 存储要删除的id
      removeIds:[],
      // 显示搜索条件
      showSearch: true,
      //条目数
      total: 0,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: undefined,
        email: undefined,
        status: undefined
      },
      // 添加用户表单
      form: {},
      // 表单校验
      rules: {
        userName: [
          { required: true, message: "用户名称不能为空", trigger: "blur" },
          { min: 2, max: 20, message: '用户名称长度必须介于 2 和 20 之间', trigger: 'blur' }
        ],
        nickName: [
          { required: true, message: "用户昵称不能为空", trigger: "blur" }
        ],
        statu: [
          { required: true, message: "请选择用户状态", trigger: "blur" }
        ],
        password: [
          { required: true, message: "用户密码不能为空", trigger: "blur" },
          { min: 5, max: 20, message: '用户密码长度必须介于 5 和 20 之间', trigger: 'blur' }
        ],
        email: [
          {
            required:true,
            type: "email",
            message: "'请输入正确的邮箱地址",
            trigger: ["blur"]
          }
        ]
      },
      

    };
  },
  mounted() {
    // 调用获取用户list方法
    this.getList();
  },
  computed: {

  },
  methods: {
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },

    // 表单重置
    reset() {
      this.form = {
        id:undefined,
        userName: undefined,
        nickName: undefined,
        password: undefined,
        status: "0",
        email: undefined,
        sex: undefined,
        roleIds: []
      };
      this.resetForm("form");
    },

    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      getUser().then(response => {
        this.role_list = response.data.roles;
        this.open = true;
        this.title = "添加用户";
        this.form.password = '123456';
      });
    },

    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const userId = row.userId || this.ids;
      getUser(userId).then(response => {
        this.form = response.data.data;
        this.role_list = response.data.roles;
        this.form.roleIds = response.data.roleIds;
        this.open = true;
        this.title = "修改用户";
      });
    },

    /** 删除按钮操作 */
    handleDelete(row) {
      var removeids = [];
      if(row.id){
        removeids.push(row.id)
      }else{
        removeids = this.ids
      }
      this.$modal.confirm('是否确认删除角色编号为"' + removeids + '"的数据项？').then(function() {
        return delUser(removeids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },

    // 管理员列表
    getList() {
      this.loading = true;
      listUser(this.queryParams).then(res=>{
        this.userList = res.data.records;
        this.total = res.data.total
        this.loading = false;
      })
    },

    // 表格check 选框
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },

    // 用户状态修改
    handleStatusChange(row) {
      let text = row.statu === "0" ? "启用" : "停用";
      this.$modal.confirm('确认要"' + text + '""' + row.userName + '"用户吗？').then(function() {
        return changeUserStatus(row.id, row.statu);
      }).then(() => {
        this.$modal.msgSuccess(text + "成功");
      }).catch(function() {
        row.statu = row.statu === "0" ? "1" : "0";
      });
    },

    /** 重置密码按钮操作 */
    handleResetPwd(row) {
      this.$prompt('请输入"' + row.userName + '"的新密码', "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        closeOnClickModal: false,
        inputPattern: /^.{5,20}$/,
        inputErrorMessage: "用户密码长度必须介于 5 和 20 之间"
      }).then(({ value }) => {
          resetUserPwd(row.id, value).then(response => {
            this.$modal.msgSuccess("修改成功，新密码是：" + value);
          });
        }).catch(() => {});
    },

    // 更多操作触发
    handleCommand(command, row) {
      switch (command) {
        case "handleResetPwd":
          this.handleResetPwd(row);
          break;
        case "handleAuthRole":
          this.handleAuthRole(row);
          break;
        default:
          break;
      }
    },

    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateUser(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addUser(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },

  }
};
</script>

<style lang="scss" scoped>
.admin {
  &-container {
    margin: 20px;
  }

}
.nav {
  display: flex;
  margin-bottom: 20px;
  .search {
    width: 200px;
    margin-right: 10px;
  }
}
.table_info {
  .table {
    width: 100%;
    color: #888;
    font-size: 0.8em;
  }
}
.demo-drawer__content{
  position: relative;
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
  .demo-drawer__footer{
    position: absolute;
    bottom: 10px;
    width: 100%;
    display: flex;
    justify-content: space-between;
    .el-button{
      flex: 1;
    }
  }
}

</style>