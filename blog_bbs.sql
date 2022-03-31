/*
 Navicat Premium Data Transfer

 Source Server         : Test
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : blog_bbs

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 26/03/2022 20:16:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单Id',
  `menu_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父级菜单id',
  `order_num` int NULL DEFAULT NULL COMMENT '显示顺序',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT NULL COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT NULL COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更改时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'system', NULL, '2022-02-09 02:57:55', '2022-02-09 02:57:55', NULL);
INSERT INTO `sys_menu` VALUES (2, '用户管理', 1, 1, 'user', 'system/user/index', NULL, 1, 0, 'C', '0', '0', NULL, 'user', NULL, '2022-02-09 02:59:01', '2022-02-09 02:59:01', NULL);
INSERT INTO `sys_menu` VALUES (3, '角色管理', 1, 2, 'role', 'system/role/index', NULL, 1, 0, 'C', '0', '0', NULL, 'peoples', NULL, '2022-02-09 02:59:53', '2022-02-09 02:59:53', NULL);
INSERT INTO `sys_menu` VALUES (4, '菜单管理', 1, 3, 'menu', 'system/menu/index', NULL, 1, 0, 'C', '0', '0', NULL, 'tree-table', NULL, '2022-02-09 03:03:51', '2022-02-09 03:03:51', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色权限字符串',
  `role_sort` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色显示顺序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0正常 1删除）',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单树选择项是否关联显示',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '1', '0', '0', NULL, '2022-02-09 14:11:28', '2022-02-09 14:11:32', '系统最高权限', NULL);
INSERT INTO `sys_role` VALUES (8, '测试', 'common', '2', '0', '1', NULL, '2022-02-09 14:21:17', NULL, '测试用户', '1');
INSERT INTO `sys_role` VALUES (9, '11', '11', '3', '0', '1', NULL, '2022-02-09 14:25:53', NULL, NULL, '1');
INSERT INTO `sys_role` VALUES (10, '大风歌', 'adf', '5', '0', '1', NULL, '2022-02-09 14:28:49', NULL, NULL, '1');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (6, 1);
INSERT INTO `sys_role_menu` VALUES (6, 2);
INSERT INTO `sys_role_menu` VALUES (6, 3);
INSERT INTO `sys_role_menu` VALUES (6, 4);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户Id',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `phonenumber` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除状态（0正常 1删除）',
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$M2Z89TOXKzitd/TEvMpQNu9aExeqMdM/BhBwiY0G2oNiCuz4QmUlC', 'laopang', 'pzy1013@163.com', '17739605211', '男', NULL, '0', '0', NULL, '2022-01-21 16:41:14', '2022-01-21 16:41:16', '超级管理员');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` int NOT NULL COMMENT '用户ID',
  `role_id` int NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for tb_blog
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`  (
  `blog_id` bigint NOT NULL AUTO_INCREMENT COMMENT '博客id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '博客创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '博客修改时间',
  `views` int NULL DEFAULT 0 COMMENT '博客浏览数',
  `click_like` bigint NULL DEFAULT NULL COMMENT '点赞次数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发表博客描述',
  `published` int NOT NULL COMMENT '是否公开博客(0:为公开、1：私密)',
  `flag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客题材（翻译 / 转载 / 原创）',
  `type_id` bigint NULL DEFAULT NULL COMMENT '外键分类表',
  `tag_id` bigint NULL DEFAULT NULL COMMENT '外键标签表',
  `status` int NULL DEFAULT NULL COMMENT '文章状态 0: 发布 1：保存',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '博客首图',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`blog_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  INDEX `tb_blog_ibfk_1`(`user_id`) USING BTREE,
  CONSTRAINT `tb_blog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_blog_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `tb_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog
-- ----------------------------
INSERT INTO `tb_blog` VALUES (26, '哈哈哈', '是VS认同感', '2022-02-14 08:26:19', '2022-02-14 08:26:19', 0, NULL, '收到v', 0, '原创', 2, NULL, 0, 'http://p0.qhimg.com/bdm/1024_768_85/t01571acf6f7e7c3ae8.jpg', '4a5406cc-d417-439e-b03f-e3821d50a835');
INSERT INTO `tb_blog` VALUES (27, '哈哈哈哈哈哈哈哈哈哈', '# 一级标题\n\n## 二级标题\n\n### 三级标题\n\n#### 四级标题\n\n##### 五级标题\n\n###### 六级标题\n\n晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二晒太阳jet也就生态园家呢呀委托函也认为台湾人特别好看加热法v不会卡尔菲v金卡二分v就杰拉尔部分v面对着比较长v你癌症v好吧SJKD v啊合资的公司vu阿达和爱尔欧发改委的官方u哦啊甘道夫啊额我给夫爱词霸v就岸边的错啊如果非常v打鼓VS百度哦u啊额我发78AE8FEisfg开发离开找不到v拉个u和我覅8哈维给彭爱华改好地啊回复v噶韩国喷发黑共和国iGH让看着不菲啊狠抓二', '2022-02-14 13:22:27', '2022-02-14 13:22:27', 0, NULL, '五十一人', 0, '原创', 2, NULL, 0, '', '4a5406cc-d417-439e-b03f-e3821d50a835');

-- ----------------------------
-- Table structure for tb_collection
-- ----------------------------
DROP TABLE IF EXISTS `tb_collection`;
CREATE TABLE `tb_collection`  (
  `id` bigint NOT NULL COMMENT 'id',
  `user_id` varchar(555) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `blog_id` bigint NULL DEFAULT NULL COMMENT '收藏的文章id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '收藏的时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `tb_collection_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_collection
-- ----------------------------

-- ----------------------------
-- Table structure for tb_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment`  (
  `id` bigint NOT NULL COMMENT '该条评论的id',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论人的昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论人的头像',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论的内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评论的时间',
  `blog_id` bigint NULL DEFAULT NULL COMMENT '博客的id',
  `visitors_comment_id` bigint NULL DEFAULT NULL COMMENT '访客评论id',
  `user_comment_id` int NULL DEFAULT NULL COMMENT '博客作者回复的id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`, `blog_id`) USING BTREE,
  INDEX `tb_comment_ibfk_2`(`visitors_comment_id`) USING BTREE,
  INDEX `blog_id`(`blog_id`) USING BTREE,
  CONSTRAINT `tb_comment_ibfk_2` FOREIGN KEY (`visitors_comment_id`) REFERENCES `tb_comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tb_comment_ibfk_3` FOREIGN KEY (`blog_id`) REFERENCES `tb_blog` (`blog_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------

-- ----------------------------
-- Table structure for tb_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_tag`;
CREATE TABLE `tb_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_tag
-- ----------------------------

-- ----------------------------
-- Table structure for tb_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_type`;
CREATE TABLE `tb_type`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `icon` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_type
-- ----------------------------
INSERT INTO `tb_type` VALUES (1, 'JAVA', '<svg t=\"1629271993745\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"3827\" width=\"25\" height=\"25\"><path d=\"M379 510.8c-26.6 12.4-70.9 14.7-90.3 41.3 19.6 14.7 48.3 14.2 74.8 15.5 108.9 4.9 245.1-4.4 338-20.6 3.1 6.7-12.9 18.3-23.2 25.8-58.6 42.8-240.7 54.9-366.3 46.4-42.1-2.8-138.3-13.9-139.3-51.6-1.3-45.7 116.6-50.6 165.1-54.2 9.4-0.7 27.3-4.6 41.2-2.6z m-54.2 116.1c12.1 1.5-8.5 8.8-5.2 18C364 688.8 502 676.4 569.8 663c14.2-2.9 28.4-11.4 38.7-10.3 25.8 2.3 42.3 32.3 64.5 36.1-78.4 35.4-229.9 52.1-340.6 30.9-28.6-5.4-78.4-20.9-80-43.9-2.1-31.1 49.5-44.3 72.4-48.9z m33.6 105.8c8 2.6-2.8 7-2.6 10.3 23.5 40.8 139.6 26.3 198.7 12.9 11.9-2.8 23.7-11.1 33.5-10.3 29.9 2 41.3 33.3 67.1 38.7-82.3 50.3-281.7 70.7-363.8 7.7-3.9-45.9 33-51 67.1-59.3z m-74.8 77.4c-24.5 6.2-88-2.6-90.3 30.9-0.8 12.9 21.7 28.1 36.1 33.5 84.1 31.7 253.1 36.6 392.1 20.6 64.5-7.5 185.8-29.2 170.3-95.5 19.4 2.3 36.6 14.7 38.7 33.5 7.7 71.2-155.8 101.1-221.9 108.4-143.7 15.7-323.3 12.6-433.4-25.8-35.9-12.4-79.2-35.4-77.4-69.7 3.1-57.6 142.4-73.6 185.8-35.9zM502.9 1024c-96.7-10.6-189.9-24.8-268.3-59.3 205.1 49.3 504.1 45.7 647.6-59.3 7.7-5.7 15-16.8 25.8-15.5-36.2 108.3-175 115.8-294.2 134.1H502.9z m219.3-487.3c53.2-45.4 143.2-27.6 147 49 4.4 89.8-93.9 140.1-165.1 144.5 33-31.5 120.2-82 103.2-154.8-7-29.4-43.6-47.2-85.1-38.7z\" fill=\"#F7BE81\" p-id=\"3828\"></path><path d=\"M569.9 0c18.1 17 30.9 48.8 30.9 82.6 0 99.8-105.8 157.6-157.4 224.5-11.4 15-26 37.9-25.8 61.9 0.5 54.4 56.8 115.3 77.4 160-36.1-23.7-80-55.5-110.9-92.9-30.9-37.1-61.9-97.5-33.5-149.6 42.6-78.4 169.3-125.1 214.1-209 10.9-20.4 19.4-51.6 5.2-77.5z\" fill=\"#FF8000\" p-id=\"3829\"></path><path d=\"M737.6 175.5c-29.7 20.9-58.6 38.7-90.3 64.5-24 19.6-67.3 46.4-69.7 82.6-3.6 54.9 81 105.8 36.1 175.4-17 26.6-45.9 37.9-82.6 54.2-4.4-8 9.5-14.7 15.5-23.2 56.3-81.5-58.6-108.6-43.9-209 14.3-97 128.6-130.9 234.9-144.5z\" fill=\"#FF8000\" p-id=\"3830\"></path></svg>');
INSERT INTO `tb_type` VALUES (2, 'Go', '<svg t=\"1628842468883\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"3155\" width=\"25\" height=\"25\"><path d=\"M130.9 381.8c-1.8 0-2.2-0.9-1.3-2.2l9.2-11.8c0.9-1.3 3-2.2 4.8-2.2h155.8c1.7 0 2.2 1.3 1.3 2.6l-7.4 11.3c-0.9 1.3-3.1 2.6-4.4 2.6 0 0.1-158-0.3-158-0.3zM65.1 422c-1.8 0-2.2-0.9-1.3-2.2l9.1-11.8c0.9-1.3 3.1-2.2 4.8-2.2h198.9c1.8 0 2.6 1.3 2.2 2.6l-3.5 10.5c-0.4 1.8-2.2 2.6-3.9 2.6l-206.3 0.5z m105.6 40.1c-1.8 0-2.2-1.3-1.3-2.6l6.1-10.9c0.9-1.3 2.6-2.6 4.4-2.6h87.2c1.8 0 2.6 1.3 2.6 3.1l-0.9 10.5c0 1.8-1.8 3.1-3.1 3.1l-95-0.6zM623.5 374c-27.5 7-46.3 12.2-73.3 19.2-6.6 1.7-7 2.2-12.7-4.4-6.5-7.4-11.3-12.2-20.5-16.6-27.5-13.5-54.1-9.6-79 6.5-29.7 19.2-44.9 47.6-44.5 82.9 0.4 34.9 24.4 63.7 58.9 68.5 29.7 3.9 54.5-6.5 74.2-28.8 3.9-4.8 7.4-10 11.8-16.2h-84.2c-9.1 0-11.3-5.7-8.3-13.1 5.7-13.5 16.1-36.2 22.3-47.6 1.9-4.3 6.2-7 10.9-7h158.8c-0.9 11.8-0.9 23.6-2.6 35.4-4.5 31.1-16.8 60.5-35.8 85.5-31.4 41.4-72.4 67.2-124.3 74.1-42.7 5.7-82.5-2.6-117.3-28.7-32.3-24.5-50.6-56.7-55.4-96.9-5.7-47.6 8.3-90.3 37.1-127.8 31-40.5 72-66.3 122.2-75.5 41-7.4 80.3-2.6 115.6 21.4 23.1 15.3 39.7 36.2 50.6 61.5 2.5 4.1 0.7 6.3-4.5 7.6m144.4 241.2c-39.7-0.9-75.9-12.2-106.5-38.4-25.4-21.4-42.2-51.3-47.1-84.2-7.8-49.3 5.7-92.9 35.4-131.7 31.8-41.9 70.2-63.7 122.2-72.8 44.5-7.8 86.4-3.5 124.3 22.3 34.5 23.5 55.9 55.4 61.5 97.3 7.4 58.9-9.6 106.9-50.2 147.9-28.8 29.2-64.1 47.5-104.7 55.8-11.8 2.1-23.6 2.5-34.9 3.8zM871.7 439c-0.4-5.7-0.4-10-1.3-14.4-7.8-43.2-47.6-67.6-89-58-40.6 9.1-66.8 34.9-76.3 75.9-7.8 34 8.7 68.5 40.1 82.5 24 10.5 48 9.1 71.1-2.6 34.5-18 53.2-45.9 55.4-83.4z\" fill=\"#E9573A\" p-id=\"3156\"></path></svg>\r\n');
INSERT INTO `tb_type` VALUES (3, 'php', '<svg t=\"1629334592827\" class=\"icon\" viewBox=\"0 0 1024 1024\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" p-id=\"2180\" width=\"25\" height=\"25\"><path d=\"M306.40355555 441.68533333h-35.38488888L251.33511111 542.72h28.78577778c22.18666667 0 38.68444445-4.096 49.152-12.17422222 10.35377778-7.96444445 17.52177778-21.73155555 21.27644444-41.07377778 3.52711111-17.97688889 2.16177778-30.60622222-3.98222222-37.31911111-6.25777778-6.94044445-19.79733333-10.46755555-40.16355556-10.46755556zM761.51466667 441.68533333h-35.38488889L706.44622222 542.72h28.78577778c22.18666667 0 38.68444445-4.096 49.152-12.17422222 10.35377778-7.96444445 17.52177778-21.73155555 21.27644445-41.07377778 3.52711111-17.97688889 2.16177778-30.60622222-3.98222223-37.31911111-6.25777778-6.94044445-19.79733333-10.46755555-40.16355555-10.46755556z\" fill=\"#787db0\" p-id=\"2181\"></path><path d=\"M512 244.96355555C231.53777778 244.96355555 4.20977778 364.544 4.20977778 512s227.328 267.03644445 507.67644444 267.03644445S1019.79022222 659.456 1019.79022222 512 792.46222222 244.96355555 512 244.96355555zM383.31733333 564.224c-12.17422222 11.37777778-25.94133333 19.56977778-40.84622222 24.46222222-14.67733333 4.77866667-33.56444445 7.168-56.09244444 7.168h-45.39733334l-12.97066666 66.67377778c-0.45511111 2.61688889-2.73066667 4.43733333-5.46133334 4.43733333h-58.25422222c-1.59288889 0-3.18577778-0.68266667-4.20977778-2.048-1.024-1.25155555-1.47911111-2.95822222-1.13777778-4.55111111l51.99644445-267.60533333c0.45511111-2.61688889 2.73066667-4.43733333 5.46133333-4.43733334h112.07111112c35.27111111 0 61.44 9.55733333 77.93777777 28.44444445 16.61155555 19.00088889 21.73155555 45.51111111 15.24622223 78.848-2.61688889 13.53955555-7.168 26.16888889-13.42577778 37.43288889-6.37155555 11.37777778-14.79111111 21.84533333-24.91733334 31.17511111zM551.02577778 593.92c-1.024-1.25155555-1.47911111-2.95822222-1.13777778-4.55111111l22.98311111-118.44266667c2.16177778-11.264 1.59288889-19.34222222-1.47911111-22.75555555-1.93422222-2.048-7.73688889-5.57511111-25.03111111-5.57511112h-41.64266667l-28.89955555 148.93511112c-0.45511111 2.61688889-2.73066667 4.43733333-5.46133334 4.43733333h-57.79911111c-1.59288889 0-3.18577778-0.68266667-4.20977777-2.048-1.024-1.25155555-1.47911111-2.95822222-1.13777778-4.55111111l51.99644444-267.60533334c0.45511111-2.61688889 2.73066667-4.43733333 5.46133334-4.43733333h57.7991111c1.59288889 0 3.18577778 0.68266667 4.20977778 2.048 1.024 1.25155555 1.47911111 2.95822222 1.13777778 4.55111111l-12.51555556 64.62577778h44.82844445c34.13333333 0 57.344 6.03022222 70.88355555 18.432 13.76711111 12.62933333 18.09066667 32.88177778 12.74311112 60.07466667L619.52 591.64444445c-0.45511111 2.61688889-2.73066667 4.43733333-5.46133333 4.43733333h-58.70933334c-1.70666667-0.11377778-3.29955555-0.91022222-4.32355555-2.16177778z m325.632-98.304c-2.61688889 13.53955555-7.168 26.16888889-13.53955556 37.43288889-6.37155555 11.264-14.67733333 21.73155555-24.80355555 31.06133333-12.17422222 11.37777778-25.94133333 19.56977778-40.84622222 24.46222223-14.67733333 4.77866667-33.56444445 7.168-56.09244445 7.168h-45.39733333l-12.97066667 66.67377777c-0.45511111 2.61688889-2.73066667 4.43733333-5.46133333 4.43733333h-58.25422222c-1.59288889 0-3.18577778-0.68266667-4.20977778-2.048-1.024-1.25155555-1.47911111-2.95822222-1.13777778-4.5511111l51.99644444-267.60533334c0.45511111-2.61688889 2.73066667-4.43733333 5.46133334-4.43733333h112.07111111c35.27111111 0 61.44 9.55733333 77.93777777 28.44444444 16.61155555 19.11466667 21.73155555 45.62488889 15.24622223 78.96177778z\" fill=\"#787db0\" p-id=\"2182\"></path></svg>');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户登录密码',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '用户创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '用户更新时间',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户性别',
  `phone` bigint NULL DEFAULT NULL COMMENT '用户手机号',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人签名',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` int NULL DEFAULT NULL COMMENT '用户状态',
  `background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户背景图',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('4a5406cc-d417-439e-b03f-e3821d50a835', '3212990982@qq.com', '$2a$10$j1XmHIABoVvCW9tvh9Jv7.wg2vKebbe7Udyrr.7bUmadqgmuYHY.S', 'http://q1.qlogo.cn/g?b=qq&nk=3212990982&s=100', 'nice', '2022-02-12 13:01:03', '2022-02-12 13:01:03', NULL, NULL, NULL, '3212990982@qq.com', NULL, 'http://p8.qhimg.com/bdm/1024_768_85/t01a9e376952238ea53.jpg');

-- ----------------------------
-- Table structure for tb_user_diary
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_diary`;
CREATE TABLE `tb_user_diary`  (
  `id` int NOT NULL COMMENT '日记id',
  `content` varchar(999) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日记内容',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日记标题',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `first_picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日记展示封面',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `tb_user_diary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_diary
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_follow`;
CREATE TABLE `tb_user_follow`  (
  `id` int NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户',
  `focuson_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关注的人的id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '关注的时间',
  `follower_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '粉丝id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `tb_user_follow_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_follow
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
