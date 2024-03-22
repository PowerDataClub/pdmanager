-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: zhizu_data
-- ------------------------------------------------------
-- Server version	5.5.68-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `QRTZ_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_BLOB_TRIGGERS`
--

LOCK TABLES `QRTZ_BLOB_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_BLOB_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CALENDARS`
--

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CALENDARS` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CALENDARS`
--

LOCK TABLES `QRTZ_CALENDARS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_CALENDARS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_CRON_TRIGGERS`
--

LOCK TABLES `QRTZ_CRON_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` DISABLE KEYS */;
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('ZhiZuDataScheduler','TASK_CLASS_NAME103','WE_COM_SYNC','0 0 0/2 * * ? *','Asia/Shanghai'),('ZhiZuDataScheduler','TASK_CLASS_NAME104','WE_COM_SYNC','0 5 0/1 * * ? *','Asia/Shanghai');
/*!40000 ALTER TABLE `QRTZ_CRON_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_FIRED_TRIGGERS`
--

LOCK TABLES `QRTZ_FIRED_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_FIRED_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_JOB_DETAILS`
--

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_JOB_DETAILS`
--

LOCK TABLES `QRTZ_JOB_DETAILS` WRITE;
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` DISABLE KEYS */;
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('ZhiZuDataScheduler','TASK_CLASS_NAME103','WE_COM_SYNC',NULL,'com.metalineage.data.quartz.util.QuartzDisallowConcurrentExecution','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0TASK_PROPERTIESsr\0#com.metalineage.data.quartz.domain.SysJob\0\0\0\0\0\0\0\0L\0\nconcurrentt\0Ljava/lang/String;L\0cronExpressionq\0~\0	L\0invokeTargetq\0~\0	L\0jobGroupq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0jobNameq\0~\0	L\0\rmisfirePolicyq\0~\0	L\0statusq\0~\0	xr\0,com.metalineage.data.common.core.domain.BaseEntity\0\0\0\0\0\0\0\0L\0createByq\0~\0	L\0\ncreateTimet\0Ljava/util/Date;L\0paramsq\0~\0L\0remarkq\0~\0	L\0searchValueq\0~\0	L\0updateByq\0~\0	L\0\nupdateTimeq\0~\0xpt\0adminsr\0java.util.Datehj�KYt\0\0xpw\0\0ya�I�xpt\0\0pppt\01t\00 0 0/2 * * ? *t\0+weComUserSyncTask.refreshWeComAccessToken()t\0WE_COM_SYNCsr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number������\0\0xp\0\0\0\0\0\0\0gt\0 企业微信 access_token 更新t\02t\00x\0'),('ZhiZuDataScheduler','TASK_CLASS_NAME104','WE_COM_SYNC',NULL,'com.metalineage.data.quartz.util.QuartzDisallowConcurrentExecution','0','1','0','0','��\0sr\0org.quartz.JobDataMap���迩��\0\0xr\0&org.quartz.utils.StringKeyDirtyFlagMap�����](\0Z\0allowsTransientDataxr\0org.quartz.utils.DirtyFlagMap�.�(v\n�\0Z\0dirtyL\0mapt\0Ljava/util/Map;xpsr\0java.util.HashMap���`�\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0t\0TASK_PROPERTIESsr\0#com.metalineage.data.quartz.domain.SysJob\0\0\0\0\0\0\0\0L\0\nconcurrentt\0Ljava/lang/String;L\0cronExpressionq\0~\0	L\0invokeTargetq\0~\0	L\0jobGroupq\0~\0	L\0jobIdt\0Ljava/lang/Long;L\0jobNameq\0~\0	L\0\rmisfirePolicyq\0~\0	L\0statusq\0~\0	xr\0,com.metalineage.data.common.core.domain.BaseEntity\0\0\0\0\0\0\0\0L\0createByq\0~\0	L\0\ncreateTimet\0Ljava/util/Date;L\0paramsq\0~\0L\0remarkq\0~\0	L\0searchValueq\0~\0	L\0updateByq\0~\0	L\0\nupdateTimeq\0~\0xpt\0adminsr\0java.util.Datehj�KYt\0\0xpw\0\0ya�7�xpt\0\0pppt\01t\00 5 0/1 * * ? *t\0!weComUserSyncTask.pullWeComUser()t\0WE_COM_SYNCsr\0java.lang.Long;��̏#�\0J\0valuexr\0java.lang.Number������\0\0xp\0\0\0\0\0\0\0ht\0同步企业微信通讯录t\02t\00x\0');
/*!40000 ALTER TABLE `QRTZ_JOB_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_LOCKS`
--

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_LOCKS` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_LOCKS`
--

LOCK TABLES `QRTZ_LOCKS` WRITE;
/*!40000 ALTER TABLE `QRTZ_LOCKS` DISABLE KEYS */;
INSERT INTO `QRTZ_LOCKS` VALUES ('ZhiZuDataScheduler','STATE_ACCESS'),('ZhiZuDataScheduler','TRIGGER_ACCESS');
/*!40000 ALTER TABLE `QRTZ_LOCKS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_PAUSED_TRIGGER_GRPS`
--

LOCK TABLES `QRTZ_PAUSED_TRIGGER_GRPS` WRITE;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SCHEDULER_STATE`
--

LOCK TABLES `QRTZ_SCHEDULER_STATE` WRITE;
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` DISABLE KEYS */;
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('ZhiZuDataScheduler','bi-tableau1621940396327',1622002383362,15000);
/*!40000 ALTER TABLE `QRTZ_SCHEDULER_STATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPLE_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPLE_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_SIMPROP_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_SIMPROP_TRIGGERS`
--

LOCK TABLES `QRTZ_SIMPROP_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QRTZ_TRIGGERS`
--

DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QRTZ_TRIGGERS` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QRTZ_TRIGGERS`
--

LOCK TABLES `QRTZ_TRIGGERS` WRITE;
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` DISABLE KEYS */;
INSERT INTO `QRTZ_TRIGGERS` VALUES ('ZhiZuDataScheduler','TASK_CLASS_NAME103','WE_COM_SYNC','TASK_CLASS_NAME103','WE_COM_SYNC',NULL,1622008800000,1622001600000,5,'WAITING','CRON',1621940396000,0,NULL,1,''),('ZhiZuDataScheduler','TASK_CLASS_NAME104','WE_COM_SYNC','TASK_CLASS_NAME104','WE_COM_SYNC',NULL,1622005500000,1622001900000,5,'WAITING','CRON',1621940396000,0,NULL,1,'');
/*!40000 ALTER TABLE `QRTZ_TRIGGERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2021-04-29 07:42:19','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2021-04-29 07:42:20','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-light','N','admin','2021-04-29 07:42:20','admin','2021-05-07 18:01:39','深色主题theme-dark，浅色主题theme-light');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(128) DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `wecom_sync` tinyint(1) DEFAULT '0' COMMENT '从企业微信同步来的数据标识',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20000 DEFAULT CHARSET=utf8 COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (1,0,'0','上海智租物联科技有限公司',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(2,1,'0,1','新能源应用中心',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(3,2,'0,1,2','二轮车部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(4,1,'0,1','产品技术中心',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(5,4,'0,1,4','系统研发部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(6,1,'0,1','工程技术应用中心',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(7,6,'0,1,6','供应链部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(8,1,'0,1','业务增长中心',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(9,8,'0,1,8','战区市场',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(11,9,'0,1,8,9','上海战区',100001000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(12,1,'0,1','客户服务中心',99996000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(13,12,'0,1,12','维养部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(14,13,'0,1,12,13','上海维养办事处',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(16,9,'0,1,8,9','合肥战区',100000500,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(17,1,'0,1','CEO办公室',99995000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(18,17,'0,1,17','法务部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(19,1,'0,1','财务中心',99994000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(20,2,'0,1,2','研发部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(21,20,'0,1,2,20','软件组',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(22,1,'0,1','人力资源中心',99993000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(23,2,'0,1,2','生产部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(24,17,'0,1,17','保险行政部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(25,9,'0,1,8,9','苏州战区',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(26,9,'0,1,8,9','安庆战区',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(27,13,'0,1,12,13','北京维养办事处',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(28,12,'0,1,12','睢宁基地',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(29,6,'0,1,6','嵌入式产品研发部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(30,4,'0,1,4','产品部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(31,19,'0,1,19','财务会计部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(32,12,'0,1,12','客服部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(33,1,'0,1','金融中心',99992000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(34,20,'0,1,2,20','电子电路组',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(35,13,'0,1,12,13','杭州维养办事处',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(36,20,'0,1,2,20','机械组',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(37,4,'0,1,4','设计部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(38,8,'0,1,8','品牌部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(39,4,'0,1,4','BI数据部',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(40,9,'0,1,8,9','浙江战区',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(41,8,'0,1,8','运营管理部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(42,8,'0,1,8','线上增长部',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(43,9,'0,1,8,9','广东战区',99996000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(44,23,'0,1,2,23','生管组',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(45,13,'0,1,12,13','贵州维养办事处',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(46,8,'0,1,8','合伙人发展部',99996000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(47,17,'0,1,17','行政部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(48,13,'0,1,12,13','广州维养办事处',99996000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(49,9,'0,1,8,9','江苏战区',100000250,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(50,13,'0,1,12,13','成都维养办事处',99995000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(51,9,'0,1,8,9','武汉战区',100000125,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(52,6,'0,1,6','电池Pack研发部',99997000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(53,19,'0,1,19','管理会计部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(54,13,'0,1,12,13','安装维修组',99994000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(55,32,'0,1,12,32','上海客服部',100000000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(56,32,'0,1,12,32','安庆客服部',99999000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(57,6,'0,1,6','品质保障部',99996000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL),(58,19,'0,1,19','审计部',99998000,NULL,NULL,NULL,'0','0',1,'WeComSync','2021-05-26 12:05:00','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'未知','0','sys_user_sex','','','Y','0','admin','2021-04-29 07:42:19','admin','2021-05-13 02:07:49','性别男'),(2,2,'男','1','sys_user_sex','','','N','0','admin','2021-04-29 07:42:19','admin','2021-05-13 02:07:54','性别女'),(3,3,'女','2','sys_user_sex','','','N','0','admin','2021-04-29 07:42:19','admin','2021-05-13 02:07:59','性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2021-04-29 07:42:19','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2021-04-29 07:42:19','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2021-04-29 07:42:19','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2021-04-29 07:42:19','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2021-04-29 07:42:19','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2021-04-29 07:42:19','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2021-04-29 07:42:19','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2021-04-29 07:42:19','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2021-04-29 07:42:19','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'关闭状态'),(18,1,'新增','1','sys_oper_type','','info','N','0','admin','2021-04-29 07:42:19','',NULL,'新增操作'),(19,2,'修改','2','sys_oper_type','','info','N','0','admin','2021-04-29 07:42:19','',NULL,'修改操作'),(20,3,'删除','3','sys_oper_type','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'删除操作'),(21,4,'授权','4','sys_oper_type','','primary','N','0','admin','2021-04-29 07:42:19','',NULL,'授权操作'),(22,5,'导出','5','sys_oper_type','','warning','N','0','admin','2021-04-29 07:42:19','',NULL,'导出操作'),(23,6,'导入','6','sys_oper_type','','warning','N','0','admin','2021-04-29 07:42:19','',NULL,'导入操作'),(24,7,'强退','7','sys_oper_type','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'强退操作'),(25,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2021-04-29 07:42:19','',NULL,'生成操作'),(26,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'清空操作'),(27,1,'成功','0','sys_common_status','','primary','N','0','admin','2021-04-29 07:42:19','',NULL,'正常状态'),(28,2,'失败','1','sys_common_status','','danger','N','0','admin','2021-04-29 07:42:19','',NULL,'停用状态'),(100,10,'是','true','tab_req_is_push',NULL,NULL,'N','0','admin','2021-05-06 17:24:52','admin','2021-05-06 17:25:17',NULL),(101,20,'否','false','tab_req_is_push',NULL,NULL,'N','0','admin','2021-05-06 17:24:59','admin','2021-05-06 17:25:22',NULL),(102,10,'企业微信同步','WE_COM_SYNC','sys_job_group',NULL,NULL,'N','0','admin','2021-05-13 02:08:53','admin','2021-05-13 02:09:08',NULL),(103,10,'需求','requirement','sys_notice_source_type',NULL,NULL,'N','0','admin','2021-05-13 09:13:14','',NULL,NULL),(104,30,'微信数据同步','wecomSync','sys_notice_source_type',NULL,NULL,'N','0','admin','2021-05-13 09:13:25','admin','2021-05-15 17:12:48',NULL),(105,10,'企业微信','wecom','sys_notice_target_type',NULL,NULL,'N','0','admin','2021-05-13 09:13:49','',NULL,NULL),(107,0,'是','true','sys_notice_mention',NULL,NULL,'N','0','admin','2021-05-13 09:14:36','admin','2021-05-13 09:48:16',NULL),(108,10,'否','false','sys_notice_mention',NULL,NULL,'N','0','admin','2021-05-13 09:14:44','admin','2021-05-13 09:48:20',NULL),(109,20,'评价&意见','suggestion','sys_notice_source_type',NULL,NULL,'N','0','admin','2021-05-15 17:12:42','admin','2021-05-18 17:00:12',NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2021-04-29 07:42:19','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2021-04-29 07:42:19','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2021-04-29 07:42:19','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2021-04-29 07:42:19','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2021-04-29 07:42:19','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2021-04-29 07:42:19','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2021-04-29 07:42:19','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2021-04-29 07:42:19','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2021-04-29 07:42:19','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2021-04-29 07:42:19','',NULL,'登录状态列表'),(100,'需求已推送','tab_req_is_push','0','admin','2021-05-06 17:23:59','admin','2021-05-06 17:24:20',NULL),(101,'推送通知数据来源','sys_notice_source_type','0','admin','2021-05-13 09:11:48','',NULL,NULL),(102,'通知推送数据目标','sys_notice_target_type','0','admin','2021-05-13 09:12:05','',NULL,NULL),(103,'是否推送','sys_notice_mention','0','admin','2021-05-13 09:12:27','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (103,'企业微信 access_token 更新','WE_COM_SYNC','weComUserSyncTask.refreshWeComAccessToken()','0 0 0/2 * * ? *','2','1','0','admin','2021-05-13 02:09:50','admin','2021-05-13 02:10:06',''),(104,'同步企业微信通讯录','WE_COM_SYNC','weComUserSyncTask.pullWeComUser()','0 5 0/1 * * ? *','2','1','0','admin','2021-05-13 02:10:51','admin','2021-05-15 13:53:03','');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=562 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=549 DEFAULT CHARSET=utf8 COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(4) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `is_frame` int(1) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `report_template` int(11) DEFAULT NULL COMMENT '报表根路径',
  `report_name` varchar(128) DEFAULT '' COMMENT '报表名称',
  `report_user_name` varchar(128) DEFAULT NULL COMMENT '指定的报表用户名',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2095 DEFAULT CHARSET=utf8 COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,20,'system',NULL,1,0,'M','0','0','','system',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-04 16:29:53','系统管理目录'),(2,'系统监控',0,30,'monitor',NULL,1,0,'M','0','0','','monitor',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-04 16:30:07','系统监控目录'),(100,'用户管理',1,10,'user','system/user/index',1,0,'C','0','0','system:user:list','user',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:17:59','用户管理菜单'),(101,'角色管理',1,20,'role','system/role/index',1,0,'C','0','0','system:role:list','peoples',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:13','角色管理菜单'),(102,'菜单管理',1,30,'menu','system/menu/index',1,0,'C','0','0','system:menu:list','tree-table',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:33','菜单管理菜单'),(103,'部门管理',1,40,'dept','system/dept/index',1,0,'C','0','0','system:dept:list','tree',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:37','部门管理菜单'),(104,'岗位管理',1,50,'post','system/post/index',1,0,'C','0','0','system:post:list','post',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:40','岗位管理菜单'),(105,'字典管理',1,60,'dict','system/dict/index',1,0,'C','0','0','system:dict:list','dict',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:44','字典管理菜单'),(106,'参数设置',1,70,'config','system/config/index',1,0,'C','0','0','system:config:list','edit',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:47','参数设置菜单'),(107,'通知公告',1,80,'notice','system/notice/index',1,0,'C','0','0','system:notice:list','message',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:18:51','通知公告菜单'),(108,'日志管理',1,100,'log','',1,0,'M','0','0','','log',1,NULL,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 15:19:06','日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index',1,0,'C','0','0','monitor:online:list','online',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index',1,0,'C','0','0','monitor:job:list','job',NULL,NULL,NULL,'admin','2021-05-11 08:05:08','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index',1,0,'C','0','0','monitor:druid:list','druid',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index',1,0,'C','0','0','monitor:server:list','server',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index',1,0,'C','0','0','monitor:cache:list','redis',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'缓存监控菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index',1,0,'C','0','0','monitor:operlog:list','form',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index',1,0,'C','0','0','monitor:logininfor:list','logininfor',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,'登录日志菜单'),(1001,'用户查询',100,1,'','',1,0,'F','0','0','system:user:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1002,'用户新增',100,2,'','',1,0,'F','0','0','system:user:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1003,'用户修改',100,3,'','',1,0,'F','0','0','system:user:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1004,'用户删除',100,4,'','',1,0,'F','0','0','system:user:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1005,'用户导出',100,5,'','',1,0,'F','0','0','system:user:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1006,'用户导入',100,6,'','',1,0,'F','0','0','system:user:import','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1007,'重置密码',100,7,'','',1,0,'F','0','0','system:user:resetPwd','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1008,'角色查询',101,1,'','',1,0,'F','0','0','system:role:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1009,'角色新增',101,2,'','',1,0,'F','0','0','system:role:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1010,'角色修改',101,3,'','',1,0,'F','0','0','system:role:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1011,'角色删除',101,4,'','',1,0,'F','0','0','system:role:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1012,'角色导出',101,5,'','',1,0,'F','0','0','system:role:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1013,'菜单查询',102,1,'','',1,0,'F','0','0','system:menu:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1014,'菜单新增',102,2,'','',1,0,'F','0','0','system:menu:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1015,'菜单修改',102,3,'','',1,0,'F','0','0','system:menu:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1016,'菜单删除',102,4,'','',1,0,'F','0','0','system:menu:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1017,'部门查询',103,1,'','',1,0,'F','0','0','system:dept:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1018,'部门新增',103,2,'','',1,0,'F','0','0','system:dept:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1019,'部门修改',103,3,'','',1,0,'F','0','0','system:dept:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1020,'部门删除',103,4,'','',1,0,'F','0','0','system:dept:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1021,'岗位查询',104,1,'','',1,0,'F','0','0','system:post:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1022,'岗位新增',104,2,'','',1,0,'F','0','0','system:post:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1023,'岗位修改',104,3,'','',1,0,'F','0','0','system:post:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1024,'岗位删除',104,4,'','',1,0,'F','0','0','system:post:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1025,'岗位导出',104,5,'','',1,0,'F','0','0','system:post:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1026,'字典查询',105,1,'#','',1,0,'F','0','0','system:dict:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1027,'字典新增',105,2,'#','',1,0,'F','0','0','system:dict:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1028,'字典修改',105,3,'#','',1,0,'F','0','0','system:dict:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1029,'字典删除',105,4,'#','',1,0,'F','0','0','system:dict:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1030,'字典导出',105,5,'#','',1,0,'F','0','0','system:dict:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1031,'参数查询',106,1,'#','',1,0,'F','0','0','system:config:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1032,'参数新增',106,2,'#','',1,0,'F','0','0','system:config:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1033,'参数修改',106,3,'#','',1,0,'F','0','0','system:config:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1034,'参数删除',106,4,'#','',1,0,'F','0','0','system:config:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1035,'参数导出',106,5,'#','',1,0,'F','0','0','system:config:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1036,'公告查询',107,1,'#','',1,0,'F','0','0','system:notice:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1037,'公告新增',107,2,'#','',1,0,'F','0','0','system:notice:add','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1038,'公告修改',107,3,'#','',1,0,'F','0','0','system:notice:edit','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1039,'公告删除',107,4,'#','',1,0,'F','0','0','system:notice:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1040,'操作查询',500,1,'#','',1,0,'F','0','0','monitor:operlog:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1041,'操作删除',500,2,'#','',1,0,'F','0','0','monitor:operlog:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1042,'日志导出',500,4,'#','',1,0,'F','0','0','monitor:operlog:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1043,'登录查询',501,1,'#','',1,0,'F','0','0','monitor:logininfor:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1044,'登录删除',501,2,'#','',1,0,'F','0','0','monitor:logininfor:remove','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1045,'日志导出',501,3,'#','',1,0,'F','0','0','monitor:logininfor:export','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1046,'在线查询',109,1,'#','',1,0,'F','0','0','monitor:online:query','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1047,'批量强退',109,2,'#','',1,0,'F','0','0','monitor:online:batchLogout','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1048,'单条强退',109,3,'#','',1,0,'F','0','0','monitor:online:forceLogout','#',1,NULL,NULL,'admin','2021-04-29 07:42:19','',NULL,''),(1049,'任务查询',110,1,'#','',1,0,'F','0','0','monitor:job:query','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(1050,'任务新增',110,2,'#','',1,0,'F','0','0','monitor:job:add','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(1051,'任务修改',110,3,'#','',1,0,'F','0','0','monitor:job:edit','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(1052,'任务删除',110,4,'#','',1,0,'F','0','0','monitor:job:remove','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(1053,'状态修改',110,5,'#','',1,0,'F','0','0','monitor:job:changeStatus','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(1054,'任务导出',110,7,'#','',1,0,'F','0','0','monitor:job:export','#',NULL,NULL,NULL,'admin','2021-05-11 08:05:50','',NULL,''),(2008,'报表模板',1,35,'template','system/template/index',1,0,'C','0','0','tableau:template:list','form',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-06 15:19:33','tableau 报表内嵌 html 模板菜单'),(2009,'报表模板查询',2008,1,'#','',1,0,'F','0','0','tableau:template:query','#',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-04 15:55:41',''),(2010,'报表模板新增',2008,2,'#','',1,0,'F','0','0','tableau:template:add','#',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-04 15:55:46',''),(2011,'报表模板修改',2008,3,'#','',1,0,'F','0','0','tableau:template:edit','#',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-04 15:55:51',''),(2012,'报表模板删除',2008,4,'#','',1,0,'F','0','0','tableau:template:remove','#',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-04 15:55:55',''),(2013,'报表模板导出',2008,5,'#','',1,0,'F','0','0','tableau:template:export','#',1,NULL,NULL,'admin','2021-05-04 15:48:31','admin','2021-05-04 15:55:59',''),(2022,'报表访问日志',108,1,'visitlog','monitor/visitlog/index',1,0,'C','0','0','monitor:visitlog:list','log',NULL,'',NULL,'admin','2021-05-06 12:50:43','admin','2021-05-06 13:06:35','报表访问日志菜单'),(2023,'报表访问日志查询',2022,1,'#','',1,0,'F','0','0','system:visitlog:query','#',NULL,'',NULL,'admin','2021-05-06 12:50:43','',NULL,''),(2024,'报表访问日志新增',2022,2,'#','',1,0,'F','0','0','system:visitlog:add','#',NULL,'',NULL,'admin','2021-05-06 12:50:43','',NULL,''),(2025,'报表访问日志修改',2022,3,'#','',1,0,'F','0','0','system:visitlog:edit','#',NULL,'',NULL,'admin','2021-05-06 12:50:43','',NULL,''),(2026,'报表访问日志删除',2022,4,'#','',1,0,'F','0','0','system:visitlog:remove','#',NULL,'',NULL,'admin','2021-05-06 12:50:43','',NULL,''),(2027,'报表访问日志导出',2022,5,'#','',1,0,'F','0','0','system:visitlog:export','#',NULL,'',NULL,'admin','2021-05-06 12:50:43','',NULL,''),(2028,'意见&评价',2034,1,'suggestion','tableau/suggestion/index',1,0,'C','0','0','tableau:suggestion:list','message',NULL,'',NULL,'admin','2021-05-06 15:12:05','admin','2021-05-06 15:17:44','意见&评价菜单'),(2029,'意见&评价查询',2028,1,'#','',1,0,'F','0','0','tableau:suggestion:query','#',NULL,'',NULL,'admin','2021-05-06 15:12:05','',NULL,''),(2031,'意见&评价修改',2028,3,'#','',1,0,'F','0','0','tableau:suggestion:edit','#',NULL,'',NULL,'admin','2021-05-06 15:12:05','',NULL,''),(2032,'意见&评价删除',2028,4,'#','',1,0,'F','0','0','tableau:suggestion:remove','#',NULL,'',NULL,'admin','2021-05-06 15:12:05','',NULL,''),(2033,'意见&评价导出',2028,5,'#','',1,0,'F','0','0','tableau:suggestion:export','#',NULL,'',NULL,'admin','2021-05-06 15:12:05','',NULL,''),(2034,'需求&评价',1,90,'comment',NULL,1,0,'M','0','0','','edit',1,'',NULL,'admin','2021-05-06 15:17:32','admin','2021-05-06 15:19:03',''),(2035,'报表需求',2034,1,'requirement','tableau/requirement/index',1,0,'C','0','0','tableau:requirement:list','log',NULL,'',NULL,'admin','2021-05-06 16:42:12','admin','2021-05-06 17:03:42','报表需求菜单'),(2036,'报表需求查询',2035,1,'#','',1,0,'F','0','0','tableau:requirement:query','#',NULL,'',NULL,'admin','2021-05-06 16:42:12','',NULL,''),(2038,'报表需求修改',2035,3,'#','',1,0,'F','0','0','tableau:requirement:edit','#',NULL,'',NULL,'admin','2021-05-06 16:42:12','',NULL,''),(2039,'报表需求删除',2035,4,'#','',1,0,'F','0','0','tableau:requirement:remove','#',NULL,'',NULL,'admin','2021-05-06 16:42:12','',NULL,''),(2040,'报表需求导出',2035,5,'#','',1,0,'F','0','0','tableau:requirement:export','#',NULL,'',NULL,'admin','2021-05-06 16:42:12','',NULL,''),(2043,'推送配置新增',2066,2,'#','',1,0,'F','0','0','system:push:add','#',NULL,'',NULL,'admin','2021-05-13 09:16:05','',NULL,''),(2044,'推送配置修改',2066,3,'#','',1,0,'F','0','0','system:push:edit','#',NULL,'',NULL,'admin','2021-05-13 09:16:05','',NULL,''),(2045,'推送配置删除',2066,4,'#','',1,0,'F','0','0','system:push:remove','#',NULL,'',NULL,'admin','2021-05-13 09:16:05','',NULL,''),(2046,'推送配置导出',2066,5,'#','',1,0,'F','0','0','system:push:export','#',NULL,'',NULL,'admin','2021-05-13 09:16:05','',NULL,''),(2061,'金融中心',0,10,'finance',NULL,1,0,'M','0','0','','excel',1,'',NULL,'admin','2021-05-07 17:18:28','admin','2021-05-14 09:45:52',''),(2062,'投资者关系',2061,1,'investors',NULL,1,0,'M','0','0','','chart',1,'',NULL,'admin','2021-05-07 17:18:50','admin','2021-05-10 10:36:15',''),(2064,'上海柜效数据',2062,1,'shanghai_exchange_data/Shanghai_Exchange_Data','tableau/report/index',1,0,'R','0','0','tableau:report:shanghai_exchange_data/Shanghai_Exchange_Data','chart',1,'shanghai_exchange_data/Shanghai_Exchange_Data',NULL,'admin','2021-05-10 10:38:21','admin','2021-05-18 10:43:15',''),(2066,'推送配置',1,45,'push','system/push/index',1,0,'C','0','0','system:push:list','guide',NULL,'',NULL,'admin','2021-05-13 09:16:05','admin','2021-05-13 10:05:04','推送配置菜单'),(2067,'推送配置查询',2066,1,'#','',1,0,'F','0','0','system:push:query','#',NULL,'',NULL,'admin','2021-05-13 09:16:05','admin','2021-05-13 09:35:42',''),(2068,'资产管理',0,2,'Asset_Management',NULL,1,0,'M','0','0','','excel',1,'',NULL,'admin','2021-05-14 09:47:26','admin','2021-05-14 12:01:36',''),(2069,'战区统计',0,3,'Sales_Area_Analysis',NULL,1,0,'M','0','0','','excel',1,'',NULL,'admin','2021-05-14 09:51:27','admin','2021-05-14 11:46:48',''),(2070,'电池分析',2068,1,'Battery_analysis',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-14 12:00:14','',NULL,''),(2071,'换电柜分析',2068,2,'Kiosk_Analysis',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-14 12:01:10','',NULL,''),(2072,'销售总览',2069,1,'Sales-Overview',NULL,1,0,'M','0','0','','chart',1,'',NULL,'admin','2021-05-14 12:02:59','admin','2021-05-14 12:03:10',''),(2073,'战区分析',2069,2,'sales_area_analysis',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-17 10:15:54','',NULL,''),(2074,'合伙人分析',2069,3,'partership_analysis',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-17 10:16:19','',NULL,''),(2075,'项目管理',0,4,'project_management',NULL,1,0,'M','0','0',NULL,'excel',1,'',NULL,'admin','2021-05-17 10:16:54','',NULL,''),(2076,'租车平台',2075,1,'car_rental',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-17 10:17:18','',NULL,''),(2077,'商家端',2075,2,'business_side',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-17 10:18:06','',NULL,''),(2078,'合伙人电池盘点',2070,1,'Battery_Inventory_Of_Partners/Battery_Inventory_Of_Partners','tableau/report/index',1,0,'R','0','0','tableau:report:Battery_Inventory_Of_Partners/Battery_Inventory_Of_Partners','chart',1,'Battery_Inventory_Of_Partners/Battery_Inventory_Of_Partners',NULL,'admin','2021-05-17 10:26:48','admin','2021-05-20 09:58:58',''),(2079,'推荐官',2075,3,'recommendation',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-17 13:26:20','',NULL,''),(2081,'CEO驾驶舱',0,1,'driving',NULL,1,0,'M','0','0',NULL,'#',1,'',NULL,'admin','2021-05-18 18:54:51','',NULL,''),(2089,'人力资源中心',0,15,'HR',NULL,1,0,'M','0','0',NULL,'excel',1,'',NULL,'admin','2021-05-20 17:23:15','',NULL,''),(2090,'人事分析',2089,1,'HR_analysis',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-20 17:23:48','',NULL,''),(2091,'数据部',0,19,'data_team',NULL,1,0,'M','0','0','','excel',1,'',NULL,'admin','2021-05-20 17:28:28','admin','2021-05-20 18:18:22',''),(2092,'平台分析',2091,1,'plateform_traffic',NULL,1,0,'M','0','0',NULL,'chart',1,'',NULL,'admin','2021-05-20 17:29:06','',NULL,''),(2093,'人力资源概览',2090,1,'HR_Overviews/HR_Overviews','tableau/report/index',1,0,'R','0','0','tableau:report:HR_Overviews/HR_Overviews','chart',1,'HR_Overviews/HR_Overviews',NULL,'admin','2021-05-24 17:45:03','',NULL,''),(2094,'平台流量分析',2092,1,'Traffic_Analysis/Traffic_Analysis','tableau/report/index',1,0,'R','0','0','tableau:report:Traffic_Analysis/Traffic_Analysis','chart',1,'Traffic_Analysis/Traffic_Analysis',NULL,'admin','2021-05-24 18:16:56','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice` (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2021-05-01 智租数据新版本发布啦','2','新版本内容','0','admin','2021-04-29 07:42:20','',NULL,'管理员'),(2,'维护通知：2021-05-03 智租数据系统凌晨维护','1','维护内容','0','admin','2021-04-29 07:42:20','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice_config`
--

DROP TABLE IF EXISTS `sys_notice_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `source_type` varchar(64) DEFAULT NULL COMMENT '来源类型',
  `target_type` varchar(64) DEFAULT NULL COMMENT '目标类型',
  `url` varchar(1024) DEFAULT NULL COMMENT 'api url',
  `mention` tinyint(1) DEFAULT '0' COMMENT '是否推送通知',
  `create_by` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(128) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tab_notice_config_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='消息推送配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice_config`
--

LOCK TABLES `sys_notice_config` WRITE;
/*!40000 ALTER TABLE `sys_notice_config` DISABLE KEYS */;
INSERT INTO `sys_notice_config` VALUES (3,'requirement','wecom','https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=2529537f-b62e-4544-9341-210afe678c16',1,NULL,'2021-05-13 23:23:58',NULL,'2021-05-17 18:04:46',NULL),(4,'wecomSync','wecom','https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=b1f9fe5b-0006-4e9f-b850-c84f867e0908',1,NULL,'2021-05-13 23:24:32',NULL,'2021-05-17 09:07:49',NULL),(5,'suggestion','wecom','https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=829e4617-669d-40f9-8860-ee8f5bf2b094',1,NULL,'2021-05-15 17:13:17',NULL,'2021-05-18 17:00:22',NULL);
/*!40000 ALTER TABLE `sys_notice_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice_mention_user`
--

DROP TABLE IF EXISTS `sys_notice_mention_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_notice_mention_user` (
  `notice_id` int(11) NOT NULL DEFAULT '0',
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`notice_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice_mention_user`
--

LOCK TABLES `sys_notice_mention_user` WRITE;
/*!40000 ALTER TABLE `sys_notice_mention_user` DISABLE KEYS */;
INSERT INTO `sys_notice_mention_user` VALUES (3,130),(3,237),(3,240),(3,260),(4,130),(4,237),(4,240),(4,260),(5,130),(5,237),(5,240),(5,260);
/*!40000 ALTER TABLE `sys_notice_mention_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8 COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2021-04-29 07:42:19','',NULL,''),(2,'se','项目经理',2,'0','admin','2021-04-29 07:42:19','',NULL,''),(3,'hr','人力资源',3,'0','admin','2021-04-29 07:42:19','',NULL,''),(4,'user','普通员工',4,'0','admin','2021-04-29 07:42:19','',NULL,''),(5,'unknown','企业微信未配置岗位',100,'0','',NULL,'',NULL,NULL),(6,'d4ada9a9c848474fa54cffddacffef30','仓库管理员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(7,'ae77fe2aadf44d8f86a65ecea0faea19','前端开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(8,'6e31f0cd7969431cbda2d15d4d1424c6','贵州维养分中心负责人',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(9,'7461568e9f924611b3cfa149b31ffe7c','高级视觉设计师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(10,'44be18facbe34040a03431f81a6215d7','市场高级总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(11,'a24cbcd930b74895b90e288d1abbb33a','维养高级专员-北京',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(12,'3171447e194c4b50a9c9e38e7f5afbc6','维养助理-杭州',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(13,'bc47b373a6994ed2ba45ed8ee7895579','新媒体内容运营',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(14,'36c4f56f8c4d4385af65b9008cd3e397','维养专员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(15,'ff26f71130014225a4a6c3e6bd222187','高级JAVA研发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(16,'6f25cd60de9f4148af2d996552e97ce1','用户高级产品经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(17,'8c826366d10047798e8e2c63746aa79c','高级工业设计师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(18,'ed7c6295ef314dae8e593d4bed6ddb34','联合创始人',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(19,'49b74fdf08cb45d892491755bb17171f','资深Java工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(20,'785b5699f2ec4606a85e6892e41bfbc2','高级UI设计师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(21,'eb19bc2b2fd1466f901793b2034b0619','电柜维养-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(22,'7e5ce3dd3a95487b928a6783c04568bc','电池Pack研发专家',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(23,'848da14a43fa4f27bde17e63c643d2d8','维养高级专员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(24,'c62da8463e7641f294d4603c359ce0b7','研发总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(25,'2be6280cb3024916b7fac3fcd94bbbe3','电池Pack工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(26,'d7e446e4353c4af6adb6e5da588723f7','维养专员-杭州',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(27,'db982864df74499584220a189e61c054','董事长助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(28,'e68fa0bb10ca42dc974ac267459269f0','维养助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(29,'2d69393eaa794e9fbcea2a8214e8f0e4','客服经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(30,'b80963df61d44b6a95ca137fc623ad9d','平台产品经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(31,'3603d43af4ee4082ad81b7a3103d41c8','设计总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(32,'b945f64b29f94153935f76662f83c2ac','维养高级专员-广州',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(33,'84143cda5db94eb0808d7cbc6a95498c','CFO',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(34,'4a635d2d2ec74fa38a2801907d68f3e7','高级JAVA开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(35,'4027197f4c0b466d8faebc46dfbaaeb4','高级总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(36,'b22c57ecf3b3449594bb2f66114d5004','调度维养专员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(37,'8b6f4e36d0a84e6fb9f55d08bbe25f94','维养专员-北京',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(38,'ffc5671221814eadb82d2ef89ed022e7','客服助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(39,'5ef6e4d051e548628f083e9be94618d8','主任工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(40,'25bc15fd8556447cb1644d11acd3ddef','业务增长VP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(41,'52dee8371b5e4286bfa462919285ce1d','用户运营',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(42,'db3d8f2224134bb680f38df0d07e71de','JAVA工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(43,'a14fd5d098f8470096a802e375531a4c','市场总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(44,'b327d3acc0894e668f6af1ce119cd59e','硬件专家',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(45,'635b90e0a71640c686250ce6b02e7a22','首席供应链官',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(46,'c120efae801d4abeb586d32d72a6d12e','维养高级助理-广州',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(47,'7d6ed971c0eb451885271526272f3515','HRVP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(48,'37a837c4cd5d4f06ad24aea45aaf406b','品牌高级总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(49,'298262bb67fd464fa177eb50ccdb85d9','维养专员-徐州',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(50,'3402ae7d8d7c49999e2af57c9930127f','运维经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(51,'fddbd607dd154e68b562217f269d8ce7','法务高级助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(52,'8542579b2a604094a8a037fb09edcf60','用户产品经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(53,'8d4b9729b2204786a7ef9eb225af86d7','产品总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(54,'689bd501385e41da8a7ed71fcff43139','财务经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(55,'bcc8d0261b9c40eeb052bf52a4424cb9','品牌负责人-安庆',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(56,'4855d51dd3564102a7111811c6de3903','资深Java开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(57,'05d4070e06ad4e9f8f40c9279d7a878b','安卓开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(58,'7b18f778cd9d47fab47045567ca47a3c','创始人&CEO',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(59,'bba6f0110e8c43d5ae66e5b1fd920ec0','CPO',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(60,'ec356377b73940b38405dfca44bbab9c','保险行政专员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(61,'9a8a131b1730423fabce24a144eb4ad6','高级数据总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(62,'518562219feb4774b338e7f9f64b2210','BI开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(63,'358126ae05f446bfb3be0352433e6b89','总账会计',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(64,'d951a615e08d45809223f3b04ee9fa76','供应链专家',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(65,'720e84e1ad4d4e90ae49d6f5627f7d84','高级调度专员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(66,'4a3f22ff2fbf44a7b65ce4cbd4ab726f','Java开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(67,'ec3859981a3d4e7fab50ba53962c1c26','高级采购助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(68,'3ce4914b8cdf4118b4a88f02da060832','市场经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(69,'d710d1e8849c4b0da67ea66ed9de6109','产品经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(70,'eab81bb9290345f3a5afe5ac22f3e4e9','数据分析师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(71,'9305c6d9e2ee4798aa12328251aa5fbf','客服专员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(72,'5f3f5e6ac7464a909b9b92ab226cfa7a','销售内勤',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(73,'fb8bef7f4be6467c952a4f4a9f5bf825','嵌入式软件开发（实习生）',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(74,'d826d79db71846f7876842d4ff002cff','审计总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(75,'30e483b047cd45d9b28e7d07d4bdc4d3','维养经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(76,'2aaec1b5d1da4f26845abeb58ab71501','维养专员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(77,'bd2094d1f8d242179f79b95367152da2','助理VP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(78,'957a5510641344d7b0a44746b0ba61c0','维养内勤',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(79,'79cc3b6209ba4624bb257bddc2e52821','维养中心负责人-成都',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(80,'40968e2d52f4493ebc92f0e9bfe86ee1','维养专员-贵阳',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(81,'289e662d3a334a089fcd3e74dd2e52ab','维养助理-北京',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(82,'9a3741209df94465b54f88848b08bfad','高级融资总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(83,'9fa6a6310c7f4cd6be086966e5f04a43','硬件产品总工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(84,'ff748c5e7ba24c97915aecb531f34e3b','电池质检员/电池返修员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(85,'4fbad721a9cc4ebb91916ee227f181e4','前置仓调度员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(86,'1c2e2ed310be4b87b91dc85e24dcb82e','客户服务VP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(87,'61cf5d630e33437db69239fe2abdf3d1','电池配送员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(88,'aeaee9ce965a4f37a1369bfb226e7393','高级测试工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(89,'5b3dec2b40ae4b9b8056ff8ea122b476','业务增长助理VP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(90,'96e74020064d476e9439d8f7fd98d6f9','硬件测试工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(91,'982c80fcb9f6461694b0316d383792f9','CEO特别助理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(92,'e9d2d9870a114949a43f912e6e7d6cf9','生产副总-徐州睢宁',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(93,'5756c83d056e47f098e092c775f8a942','嵌入式软件开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(94,'12bd93af120e4fa5997234064e5fd7cc','高级iOS开发工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(95,'0edaa1cd372b455ead19700377771247','财务VP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(96,'6fcdcef185c34447987da54b1ad3232c','仓管高级助理-北京',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(97,'50918e2ffd7b429b8eac7084f2fa83e4','采购主管',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(98,'c0f381a674204689a65357c54fa11565','应收会计',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(99,'8be82df2dad341c79831de324f0fa0be','生产工艺',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(100,'5becf8e24a0b4116898394a03ce12eef','市场高级经理',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(101,'6b8228e5ad9c4970976a04f77b8f0839','电池Pack总监',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(102,'c71fb76cd53747e6a1c6328cc731cd05','项目专员-上海',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(103,'6c092460b1654cc99a1f45fa782b45fc','出纳',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(104,'b085ea5da56248ce9c1799f0a38a69b8','数据分析实习生',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(105,'ad6157752a9a4f66b355fd507a142aa0','嵌入式软件专家',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(106,'4f5c8f3d24ff46e3810c81710b3fe04e','测试主管',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(107,'36719895d0c34ac5827bb16a134fa553','研发总监-安庆',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(108,'7c5247f1a1bd483eb604c2b2d32f96d8','驾驶员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(109,'47fa5e9a64ad4f8f844867b9a0ff545a','HRBP',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(110,'a84e379d07fc4b24b308427f415a87d8','测试工程师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(111,'ec7fe719c14644eda49a7b44ff898036','质检客服',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(112,'14d3cc4d4f184dc5b73057da503ab4f5','配送调度员',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(113,'7a31ebab36de4177b60a117f00b8c858','芯片焊接技师',100,'0','weComSync','2021-05-13 02:14:34','',NULL,NULL),(114,'e93e55f949bd4a7f929646ba24c755f0','高级Java开发工程师',100,'0','weComSync','2021-05-14 10:05:00','',NULL,NULL),(115,'5f088c50affe4ac4a1fc26adf8922257','硬件开发工程师',100,'0','weComSync','2021-05-17 10:05:01','',NULL,NULL),(116,'40c25576d14a4f0aa4504284f9bf9569','资产管理专员',100,'0','weComSync','2021-05-19 11:05:00','',NULL,NULL),(117,'4b3b7f9fe3a14a0c8709cfdaaa9799bd','机械结构设计工程师',100,'0','weComSync','2021-05-20 10:05:00','',NULL,NULL),(118,'617e2220d04140b688798ff71487ca9b','电池Pack电气工程师',100,'0','weComSync','2021-05-20 11:05:01','',NULL,NULL),(119,'c216628dda5d440ca206c05ca865096f','质量总监',100,'0','weComSync','2021-05-24 11:05:00','',NULL,NULL),(120,'e467d2be9eff4259bb9e86f5713f1177','供应链总监',100,'0','weComSync','2021-05-25 12:05:00','',NULL,NULL),(121,'48ae978a81794860ab64d992e291feb8','Java技术专家',100,'0','weComSync','2021-05-25 18:05:00','',NULL,NULL),(122,'ecb9d4354a09492c880f85e069265984','质量专家',100,'0','weComSync','2021-05-25 18:05:00','',NULL,NULL);
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `default_role` tinyint(1) DEFAULT '0' COMMENT '默认角色标识',
  `from_dept` bigint(20) DEFAULT NULL COMMENT '根据哪个部门生成的默认角色',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8 COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0',0,NULL,'admin','2021-04-29 07:42:19','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','2',0,NULL,'admin','2021-04-29 07:42:19','admin','2021-05-06 19:49:53','普通角色'),(100,'管理员','superuser',1,'1',1,1,'0','0',0,NULL,'admin','2021-05-06 20:15:18','admin','2021-05-25 10:47:35','普通管理员'),(101,'报表用户','ReportUser',3,'1',1,1,'0','2',0,NULL,'admin','2021-05-06 20:16:29','admin','2021-05-13 20:09:27',NULL),(157,'公司高层','CorpManagement',3,'1',1,1,'0','0',0,NULL,'admin','2021-05-13 20:05:29','admin','2021-05-25 10:47:56',NULL),(158,'金融中心-高层','FinManagement',100,'1',1,1,'0','0',0,NULL,'admin','2021-05-13 20:21:10','admin','2021-05-20 18:19:14',NULL),(159,'运营中高层','op_management',10,'1',1,1,'0','0',0,NULL,'admin','2021-05-17 11:04:54','admin','2021-05-25 10:48:14',NULL),(160,'数据开发团队','data_developer',1,'1',1,1,'0','0',0,NULL,'admin','2021-05-17 13:24:49','admin','2021-05-20 18:20:51',NULL),(161,'CEO/董事长/CEO助理','CEO',2,'1',1,1,'0','0',0,NULL,'admin','2021-05-20 18:19:56','admin','2021-05-25 18:44:35',NULL),(162,'人力资源-中层','HR_normal',11,'1',1,1,'0','0',0,NULL,'admin','2021-05-24 17:53:35','',NULL,NULL);
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (1,2071),(100,1),(100,2),(100,100),(100,101),(100,102),(100,103),(100,104),(100,105),(100,106),(100,107),(100,108),(100,109),(100,110),(100,111),(100,112),(100,113),(100,500),(100,501),(100,1001),(100,1002),(100,1003),(100,1004),(100,1005),(100,1006),(100,1007),(100,1008),(100,1009),(100,1010),(100,1011),(100,1012),(100,1013),(100,1014),(100,1015),(100,1016),(100,1017),(100,1018),(100,1019),(100,1020),(100,1021),(100,1022),(100,1023),(100,1024),(100,1025),(100,1026),(100,1027),(100,1028),(100,1029),(100,1030),(100,1031),(100,1032),(100,1033),(100,1034),(100,1035),(100,1036),(100,1037),(100,1038),(100,1039),(100,1040),(100,1041),(100,1042),(100,1043),(100,1044),(100,1045),(100,1046),(100,1047),(100,1048),(100,1049),(100,1050),(100,1051),(100,1052),(100,1053),(100,1054),(100,2008),(100,2009),(100,2010),(100,2011),(100,2012),(100,2013),(100,2022),(100,2023),(100,2024),(100,2025),(100,2026),(100,2027),(100,2028),(100,2029),(100,2031),(100,2032),(100,2033),(100,2034),(100,2035),(100,2036),(100,2038),(100,2039),(100,2040),(100,2043),(100,2044),(100,2045),(100,2046),(100,2061),(100,2062),(100,2064),(100,2066),(100,2067),(100,2068),(100,2069),(100,2070),(100,2071),(100,2072),(100,2073),(100,2074),(100,2075),(100,2076),(100,2077),(100,2078),(100,2079),(100,2081),(100,2089),(100,2090),(100,2091),(100,2092),(100,2093),(100,2094),(157,2061),(157,2062),(157,2064),(157,2068),(157,2069),(157,2070),(157,2071),(157,2072),(157,2073),(157,2074),(157,2075),(157,2076),(157,2077),(157,2078),(157,2079),(157,2089),(157,2090),(157,2091),(157,2092),(157,2094),(158,2061),(158,2062),(158,2064),(158,2068),(158,2071),(159,2068),(159,2069),(159,2070),(159,2071),(159,2072),(159,2073),(159,2074),(159,2075),(159,2076),(159,2077),(159,2078),(159,2079),(160,1),(160,2),(160,100),(160,101),(160,102),(160,103),(160,104),(160,105),(160,106),(160,107),(160,108),(160,109),(160,110),(160,111),(160,112),(160,113),(160,500),(160,501),(160,1001),(160,1002),(160,1003),(160,1004),(160,1005),(160,1006),(160,1007),(160,1008),(160,1009),(160,1010),(160,1011),(160,1012),(160,1013),(160,1014),(160,1015),(160,1016),(160,1017),(160,1018),(160,1019),(160,1020),(160,1021),(160,1022),(160,1023),(160,1024),(160,1025),(160,1026),(160,1027),(160,1028),(160,1029),(160,1030),(160,1031),(160,1032),(160,1033),(160,1034),(160,1035),(160,1036),(160,1037),(160,1038),(160,1039),(160,1040),(160,1041),(160,1042),(160,1043),(160,1044),(160,1045),(160,1046),(160,1047),(160,1048),(160,1049),(160,1050),(160,1051),(160,1052),(160,1053),(160,1054),(160,2008),(160,2009),(160,2010),(160,2011),(160,2012),(160,2013),(160,2022),(160,2023),(160,2024),(160,2025),(160,2026),(160,2027),(160,2028),(160,2029),(160,2031),(160,2032),(160,2033),(160,2034),(160,2035),(160,2036),(160,2038),(160,2039),(160,2040),(160,2043),(160,2044),(160,2045),(160,2046),(160,2061),(160,2062),(160,2064),(160,2066),(160,2067),(160,2068),(160,2069),(160,2070),(160,2071),(160,2072),(160,2073),(160,2074),(160,2075),(160,2076),(160,2077),(160,2078),(160,2079),(160,2081),(160,2089),(160,2090),(160,2091),(160,2092),(161,2061),(161,2062),(161,2064),(161,2068),(161,2069),(161,2070),(161,2071),(161,2072),(161,2073),(161,2074),(161,2075),(161,2076),(161,2077),(161,2078),(161,2079),(161,2081),(161,2089),(161,2090),(161,2091),(161,2092),(161,2093),(161,2094),(162,2089),(162,2090),(162,2093);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
        `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
        `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
        `user_name` varchar(30) NOT NULL COMMENT '用户账号',
        `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
        `user_type` varchar(16) DEFAULT '00' COMMENT '用户类型（00系统用户,01企业微信同步用户,10 企业微信同步用户未修改初始密码）',
        `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
        `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
        `sex` char(1) DEFAULT '0' COMMENT '用户性别（0未知 1男 2女）',
        `avatar` varchar(512) DEFAULT '' COMMENT '头像地址',
        `password` varchar(100) DEFAULT '' COMMENT '密码',
        `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
        `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
        `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
        `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
        `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
        `create_time` datetime DEFAULT NULL COMMENT '创建时间',
        `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        `remark` varchar(500) DEFAULT NULL COMMENT '备注',
        `wecom_user_id` varchar(128) DEFAULT NULL COMMENT '企业微信用户id',
        `province` varchar(255) DEFAULT '' COMMENT '省id',
        `city` varchar(255) DEFAULT '' COMMENT '市id',
        `district` varchar(255) DEFAULT '' COMMENT '区域id',
        `province_id` int(11) DEFAULT NULL,
        `city_id` int(11) DEFAULT NULL,
        `district_id` int(11) DEFAULT NULL,
        `group_role_name` varchar(255) DEFAULT NULL,
        PRIMARY KEY (`user_id`) USING BTREE,
        UNIQUE KEY `USER_NAME` (`user_name`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=4944 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户信息表'
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,1,'admin','超级管理员','00','zhizu@zhizu.com','15888888888','0','','$2a$10$hvUDXU4N.Ec4F8lwROQtKO8PaFbdDC1zoq9vGBILwtqpb2dLzhVNG','0','0','127.0.0.1','2021-04-29 07:42:19','admin','2021-04-29 07:42:19','','2021-05-06 20:10:28','管理员',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `wecom_sync` tinyint(1) DEFAULT '0' COMMENT '企业微信同步标识',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1,0),(102,78,1),(103,20,1),(104,27,1),(105,79,1),(106,105,1),(107,76,1),(108,16,1),(109,97,1),(110,110,1),(111,49,1),(112,52,1),(113,113,1),(114,9,1),(115,42,1),(116,7,1),(117,57,1),(118,42,1),(119,37,1),(120,110,1),(121,50,1),(122,100,1),(123,69,1),(124,92,1),(125,55,1),(126,98,1),(127,85,1),(128,110,1),(129,105,1),(130,70,1),(131,13,1),(132,31,1),(133,49,1),(134,35,1),(135,83,1),(136,82,NULL),(137,33,NULL),(138,121,1),(139,15,1),(140,24,1),(141,43,1),(142,106,1),(143,68,1),(144,45,1),(145,20,1),(146,100,1),(147,6,1),(148,41,1),(149,72,1),(150,41,1),(151,80,1),(152,53,1),(153,30,1),(154,90,1),(155,43,1),(156,100,1),(157,100,1),(158,10,1),(159,100,1),(160,47,1),(161,10,1),(162,12,1),(163,10,1),(164,103,1),(165,28,1),(166,43,1),(167,34,1),(168,88,1),(169,65,1),(170,108,1),(171,68,1),(172,54,1),(173,34,1),(174,94,1),(175,46,1),(176,81,1),(177,81,1),(178,39,1),(179,34,1),(180,89,1),(181,43,1),(182,21,1),(183,72,1),(185,8,1),(186,89,1),(187,11,1),(188,44,1),(189,95,1),(190,99,1),(191,48,1),(192,86,1),(193,100,1),(194,68,1),(195,26,1),(196,18,1),(198,10,1),(199,40,1),(200,77,1),(201,32,1),(202,58,1),(203,67,1),(204,89,1),(205,109,1),(206,59,NULL),(207,5,1),(208,5,1),(209,5,1),(210,14,1),(211,72,1),(213,60,1),(214,14,1),(215,63,1),(216,100,1),(217,7,1),(218,73,1),(219,100,1),(220,112,1),(221,93,1),(222,14,1),(223,68,1),(224,14,1),(225,25,1),(226,68,1),(227,120,1),(228,93,1),(229,100,1),(230,66,1),(231,87,1),(232,7,1),(233,74,1),(234,100,1),(235,100,1),(236,109,1),(237,61,NULL),(238,101,1),(239,122,1),(240,62,1),(241,96,1),(242,23,1),(243,36,1),(244,84,1),(245,102,1),(246,75,1),(247,38,1),(248,71,1),(249,38,1),(250,71,1),(251,71,1),(252,29,1),(253,71,1),(254,71,1),(255,71,1),(256,71,1),(257,71,1),(258,111,1),(259,93,1),(260,104,1),(261,109,1),(262,17,1),(263,71,1),(264,71,1),(265,100,1),(266,56,1),(269,118,1),(271,72,1),(275,14,1),(276,65,1),(277,116,1),(278,71,1),(279,117,1),(280,119,1),(281,14,1),(282,97,1),(283,71,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `wecom_sync` tinyint(1) DEFAULT '0' COMMENT '企业微信同步数据标识',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1,0),(100,100,0),(130,160,0),(135,157,0),(136,158,0),(137,157,0),(137,158,0),(144,157,0),(148,159,0),(150,159,0),(160,162,0),(189,157,0),(192,157,0),(199,157,0),(200,159,0),(202,157,0),(202,161,0),(205,162,0),(206,157,0),(236,162,0),(237,160,0),(240,160,0),(260,160,0),(261,162,0);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_html_param`
--

DROP TABLE IF EXISTS `tab_html_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_html_param` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `template_id` int(11) NOT NULL COMMENT '模板 id',
  `param_name` varchar(64) NOT NULL COMMENT '参数名',
  `param_value` varchar(128) NOT NULL DEFAULT '0' COMMENT '参数值',
  `param_desc` varchar(128) DEFAULT NULL COMMENT '参数描述',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`param_id`),
  UNIQUE KEY `tab_param_tag_tag_id_uindex` (`param_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='嵌入式报表 html 标签配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_html_param`
--

LOCK TABLES `tab_html_param` WRITE;
/*!40000 ALTER TABLE `tab_html_param` DISABLE KEYS */;
INSERT INTO `tab_html_param` VALUES (1,1,'embed_code_version','3','嵌入式代码版本',NULL,NULL,NULL,NULL,NULL),(2,1,'site_root','','网站根节点',NULL,NULL,NULL,NULL,NULL),(3,1,'tabs','yes','标签页面',NULL,NULL,NULL,NULL,NULL),(4,1,'toolbar','top','工具条',NULL,NULL,NULL,NULL,NULL),(5,1,'showAppBanner','false','展示 App Banner',NULL,NULL,NULL,NULL,NULL),(6,1,'alerts','no','隐藏工具栏中的“通知”按钮',NULL,NULL,NULL,NULL,NULL),(7,1,'customViews','	no','隐藏工具栏中的“视图”按钮',NULL,NULL,NULL,NULL,NULL),(8,1,'subscriptions','no','隐藏工具栏中的“订阅”按钮',NULL,NULL,NULL,NULL,NULL),(14,1,'showShareOptions','false','显示“共享”选项。',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `tab_html_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_html_template`
--

DROP TABLE IF EXISTS `tab_html_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_html_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `template_name` varchar(64) NOT NULL,
  `template_desc` varchar(128) DEFAULT NULL,
  `tableau_host` varchar(256) NOT NULL COMMENT 'tableau server 服务器地址',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tab_html_template_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='tableau 报表内嵌 html 模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_html_template`
--

LOCK TABLES `tab_html_template` WRITE;
/*!40000 ALTER TABLE `tab_html_template` DISABLE KEYS */;
INSERT INTO `tab_html_template` VALUES (1,'普通用户标准模板','标准1','https://tableau.zhizukj.com','admin','2021-05-05 01:16:08','admin','2021-05-21 19:19:06',NULL);
/*!40000 ALTER TABLE `tab_html_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_requirement`
--

DROP TABLE IF EXISTS `tab_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_requirement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户 id\n',
  `user_name` varchar(128) DEFAULT NULL COMMENT '用户账户',
  `nick_name` varchar(128) DEFAULT NULL COMMENT '用户昵称',
  `require_subject` varchar(256) DEFAULT NULL COMMENT '需求主题',
  `require_detail` varchar(2048) DEFAULT NULL COMMENT '需求明细',
  `except_online_time` datetime DEFAULT NULL COMMENT '期望上线时间',
  `is_push` tinyint(1) DEFAULT '0' COMMENT '已推送',
  `contact_info` varchar(128) DEFAULT NULL COMMENT '联系方式',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单 id\n',
  `menu_name` varchar(128) DEFAULT NULL COMMENT '菜单名称',
  `report_name` varchar(128) DEFAULT NULL COMMENT '报表名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tab_requirement_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='报表需求表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_requirement`
--

LOCK TABLES `tab_requirement` WRITE;
/*!40000 ALTER TABLE `tab_requirement` DISABLE KEYS */;
/*!40000 ALTER TABLE `tab_requirement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_suggestion`
--

DROP TABLE IF EXISTS `tab_suggestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_suggestion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(128) DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(128) DEFAULT NULL COMMENT '用户昵称',
  `report_score` smallint(6) DEFAULT NULL COMMENT '报表评分',
  `data_accurate` smallint(6) DEFAULT NULL COMMENT '数据精准度',
  `suggestions_detail` varchar(2048) DEFAULT NULL COMMENT '意见明细',
  `contact_info` varchar(128) DEFAULT NULL COMMENT '联系方式',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单 id\n',
  `menu_name` varchar(128) DEFAULT NULL COMMENT '菜单名称',
  `report_name` varchar(128) DEFAULT NULL COMMENT '报表名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tab_suggestion_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='报表意见表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_suggestion`
--

LOCK TABLES `tab_suggestion` WRITE;
/*!40000 ALTER TABLE `tab_suggestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tab_suggestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_visit_log`
--

DROP TABLE IF EXISTS `tab_visit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_visit_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(128) DEFAULT NULL,
  `nick_name` varchar(128) DEFAULT NULL,
  `menu_id` bigint(20) DEFAULT NULL,
  `menu_name` varchar(128) DEFAULT NULL,
  `parent_menu_name` varchar(128) DEFAULT NULL,
  `report_name` varchar(128) DEFAULT NULL,
  `ip_addr` varchar(1024) DEFAULT NULL,
  `browser` varchar(128) DEFAULT NULL,
  `login_location` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tab_visit_log_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=381 DEFAULT CHARSET=utf8 COMMENT='报表访问日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_visit_log`
--

LOCK TABLES `tab_visit_log` WRITE;
/*!40000 ALTER TABLE `tab_visit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tab_visit_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-26 12:13:08
