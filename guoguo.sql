/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.1.30-community-log : Database - guoguo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`guoguo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `guoguo`;

/*Table structure for table `guoguoblog` */

DROP TABLE IF EXISTS `guoguoblog`;

CREATE TABLE `guoguoblog` (
  `name` varchar(50) DEFAULT NULL,
  `id` varchar(50) DEFAULT NULL,
  `row_id` varchar(50) DEFAULT NULL,
  `age` int(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `guoguoblog` */

insert  into `guoguoblog`(`name`,`id`,`row_id`,`age`,`password`) values ('guosl','714C8AA908BB4C3A95284382DC311958','1',26,'1'),('admin','294AC69C3158416B8A3BA5D786F250FA','2',20,'1');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
