# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.17)
# Database: ssmroot
# Generation Time: 2019-12-06 08:27:28 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_pid` int(11) DEFAULT '0' COMMENT '上级id',
  `menu_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '菜单名称',
  `menu_url` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '访问地址',
  `menu_icon` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '图标',
  `menu_show` tinyint(4) NOT NULL COMMENT '1显示',
  `menu_status` tinyint(4) NOT NULL COMMENT '状态',
  `menu_level` tinyint(4) unsigned DEFAULT '0',
  `menu_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`menu_id`),
  KEY `menu_pid` (`menu_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='菜单表';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`menu_id`, `menu_pid`, `menu_name`, `menu_url`, `menu_icon`, `menu_show`, `menu_status`, `menu_level`, `menu_path`)
VALUES
	(1,0,'系统管理','#','&#xe6ae;',1,1,1,'01'),
	(2,1,'菜单管理','/sys/menu/list','',1,1,2,'12'),
	(3,6,'欢迎页面','/sys/admin/welcome','',0,1,3,'163'),
	(4,0,'文章管理','','',1,1,1,'4'),
	(6,1,'用户管理','/sys/user/list.do','',1,1,2,'16'),
	(7,2,'菜单表单','/sys/menu/menuForm','',0,1,3,'127'),
	(74,6,'系统首页','/sys/admin/home','',0,1,3,'1674'),
	(75,2,'菜单保存','/sys/menu/doSaveMenu','',0,1,3,'1275'),
	(76,2,'菜单删除','/sys/menu/delete','',0,1,3,'1276'),
	(77,1,'角色管理','/sys/role/list','',1,1,2,'177'),
	(78,77,'角色表单','/sys/role/form','',0,1,3,'17778'),
	(79,77,'角色保存','/sys/role/doSave','',0,1,3,'17779'),
	(80,6,'用户表单','/sys/admin/form','',0,1,3,'1680');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL COMMENT '角色名称',
  `role_menus` varchar(1024) COLLATE utf8_unicode_ci NOT NULL COMMENT '关联菜单id逗号分隔',
  `role_intro` text COLLATE utf8_unicode_ci COMMENT '角色简介',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='角色表';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`role_id`, `role_name`, `role_menus`, `role_intro`)
VALUES
	(1,'test','1,2,3,4,6,7,74,75,76,77,78,79,80','1111'),
	(2,'测试角色','1,2,3','NULL水电费'),
	(3,'测试角色3','1,2,3','NULL水电费'),
	(4,'测试角色4','1,2,3','NULL水电费'),
	(5,'测试角色5','1,2,3','NULL水电费');

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '登录名',
  `password` char(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '密码',
  `user_roles` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '角色id',
  `user_photo` char(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `user_lastip` char(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_type` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `user_status` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='后台用户表';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`user_id`, `username`, `password`, `user_roles`, `user_photo`, `user_lastip`, `user_type`, `user_status`, `create_time`, `update_time`)
VALUES
	(1,'abc123','123456','1,2,3','','',1,1,0,0),
	(2,'admin','123456','1,2,3','','',0,1,0,0),
	(3,'sdf333333111sdf','123456222','1,2,3,4,5','','',1,1,0,1575543914),
	(4,'4534','433','1,3,4','','',0,1,1575543921,1575544343),
	(5,'67890','werwe','1,2,3,4,5','','',0,1,1575544353,1575544353),
	(6,'sdf3323','343','1,2,4,5','','',0,1,1575544689,1575561078);

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
