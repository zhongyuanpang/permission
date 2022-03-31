import request from '@/utils/request'

// 登录方法
export function login(data) {

  return request({
    url: '/login',
    headers: {
      isToken: false
    },
    method: 'post',
    data
  })
}

// 获取用户详细信息
export function getInfo() {
    return request({
      url: '/getInfo',
      method: 'get',
    })
  }

// 退出方法
export function logout() {
  return request({
    url: '/logout',
    method: 'post'
  })
}