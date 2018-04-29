/*
 Navicat Premium Data Transfer

 Source Server Type    : MySQL
 Source Server Version : 50708
 Source Host           : localhost:3307
 Source Schema         : mybatis_test

 Target Server Type    : MySQL
 Target Server Version : 50708
 File Encoding         : 65001

 Date: 29/04/2018 11:14:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for batch
-- ----------------------------
DROP TABLE IF EXISTS `batch`;
CREATE TABLE `batch`  (
  `batch_id` int(11) NOT NULL AUTO_INCREMENT,
  `cus_id` int(11) NOT NULL COMMENT '创建批次用户id',
  `number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批次编号',
  `createtime` datetime(0) NOT NULL COMMENT '创建批次时间',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`batch_id`) USING BTREE,
  INDEX `FK_batch_id`(`cus_id`) USING BTREE,
  CONSTRAINT `FK_batch_id` FOREIGN KEY (`cus_id`) REFERENCES `customer` (`cus_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for batchdetail
-- ----------------------------
DROP TABLE IF EXISTS `batchdetail`;
CREATE TABLE `batchdetail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(11) NOT NULL COMMENT '批次id',
  `product_id` int(11) NOT NULL COMMENT '理财产品id',
  `product_num` int(11) DEFAULT NULL COMMENT '理财产品购买数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_batchdetail_1`(`batch_id`) USING BTREE,
  INDEX `FK_batchdetail_2`(`product_id`) USING BTREE,
  CONSTRAINT `FK_batchdetail_1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`batch_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_batchdetail_2` FOREIGN KEY (`product_id`) REFERENCES `finacial_products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cus_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `acno` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '卡号',
  `gender` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `phone` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`cus_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for finacial_products
-- ----------------------------
DROP TABLE IF EXISTS `finacial_products`;
CREATE TABLE `finacial_products`  (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '理财产品名称',
  `price` float(10, 1) NOT NULL COMMENT '理财产品定价',
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '理财产品描述',
  `pic` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '理财产品图片',
  `invasttime` datetime(0) NOT NULL COMMENT '理财产品收益日期',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', '111', '男', '1111@126.com', '河南省', '郑州市', '1991-04-23');
INSERT INTO `user` VALUES (2, '李四', '222', '男', '2222@126.com', '河北省', '邯郸市', '1989-10-13');
INSERT INTO `user` VALUES (3, '刘丽', '333', '女', '3333@126.com', '江苏省', '苏州市', '1994-06-09');
INSERT INTO `user` VALUES (4, '李丽', '444', '女', '4444@126.com', '四川省', '成都市', '1992-11-07');
INSERT INTO `user` VALUES (5, '孙佳佳', '5555', '男', '5555@126.com', '湖北省', '武汉市', '1993-03-03');
INSERT INTO `user` VALUES (6, '孙嘉', '6666', '女', '6666@126.com', '湖北省', '武汉市', '1994-03-03');

SET FOREIGN_KEY_CHECKS = 1;
