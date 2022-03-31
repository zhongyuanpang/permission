import request from '@/utils/request'


// 查询角色列表
export function listRole(query) {
  return request({
    url: '/system/role/list',
    method: 'get',
    params: query
  })
}

// 查询角色详细
export function getRole(roleId) {
  return request({
    url: `/system/role/info/${roleId}`,
    method: 'get'
  })
}


// 新增角色
export function addRole(data) {
  return request({
    url: '/system/role/add',
    method: 'post',
    data: data
  })
}

// 修改角色
export function updateRole(data) {
  return request({
    url: '/system/role/update',
    method: 'post',
    data: data
  })
}

// 删除角色
export function delRole(data) {
  return request({
    url: '/system/role/delete',
    method: 'post',
    data
  })
}


// 角色状态修改
export function changeRoleStatus(id, statu) {
  const data = {
    id,
    statu
  }
  return request({
    url: '/system/role/changeStatus',
    method: 'put',
    data: data
  })
}
