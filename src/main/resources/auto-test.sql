/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50173
Source Host           : localhost:3306
Source Database       : auto-test

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2015-07-14 23:41:01
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `t_constant`
-- ----------------------------
DROP TABLE IF EXISTS `t_constant`;
CREATE TABLE `t_constant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `value` varchar(2000) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_constant
-- ----------------------------
INSERT INTO t_constant VALUES ('1', '77', '88', '2015-07-04 22:02:00');
INSERT INTO t_constant VALUES ('3', '常量一', '常量值一', '2015-07-09 21:47:29');
INSERT INTO t_constant VALUES ('4', '百度提交按钮', 'xpath://id=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '2015-07-09 21:47:44');
INSERT INTO t_constant VALUES ('6', '百度首页_提交按钮_地址', 'xpath:fdsfjdslfjdslkfjldsjfldsjfldskfj', '2015-07-12 10:22:13');

-- ----------------------------
-- Table structure for `t_scenario`
-- ----------------------------
DROP TABLE IF EXISTS `t_scenario`;
CREATE TABLE `t_scenario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_scenario
-- ----------------------------

-- ----------------------------
-- Table structure for `t_scen_step`
-- ----------------------------
DROP TABLE IF EXISTS `t_scen_step`;
CREATE TABLE `t_scen_step` (
  `scen_id` bigint(20) DEFAULT NULL,
  `step_id` bigint(20) DEFAULT NULL,
  KEY `fk_scen_id` (`scen_id`),
  KEY `fk_step_id` (`step_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_scen_step
-- ----------------------------

-- ----------------------------
-- Table structure for `t_step`
-- ----------------------------
DROP TABLE IF EXISTS `t_step`;
CREATE TABLE `t_step` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `tpl_id` bigint(20) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_tplid` (`tpl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_step
-- ----------------------------
INSERT INTO t_step VALUES ('8', '点击百度首页提交按钮', '146', '2015-07-12 10:21:37');
INSERT INTO t_step VALUES ('9', '测试步骤', '146', '2015-07-12 10:33:28');
INSERT INTO t_step VALUES ('10', 'fdsfsdf', '146', '2015-07-14 22:55:19');

-- ----------------------------
-- Table structure for `t_steptpl`
-- ----------------------------
DROP TABLE IF EXISTS `t_steptpl`;
CREATE TABLE `t_steptpl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `expression` varchar(1000) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_steptpl
-- ----------------------------
INSERT INTO t_steptpl VALUES ('146', '点击', '点击{0}按钮，进入{1}页面', '2015-07-12 10:20:36');

-- ----------------------------
-- Table structure for `t_step_const`
-- ----------------------------
DROP TABLE IF EXISTS `t_step_const`;
CREATE TABLE `t_step_const` (
  `step_id` bigint(20) DEFAULT NULL,
  `constant_id` bigint(20) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  KEY `fk_stepid` (`step_id`),
  KEY `fk_constantid` (`constant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_step_const
-- ----------------------------
INSERT INTO t_step_const VALUES ('1', '3', '1');
INSERT INTO t_step_const VALUES ('6', '3', '1');
INSERT INTO t_step_const VALUES ('6', '1', '2');
INSERT INTO t_step_const VALUES ('6', '4', '3');
INSERT INTO t_step_const VALUES ('5', '4', '1');
INSERT INTO t_step_const VALUES ('5', '4', '2');
INSERT INTO t_step_const VALUES ('5', '4', '3');
INSERT INTO t_step_const VALUES ('8', '4', '1');
INSERT INTO t_step_const VALUES ('8', '6', '2');
INSERT INTO t_step_const VALUES ('9', '6', '1');
INSERT INTO t_step_const VALUES ('9', '3', '2');
INSERT INTO t_step_const VALUES ('10', '3', '2');
INSERT INTO t_step_const VALUES ('10', '6', '1');
