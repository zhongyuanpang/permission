import axios from 'axios'
import { Notification, MessageBox, Message, Loading } from 'element-ui'
import store from '@/store'
import { getToken } from '@/utils/auth'
import {BASE_API } from '@/utils/config'

// create an axios instance
const service = axios.create({
  baseURL: BASE_API, // url = base url + request url
  // withCredentials: true, // send cookies when cross-domain requests
  timeout: 50000000 // request timeout
})

// 请求拦截器
service.interceptors.request.use(
  config => {
    // 是否需要设置 token
    const isToken = (config.headers || {}).isToken === false
    if (getToken() && !isToken) {
      config.headers['Authorization'] = getToken() // 让每个请求携带自定义token 请根据实际情况自行修改
    }
    // get请求映射params参数
    // if (config.method === 'get' && config.params) {
    //   let url = config.url + '?' + tansParams(config.params);
    //   url = url.slice(0, -1);
    //   config.params = {};
    //   config.url = url;
    // }
    return config;
  },
  error => {
    // 处理请求错误
    console.log(error) // for debug
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(

  response => {
    const res = response.data

    const { code,msg } = res

    if (code === 401) {
      MessageBox.confirm('登录状态已过期，您可以继续留在该页面，或者重新登录', '系统提示', {
          confirmButtonText: '重新登录',
          cancelButtonText: '取消',
          type: 'warning'
        }
      ).then(() => {
        store.dispatch('user/logout').then(() => {
          location.href = '/login';
        })
      }).catch(() => {});
      return Promise.reject('无效的会话，或者会话已过期，请重新登录。')
    } else if (code === 500) {
      Message({
        message: msg,
        type: 'error'
      })
      return Promise.reject(new Error(msg))
    } else if(code === 3527){
      
    } else if (code !== 200) {
      Notification.error({
        title: "提示",
        message:msg
      })
      return Promise.reject(msg)
    } else {
      return res
    }
  },
  // 响应数据错误
  error => {
    console.error(error) // for debug
    if (error && error.response) {
        console.log(error.response.status);
        switch (error.response.status) {
            case 400:
                error.message = '请求错误'
                break
            case 401:
                error.message = '未授权，请登录'
                break
            case 403:
                error.message = '拒绝访问'
                break
            case 404:
                error.message = `请求地址出错: ${error.response.config.url}`
                break
            case 408:
                error.message = '请求超时'
                break
            case 500:
                error.message = '服务器内部错误'
                break
            case 501:
                error.message = '服务未实现'
                break
            case 502:
                error.message = '网关错误'
                break
            case 503:
                error.message = '服务不可用'
                break
            case 504:
                error.message = '网关超时'
                break
            case 505:
                error.message = 'HTTP版本不受支持'
                break
            default:
                break
        }
    }
    return Promise.reject(error)
  }
)

export default service
