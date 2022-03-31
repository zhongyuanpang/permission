import request from '@/utils/request'


// 查询菜单列表
export function listMenu(query) {
  return request({
    url: '/system/menu/list',
    method: 'get',
    params:query
  })
}

// 新增菜单
export function addMenu(data) {
  return request({
    url: '/system/menu/add',
    method: 'post',
    data
  })
}

// 修改菜单
export function updateMenu(data) {
  return request({
    url: '/system/menu/update',
    method: 'post',
    data: data
  })
}


// 查询菜单详细
export function getMenu(menuId) {
  return request({
    url: '/system/menu/'+menuId,
    method: 'get'
  })
}

// 删除菜单
export function delMenu(menuId) {
  return request({
    url: `/system/menu/delete/${menuId}`,
    method: 'post'
  })
}


// 查询菜单下拉树结构
export function treeselect() {
  return request({
    url: '/system/menu/treeselect',
    method: 'get'
  })
}

// 根据角色ID查询菜单下拉树结构
export function roleMenuTreeselect(roleId) {
  return request({
    url: '/system/menu/roleMenuTreeselect',
    method: 'get',
    params:{roleId}
  })
}

