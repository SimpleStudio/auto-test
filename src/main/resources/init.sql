/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50173
Source Host           : localhost:3306
Source Database       : auto-test

Target Server Type    : MYSQL
Target Server Version : 50173
File Encoding         : 65001

Date: 2015-07-06 23:32:23
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_constant
-- ----------------------------
INSERT INTO t_constant VALUES ('1', '77', '88', '2015-07-04 22:02:00');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_step
-- ----------------------------
INSERT INTO t_step VALUES ('1', '我的步骤', '142', '2015-07-06 21:07:43');

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
) ENGINE=MyISAM AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_steptpl
-- ----------------------------
INSERT INTO t_steptpl VALUES ('142', '模板名称', '模板{0}内容', '2015-07-06 22:35:20');
INSERT INTO t_steptpl VALUES ('143', '1', '1', '2015-07-04 20:41:41');

-- ----------------------------
-- Table structure for `t_step_const`
-- ----------------------------
DROP TABLE IF EXISTS `t_step_const`;
CREATE TABLE `t_step_const` (
  `step_id` bigint(20) DEFAULT NULL,
  `constant_id` bigint(20) DEFAULT NULL,
  `value` varchar(1000) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  KEY `fk_stepid` (`step_id`),
  KEY `fk_constantid` (`constant_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_step_const
-- ----------------------------
INSERT INTO t_step_const VALUES ('1', '1', '数值value', '1');
