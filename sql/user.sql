/*
 Navicat Premium Data Transfer

 Source Server         : dalong57
 Source Server Type    : MySQL
 Source Server Version : 50708
 Source Host           : localhost:3307
 Source Schema         : mybatis_test

 Target Server Type    : MySQL
 Target Server Version : 50708
 File Encoding         : 65001

 Date: 27/04/2018 21:30:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gender` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', '111', '男', '1111@126.com', '河南省', '郑州市', '1991-04-23');
INSERT INTO `user` VALUES (2, '李四', '222', '男', '2222@126.com', '河北省', '邯郸市', '1989-10-13');
INSERT INTO `user` VALUES (3, '刘丽', '333', '女', '3333@126.com', '江苏省', '苏州市', '1994-06-09');
INSERT INTO `user` VALUES (4, '李丽', '444', '女', '4444@126.com', '四川省', '成都市', '1992-11-07');

SET FOREIGN_KEY_CHECKS = 1;
