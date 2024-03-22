/*
 Navicat Premium Data Transfer

 Source Server         : dev-192.168.2.202
 Source Server Type    : MySQL
 Source Server Version : 50733
 Source Host           : 192.168.2.202:3306
 Source Schema         : zhizu_data

 Target Server Type    : MySQL
 Target Server Version : 50733
 File Encoding         : 65001

 Date: 25/10/2022 17:39:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `blob_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('ZhiZuDataScheduler','STATE_ACCESS'),('ZhiZuDataScheduler','TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('ZhiZuDataScheduler','bi-tableau1621940396327',1622002383362,15000);

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `int_prop_1` int(11) NULL DEFAULT NULL,
  `int_prop_2` int(11) NULL DEFAULT NULL,
  `long_prop_1` bigint(20) NULL DEFAULT NULL,
  `long_prop_2` bigint(20) NULL DEFAULT NULL,
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL,
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL,
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_fire_time` bigint(13) NULL DEFAULT NULL,
  `prev_fire_time` bigint(13) NULL DEFAULT NULL,
  `priority` int(11) NULL DEFAULT NULL,
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) NULL DEFAULT NULL,
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `misfire_instr` smallint(2) NULL DEFAULT NULL,
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for ip
-- ----------------------------
DROP TABLE IF EXISTS `ip`;
CREATE TABLE `ip`  (
  `IP地址` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IP归属地` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of ip
-- ----------------------------

-- ----------------------------
-- Table structure for ip_address
-- ----------------------------
DROP TABLE IF EXISTS `ip_address`;
CREATE TABLE `ip_address`  (
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录IP地址',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `IP归属地` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `num` bigint(21) NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of ip_address
-- ----------------------------

-- ----------------------------
-- Table structure for map_city_json
-- ----------------------------
DROP TABLE IF EXISTS `map_city_json`;
CREATE TABLE `map_city_json`  (
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `map_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `adcode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of map_city_json
-- ----------------------------

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
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '最后一次更新时间',
  `demander` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求提出人',
  `report_maker` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表制作人',
  `report_online_time` datetime NULL DEFAULT NULL COMMENT '报表上线时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of report_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_level` tinyint(4) NOT NULL COMMENT '区域级别',
  `area_code` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '区域编码',
  `area_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '区域名称',
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '父级id',
  `letter` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `baidu_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '百度城市id',
  `longitude` double NULL DEFAULT NULL COMMENT '经度',
  `latitude` double NULL DEFAULT NULL COMMENT '纬度',
  `business_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_area_name`(`area_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '区域表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_area
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-04-29 07:42:19', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-04-29 07:42:20', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'N', 'admin', '2021-04-29 07:42:20', 'admin', '2021-05-07 18:01:39', '深色主题theme-dark，浅色主题theme-light');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `wecom_sync` tinyint(1) NULL DEFAULT 0 COMMENT '从企业微信同步来的数据标识',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '未知', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '男', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '女', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 10, '是', 'true', 'tab_req_is_push', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 20, '否', 'false', 'tab_req_is_push', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 10, '企业微信同步', 'WE_COM_SYNC', 'sys_job_group', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 10, '需求', 'requirement', 'sys_notice_source_type', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 30, '微信数据同步', 'wecomSync', 'sys_notice_source_type', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 10, '企业微信', 'wecom', 'sys_notice_target_type', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', '', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 0, '是', 'true', 'sys_notice_mention', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 10, '否', 'false', 'sys_notice_mention', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);
INSERT INTO `sys_dict_data` VALUES (109, 20, '评价&意见', 'suggestion', 'sys_notice_source_type', NULL, NULL, 'N', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 07:42:19', NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-10-25 07:42:19', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '需求已推送', 'tab_req_is_push', '0', 'admin', '2022-10-25 07:42:19', 'admin', '2022-10-25 15:01:28', NULL);
INSERT INTO `sys_dict_type` VALUES (101, '推送通知数据来源', 'sys_notice_source_type', '0', 'admin', '2022-10-25 07:42:19', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '通知推送数据目标', 'sys_notice_target_type', '0', 'admin', '2022-10-25 07:42:19', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '是否推送', 'sys_notice_mention', '0', 'admin', '2022-10-25 07:42:19', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '企业微信 access_token 更新', 'WE_COM_SYNC', 'weComUserSyncTask.refreshWeComAccessToken()', '0 0 0/2 * * ? *', '1', '1', '1', 'admin', '2022-10-25 15:08:40', '', '2022-10-25 17:21:04', '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1, 'test', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-10-25 14:36:55');
INSERT INTO `sys_logininfor` VALUES (2, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-25 14:37:01');
INSERT INTO `sys_logininfor` VALUES (3, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-10-25 16:39:01');
INSERT INTO `sys_logininfor` VALUES (4, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-10-25 16:39:01');
INSERT INTO `sys_logininfor` VALUES (5, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-10-25 16:39:05');
INSERT INTO `sys_logininfor` VALUES (6, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-10-25 16:39:08');
INSERT INTO `sys_logininfor` VALUES (7, 'admin', '172.16.0.231', '内网IP', 'Chrome 8', 'Windows 10', '0', '登录成功', '2022-10-25 16:42:33');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `report_template` int(11) NULL DEFAULT NULL COMMENT '报表根路径',
  `report_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '报表名称',
  `report_user_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指定的报表用户名',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE,
  INDEX `menu_name`(`menu_name`) USING BTREE,
  INDEX `visible`(`visible`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `menu_type`(`menu_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2096 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 20, 'system', NULL, 1, 0, 'M', '0', '0', '', 'system', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-04 16:29:53', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 30, 'monitor', NULL, 1, 0, 'M', '0', '0', '', 'monitor', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-04 16:30:07', '系统监控目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 10, 'user', 'system/user/index', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-06 15:17:59', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 20, 'role', 'system/role/index', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-06 15:18:13', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 30, 'menu', 'system/menu/index', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-06 15:18:33', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '公司部门管理', 1, 40, 'dept', 'system/dept/index', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2022-10-25 16:49:54', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '公司岗位管理', 1, 41, 'post', 'system/post/index', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2022-10-25 16:50:01', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 2, 10, 'log', '', 1, 0, 'M', '0', '0', '', 'log', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2022-10-25 16:48:07', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:08', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 1, NULL, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', NULL, NULL, NULL, 'admin', '2021-05-11 08:05:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '报表模板', 1, 46, 'template', 'system/template/index', 1, 0, 'C', '0', '0', 'tableau:template:list', 'form', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2022-10-25 16:49:41', 'tableau 报表内嵌 html 模板菜单');
INSERT INTO `sys_menu` VALUES (2009, '报表模板查询', 2008, 1, '#', '', 1, 0, 'F', '0', '0', 'tableau:template:query', '#', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2021-05-04 15:55:41', '');
INSERT INTO `sys_menu` VALUES (2010, '报表模板新增', 2008, 2, '#', '', 1, 0, 'F', '0', '0', 'tableau:template:add', '#', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2021-05-04 15:55:46', '');
INSERT INTO `sys_menu` VALUES (2011, '报表模板修改', 2008, 3, '#', '', 1, 0, 'F', '0', '0', 'tableau:template:edit', '#', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2021-05-04 15:55:51', '');
INSERT INTO `sys_menu` VALUES (2012, '报表模板删除', 2008, 4, '#', '', 1, 0, 'F', '0', '0', 'tableau:template:remove', '#', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2021-05-04 15:55:55', '');
INSERT INTO `sys_menu` VALUES (2013, '报表模板导出', 2008, 5, '#', '', 1, 0, 'F', '0', '0', 'tableau:template:export', '#', 1, NULL, NULL, 'admin', '2021-05-04 15:48:31', 'admin', '2021-05-04 15:55:59', '');
INSERT INTO `sys_menu` VALUES (2022, '报表访问日志', 108, 1, 'visitlog', 'monitor/visitlog/index', 1, 0, 'C', '0', '0', 'monitor:visitlog:list', 'log', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', 'admin', '2021-05-06 13:06:35', '报表访问日志菜单');
INSERT INTO `sys_menu` VALUES (2023, '报表访问日志查询', 2022, 1, '#', '', 1, 0, 'F', '0', '0', 'system:visitlog:query', '#', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '报表访问日志新增', 2022, 2, '#', '', 1, 0, 'F', '0', '0', 'system:visitlog:add', '#', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '报表访问日志修改', 2022, 3, '#', '', 1, 0, 'F', '0', '0', 'system:visitlog:edit', '#', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '报表访问日志删除', 2022, 4, '#', '', 1, 0, 'F', '0', '0', 'system:visitlog:remove', '#', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '报表访问日志导出', 2022, 5, '#', '', 1, 0, 'F', '0', '0', 'system:visitlog:export', '#', NULL, '', NULL, 'admin', '2021-05-06 12:50:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '报表需求查询', 1, 80, 'requirement', 'tableau/requirement/index', 1, 0, 'C', '0', '0', 'tableau:requirement:list', 'log', NULL, '', NULL, 'admin', '2021-05-06 16:42:12', 'admin', '2022-10-25 16:50:14', '报表需求菜单');
INSERT INTO `sys_menu` VALUES (2036, '报表需求查询', 2035, 1, '#', '', 1, 0, 'F', '0', '0', 'tableau:requirement:query', '#', NULL, '', NULL, 'admin', '2021-05-06 16:42:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '报表需求修改', 2035, 3, '#', '', 1, 0, 'F', '0', '0', 'tableau:requirement:edit', '#', NULL, '', NULL, 'admin', '2021-05-06 16:42:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '报表需求删除', 2035, 4, '#', '', 1, 0, 'F', '0', '0', 'tableau:requirement:remove', '#', NULL, '', NULL, 'admin', '2021-05-06 16:42:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '报表需求导出', 2035, 5, '#', '', 1, 0, 'F', '0', '0', 'tableau:requirement:export', '#', NULL, '', NULL, 'admin', '2021-05-06 16:42:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '推送配置新增', 2066, 2, '#', '', 1, 0, 'F', '0', '0', 'system:push:add', '#', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '推送配置修改', 2066, 3, '#', '', 1, 0, 'F', '0', '0', 'system:push:edit', '#', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '推送配置删除', 2066, 4, '#', '', 1, 0, 'F', '0', '0', 'system:push:remove', '#', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '推送配置导出', 2066, 5, '#', '', 1, 0, 'F', '0', '0', 'system:push:export', '#', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '推送配置', 1, 45, 'push', 'system/push/index', 1, 0, 'C', '0', '0', 'system:push:list', 'guide', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', 'admin', '2021-05-13 10:05:04', '推送配置菜单');
INSERT INTO `sys_menu` VALUES (2067, '推送配置查询', 2066, 1, '#', '', 1, 0, 'F', '0', '0', 'system:push:query', '#', NULL, '', NULL, 'admin', '2021-05-13 09:16:05', 'admin', '2021-05-13 09:35:42', '');
INSERT INTO `sys_menu` VALUES (2081, 'CEO驾驶舱', 0, 1, 'driving', NULL, 1, 0, 'M', '0', '0', NULL, '#', 1, '', NULL, 'admin', '2021-05-18 18:54:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '数据部', 0, 19, 'data_team', NULL, 1, 0, 'M', '0', '0', '', 'excel', 1, '', NULL, 'admin', '2021-05-20 17:28:28', 'admin', '2021-05-20 18:18:22', '');
INSERT INTO `sys_menu` VALUES (2092, '平台分析', 2091, 1, 'plateform_traffic', NULL, 1, 0, 'M', '0', '0', NULL, 'chart', 1, '', NULL, 'admin', '2021-05-20 17:29:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2094, '平台流量分析', 2092, 1, 'Traffic_Analysis/Traffic_Analysis', 'tableau/report/index', 1, 0, 'R', '0', '0', 'tableau:report:Traffic_Analysis/Traffic_Analysis', 'chart', 1, 'Traffic_Analysis/Traffic_Analysis', NULL, 'admin', '2021-05-24 18:16:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2095, 'Test', 2092, 1, 'test_site/dash', 'tableau/report/index', 1, 0, 'R', '0', '0', 'tableau:report:test_site/dash', 'chart', 1, 'test_site/dash', NULL, 'admin', '2022-10-25 16:36:40', '', NULL, '');

-- ----------------------------
-- Table structure for sys_menu_health
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_health`;
CREATE TABLE `sys_menu_health`  (
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `is_health` int(11) NULL DEFAULT NULL COMMENT '是否健康，0为不规范，1为部分规范，2为完全规范。',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_menu_health
-- ----------------------------

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_notice_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_config`;
CREATE TABLE `sys_notice_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `source_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源类型',
  `target_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '目标类型',
  `url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'api url',
  `mention` tinyint(1) NULL DEFAULT 0 COMMENT '是否推送通知',
  `create_by` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `remark` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tab_notice_config_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '消息推送配置表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_notice_config
-- ----------------------------
INSERT INTO `sys_notice_config` VALUES (3, 'requirement', 'wecom', 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=87c7c913-622e-427b-849e-d4653e62c0c9', 1, NULL, '2022-10-25 13:23:58', NULL, '2022-10-25 13:23:58', NULL);
INSERT INTO `sys_notice_config` VALUES (4, 'wecomSync', 'wecom', 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=87c7c913-622e-427b-849e-d4653e62c0c9', 1, NULL, '2022-10-25 13:23:58', NULL, '2022-10-25 13:23:58', NULL);
INSERT INTO `sys_notice_config` VALUES (5, 'suggestion', 'wecom', 'https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=87c7c913-622e-427b-849e-d4653e62c0c9', 1, NULL, '2022-10-25 13:23:58', NULL, '2022-10-25 13:23:58', NULL);

-- ----------------------------
-- Table structure for sys_notice_mention_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_mention_user`;
CREATE TABLE `sys_notice_mention_user`  (
  `notice_id` int(11) NOT NULL DEFAULT 0,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`notice_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_notice_mention_user
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_post
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `default_role` tinyint(1) NULL DEFAULT 0 COMMENT '默认角色标识',
  `from_dept` bigint(20) NULL DEFAULT NULL COMMENT '根据哪个部门生成的默认角色',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-04-29 07:42:19', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '2', 0, NULL, 'admin', '2021-04-29 07:42:19', 'admin', '2021-05-06 19:49:53', '普通角色');
INSERT INTO `sys_role` VALUES (100, '管理员', 'superuser', 1, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-06 20:15:18', 'admin', '2021-05-25 10:47:35', '普通管理员');
INSERT INTO `sys_role` VALUES (101, '报表用户', 'ReportUser', 3, '1', 1, 1, '0', '2', 0, NULL, 'admin', '2021-05-06 20:16:29', 'admin', '2021-05-13 20:09:27', NULL);
INSERT INTO `sys_role` VALUES (157, '公司高层', 'CorpManagement', 3, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-13 20:05:29', 'admin', '2021-05-25 10:47:56', NULL);
INSERT INTO `sys_role` VALUES (158, '金融中心-高层', 'FinManagement', 100, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-13 20:21:10', 'admin', '2021-05-20 18:19:14', NULL);
INSERT INTO `sys_role` VALUES (159, '运营中高层', 'op_management', 10, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-17 11:04:54', 'admin', '2021-05-25 10:48:14', NULL);
INSERT INTO `sys_role` VALUES (160, '数据开发团队', 'data_developer', 1, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-17 13:24:49', 'admin', '2021-05-20 18:20:51', NULL);
INSERT INTO `sys_role` VALUES (161, 'CEO/董事长/CEO助理', 'CEO', 2, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-20 18:19:56', 'admin', '2021-05-25 18:44:35', NULL);
INSERT INTO `sys_role` VALUES (162, '人力资源-中层', 'HR_normal', 11, '1', 1, 1, '0', '0', 0, NULL, 'admin', '2021-05-24 17:53:35', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户,01企业微信同步用户,10 企业微信同步用户未修改初始密码）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0未知 1男 2女）',
  `avatar` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `wecom_user_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '企业微信用户id',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '区域',
  `province_id` int(11) NULL DEFAULT NULL COMMENT '省id',
  `city_id` int(11) NULL DEFAULT NULL COMMENT '市id',
  `district_id` int(11) NULL DEFAULT NULL COMMENT '区域id',
  `group_role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 1, 'admin', '超级管理员', '00', 'zhizu@zhizu.com', '15888888888', '0', '/profile/avatar/2021/05/07/e7d7fe3a-42eb-420d-9440-069a07a2ac8e.jpeg', '$2a$10$70UWxPDgmg.UKDPTSbQm1.KbrbgwDU8sRUb9b9cZunnHA46Pb3E7G', '0', '0', '127.0.0.1', '2021-04-29 07:42:19', 'admin', '2021-04-29 07:42:19', '', '2022-07-15 14:52:55', '管理员', NULL, '上海省', '上海市', '闵行区', 0, 0, 0, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '岗位ID',
  `wecom_sync` tinyint(1) NULL DEFAULT 0 COMMENT '企业微信同步标识',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `wecom_sync` tinyint(1) NULL DEFAULT 0 COMMENT '企业微信同步数据标识',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for tab_group_role
-- ----------------------------
DROP TABLE IF EXISTS `tab_group_role`;
CREATE TABLE `tab_group_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_regex` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '规则',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组名称',
  `update_time` datetime NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `name`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_group_role
-- ----------------------------

-- ----------------------------
-- Table structure for tab_html_param
-- ----------------------------
DROP TABLE IF EXISTS `tab_html_param`;
CREATE TABLE `tab_html_param`  (
  `param_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `template_id` int(11) NOT NULL COMMENT '模板 id',
  `param_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '参数名',
  `param_value` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '参数值',
  `param_desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数描述',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`param_id`) USING BTREE,
  UNIQUE INDEX `tab_param_tag_tag_id_uindex`(`param_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '嵌入式报表 html 标签配置' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_html_param
-- ----------------------------
INSERT INTO `tab_html_param` VALUES (1, 1, 'embed_code_version', '3', '嵌入式代码版本', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (2, 1, 'site_root', '', '网站根节点', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (3, 1, 'tabs', 'yes', '标签页面', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (4, 1, 'toolbar', 'top', '工具条', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (5, 1, 'showAppBanner', 'false', '展示 App Banner', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (6, 1, 'alerts', 'no', '隐藏工具栏中的“通知”按钮', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (7, 1, 'customViews', 'no', '隐藏工具栏中的“视图”按钮', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (8, 1, 'subscriptions', 'no', '隐藏工具栏中的“订阅”按钮', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tab_html_param` VALUES (14, 1, 'showShareOptions', 'false', '显示“共享”选项。', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tab_html_template
-- ----------------------------
DROP TABLE IF EXISTS `tab_html_template`;
CREATE TABLE `tab_html_template`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `template_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template_desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tableau_host` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'tableau server 服务器地址',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tab_html_template_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'tableau 报表内嵌 html 模板' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_html_template
-- ----------------------------
INSERT INTO `tab_html_template` VALUES (1, '普通用户标准模板', '标准1', 'https://tableau_partner.zhizukj.com', 'admin', '2021-05-05 01:16:08', 'admin', '2022-10-25 15:37:47', NULL);

-- ----------------------------
-- Table structure for tab_profile_info
-- ----------------------------
DROP TABLE IF EXISTS `tab_profile_info`;
CREATE TABLE `tab_profile_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tableau_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据平台地址',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '类型',
  `lable` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_profile_info
-- ----------------------------

-- ----------------------------
-- Table structure for tab_regex_relation
-- ----------------------------
DROP TABLE IF EXISTS `tab_regex_relation`;
CREATE TABLE `tab_regex_relation`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户号码',
  `menu_id` bigint(20) NOT NULL COMMENT '报表id',
  `rule_regex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '过滤规则',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `update_time` datetime NULL DEFAULT NULL,
  `user_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tab_regex_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tab_requirement
-- ----------------------------
DROP TABLE IF EXISTS `tab_requirement`;
CREATE TABLE `tab_requirement`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键 id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户 id\n',
  `user_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账户',
  `nick_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `require_subject` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求主题',
  `require_detail` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求明细',
  `except_online_time` datetime NULL DEFAULT NULL COMMENT '期望上线时间',
  `is_push` tinyint(1) NULL DEFAULT 0 COMMENT '已推送',
  `contact_info` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单 id\n',
  `menu_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `report_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `car_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生成的卡片id',
  `execution_status` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '执行状态，参见字典表中【execution_status】',
  `feishu_create` int(11) NULL DEFAULT 0,
  `start_time` datetime NULL DEFAULT NULL,
  `finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `class_level_1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1类分级',
  `class_level_2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '2类分级',
  `require_deal_numbers` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求处理人',
  `requirement_classify` int(11) NULL DEFAULT NULL,
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tab_requirement_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报表需求表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_requirement
-- ----------------------------

-- ----------------------------
-- Table structure for tab_suggestion
-- ----------------------------
DROP TABLE IF EXISTS `tab_suggestion`;
CREATE TABLE `tab_suggestion`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `report_score` smallint(6) NULL DEFAULT NULL COMMENT '报表评分',
  `data_accurate` smallint(6) NULL DEFAULT NULL COMMENT '数据精准度',
  `suggestions_detail` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '意见明细',
  `contact_info` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单 id\n',
  `menu_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `report_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tab_suggestion_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报表意见表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_suggestion
-- ----------------------------

-- ----------------------------
-- Table structure for tab_visit_log
-- ----------------------------
DROP TABLE IF EXISTS `tab_visit_log`;
CREATE TABLE `tab_visit_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `user_id` bigint(20) NULL DEFAULT NULL,
  `user_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nick_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menu_id` bigint(20) NULL DEFAULT NULL,
  `menu_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_menu_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `report_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip_addr` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `browser` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_location` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tab_visit_log_id_uindex`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报表访问日志' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tab_visit_log
-- ----------------------------

-- ----------------------------
-- Table structure for tableau_dashboard_info
-- ----------------------------
DROP TABLE IF EXISTS `tableau_dashboard_info`;
CREATE TABLE `tableau_dashboard_info`  (
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'tableau 报表路径',
  `demander` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '需求提出人',
  `report_maker` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报表制作人',
  `report_online_time` datetime NULL DEFAULT NULL COMMENT '报表上线时间',
  `report_update_time` datetime NULL DEFAULT NULL COMMENT '数据更新时间',
  `page_uv` int(11) NULL DEFAULT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tableau_dashboard_info
-- ----------------------------

-- ----------------------------
-- View structure for sys_dict_view
-- ----------------------------
DROP VIEW IF EXISTS `sys_dict_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sys_dict_view` AS select `t2`.`dict_code` AS `dict_code`,`t1`.`dict_name` AS `dict_name`,`t1`.`dict_type` AS `dict_type`,`t2`.`dict_value` AS `dict_value`,`t2`.`dict_label` AS `dict_label`,`t2`.`dict_sort` AS `dict_sort`,`t2`.`is_default` AS `is_default`,`t2`.`status` AS `STATUS`,`t2`.`remark` AS `remark` from (`sys_dict_type` `t1` left join `sys_dict_data` `t2` on((`t1`.`dict_type` = `t2`.`dict_type`)));

-- ----------------------------
-- View structure for user_report_view
-- ----------------------------
DROP VIEW IF EXISTS `user_report_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_report_view` AS select distinct `t1`.`user_id` AS `user_id`,`t1`.`user_name` AS `user_name`,`t1`.`status` AS `status`,`t1`.`del_flag` AS `del_flag`,`t4`.`menu_id` AS `menu_id`,`t4`.`menu_name` AS `menu_name`,`t4`.`menu_type` AS `menu_type`,`t4`.`path` AS `path`,`t4`.`parent_id` AS `parent_id`,`t4`.`create_time` AS `create_time` from (((`sys_user` `t1` left join `sys_user_role` `t2` on((`t1`.`user_id` = `t2`.`user_id`))) left join `sys_role_menu` `t3` on((`t2`.`role_id` = `t3`.`role_id`))) left join `sys_menu` `t4` on((`t3`.`menu_id` = `t4`.`menu_id`))) where ((`t4`.`menu_type` = 'R') and (`t4`.`status` = '0'));

SET FOREIGN_KEY_CHECKS = 1;
