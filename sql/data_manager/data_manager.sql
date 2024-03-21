/*
 Navicat Premium Data Transfer

 Source Server         : 10.1.8.32
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : 10.1.8.32:3306
 Source Schema         : data_manager

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 07/11/2022 13:45:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dim_sys_wechat_user
-- ----------------------------
DROP TABLE IF EXISTS `dim_sys_wechat_user`;
CREATE TABLE `dim_sys_wechat_user`  (
  `user_id` int(11) NOT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_name1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_name2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_name3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_name4` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `del_falg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_create_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phonenumber` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `post_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for metadata_field
-- ----------------------------
DROP TABLE IF EXISTS `metadata_field`;
CREATE TABLE `metadata_field`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_id` int(11) NOT NULL DEFAULT 1 COMMENT '所属表ID',
  `field_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字段名称',
  `field_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `field_comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段注释',
  `is_key` int(11) NULL DEFAULT 0 COMMENT '是否为主键，1为是，0为否',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `TABLE_ID`(`table_id`) USING BTREE,
  CONSTRAINT `metadata_field_ibfk_1` FOREIGN KEY (`table_id`) REFERENCES `metadata_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10166 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for metadata_table
-- ----------------------------
DROP TABLE IF EXISTS `metadata_table`;
CREATE TABLE `metadata_table`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前库名称',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前表名称',
  `db_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前库表名称',
  `db_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前库类型：mysql/kudu/hive/ck/doris/delete',
  `owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人姓名',
  `priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优先级',
  `is_dw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否数仓',
  `dw_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数仓层级',
  `lineage_id` int(11) NULL DEFAULT NULL COMMENT '血缘ID',
  `field_num` int(11) NULL DEFAULT NULL COMMENT '字段数量',
  `partition_type` int(11) NULL DEFAULT NULL COMMENT '是否分区 1：有分区 0:无分区',
  `partition_count` int(11) NULL DEFAULT NULL COMMENT '分区数量，7点定时获取',
  `partition_field` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分区字段',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次更新时间',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息，业务描述',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前表注释',
  `extract_logic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '刷新方式',
  `extract_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '刷新时间',
  `busines_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务描述',
  `db_count` bigint(255) NULL DEFAULT NULL COMMENT '当前表中数据总量，7点定时获取',
  `file_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前表的物理地址',
  `filesize` bigint(255) NULL DEFAULT NULL COMMENT '当前表占用空间，7点定时获取',
  `file_format` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前表文件格式',
  `file_compress` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '当前表压缩方式',
  `file_count` bigint(255) NULL DEFAULT NULL COMMENT '当前表文件数量，7点定时获取',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3276 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for report_info
-- ----------------------------
DROP TABLE IF EXISTS `report_info`;
CREATE TABLE `report_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报表名称',
  `workbook` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'tableau名称',
  `report_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表引用路径',
  `report_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表页面URL',
  `tableau_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'tableau页面URL',
  `tableau_detail_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'tableau详情页面URL',
  `dispatch_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调度所需路径',
  `visit_num` int(11) NULL DEFAULT NULL COMMENT '浏览次数',
  `role_num` int(11) NULL DEFAULT NULL COMMENT '角色数量',
  `user_num` int(11) NULL DEFAULT NULL COMMENT '用户数量',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
  `lineage_id` int(11) NULL DEFAULT NULL COMMENT '血缘ID',
  `is_report` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否录入数据平台中',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次更新时间',
  `demander` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求提出人',
  `report_maker` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表制作人',
  `report_online_time` datetime(0) NULL DEFAULT NULL COMMENT '报表上线时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 320 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for scheduler_info
-- ----------------------------
DROP TABLE IF EXISTS `scheduler_info`;
CREATE TABLE `scheduler_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workflow_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作流名称',
  `workflow_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作流描述',
  `project_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `scheduler_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调度时间',
  `scheduler_stutas` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调度状态：上线，下线',
  `workflow_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调度url',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属用户名',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务节点名称',
  `sql_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '调度sql',
  `task_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务描述',
  `table_id` int(11) NULL DEFAULT NULL COMMENT '元数据表ID',
  `file_names` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sql文件列表',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `SCHEDULER_TABLE_ID`(`table_id`) USING BTREE,
  CONSTRAINT `scheduler_info_ibfk_1` FOREIGN KEY (`table_id`) REFERENCES `metadata_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 195 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sys_menu_health
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_health`;
CREATE TABLE `sys_menu_health`  (
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `is_health` int(11) NULL DEFAULT NULL COMMENT '是否健康，0为不规范，1为部分规范，2为完全规范。',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tableau_sql
-- ----------------------------
DROP TABLE IF EXISTS `tableau_sql`;
CREATE TABLE `tableau_sql`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `workbook` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_sql` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `workbook_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `workbook_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  `md5` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `webpage_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `md5`, `workbook`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1132 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
