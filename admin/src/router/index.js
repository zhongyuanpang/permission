import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/views/login'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

export const constantRoutes = [
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path(.*)',
        component: (resolve) => require(['@/views/redirect'], resolve)
      }
    ]
  },
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  // 仪表盘
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [{
      path: 'dashboard',
      name: 'Dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '仪表盘', icon: 'dashboard' }
    }]
  },

  

  // { path: '*', redirect: '/404', hidden: true }
]


// const createRouter = () => new Router({
//   // mode: 'history', // require service support
//   scrollBehavior: () => ({ y: 0 }),
//   routes: constantRoutes
// })

// const router = createRouter()

// // 重置路由
// export function resetRouter() {
//   const newRouter = createRouter()
//   router.matcher = newRouter.matcher // reset router
// }

// export default router



export default new Router({
  mode: 'hash', // 去掉url中的#
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})
