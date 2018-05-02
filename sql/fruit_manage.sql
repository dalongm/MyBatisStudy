/*
 Navicat Premium Data Transfer

 Source Server         : dalong57
 Source Server Type    : MySQL
 Source Server Version : 50708
 Source Host           : localhost:3307
 Source Schema         : fruit_manage

 Target Server Type    : MySQL
 Target Server Version : 50708
 File Encoding         : 65001

 Date: 02/05/2018 23:41:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for retailer
-- ----------------------------
DROP TABLE IF EXISTS `retailer`;
CREATE TABLE `retailer`  (
  `retailerid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `createtime` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`retailerid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of retailer
-- ----------------------------
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e091', '石恩华', '13777777777', '上海市普陀区', 1, '2018-05-02 20:18:20');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e092', '蒋虎子', '13888888888', '重庆市大渡口区', 1, '2018-05-02 20:19:07');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e093', '龚东林', '15999999999', '陕西省西安市', 0, '2018-05-02 20:20:21');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('', NULL, NULL, NULL, NULL);
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e095', 'jack', '1234', '张三', '18345678910');
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e096', 'rose', '4321', '贺诗', '13987654321');
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e097', 'tom', '1234', '唐穆', '15345678910');

SET FOREIGN_KEY_CHECKS = 1;
