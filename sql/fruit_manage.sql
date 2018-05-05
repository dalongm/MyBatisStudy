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

 Date: 05/05/2018 19:14:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accessory
-- ----------------------------
DROP TABLE IF EXISTS `accessory`;
CREATE TABLE `accessory`  (
  `accessoryid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fruitid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` decimal(10, 2) DEFAULT NULL,
  `createtime` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`accessoryid`) USING BTREE,
  INDEX `accessory_fruitid`(`fruitid`) USING BTREE,
  CONSTRAINT `accessory_fruitid` FOREIGN KEY (`fruitid`) REFERENCES `commodities` (`fruitid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of accessory
-- ----------------------------
INSERT INTO `accessory` VALUES ('5532d5fd-915f-4d2a-a753-fbfc37fbcb9c', 'f87756bf-2335-4dc5-951b-98c71327e014', '纸箱', 0.50, '2018-05-03 20:47:57');
INSERT INTO `accessory` VALUES ('d06dd75c-998e-4526-822e-79470fd5445e', 'f87756bf-2335-4dc5-951b-98c71327e014', '纸袋', 0.50, '2018-05-03 20:47:38');

-- ----------------------------
-- Table structure for commodities
-- ----------------------------
DROP TABLE IF EXISTS `commodities`;
CREATE TABLE `commodities`  (
  `fruitid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` decimal(10, 2) DEFAULT NULL,
  `locality` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createtime` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`fruitid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of commodities
-- ----------------------------
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e014', '火龙果', 6.50, '浙江绍兴', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e015', '橙子', 6.00, '江苏南京', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e016', '柚子', 7.00, '上海金山', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e017', '猕猴桃', 8.00, '上海嘉定', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e018', '苹果', 4.50, '山东青岛', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e019', '橘子', 2.20, '上海普陀', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e020', '香蕉', 3.50, '江苏昆山', '2018-05-03 15:10:37');
INSERT INTO `commodities` VALUES ('f87756bf-2335-4dc5-951b-98c71327e021', '柿子', 1.00, '江苏苏州', '2018-05-03 15:10:37');

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `contractid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '合同ID',
  `barcode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '合同号',
  `type` int(1) DEFAULT NULL COMMENT '运输类型',
  `retailerid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '零售商ID',
  `createtime` datetime(0) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`contractid`) USING BTREE,
  INDEX `retailerid`(`retailerid`) USING BTREE,
  CONSTRAINT `retailerid` FOREIGN KEY (`retailerid`) REFERENCES `retailer` (`retailerid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES ('b47f4315-8192-4ad6-aff4-072884c14da5', '201805050001', 1, 'f87756bf-2335-4dc5-951a-98c71327e010', '2018-05-05 18:58:59');

-- ----------------------------
-- Table structure for middle_tab
-- ----------------------------
DROP TABLE IF EXISTS `middle_tab`;
CREATE TABLE `middle_tab`  (
  `middleid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '中间表ID',
  `contractid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '合同ID',
  `fruitid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '商品ID',
  `number` decimal(10, 2) DEFAULT NULL COMMENT '商品数量',
  PRIMARY KEY (`middleid`) USING BTREE,
  INDEX `fruitid`(`fruitid`) USING BTREE,
  INDEX `contractid`(`contractid`) USING BTREE,
  CONSTRAINT `contractid` FOREIGN KEY (`contractid`) REFERENCES `contract` (`contractid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fruitid` FOREIGN KEY (`fruitid`) REFERENCES `commodities` (`fruitid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of middle_tab
-- ----------------------------
INSERT INTO `middle_tab` VALUES ('3f9a2612-88ea-4453-8d4f-62d70a029d64', 'b47f4315-8192-4ad6-aff4-072884c14da5', 'f87756bf-2335-4dc5-951b-98c71327e014', 9.97);

-- ----------------------------
-- Table structure for retailer
-- ----------------------------
DROP TABLE IF EXISTS `retailer`;
CREATE TABLE `retailer`  (
  `retailerid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int(1) DEFAULT NULL,
  `createtime` datetime(0) DEFAULT NULL,
  PRIMARY KEY (`retailerid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of retailer
-- ----------------------------
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e010', '刘霞丽', '14777777774', '陕西省西安市', 1, '2018-05-03 09:40:52');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e012', '施才华', '15999999499', '陕西省西安市', 1, '2018-05-03 09:40:52');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e013', '李四武', '15999999399', '上海市普陀区', 1, '2018-05-03 09:40:52');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e014', '张三寺', '15999979999', '重庆市大渡口区', 1, '2018-05-03 09:40:52');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e091', '石恩华', '13777777777', '上海市普陀区', 1, '2018-05-02 20:18:20');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e092', '蒋虎子', '13888888888', '重庆市大渡口区', 1, '2018-05-02 20:19:07');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e093', '龚东林', '15999999999', '陕西省西安市', 0, '2018-05-02 20:20:21');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e094', '胡晓丽', '15888888888', '陕西省西安市', 1, '2018-05-03 09:40:44');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e097', '刘浩', '14777777778', '重庆市大渡口区', 1, '2018-05-03 09:40:49');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e098', '周佳', '14777777770', '陕西省西安市', 1, '2018-05-03 09:40:52');
INSERT INTO `retailer` VALUES ('f87756bf-2335-4dc5-951a-98c71327e099', '钱多多', '14777777771', '重庆市大渡口区', 1, '2018-05-03 09:40:52');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e095', 'zhangsan', '123456', '张三', '18345678910');
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e096', 'rose', '4321', '贺诗', '13987654321');
INSERT INTO `user` VALUES ('f87756bf-2335-4dc5-951a-98c71327e097', 'tom', '1234', '唐穆', '15345678910');

SET FOREIGN_KEY_CHECKS = 1;
