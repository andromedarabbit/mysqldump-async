-- MySQL dump 10.15  Distrib 10.0.20-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: db_schedule
-- ------------------------------------------------------
-- Server version	10.0.20-MariaDB

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
-- Table structure for table `BATCH_JOB_EXECUTION`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(100) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `BATCH_JOB_INSTANCE` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_CONTEXT`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_CONTEXT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_CONTEXT` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_PARAMS`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_PARAMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_PARAMS` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_EXECUTION_SEQ`
--

DROP TABLE IF EXISTS `BATCH_JOB_EXECUTION_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_INSTANCE`
--

DROP TABLE IF EXISTS `BATCH_JOB_INSTANCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_INSTANCE` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_JOB_SEQ`
--

DROP TABLE IF EXISTS `BATCH_JOB_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_JOB_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(100) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  KEY `VERSION_IX` (`VERSION`) USING BTREE,
  KEY `STEP_NAME_AND_JOB_EXECUTION_ID_IX` (`STEP_NAME`,`JOB_EXECUTION_ID`) USING BTREE,
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `BATCH_JOB_EXECUTION` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION_CONTEXT`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_CONTEXT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION_CONTEXT` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `BATCH_STEP_EXECUTION` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `BATCH_STEP_EXECUTION_SEQ`
--

DROP TABLE IF EXISTS `BATCH_STEP_EXECUTION_SEQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BATCH_STEP_EXECUTION_SEQ` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_BLOB_TRIGGERS`
--

