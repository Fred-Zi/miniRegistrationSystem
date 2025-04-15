-- 创建医疗数据库
CREATE DATABASE  IF NOT EXISTS `myRegistrationSystemDB` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8_bin */;
USE `myRegistrationSystemDB`;


-- 医务人员表
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '工号',
                            `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '姓名',
                            `username` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '工号',
                            `password` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '密码',
                            `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
                            `sex` varchar(2) COLLATE utf8_bin NOT NULL COMMENT '性别',
                            `id_number` varchar(18) COLLATE utf8_bin NOT NULL COMMENT '身份证号',
                            `status` int NOT NULL DEFAULT '1' COMMENT '状态 0:停职 1:在岗',
                            `create_time` datetime DEFAULT NULL COMMENT '入职时间',
                            `update_time` datetime DEFAULT NULL COMMENT '信息更新时间',
                            `create_user` bigint DEFAULT NULL COMMENT '创建人',
                            `update_user` bigint DEFAULT NULL COMMENT '修改人',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='医务人员信息';

INSERT INTO `employee` VALUES
    (1,'张主任','D1001','123456','13812312312','男','110101199001010047',1,'2023-01-01 09:00:00','2023-01-01 09:00:00',10,1);

-- 科室分类表
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
                            `id` bigint NOT NULL AUTO_INCREMENT COMMENT '科室编号',
                            `type` int DEFAULT NULL COMMENT '分类类型 1:门诊科室 2:体检中心',
                            `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '科室名称',
                            `sort` int NOT NULL DEFAULT '0' COMMENT '显示顺序',
                            `status` int DEFAULT NULL COMMENT '科室状态 0:停诊 1:接诊',
                            `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                            `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                            `create_user` bigint DEFAULT NULL COMMENT '创建人',
                            `update_user` bigint DEFAULT NULL COMMENT '修改人',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `idx_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='科室分类管理';

