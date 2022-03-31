import { login, logout, getInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    username: '',
    avatar: '',
    roles: [],
    permissions: [],
    // httpURL:'http://9vtied.natappfree.cc',
    httpURL:'https://www.kpdwm.com/'
  }
}

const state = getDefaultState()

const mutations = {
  // 存储用户token
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  // 存储用户名
  SET_USERNAME: (state, username) => {
    state.username = username
  },
  // 存储用户头像
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_ROLES: (state, roles) => {
    state.roles = roles
  },
  SET_PERMISSIONS: (state, permissions) => {
    state.permissions = permissions
  }
}

const actions = {
  // user login
  login({ commit }, loginForm) {
    return new Promise((resolve, reject) => {
      login(loginForm).then(response => {
        setToken(response.data)
        commit('SET_TOKEN', response.data)
        resolve()
      }).catch(error => {   
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getInfo().then(response => {
        const res = response.data;
        const user = res.user
        if (res.roles && res.roles.length > 0) { // 验证返回的roles是否是一个非空数组
          commit('SET_ROLES', res.roles)
          commit('SET_PERMISSIONS', res.permissions)
        } else {
          commit('SET_ROLES', ['ROLE_DEFAULT'])
        }
        commit('SET_USERNAME', user.username)
        commit('SET_AVATAR',state.httpURL+user.avatar)
        resolve(res)
      }).catch(error => {
        reject(error)
      })
    })
  },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

