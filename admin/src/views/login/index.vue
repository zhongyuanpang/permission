<template>
  <div class="login-container">
    <div class="login-particles">
      <!-- 粒子效果 -->
      <vue-particles color="#409EFF" shapeType="star"></vue-particles>
    </div>

    <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form" auto-complete="on" label-position="left">

      <div class="title-container">
        <h3 class="title">博客社区后台管理</h3>
      </div>

      <el-form-item prop="username">
        <span class="svg-container">
          <svg-icon icon-class="user" />
        </span>
        <el-input
          ref="username"
          v-model="loginForm.username"
          placeholder="serName"
          name="username"
          type="text"
          tabindex="1"
          auto-complete="on"
        />
      </el-form-item>

      <el-form-item prop="password">
        <span class="svg-container">
          <svg-icon icon-class="password" />
        </span>
        <el-input
          :key="passwordType"
          ref="password"
          v-model="loginForm.password"
          :type="passwordType"
          placeholder="Password"
          name="password"
          tabindex="2"
          auto-complete="on"
          @keyup.enter.native="handleLogin"
        />
        <span class="show-pwd" @click="showPwd">
          <svg-icon :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'" />
        </span>
      </el-form-item>

      <el-button :loading="loading" type="primary" style="width:100%;margin-bottom:30px;" @click.native.prevent="handleLogin">登录</el-button>
    </el-form>
  </div>
</template>

<script>
import store from '@/store'
import { Message } from 'element-ui'
import VueParticles from "vue-particles/src/vue-particles/vue-particles";
// import { validUsername } from '@/utils/validate'
 
export default {
  name: 'Login',
  components:{
    VueParticles
  },
  data() {
    const checkUsername = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入用户名'))
      } else {
        callback()
      }
    }
    const checkPassword = (rule, value, callback) => {
      if (value.length < 4) {
        callback(new Error('密码输入不正确'))
      } else {
        callback()
      }
    }
    return {
      loginForm: {
        username: 'admin',
        password: 'admin'
      },
      loginRules: {
        username: [{ required: true, trigger: 'blur', validator: checkUsername }],
        password: [{ required: true, trigger: 'blur', validator: checkPassword }]
      },
      loading: false,
      passwordType: 'password',
      redirect: undefined
    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  methods: {
    showPwd() {
      if (this.passwordType === 'password') {
        this.passwordType = ''
      } else {
        this.passwordType = 'password'
      }
      this.$nextTick(() => {
        this.$refs.password.focus()
      })
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          this.$store.dispatch('user/login', this.loginForm).then(() => {
            Message.success("登录成功");
            this.$router.push({ path: this.redirect || '/' }).catch(()=>{});
            this.loading = false
          }).catch(() => {
            this.loading = false
          })
        } else {
          Message.error("请先填写用户名或密码哦~")
          return false
        }
      })
    }
  }
}
</script>

<style lang="scss">
/* 修复input 背景不协调 和光标变色 */
/* Detail see https://github.com/PanJiaChen/vue-element-admin/pull/927 */

$bg:#283443;
$light_gray:#fff;
$cursor: #fff;

@supports (-webkit-mask: none) and (not (cater-color: $cursor)) {
  .login-container .el-input input {
    color: $cursor;
  }
}

/* reset element-ui css */
.login-container {
  .el-input {
    display: inline-block;
    height: 47px;
    width: 85%;

    input {
      background: transparent;
      border: 0px;
      -webkit-appearance: none;
      border-radius: 0px;
      padding: 12px 5px 12px 15px;
      color: $light_gray;
      height: 47px;
      caret-color: $cursor;

      &:-webkit-autofill {
        box-shadow: 0 0 0px 1000px $bg inset !important;
        -webkit-text-fill-color: $cursor !important;
      }
    }
  }

  .el-form-item {
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    color: #454545;
  }
}
</style>

<style lang="scss" scoped>
$bg:#e59116;
$dark_gray:#889aa4;
$light_gray:#eee;

.login-container {
  // background-image: url("../../assets/bg.jpg");
  background-position: center;
  background-size: cover;
  background-repeat: no-repeat;
  // min-height: 100%;
  height: 100vh;
  width: 100%;
  background-color: $bg;
  overflow: hidden;

  .login-particles {
    
    width: 100%;
    height: 100%;
  }
  .login-form {
    backdrop-filter: blur(5px);
    -webkit-backdrop-filter: blur(5px);	
    width: 520px;
    height: auto;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    background: rgba(0, 0, 0, 0.3);
    padding: 40px;
    border-radius: 5px;
    box-shadow: 0 0 5px #333;
    max-width: 100%;
  }

  .tips {
    font-size: 14px;
    color: #fff;
    margin-bottom: 10px;

    span {
      &:first-of-type {
        margin-right: 16px;
      }
    }
  }

  .svg-container {
    padding: 6px 5px 6px 15px;
    color: $dark_gray;
    vertical-align: middle;
    width: 30px;
    display: inline-block;
  }

  .title-container {
    position: relative;

    .title {
      font-size: 26px;
      color: $light_gray;
      margin: 0px auto 40px auto;
      text-align: center;
      font-weight: bold;
      letter-spacing: 2px;
      text-shadow: .2rem 0rem .5rem #1791ca,-.2rem 0rem .5rem #1791ca,0rem .2rem .5rem #1791ca,0rem -.2rem .5rem #1791ca;
    }
  }

  .show-pwd {
    position: absolute;
    right: 10px;
    top: 7px;
    font-size: 16px;
    color: $dark_gray;
    cursor: pointer;
    user-select: none;
  }
}
</style>