INSERT INTO `category` VALUES
                           (11,1,'心血管内科',10,1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                           (12,1,'儿科门诊',9,1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                           (13,2,'入职体检中心',12,1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                           (15,2,'高端体检中心',13,1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1);

-- 挂号项目表
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish` (
                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目编号',
                        `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '项目名称',
                        `category_id` bigint NOT NULL COMMENT '科室编号',
                        `price` decimal(10,2) DEFAULT NULL COMMENT '挂号费用',
                        `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '科室导引图',
                        `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '诊疗范围',
                        `status` int DEFAULT '1' COMMENT '接诊状态 0:停号 1:可约',
                        `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                        `create_user` bigint DEFAULT NULL COMMENT '创建人',
                        `update_user` bigint DEFAULT NULL COMMENT '修改人',
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `idx_dish_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='挂号项目管理';

INSERT INTO `dish` VALUES
                       (46,'专家门诊-心血管内科',11,30.00,'/img/cardiology.png','主任医师门诊',1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                       (47,'儿科普通门诊',12,15.00,'/img/pediatrics.png','副主任医师坐诊',1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                       (48,'专家会诊',11,100.00,'/img/meeting.png','多学科联合会诊',1,'2023-01-01 09:00:00','2023-01-01 09:00:00',1,1);

-- 挂号选项表
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor` (
                               `id` bigint NOT NULL AUTO_INCREMENT COMMENT '选项编号',
                               `dish_id` bigint NOT NULL COMMENT '项目编号',
                               `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '选项类型',
                               `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '可选值',
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='挂号选项配置';

INSERT INTO `dish_flavor` VALUES
                              (40,46,'就诊时段','["周一上午 09:00-11:00","周三下午 14:00-16:00"]'),
                              (41,46,'专家选择','["张建国 主任医师","王丽华 副主任医师"]'),
                              (42,47,'就诊时段','["周二全天","周五上午"]');

-- 体检套餐表
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal` (
                           `id` bigint NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
                           `category_id` bigint NOT NULL COMMENT '体检中心编号',
                           `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
                           `price` decimal(10,2) NOT NULL COMMENT '套餐价格',
                           `status` int DEFAULT '1' COMMENT '状态 0:下架 1:可约',
                           `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '套餐说明',
                           `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '套餐示意图',
                           `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                           `update_time` datetime DEFAULT NULL COMMENT '更新时间',
                           `create_user` bigint DEFAULT NULL COMMENT '创建人',
                           `update_user` bigint DEFAULT NULL COMMENT '修改人',
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `idx_setmeal_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='体检套餐管理';

INSERT INTO `setmeal` VALUES
                          (1,13,'入职基础套餐',299.00,1,'常规入职体检项目','/img/package1.png','2023-01-01 09:00:00','2023-01-01 09:00:00',1,1),
                          (2,15,'高管尊享套餐',1999.00,1,'深度全面体检','/img/package2.png','2023-01-01 09:00:00','2023-01-01 09:00:00',1,1);

-- 套餐项目关系表
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系编号',
                                `setmeal_id` bigint DEFAULT NULL COMMENT '套餐编号',
                                `dish_id` bigint DEFAULT NULL COMMENT '检查项目编号',
                                `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目名称',
                                `price` decimal(10,2) DEFAULT NULL COMMENT '项目单价',
                                `copies` int DEFAULT NULL COMMENT '检查次数',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='套餐项目明细';

INSERT INTO `setmeal_dish` VALUES
                               (1,1,49,'血常规检查',50.00,1),
                               (2,1,50,'胸透检查',120.00,1),
                               (3,2,51,'全身MRI扫描',1500.00,1);

-- 患者信息表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
                        `id` bigint NOT NULL AUTO_INCREMENT COMMENT '患者编号',
                        `openid` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '微信标识',
                        `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '患者姓名',
                        `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
                        `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
                        `id_number` varchar(18) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
                        `avatar` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '患者头像',
                        `create_time` datetime DEFAULT NULL COMMENT '注册时间',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='患者信息管理';

INSERT INTO `user` VALUES
    (1,'oK123456','张三','13800138000','男','110101199001011234','/img/avatar1.png','2023-01-01 09:00:00');

-- 患者地址表
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book` (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址编号',
                                `user_id` bigint NOT NULL COMMENT '患者编号',
                                `consignee` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '紧急联系人',
                                `sex` varchar(2) COLLATE utf8_bin DEFAULT NULL COMMENT '性别',
                                `phone` varchar(11) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
                                `province_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '省份编码',
                                `province_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '省份名称',
                                `city_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '城市编码',
                                `city_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '城市名称',
                                `district_code` varchar(12) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '区县编码',
                                `district_name` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '区县名称',
                                `detail` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '详细地址',
                                `label` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '地址标签',
                                `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='就诊地址管理';

INSERT INTO `address_book` VALUES
    (1,1,'李四','女','13800138001','110000','北京市','110100','市辖区','110106','海淀区','中关村大街1号','工作单位',1);

-- 预约暂存表
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart` (
                                 `id` bigint NOT NULL AUTO_INCREMENT COMMENT '暂存编号',
                                 `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目名称',
                                 `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '项目图片',
                                 `user_id` bigint NOT NULL COMMENT '患者编号',
                                 `dish_id` bigint DEFAULT NULL COMMENT '挂号项目',
                                 `setmeal_id` bigint DEFAULT NULL COMMENT '体检套餐',
                                 `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '就诊选项',
                                 `number` int NOT NULL DEFAULT '1' COMMENT '预约数量',
  `amount` decimal(10,2) NOT NULL COMMENT '项目金额',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='预约暂存管理';

-- 挂号订单表
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `number` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '业务流水号',
  `status` int NOT NULL DEFAULT '1' COMMENT '订单状态 1:待支付 2:已预约 3:已完成 4:已取消 5:已退号',
  `user_id` bigint NOT NULL COMMENT '患者编号',
  `address_book_id` bigint NOT NULL COMMENT '就诊地址',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_method` int NOT NULL DEFAULT '1' COMMENT '支付方式 1:微信 2:医保',
  `pay_status` tinyint NOT NULL DEFAULT '0' COMMENT '支付状态 0:未支付 1:已支付 2:已退款',
  `amount` decimal(10,2) NOT NULL COMMENT '实际金额',
  `remark` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '患者备注',
  `phone` varchar(11) COLLATE utf8_bin DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '就诊地点',
  `user_name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '患者姓名',
  `consignee` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '紧急联系人',
  `cancel_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '取消原因',
  `rejection_reason` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '拒单原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  `estimated_delivery_time` datetime DEFAULT NULL COMMENT '预计就诊时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '就诊状态 1:待就诊 0:已就诊',
  `delivery_time` datetime DEFAULT NULL COMMENT '实际就诊时间',
  `pack_amount` int DEFAULT NULL COMMENT '病历费用',
  `tableware_number` int DEFAULT NULL COMMENT '病历本数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '病历状态 1:未领取 0:已领取',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='挂号订单管理';

-- 订单明细表
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细编号',
  `name` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT '项目名称',
  `image` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '项目图片',
  `order_id` bigint NOT NULL COMMENT '订单编号',
  `dish_id` bigint DEFAULT NULL COMMENT '挂号项目',
  `setmeal_id` bigint DEFAULT NULL COMMENT '体检套餐',
  `dish_flavor` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '就诊选项',
  `number` int NOT NULL DEFAULT '1' COMMENT '项目数量',
  `amount` decimal(10,2) NOT NULL COMMENT '项目金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin COMMENT='订单明细管理';