DROP TABLE IF EXISTS `SCHEDULE_BLOB_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_BLOB_TRIGGERS` (
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `SCHEDULE_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `SCHEDULE_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_CALENDARS`
--

DROP TABLE IF EXISTS `SCHEDULE_CALENDARS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_CALENDARS` (
  `CALENDAR_NAME` varchar(100) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_CRON_TRIGGERS`
--

DROP TABLE IF EXISTS `SCHEDULE_CRON_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_CRON_TRIGGERS` (
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `SCHEDULE_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `SCHEDULE_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_FIRED_TRIGGERS`
--

DROP TABLE IF EXISTS `SCHEDULE_FIRED_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_FIRED_TRIGGERS` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(100) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(100) DEFAULT NULL,
  `JOB_GROUP` varchar(100) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_JOB_DETAILS`
--

DROP TABLE IF EXISTS `SCHEDULE_JOB_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_JOB_DETAILS` (
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_GROUP` varchar(100) NOT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(150) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_JOB_LISTENERS`
--

DROP TABLE IF EXISTS `SCHEDULE_JOB_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_JOB_LISTENERS` (
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_GROUP` varchar(100) NOT NULL,
  `JOB_LISTENER` varchar(100) NOT NULL,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`,`JOB_LISTENER`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `SCHEDULE_JOB_LISTENERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `SCHEDULE_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_LOCKS`
--

DROP TABLE IF EXISTS `SCHEDULE_LOCKS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_LOCKS` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_PAUSED_TRIGGER_GRPS`
--

DROP TABLE IF EXISTS `SCHEDULE_PAUSED_TRIGGER_GRPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_PAUSED_TRIGGER_GRPS` (
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_SCHEDULER_STATE`
--

DROP TABLE IF EXISTS `SCHEDULE_SCHEDULER_STATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_SCHEDULER_STATE` (
  `INSTANCE_NAME` varchar(100) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_SIMPLE_TRIGGERS`
--

DROP TABLE IF EXISTS `SCHEDULE_SIMPLE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_SIMPLE_TRIGGERS` (
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `SCHEDULE_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `SCHEDULE_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_TRIGGERS`
--

DROP TABLE IF EXISTS `SCHEDULE_TRIGGERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_TRIGGERS` (
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_GROUP` varchar(100) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(150) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(100) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `JOB_NAME` (`JOB_NAME`,`JOB_GROUP`),
  KEY `NEXT_FIRE_TIME` (`NEXT_FIRE_TIME`) USING BTREE,
  KEY `TRIGGER_STATE` (`TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `SCHEDULE_TRIGGERS_ibfk_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `SCHEDULE_JOB_DETAILS` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SCHEDULE_TRIGGER_LISTENERS`
--

DROP TABLE IF EXISTS `SCHEDULE_TRIGGER_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE_TRIGGER_LISTENERS` (
  `TRIGGER_NAME` varchar(100) NOT NULL,
  `TRIGGER_GROUP` varchar(100) NOT NULL,
  `TRIGGER_LISTENER` varchar(100) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_LISTENER`),
  KEY `TRIGGER_NAME` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `SCHEDULE_TRIGGER_LISTENERS_ibfk_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `SCHEDULE_TRIGGERS` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `schedule_scheduler_state_readable`
--

DROP TABLE IF EXISTS `schedule_scheduler_state_readable`;
/*!50001 DROP VIEW IF EXISTS `schedule_scheduler_state_readable`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `schedule_scheduler_state_readable` (
  `INSTANCE_NAME` tinyint NOT NULL,
  `LAST_CHECKIN_TIME` tinyint NOT NULL,
  `CHECKIN_INTERVAL` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `schedule_triggers_readable`
--

DROP TABLE IF EXISTS `schedule_triggers_readable`;
/*!50001 DROP VIEW IF EXISTS `schedule_triggers_readable`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `schedule_triggers_readable` (
  `TRIGGER_NAME` tinyint NOT NULL,
  `TRIGGER_GROUP` tinyint NOT NULL,
  `JOB_NAME` tinyint NOT NULL,
  `JOB_GROUP` tinyint NOT NULL,
  `IS_VOLATILE` tinyint NOT NULL,
  `DESCRIPTION` tinyint NOT NULL,
  `NEXT_FIRE_TIME` tinyint NOT NULL,
  `NEXT_FIRE_TIME_TEXT` tinyint NOT NULL,
  `PREV_FIRE_TIME` tinyint NOT NULL,
  `PREV_FIRE_TIME_TEXT` tinyint NOT NULL,
  `PRIORITY` tinyint NOT NULL,
  `TRIGGER_STATE` tinyint NOT NULL,
  `TRIGGER_TYPE` tinyint NOT NULL,
  `START_TIME` tinyint NOT NULL,
  `START_TIME_TEXT` tinyint NOT NULL,
  `END_TIME` tinyint NOT NULL,
  `END_TIME_TEXT` tinyint NOT NULL,
  `CALENDAR_NAME` tinyint NOT NULL,
  `MISFIRE_INSTR` tinyint NOT NULL,
  `JOB_DATA` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'db_schedule'
--

--
-- Dumping routines for database 'db_schedule'
--

--
-- Final view structure for view `schedule_scheduler_state_readable`
--

/*!50001 DROP TABLE IF EXISTS `schedule_scheduler_state_readable`*/;
/*!50001 DROP VIEW IF EXISTS `schedule_scheduler_state_readable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `schedule_scheduler_state_readable` AS select `schedule_scheduler_state`.`INSTANCE_NAME` AS `INSTANCE_NAME`,date_format(from_unixtime((`schedule_scheduler_state`.`LAST_CHECKIN_TIME` / 1000)),'%Y-%m-%d %H:%i:%s') AS `LAST_CHECKIN_TIME`,`schedule_scheduler_state`.`CHECKIN_INTERVAL` AS `CHECKIN_INTERVAL` from `schedule_scheduler_state` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `schedule_triggers_readable`
--

/*!50001 DROP TABLE IF EXISTS `schedule_triggers_readable`*/;
/*!50001 DROP VIEW IF EXISTS `schedule_triggers_readable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `schedule_triggers_readable` AS select `schedule_triggers`.`TRIGGER_NAME` AS `TRIGGER_NAME`,`schedule_triggers`.`TRIGGER_GROUP` AS `TRIGGER_GROUP`,`schedule_triggers`.`JOB_NAME` AS `JOB_NAME`,`schedule_triggers`.`JOB_GROUP` AS `JOB_GROUP`,`schedule_triggers`.`IS_VOLATILE` AS `IS_VOLATILE`,`schedule_triggers`.`DESCRIPTION` AS `DESCRIPTION`,`schedule_triggers`.`NEXT_FIRE_TIME` AS `NEXT_FIRE_TIME`,date_format(from_unixtime((`schedule_triggers`.`NEXT_FIRE_TIME` / 1000)),'%Y-%m-%d %H:%i:%s') AS `NEXT_FIRE_TIME_TEXT`,`schedule_triggers`.`PREV_FIRE_TIME` AS `PREV_FIRE_TIME`,date_format(from_unixtime((`schedule_triggers`.`PREV_FIRE_TIME` / 1000)),'%Y-%m-%d %H:%i:%s') AS `PREV_FIRE_TIME_TEXT`,`schedule_triggers`.`PRIORITY` AS `PRIORITY`,`schedule_triggers`.`TRIGGER_STATE` AS `TRIGGER_STATE`,`schedule_triggers`.`TRIGGER_TYPE` AS `TRIGGER_TYPE`,`schedule_triggers`.`START_TIME` AS `START_TIME`,date_format(from_unixtime((`schedule_triggers`.`START_TIME` / 1000)),'%Y-%m-%d %H:%i:%s') AS `START_TIME_TEXT`,`schedule_triggers`.`END_TIME` AS `END_TIME`,date_format(from_unixtime((`schedule_triggers`.`END_TIME` / 1000)),'%Y-%m-%d %H:%i:%s') AS `END_TIME_TEXT`,`schedule_triggers`.`CALENDAR_NAME` AS `CALENDAR_NAME`,`schedule_triggers`.`MISFIRE_INSTR` AS `MISFIRE_INSTR`,`schedule_triggers`.`JOB_DATA` AS `JOB_DATA` from `schedule_triggers` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
