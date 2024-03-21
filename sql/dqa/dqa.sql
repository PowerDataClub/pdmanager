/*
 Navicat Premium Data Transfer

 Source Server         : 10.1.8.32
 Source Server Type    : MySQL
 Source Server Version : 50739
 Source Host           : 10.1.8.32:3306
 Source Schema         : author_db

 Target Server Type    : MySQL
 Target Server Version : 50739
 File Encoding         : 65001

 Date: 07/11/2022 13:43:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dqa_alert_group
-- ----------------------------
DROP TABLE IF EXISTS `dqa_alert_group`;
CREATE TABLE `dqa_alert_group`  (
  `id` int(11) NOT NULL COMMENT '告警组ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警组名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警组描述',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '记录创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dqa_alert_group_user
-- ----------------------------
DROP TABLE IF EXISTS `dqa_alert_group_user`;
CREATE TABLE `dqa_alert_group_user`  (
  `id` int(11) NOT NULL,
  `alert_group_id` int(11) NULL DEFAULT NULL COMMENT '告警组ID',
  `alert_user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dqa_alert_user
-- ----------------------------
--DROP TABLE IF EXISTS `dqa_alert_user`;
--CREATE TABLE `dqa_alert_user`  (
--  `id` int(11) NOT NULL COMMENT '告警人ID',
--  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警人名称',
--  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '告警人电话',
--  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮件',
--  `del_flag` tinyint(2) NOT NULL COMMENT '逻辑删除标记:2 移除; 1正常',
--  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '记录创建时间',
--  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '记录更新时间',
--  `wecom_user_id` varchar(50) DEFAULT NULL COMMENT '企业微信ID',
--  PRIMARY KEY (`id`) USING BTREE
--) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;
create view    `dqa_alert_user` (`id`, `name`, `phone`, `email`, `del_flag`, `create_date`, `update_date`,`wecom_user_id`)   select user_id,nick_name,phonenumber,email,del_flag,create_time,update_time,`wecom_user_id` from `zhizu_data`.sys_user where dept_id=143;

-- ----------------------------
-- Table structure for dqa_rule
-- ----------------------------
DROP TABLE IF EXISTS `dqa_rule`;
CREATE TABLE `dqa_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL COMMENT '规则模板名称',
  `template_type` tinyint(4) NOT NULL COMMENT '规则模板类型:1 表级;2 字段级;',
  `expression` varchar(4192) NOT NULL COMMENT '规则表达式',
  `threshold_expr` varchar(4192) DEFAULT NULL COMMENT '规则阈值计算表达式',
  `parser_class_name` varchar(255) DEFAULT NULL COMMENT '解析规则的类名称',
  `description` text NOT NULL COMMENT '规则模板描述',
  `status` tinyint(4) NOT NULL COMMENT '规则模板状态:1 启用; 2 停用',
  `combine_type` tinyint(4) DEFAULT NULL COMMENT '规则合并类型:1 字段普通合并;2 分组聚合合并;3 不能合并',
  `field_type` varchar(255) DEFAULT NULL COMMENT '字段级监控时该规则所适用的字段类型范围',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_date` datetime DEFAULT NULL COMMENT '记录创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
-- ----------------------------
-- Table structure for dqa_task
-- ----------------------------
DROP TABLE IF EXISTS `dqa_task`;
CREATE TABLE `dqa_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `rule_id` int(255) NOT NULL COMMENT '规则ID,外键',
  `alert_user_id` varchar(128) NOT NULL COMMENT '告警接收人的用户ID列表,多个人使用英文逗号隔开',
  `alert_user_name` varchar(255) DEFAULT NULL COMMENT '告警人接收名称',
  `table_id` int(11) NOT NULL COMMENT '库表详情的数据,库表名称等',
  `db_table` varchar(255) DEFAULT NULL COMMENT '库表名',
  `field_id` int(11) DEFAULT '0' COMMENT '字段ID',
  `field_name` varchar(255) DEFAULT NULL COMMENT '监控字段名',
  `task_status` tinyint(4) DEFAULT NULL COMMENT '任务状态:1 启用;2 停用;3 创建',
  `create_user` varchar(255) DEFAULT NULL COMMENT '任务创建人',
  `create_date` datetime DEFAULT NULL COMMENT '任务创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '任务更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `task_key` (`rule_id`,`table_id`,`field_id`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for dqa_task_instance
-- ----------------------------
DROP TABLE IF EXISTS `dqa_task_instance`;
CREATE TABLE `dqa_task_instance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务实例名称',
  `task_id` int(11) NULL DEFAULT NULL COMMENT '任务定义的ID',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务实例执行的状态:1 正常;2 异常;3 失败',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '任务实例开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '任务实例结束时间',
  `alert_message` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '异常告警信息内容',
  `db_table` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '库表名称',
  `field_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '字段名称',
  `rule_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `alert_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预警接收人',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '记录更新时间',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '记录创建时间',
  `rule_id` int(11) NULL DEFAULT NULL COMMENT '规则ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

--  生成告警接受用户数据
--  insert into `dqa`.`dqa_alert_user` (`id`, `name`, `phone`, `email`, `del_flag`, `create_date`, `update_date`,`wecom_user_id`)   select user_id,nick_name,phonenumber,email,del_flag,create_time,update_time,`wecom_user_id` from `zhizu_data`.sys_user where dept_id=143;