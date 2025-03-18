/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : springvue24280jymzzlxt

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2025-03-01 14:06:55
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `admins`
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '帐号',
  `pwd` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员';

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('1', 'admin', 'admin');

-- ----------------------------
-- Table structure for `chengji`
-- ----------------------------
DROP TABLE IF EXISTS `chengji`;
CREATE TABLE `chengji` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shijuanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷id',
  `shijuanbianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '试卷编号',
  `shijuanmingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `faburen` varchar(50) NOT NULL DEFAULT '' COMMENT '发布人',
  `datileixing` varchar(50) NOT NULL DEFAULT '' COMMENT '答题类型',
  `kaoshibianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '考试编号',
  `zongdefen` int(11) NOT NULL DEFAULT '0' COMMENT '总得分',
  `datiren` varchar(50) NOT NULL DEFAULT '' COMMENT '答题人',
  PRIMARY KEY (`id`),
  KEY `chengji_shijuanid_index` (`shijuanid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='成绩';

-- ----------------------------
-- Records of chengji
-- ----------------------------
INSERT INTO `chengji` VALUES ('1', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '60', '001');
INSERT INTO `chengji` VALUES ('2', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '80', '001');
INSERT INTO `chengji` VALUES ('3', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '60', '006');
INSERT INTO `chengji` VALUES ('4', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '80', '006');

-- ----------------------------
-- Table structure for `dingdan`
-- ----------------------------
DROP TABLE IF EXISTS `dingdan`;
CREATE TABLE `dingdan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dingdanhao` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `dingdanjine` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额',
  `shouhuoxinxi` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货信息ID',
  `shouhuoren` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人',
  `shouji` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `dizhi` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `beizhu` text NOT NULL COMMENT '备注',
  `zhuangtai` varchar(50) NOT NULL DEFAULT '' COMMENT '状态',
  `xiadanren` varchar(50) NOT NULL DEFAULT '' COMMENT '下单人',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `iszf` varchar(10) NOT NULL DEFAULT '否' COMMENT '是否支付',
  PRIMARY KEY (`id`),
  KEY `dingdan_shouhuoxinxi_index` (`shouhuoxinxi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='订单';

-- ----------------------------
-- Records of dingdan
-- ----------------------------
INSERT INTO `dingdan` VALUES ('1', '030100009355', '815.00', '1', '张三', '13700137001', 'xxx地址', '士大夫械', '已付款', '001', '2025-03-01 00:00:23', '是');
INSERT INTO `dingdan` VALUES ('2', '030114035344', '69.00', '2', '李可', '13700137006', 'xxx地址', 'xxx', '已付款', '006', '2025-03-01 14:03:37', '是');

-- ----------------------------
-- Table structure for `dingdanshangpin`
-- ----------------------------
DROP TABLE IF EXISTS `dingdanshangpin`;
CREATE TABLE `dingdanshangpin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dingdanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单id',
  `yaopinid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '药品id',
  `bianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '编号',
  `mingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `fenlei` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `jiage` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `tupian` text NOT NULL COMMENT '图片',
  `goumaishu` int(11) NOT NULL DEFAULT '0' COMMENT '购买数',
  `xiaoji` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '小计',
  `goumairen` varchar(50) NOT NULL DEFAULT '' COMMENT '购买人',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `dingdanshangpin_dingdanid_index` (`dingdanid`),
  KEY `dingdanshangpin_yaopinid_index` (`yaopinid`),
  KEY `dingdanshangpin_fenlei_index` (`fenlei`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='订单商品';

-- ----------------------------
-- Records of dingdanshangpin
-- ----------------------------
INSERT INTO `dingdanshangpin` VALUES ('1', '1', '8', '2101121633371', '江中健胃消食片', '2', '19.00', '/upload/cf8509cd034b4a7c16c8a5973faea864.png', '1', '19.00', '001', '2025-03-01 00:00:23');
INSERT INTO `dingdanshangpin` VALUES ('2', '1', '6', '2101121625394', '陈李济胃疡宁丸', '1', '398.00', '/upload/f43a07ecb33669d1813cfd8d5b7f88e3.png', '2', '796.00', '001', '2025-03-01 00:00:23');
INSERT INTO `dingdanshangpin` VALUES ('4', '2', '8', '2101121633371', '江中健胃消食片', '2', '19.00', '/upload/cf8509cd034b4a7c16c8a5973faea864.png', '1', '19.00', '006', '2025-03-01 14:03:37');
INSERT INTO `dingdanshangpin` VALUES ('5', '2', '5', '2101121623104', '双黄连口服液', '2', '25.00', '/upload/c86fd7e3bfe30391ac0bc4f74466fe30.png', '2', '50.00', '006', '2025-03-01 14:03:37');

-- ----------------------------
-- Table structure for `gerenjiankangshuju`
-- ----------------------------
DROP TABLE IF EXISTS `gerenjiankangshuju`;
CREATE TABLE `gerenjiankangshuju` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `xingbie` varchar(10) NOT NULL DEFAULT '' COMMENT '性别',
  `shengao` varchar(50) NOT NULL DEFAULT '' COMMENT '身高',
  `tizhong` varchar(50) NOT NULL DEFAULT '' COMMENT '体重',
  `riqi` varchar(25) NOT NULL DEFAULT '' COMMENT '日期',
  `shuzhangya` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '舒张压',
  `shousuoya` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收缩压',
  `xuetang` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '血糖',
  `xinlv` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '心率',
  `beizhu` text NOT NULL COMMENT '备注',
  `yonghu` varchar(50) NOT NULL DEFAULT '' COMMENT '用户',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='个人健康数据';

-- ----------------------------
-- Records of gerenjiankangshuju
-- ----------------------------
INSERT INTO `gerenjiankangshuju` VALUES ('1', '张三', '女', '170', '45', '2025-03-01', '90.00', '120.00', '3.60', '90.00', 'xxx', '001');
INSERT INTO `gerenjiankangshuju` VALUES ('2', '李可', '女', '172', '100', '2025-03-01', '125.00', '85.00', '3.60', '85.00', 'xxxx', '006');

-- ----------------------------
-- Table structure for `gouwuche`
-- ----------------------------
DROP TABLE IF EXISTS `gouwuche`;
CREATE TABLE `gouwuche` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yaopinid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '药品id',
  `bianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '编号',
  `mingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `fenlei` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `jiage` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `tupian` text NOT NULL COMMENT '图片',
  `goumaishu` int(11) NOT NULL DEFAULT '0' COMMENT '购买数',
  `xiaoji` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '小计',
  `goumairen` varchar(50) NOT NULL DEFAULT '' COMMENT '购买人',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `gouwuche_yaopinid_index` (`yaopinid`),
  KEY `gouwuche_fenlei_index` (`fenlei`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='购物车';

-- ----------------------------
-- Records of gouwuche
-- ----------------------------

-- ----------------------------
-- Table structure for `jieguo`
-- ----------------------------
DROP TABLE IF EXISTS `jieguo`;
CREATE TABLE `jieguo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shijuanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷id',
  `shijuanbianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '试卷编号',
  `shijuanmingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `faburen` varchar(50) NOT NULL DEFAULT '' COMMENT '发布人',
  `datileixing` varchar(50) NOT NULL DEFAULT '' COMMENT '答题类型',
  `kaoshibianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '考试编号',
  `shititimu` text NOT NULL COMMENT '试题题目',
  `leixing` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
  `daan` text NOT NULL COMMENT '答案',
  `defen` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `zimu` varchar(50) NOT NULL DEFAULT '' COMMENT '字母',
  `datiren` varchar(50) NOT NULL DEFAULT '' COMMENT '答题人',
  PRIMARY KEY (`id`),
  KEY `jieguo_shijuanid_index` (`shijuanid`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='结果';

-- ----------------------------
-- Records of jieguo
-- ----------------------------
INSERT INTO `jieguo` VALUES ('1', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目1', '单选题', '防守打法要', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('2', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目4', '多选题', '无可奈何花落去枯荣,橱柜在苛', '10', 'A,C', '001');
INSERT INTO `jieguo` VALUES ('3', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目5', '多选题', '城标要,防守打法枯荣', '10', 'A,C', '001');
INSERT INTO `jieguo` VALUES ('4', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目2', '单选题', '魂牵梦萦地', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('5', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目7', '判断题', '对', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('6', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目6', '判断题', '对', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('7', '2', '022823212585', '健康自测', 'admin', '健康自测', '030100061800', '题目3', '单选题', '夺标枯荣', '0', 'B', '001');
INSERT INTO `jieguo` VALUES ('8', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目4', '多选题', '富士达', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('9', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目2', '单选题', '无可奈何花落去', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('10', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目3', '单选题', '魂牵梦萦', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('11', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目1', '单选题', '防守打法', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('12', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目5', '多选题', '无可奈何花落去枯荣,桔柑', '20', 'A,B', '001');
INSERT INTO `jieguo` VALUES ('13', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目7', '判断题', '对', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('14', '1', '022823212585', '每日答题', 'admin', '每日答题', '030100071691', '题目6', '判断题', '对', '10', 'A', '001');
INSERT INTO `jieguo` VALUES ('15', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目6', '判断题', '对', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('16', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目3', '单选题', '魂牵梦萦富士达', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('17', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目7', '判断题', '对', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('18', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目5', '多选题', '城标要', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('19', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目1', '单选题', '防守打法', '0', 'B', '006');
INSERT INTO `jieguo` VALUES ('20', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目4', '多选题', '无可奈何花落去枯荣,的撒发生大', '20', 'A,B', '006');
INSERT INTO `jieguo` VALUES ('21', '2', '022823212585', '健康自测', 'admin', '健康自测', '030113596485', '题目2', '单选题', '械魂牵梦萦地要', '0', 'B', '006');
INSERT INTO `jieguo` VALUES ('22', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目3', '单选题', '枯荣', '0', 'B', '006');
INSERT INTO `jieguo` VALUES ('23', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目2', '单选题', '无可奈何花落去', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('24', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目1', '单选题', '防守打法', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('25', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目7', '判断题', '对', '10', 'A', '006');
INSERT INTO `jieguo` VALUES ('26', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目4', '多选题', '富士达,柑要', '20', 'A,B', '006');
INSERT INTO `jieguo` VALUES ('27', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目5', '多选题', '无可奈何花落去枯荣,桔柑', '20', 'A,B', '006');
INSERT INTO `jieguo` VALUES ('28', '1', '022823212585', '每日答题', 'admin', '每日答题', '030113591450', '题目6', '判断题', '对', '10', 'A', '006');

-- ----------------------------
-- Table structure for `leibie`
-- ----------------------------
DROP TABLE IF EXISTS `leibie`;
CREATE TABLE `leibie` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `leibiemingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '类别名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='类别';

-- ----------------------------
-- Records of leibie
-- ----------------------------
INSERT INTO `leibie` VALUES ('1', '中西药品');
INSERT INTO `leibie` VALUES ('2', '家庭常备');

-- ----------------------------
-- Table structure for `liuyanban`
-- ----------------------------
DROP TABLE IF EXISTS `liuyanban`;
CREATE TABLE `liuyanban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yishengid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '医生id',
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `zixunrenxingming` varchar(50) NOT NULL DEFAULT '' COMMENT '咨询人姓名',
  `lianxidianhua` varchar(50) NOT NULL DEFAULT '' COMMENT '联系电话',
  `liuyanneirong` text NOT NULL COMMENT '留言内容',
  `liuyanren` varchar(50) NOT NULL DEFAULT '' COMMENT '留言人',
  `huifuneirong` text NOT NULL COMMENT '回复内容',
  PRIMARY KEY (`id`),
  KEY `liuyanban_yishengid_index` (`yishengid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='留言板';

-- ----------------------------
-- Records of liuyanban
-- ----------------------------
INSERT INTO `liuyanban` VALUES ('1', '8', '888', '雷厉秀', '张三', '13700137001', '发斯蒂芬斯蒂芬手打', '001', '防守打法械');
INSERT INTO `liuyanban` VALUES ('2', '8', '888', '雷厉秀', '李可', '13700137006', '防守打法士大夫枯荣', '006', '城标可耕地棋鼓楼区');

-- ----------------------------
-- Table structure for `lunbotu`
-- ----------------------------
DROP TABLE IF EXISTS `lunbotu`;
CREATE TABLE `lunbotu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '连接地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='轮播图';

-- ----------------------------
-- Records of lunbotu
-- ----------------------------
INSERT INTO `lunbotu` VALUES ('1', '/upload/a5ad0a7c6474cfb9099dc6c6b99dba60.png', '#');
INSERT INTO `lunbotu` VALUES ('2', '/upload/4aabdfdd84d7acb72be3f7bb6b65bfef.png', '#');
INSERT INTO `lunbotu` VALUES ('3', '/upload/001998665bc9f7f78cb8cb5ec24c7bca.png', '#');

-- ----------------------------
-- Table structure for `paiban`
-- ----------------------------
DROP TABLE IF EXISTS `paiban`;
CREATE TABLE `paiban` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yishengid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '医生id',
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `zhicheng` varchar(50) NOT NULL DEFAULT '' COMMENT '职称',
  `shangbanshijian` varchar(25) NOT NULL DEFAULT '' COMMENT '上班时间',
  `xiabanshijian` varchar(25) NOT NULL DEFAULT '' COMMENT '下班时间',
  PRIMARY KEY (`id`),
  KEY `paiban_yishengid_index` (`yishengid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='排班';

-- ----------------------------
-- Records of paiban
-- ----------------------------
INSERT INTO `paiban` VALUES ('1', '8', '888', '雷厉秀', '副主任医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('2', '7', '777', '龙隽', '副主任医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('3', '6', '666', '陈旭辉', '副主任医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('4', '5', '555', '李海军', '主任医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('5', '4', '444', '王红芳', '医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('6', '3', '333', '卢先红', '医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('7', '2', '222', '吴进峰', '副主任医师', '07:00', '21:00');
INSERT INTO `paiban` VALUES ('8', '1', '111', '李晓冬', '副主任医师', '07:00', '21:00');

-- ----------------------------
-- Table structure for `shijuan`
-- ----------------------------
DROP TABLE IF EXISTS `shijuan`;
CREATE TABLE `shijuan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shijuanbianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '试卷编号',
  `shijuanmingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `datileixing` varchar(50) NOT NULL DEFAULT '' COMMENT '答题类型',
  `tupian` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `shichang` varchar(50) NOT NULL DEFAULT '' COMMENT '时长',
  `shijuanjianjie` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷简介',
  `faburen` varchar(50) NOT NULL DEFAULT '' COMMENT '发布人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='试卷';

-- ----------------------------
-- Records of shijuan
-- ----------------------------
INSERT INTO `shijuan` VALUES ('1', '022823212585', '每日答题', '每日答题', '/upload/bd2c5c8405357701d32535421eabcc83.png', '30', 'xxxxxx', 'admin');
INSERT INTO `shijuan` VALUES ('2', '022823212585', '健康自测', '健康自测', '/upload/71a070ef758ceb87d34c6e9fab31f220.png', '40', 'xxxxxxxxx', 'admin');

-- ----------------------------
-- Table structure for `shiti`
-- ----------------------------
DROP TABLE IF EXISTS `shiti`;
CREATE TABLE `shiti` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shijuanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '试卷id',
  `shijuanbianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '试卷编号',
  `shijuanmingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '试卷名称',
  `faburen` varchar(50) NOT NULL DEFAULT '' COMMENT '发布人',
  `shititimu` text NOT NULL COMMENT '试题题目',
  `leixing` varchar(50) NOT NULL DEFAULT '' COMMENT '类型',
  `daan` text NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`),
  KEY `shiti_shijuanid_index` (`shijuanid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COMMENT='试题';

-- ----------------------------
-- Records of shiti
-- ----------------------------
INSERT INTO `shiti` VALUES ('1', '2', '022823212585', '健康自测', 'admin', '题目1', '单选题', '[{\"zimu\":\"A\",\"title\":\"防守打法要\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"防守打法\",\"point\":0},{\"zimu\":\"C\",\"title\":\"魂牵梦萦 \",\"point\":0},{\"zimu\":\"D\",\"title\":\"魂牵梦萦 要\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('2', '2', '022823212585', '健康自测', 'admin', '题目2', '单选题', '[{\"zimu\":\"A\",\"title\":\"魂牵梦萦地\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"械魂牵梦萦地要\",\"point\":0},{\"zimu\":\"C\",\"title\":\"魂牵梦萦地枯荣\",\"point\":0},{\"zimu\":\"D\",\"title\":\"柑枯荣\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('3', '2', '022823212585', '健康自测', 'admin', '题目3', '单选题', '[{\"zimu\":\"A\",\"title\":\"魂牵梦萦富士达\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"夺标枯荣\",\"point\":0},{\"zimu\":\"C\",\"title\":\"魂牵梦萦地枯\",\"point\":0},{\"zimu\":\"D\",\"title\":\"魂牵梦萦地枯荣\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('4', '2', '022823212585', '健康自测', 'admin', '题目4', '多选题', '[{\"zimu\":\"A\",\"title\":\"无可奈何花落去枯荣\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"的撒发生大\",\"point\":\"10\"},{\"zimu\":\"C\",\"title\":\"橱柜在苛\",\"point\":0},{\"zimu\":\"D\",\"title\":\"魂牵梦萦 \",\"point\":0}]');
INSERT INTO `shiti` VALUES ('5', '2', '022823212585', '健康自测', 'admin', '题目5', '多选题', '[{\"zimu\":\"A\",\"title\":\"城标要\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"魂牵梦萦 \",\"point\":\"10\"},{\"zimu\":\"C\",\"title\":\"防守打法枯荣\",\"point\":0},{\"zimu\":\"D\",\"title\":\"士大夫要\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('6', '2', '022823212585', '健康自测', 'admin', '题目6', '判断题', '[{\"zimu\":\"A\",\"title\":\"对\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"错\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('7', '2', '022823212585', '健康自测', 'admin', '题目7', '判断题', '[{\"zimu\":\"A\",\"title\":\"对\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"错\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('8', '1', '022823212585', '每日答题', 'admin', '题目1', '单选题', '[{\"zimu\":\"A\",\"title\":\"防守打法\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"楳工\",\"point\":0},{\"zimu\":\"C\",\"title\":\"魂牵梦萦 \",\"point\":0},{\"zimu\":\"D\",\"title\":\"大本营\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('9', '1', '022823212585', '每日答题', 'admin', '题目2', '单选题', '[{\"zimu\":\"A\",\"title\":\"无可奈何花落去\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"魂牵梦萦 \",\"point\":0},{\"zimu\":\"C\",\"title\":\"顶戴\",\"point\":0},{\"zimu\":\"D\",\"title\":\"栽\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('10', '1', '022823212585', '每日答题', 'admin', '题目3', '单选题', '[{\"zimu\":\"A\",\"title\":\"魂牵梦萦 \",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"枯荣\",\"point\":0},{\"zimu\":\"C\",\"title\":\"大本营\",\"point\":0},{\"zimu\":\"D\",\"title\":\"枯荣\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('11', '1', '022823212585', '每日答题', 'admin', '题目4', '多选题', '[{\"zimu\":\"A\",\"title\":\"富士达\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"柑要\",\"point\":\"10\"},{\"zimu\":\"C\",\"title\":\"富士达工\",\"point\":0},{\"zimu\":\"D\",\"title\":\"革载\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('12', '1', '022823212585', '每日答题', 'admin', '题目5', '多选题', '[{\"zimu\":\"A\",\"title\":\"无可奈何花落去枯荣\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"桔柑 \",\"point\":\"10\"},{\"zimu\":\"C\",\"title\":\"大本营\",\"point\":0},{\"zimu\":\"D\",\"title\":\"枯荣\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('13', '1', '022823212585', '每日答题', 'admin', '题目6', '判断题', '[{\"zimu\":\"A\",\"title\":\"对\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"错\",\"point\":0}]');
INSERT INTO `shiti` VALUES ('14', '1', '022823212585', '每日答题', 'admin', '题目7', '判断题', '[{\"zimu\":\"A\",\"title\":\"对\",\"point\":\"10\"},{\"zimu\":\"B\",\"title\":\"错\",\"point\":0}]');

-- ----------------------------
-- Table structure for `shouhuodizhi`
-- ----------------------------
DROP TABLE IF EXISTS `shouhuodizhi`;
CREATE TABLE `shouhuodizhi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shouhuoren` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人',
  `shouji` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `dizhi` varchar(255) NOT NULL DEFAULT '' COMMENT '地址',
  `tianjiaren` varchar(50) NOT NULL DEFAULT '' COMMENT '添加人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='收货地址';

-- ----------------------------
-- Records of shouhuodizhi
-- ----------------------------
INSERT INTO `shouhuodizhi` VALUES ('1', '张三', '13700137001', 'xxx地址', '001');
INSERT INTO `shouhuodizhi` VALUES ('2', '李可', '13700137006', 'xxx地址', '006');

-- ----------------------------
-- Table structure for `tongzhi`
-- ----------------------------
DROP TABLE IF EXISTS `tongzhi`;
CREATE TABLE `tongzhi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yonghu` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `tongzhineirong` text NOT NULL COMMENT '通知内容',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `tongzhi_yonghu_index` (`yonghu`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='通知';

-- ----------------------------
-- Records of tongzhi
-- ----------------------------
INSERT INTO `tongzhi` VALUES ('1', '1', '001', '张三', '通知内容通知内容通知内容通知内容', '2025-02-28 23:39:01');
INSERT INTO `tongzhi` VALUES ('2', '2', '002', '李四', '通知内容通知内容通知内容通知内容通知内容', '2025-02-28 23:39:14');
INSERT INTO `tongzhi` VALUES ('3', '4', '006', '李可', '通知内容通知内容通知内容通知内容', '2025-03-01 14:04:22');

-- ----------------------------
-- Table structure for `wenzhang`
-- ----------------------------
DROP TABLE IF EXISTS `wenzhang`;
CREATE TABLE `wenzhang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `biaoti` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `tupian` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `dianjiliang` int(11) NOT NULL DEFAULT '0' COMMENT '点击量',
  `xiangqing` longtext NOT NULL COMMENT '详情',
  `tianjiaren` varchar(50) NOT NULL DEFAULT '' COMMENT '添加人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COMMENT='文章';

-- ----------------------------
-- Records of wenzhang
-- ----------------------------
INSERT INTO `wenzhang` VALUES ('8', '最快速最有效的戒烟方法', 'upload/e5d729ca1380e097d4a3be23b57e0fdf.png', '0', '<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　吸烟是有害健康的，这是所有人都知道的，因此对于吸烟者，我们要劝诫大家戒烟，有人会问怎样戒烟有效呢?戒烟后的症状有哪些呢?今天就向大家分享一些戒烟的小技巧，以及常见的戒烟饮食。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　生活中戒烟的方式有很多，但是总有人会戒烟失败，是因为没有掌握正确的戒烟方法，下面就教吸烟者怎样戒烟，感兴趣的一起来看看吧。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　教你十招科学戒烟的方法</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　冷火鸡</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　冷火鸡戒烟方法已经为一些戒烟者起到了明显效果。冷火鸡是指无论烟瘾如何，直接了当把烟停了，换个意思是指戒烟不需药物或其它戒烟辅助方法，比如尼古丁替代疗法。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　处方药</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有些医生开的抗抑郁药盐酸安非他酮对那些想戒烟的人是有效果的。这种药物可以减缓那些戒烟产生的焦虑，可以减轻戒断症状。这种药物如何帮助减少这些症状的科学机理是未知的，因此它只归类于处方药的形式。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　尼古丁贴片</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有不少尼古丁贴片，可以有助于人们戒烟。尼古丁贴剂可通过皮肤，来提供一定剂量的尼古丁，身体从而就不需要通过抽烟来获取尼古丁。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　该贴片的使用通常是逐步的，开始时贴片的尼古丁含量最高，并逐渐降低尼古丁水平，以抑制戒断症状，直到不再需要</p>', '333');
INSERT INTO `wenzhang` VALUES ('9', '科学戒烟，您找对方法了吗', 'upload/6462ae0ac1cd8d0219a0c269236b578e.png', '0', '<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">冷火鸡戒烟方法已经为一些戒烟者起到了明显效果。冷火鸡是指无论烟瘾如何，直接了当把烟停了，换个意思是指戒烟不需药物或其它戒烟辅助方法，比如尼古丁替代疗法。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　处方药</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有些医生开的抗抑郁药盐酸安非他酮对那些想戒烟的人是有效果的。这种药物可以减缓那些戒烟产生的焦虑，可以减轻戒断症状。这种药物如何帮助减少这些症状的科学机理是未知的，因此它只归类于处方药的形式。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　尼古丁贴片</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有不少尼古丁贴片，可以有助于人们戒烟。尼古丁贴剂可通过皮肤，来提供一定剂量的尼古丁，身体从而就不需要通过抽烟来获取尼古丁。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　该贴片的使用通常是逐步的，开始时贴片的尼古丁含量最高，并逐渐降低尼古丁水平，以抑制戒断症状，直到不再需要。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　口香糖</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　许多人觉得戒烟很难，因为他们在吸烟的同时也发展了口腔的固定习惯。口香糖可以成为一个很好的替代吸烟的替代品。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有些戒烟者则把食物变成另一种替代品，这就是为什么许多人在戒烟时会增加体重。当然，由于缺乏尼古丁，他们的新陈代谢会减慢。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　手忙起来</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　手里不要闲着，要动起来(需要用你的双手做某事)，因为吸烟的习惯是慢慢发展起来的，所以现在可以更换一些类似于香烟的东西握在手里，如钢笔或筷子等。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　这些可以以同样的方式来满足你手拿一根烟的习惯。确保自己随身携带一些这类小器具，曾经的吸烟者不少也有咀嚼钢笔和铅笔的嗜好。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　计划变更</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　许多人觉得戒烟很难，因为吸烟已经形成了一种常规。你可能喜欢在车里抽一根烟;午餐后，你可能会再抽一根烟。改变你的习惯可能有助于戒烟。</p>', '888');
INSERT INTO `wenzhang` VALUES ('10', '为啥戒烟那么难？教你4招应对戒断症状', '/upload/98e6d33a95bd8217c06a0101ce683848.png', '0', '<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">三湘都市报&middot;新湖南客户端6月1日讯 （全媒体记者 李琪 通讯员 王红艳）吸烟致癌人尽皆知，根据《中国吸烟危害健康报告2020》显示，我国现有吸烟人数超过三亿，15岁以上人群吸烟率为26.6%，其中男性吸烟率高达50.5%，每年香烟消费量超过2万亿支。在15岁男性烟民中，平均每天会抽一包烟，或者更多。奇怪的是，烟民甚至比普通人更了解吸烟的危害，根据美国疾控中心数据，有超过70%的烟民希望戒烟并有过戒烟经历，但最后多以失败告终，究竟是什么原因，让人们无法摆脱香烟这种白色幽灵呢？湖南省卫健委健康教育宣传中心邀请相关专家进行解读。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">在停止吸烟或减少吸烟量后，吸烟者会产生一系列不易忍受的症状和体征，医学上称之为戒断症状，包括吸烟渴求、焦虑、抑郁、不安、头痛、唾液腺分泌增加、注意力不集中、睡眠障碍、血压升高和心率加快等，部分戒烟者还会出现体重增加<span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">。</span>戒断症状往往使戒烟者感觉很痛苦,此时再吸上烟，会减轻或消除戒断症状，破坏戒烟进程。因此，戒断症状是导致戒烟失败的最主要原因，也是戒烟者遇到的最大挑战。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">那么，戒断症状会一直存在吗？不会<span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">。</span>一般情况下，戒断症状可在停止吸烟后数小时内开始出现，在戒烟最初14天内戒断反应会达到一个峰值，表现最为强烈，烟民甚至会变得暴躁，易怒，大约1个月后开始减轻，一般不超过三个月，部分患者对吸烟的渴求会持续1年以上。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">处理好戒断症状，才能助戒烟事半功倍<span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">。</span>教你4招轻松应对戒断症状：</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">第一招：让自己忙起来：培养其他爱好，如散步、阅读、烹饪。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">第二招：让手和嘴忙起来：如手拿玩物或健身器材、练书法、含牙签或吸管、嚼口香糖、吃棒棒糖或薄荷糖、嗑瓜子等。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">第三招：改变生活习惯、周围环境和社会交往：如饭后散步或刷碗、听音乐或聊天、改变家具挂件的位置、去无烟场所、结交不吸烟的朋友等。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">第四招：获得家人和朋友的支持：告诉他们你正在戒烟，当出现戒断症状时，请他们理解包涵，当烟瘾发作时，请他们监督支持。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">下面列出一些具体的症状及处理办法：</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">n 压力增加或强烈想吸烟的冲动：尝试做深呼吸，或喝水（喝一大口水并分几小口咽下），动作反复多次直到感觉压力减轻。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">n 食欲或体重增加：饮食均衡规律，多吃水果和蔬菜，不要吃快餐、方便食品和油炸食品，减少热量摄入，适当运动。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">n 总想吃东西或吃不饱：多喝水，嚼无糖口香糖，吃黄瓜、小西红柿等低热量的食物。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">n 焦虑、烦躁、易怒：暂时离开此处换个环境，深呼吸或去室外透透气；找一些自己喜欢做的事情或能发泄情绪的方法，转移注意力，如玩游戏、打球、跑步、K歌等等；告诉身边的亲友你正在尝试戒烟，情绪变化是戒烟后常见的症状之一，请他们体谅并告知会逐渐好转，获得支持渡过难关。</span></div>', '444');
INSERT INTO `wenzhang` VALUES ('11', '来看常见的错误戒烟方法', '/upload/831f4c8dd7b7d82c5e54a70c48095a82.png', '0', '<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\"><span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">错误戒烟法一：替代品戒烟法（电子烟）</span></span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">电子烟以&ldquo;戒烟神器&rdquo;的形象出现在公众视野后，吸引了大批戒烟大军。他们希望&ldquo;电子烟&rdquo;成为戒烟替代品。殊不知，替代品只会让戒烟变得更困难，延长戒断症状。你会自我暗示：&ldquo;我需要吸烟，我需要电子烟来填补空虚。&rdquo;《中国吸烟危害健康报告2020》明确提出，电子烟无法帮助戒烟，电子烟也是烟。电子烟液中除了尼古丁，还含有甲醛、乙醛、丙酮等致癌物。电子烟以&ldquo;味甜&rdquo;&ldquo;安全&rdquo;&ldquo;无害&rdquo;等标签，吸引大批青少年&ldquo;入坑&rdquo;尝试，吸烟队伍越来越壮大，越来越年轻化。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\"><span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">错误戒烟法二：意志力戒烟法</span></span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">晚上睡觉不吸烟，不影响睡眠。考场考试禁吸烟，不影响发挥。尼古丁不是必需品，戒烟你不需要放弃任何东西。吸烟后半小时，血液中的尼古丁含量就会下降50%，再过半小时就会下降到25%。吸烟者抽完一支烟，血液中的尼古丁含量就会迅速下降，很快就会引发戒断症状。这就是大部分吸烟者每天吸20支烟的原因。吸烟只是暂时满足毒瘾、缓解戒断症状而已。认为只有意志薄弱的人才会染上烟瘾，戒烟靠意志力，其实是错误的。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\"><span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">错误戒烟法三：减量戒烟法</span></span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">吸烟者考虑减量法，通常是在尝试戒烟失败之后。一旦采用减量戒烟法，戒烟者就陷入了十分矛盾的境地。他的想法是，吸烟越少，他就会越不想吸烟。事实则正好相反，吸的烟越少，戒断症状就越严重，对尼古丁的渴望也就越迫切，反而延长了戒烟过程。所以，想戒，就要一次性戒掉。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\"><span class=\"bjh-strong\" style=\"max-width: 100%; font-size: 18px; color: rgb(51, 51, 51); font-weight: bold;\">轻松戒烟的秘密</span></span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">任何人都可以轻松戒烟，但是首先必须知道一些事实。我们究竟为什么要吸烟？导致吸烟的因素只有两种：第一种是尼古丁上瘾，第二种是心理因素。</span></div>\n<div class=\"dpu8C _2kCxD \" style=\"max-width: 100%; overflow-x: visible; font-size: 18px; line-height: 30px; color: rgb(34, 34, 34); margin-top: 24px; font-family: arial; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><span class=\"bjh-p\" style=\"overflow-y: auto; max-width: 100%;\">我们每吸一口烟，都会有少量的尼古丁通过肺部进入大脑。如果一支烟用20口才吸完，那么你的大脑就会受到20次尼古丁刺激。吸烟者经常认为，戒烟时出现的痛苦感觉就是戒断症状。事实上，这种痛苦是精神上的，是吸烟者的心理作用。尼古丁本身的戒断症状十分轻微，并不会导致生理上的疼痛。唯一的症状是心理上的空虚感，让我们渴求尼古丁的作用。一旦点燃烟卷，渴望就会自行消失。不过这种状态只是暂时的，一旦烟卷熄灭，整个周期就会重新开始。由于不了解戒断症状的机制，我们会误以为自己真的喜欢上了吸烟，或者养成了&ldquo;习惯&rdquo;。事实真相是，之所以要经常吸烟，是为了满足尼古丁的刺激。单纯的尼古丁上瘾绝不是主要问题，只是起到催化剂的作用，让我们意识不到问题的真正所在。戒烟并不会导致痛苦，尼古丁戒断症反应也不会。痛苦是犹豫和怀疑的产物。只有当你想吸烟却不能吸时，才会感觉到痛苦。</span></div>', '555');
INSERT INTO `wenzhang` VALUES ('12', '每天或每周逐步减少，直到他们终于无烟了', '/upload/6971e48bd596efaa06bddc108df6167a.png', '0', '<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">有些人设置了自己的烟量减少计划。他们一天减少一支或两支，每天或每周逐步减少，直到他们终于无烟了。如果这是你的一步计划，慢慢地，不要匆忙。不过就我个人经验来看，此法效果一般，谈不上最科学。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">&nbsp;</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　运动</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　开始锻炼规划显然有利于戒烟。这是编者认为的最科学戒烟方法。当你手上没拿起烟的时候，跑步起来，你也就无暇拿烟了，喘着气时，你还能吸烟吗!</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　此外，设定目标，增加锻炼量也可以给戒烟带来积极的影响。研究表明，锻炼的人比不锻炼的人戒烟成功率高出两倍。研究还表明，运动还可以降低食欲的影响。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　跟朋友一块戒烟</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　渴望吸烟会传染，戒烟也是如此。如果你能有个朋友也跟你一样想戒烟，你就更容易戒烟了。如果你发现除了吸烟以外，另有共同的事情想干，那当然敢情好，干起来也更容易。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　群体支持</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　如果你的朋友不戒烟，那就找戒烟的朋友。一些戒烟团队可以提供免费的药物戒烟方法，这可以增加戒烟成功的机会。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　我国现在有些城市征召戒烟的志愿者，这可是千载难逢的机会，千万别错过了。团队的力量可以帮助增加戒烟成功率。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　戒烟饮食</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　1.吃碱性食品，减轻吸烟欲望</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　近年来科学家发现，烟瘾的产生与*内的酸碱度有关：当*体液呈现碱性时，烟瘾就会受到一定程度的抑制;当*体液呈现酸性时，便会诱发烟瘾。所以，在戒烟过程中，多吃一些碱性食品，中和一下体内的酸性液体是非常有必要的。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　食物中的蔬菜、水果和奶类属于碱性食品，因此戒烟者应多吃蔬果、少吃肉类。同时，蔬菜水果还含有丰富的维生素和矿物质。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　其中的B族维生素可以帮助缓解压力，减轻戒烟时的焦虑，帮助睡眠维生素A可以保护黏膜，减少因吸烟造成的黏膜受损。</p>', '666');
INSERT INTO `wenzhang` VALUES ('13', '教你十招科学戒烟的方法', '/upload/414b785e87e4097c5c5720ae80651179.png', '2', '<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">吸烟是有害健康的，这是所有人都知道的，因此对于吸烟者，我们要劝诫大家戒烟，有人会问怎样戒烟有效呢?戒烟后的症状有哪些呢?今天就向大家分享一些戒烟的小技巧，以及常见的戒烟饮食。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　生活中戒烟的方式有很多，但是总有人会戒烟失败，是因为没有掌握正确的戒烟方法，下面就教吸烟者怎样戒烟，感兴趣的一起来看看吧。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　教你十招科学戒烟的方法</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　冷火鸡</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　冷火鸡戒烟方法已经为一些戒烟者起到了明显效果。冷火鸡是指无论烟瘾如何，直接了当把烟停了，换个意思是指戒烟不需药物或其它戒烟辅助方法，比如尼古丁替代疗法。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　处方药</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有些医生开的抗抑郁药盐酸安非他酮对那些想戒烟的人是有效果的。这种药物可以减缓那些戒烟产生的焦虑，可以减轻戒断症状。这种药物如何帮助减少这些症状的科学机理是未知的，因此它只归类于处方药的形式。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　尼古丁贴片</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有不少尼古丁贴片，可以有助于人们戒烟。尼古丁贴剂可通过皮肤，来提供一定剂量的尼古丁，身体从而就不需要通过抽烟来获取尼古丁。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　该贴片的使用通常是逐步的，开始时贴片的尼古丁含量最高，并逐渐降低尼古丁水平，以抑制戒断症状，直到不再需要。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　口香糖</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　许多人觉得戒烟很难，因为他们在吸烟的同时也发展了口腔的固定习惯。口香糖可以成为一个很好的替代吸烟的替代品。</p>\n<center style=\"color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"></center>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　有些戒烟者则把食物变成另一种替代品，这就是为什么许多人在戒烟时会增加体重。当然，由于缺乏尼古丁，他们的新陈代谢会减慢。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\"><strong>　　手忙起来</strong></p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　手里不要闲着，要动起来(需要用你的双手做某事)，因为吸烟的习惯是慢慢发展起来的，所以现在可以更换一些类似于香烟的东西握在手里，如钢笔或筷子等。</p>\n<p style=\"margin: 0px; padding: 10px 0px; text-align: justify; color: rgb(51, 51, 51); font-family: 微软雅黑; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">　　这些可以以同样的方式来满足你手拿一根烟的习惯。确保自己随身携带一些这类小器具，曾经的吸烟者不少也有咀嚼钢笔和铅笔的嗜好。</p>', '888');
INSERT INTO `wenzhang` VALUES ('14', '新年新开始，下定决心优雅戒烟吧', '/upload/57f8a553ae10980ae42cc0f67395f571.png', '2', '<p><span style=\"color: rgb(0, 0, 0); font-family: -apple-system-font, \'Helvetica Neue\', \'PingFang SC\', \'Hiragino Sans GB\', \'Microsoft YaHei\', sans-serif; font-size: 19px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">吸烟者在吸烟时主动将香烟烟雾吸入肺部的过程叫主动吸烟，称&ldquo;一手烟&rdquo;；吸烟者主动吸烟时部分未吸入其体内的烟雾会扩散到周围的空气，被周围的人吸入体内，这一过程叫被动吸烟，称&ldquo;二手烟&rdquo;；而&ldquo;三手烟&rdquo;是指吸烟者吸烟后释放的有害气体会吸附在衣服、墙壁、家具甚至皮肤、头发等表面，可能存在几天、几周甚至数月。</span></p>\n<p>&nbsp;</p>', '777');

-- ----------------------------
-- Table structure for `xinlizhenliaofangan`
-- ----------------------------
DROP TABLE IF EXISTS `xinlizhenliaofangan`;
CREATE TABLE `xinlizhenliaofangan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yuyueguahaoid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '预约挂号id',
  `paibanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排班id',
  `yishengid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '医生id',
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `zhicheng` varchar(50) NOT NULL DEFAULT '' COMMENT '职称',
  `huanzhexingming` varchar(50) NOT NULL DEFAULT '' COMMENT '患者姓名',
  `nianling` int(11) NOT NULL DEFAULT '0' COMMENT '年龄',
  `guahaoren` varchar(50) NOT NULL DEFAULT '' COMMENT '挂号人',
  `zhenliaofangan` text NOT NULL COMMENT '诊疗方案',
  `chufang` text NOT NULL COMMENT '处方',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `xinlizhenliaofangan_yuyueguahaoid_index` (`yuyueguahaoid`),
  KEY `xinlizhenliaofangan_paibanid_index` (`paibanid`),
  KEY `xinlizhenliaofangan_yishengid_index` (`yishengid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='心理诊疗方案';

-- ----------------------------
-- Records of xinlizhenliaofangan
-- ----------------------------
INSERT INTO `xinlizhenliaofangan` VALUES ('1', '1', '1', '8', '888', '雷厉秀', '副主任医师', '张三', '23', '001', '诊疗方案诊疗方案诊疗方案', '处方处方处方处方处方', '2025-03-01 00:13:56');
INSERT INTO `xinlizhenliaofangan` VALUES ('2', '2', '1', '8', '888', '雷厉秀', '副主任医师', '李可', '26', '006', '诊疗方案诊疗方案诊疗方案', '处方处方处方处方处方', '2025-03-01 14:00:59');

-- ----------------------------
-- Table structure for `yaopin`
-- ----------------------------
DROP TABLE IF EXISTS `yaopin`;
CREATE TABLE `yaopin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bianhao` varchar(50) NOT NULL DEFAULT '' COMMENT '编号',
  `mingcheng` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `tupian` text NOT NULL COMMENT '图片',
  `fenlei` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `jiage` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `kucun` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `xiaoliang` int(11) NOT NULL DEFAULT '0' COMMENT '销量',
  `yaopinxiangqing` longtext NOT NULL COMMENT '药品详情',
  `tianjiaren` varchar(50) NOT NULL DEFAULT '' COMMENT '添加人',
  PRIMARY KEY (`id`),
  KEY `yaopin_fenlei_index` (`fenlei`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='药品';

-- ----------------------------
-- Records of yaopin
-- ----------------------------
INSERT INTO `yaopin` VALUES ('1', '2101121611034', '同仁堂六味地黄丸', '/upload/ae87be130e105d6a2e957a56066f96a3.png', '1', '49.00', '100', '10', '<p>六味地黄浓缩丸，由熟<a href=\"https://baike.baidu.com/item/%E5%9C%B0%E9%BB%84\" target=\"_blank\" rel=\"noopener\">地黄</a>、山茱萸、<a href=\"https://baike.baidu.com/item/%E5%B1%B1%E8%8D%AF/414450\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"414450\">山药</a>、泽泻、丹皮、茯苓这六味中药组成。最早是“八味地黄丸”，见于<a href=\"https://baike.baidu.com/item/%E5%BC%A0%E4%BB%B2%E6%99%AF/66566\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"66566\">张仲景</a>的《金匮要略》。后来，宋代名医、儿科专家钱乙把八味地黄丸里面的附子和桂枝这种温补的药物去掉了，变成了现在的六味地黄丸，并用它来治疗小儿先天不足，发育迟缓等病症</p>\n<h2 class=\"title-text\">简介</h2>\n<div class=\"para\">六味地黄丸这一称谓来自钱仲阳所著的《小儿药证直诀》</div>\n<div class=\"para\">后来，明代中医有一派非常推崇“肾”的作用，认为肾是人的“先天之本”，一时间，很多名医倡导补肾，比如明代名医薛己最善补肾，他就主张，肾阴虚用六味地黄丸，肾阳虚用八味地黄丸。薛己的实践为许多后世医家认可，他们倡导的补肾观点对后世的影响非常大。</div>\n<div class=\"para\">比如同仁堂古方六味地黄丸要求使用出自河南的怀地黄和怀山药（四大怀药）。怀地黄则要求第一要大，第二要熟，只用三等以上的高品质原料，再将生地黄以黄酒泡透蒸熟，遵循古方“酒蒸酒制；而山萸肉除采用道地药材“杭萸”，含核量控制在1%以内；丹皮只用安徽地产“凤丹皮”等。名方之所以有名有效就是从源头用好材制成。</div>\n<div class=\"para\"> </div>\n<div class=\"para\">\n<h2 class=\"title-text\">适用</h2>\n<div class=\"para\"><strong>适用于肾阴虚</strong></div>\n<div class=\"para\">仅从历史医家的主张就可以看出，六味地黄丸以滋补肾阴为主；此外，从药方的组成来看，它可以达到三阴同补（补肾阴、补肝阴、补脾阴）的效果，比如熟地黄可以补肾阴；山茱萸则是肝肾同补，通过补肝来达到补肾的目的；山药能健脾益肾，通过健脾来补后天。由此可以看出，六味地黄丸只适用于阴虚，阳虚者就不适用了。</div>\n<div class=\"para\">如何判断是阴虚、还是阳虚呢？肾阴虚的典型症状是潮热、盗汗、手心和脚心烦热、口燥咽干，此外还有遗精、梦遗、早泄等。肾阳虚的典型症状是腰膝酸软、不耐疲劳、经常觉得乏力、四肢发凉、喜热怕冷等。有些肾阳不足的人，也可能会出现勃起功能障碍、早泄、滑精等性功能问题。</div>\n<div class=\"para\">那么，目前中年人是肾阳虚多还是肾阴虚多呢？对正常人群，做这样的区分没有意义。阴虚、阳虚是指肾虚发展到一定程度之后才有的症状。大部分人可能仅仅处于肾气轻微不足的状态，远未到肾阴虚或肾阳虚的程度</div>\n</div>', 'admin');
INSERT INTO `yaopin` VALUES ('2', '2101121614191', '东阿 阿胶250g', '/upload/8ca53ac11c7ddfb738b99e4cfd94db15.png', '1', '869.00', '100', '25', '<p>东阿阿胶参与了自1985版《中国药典》以来连续7版阿胶质量标准的制订，其建立的37项质控指标被收录到《中国药典》中，参与了阿胶等10余个中药产品国家药品质量标准的起草和修订，先后共填补《中国药典》阿胶质量标准空白9项，成为行业法定标准</p>\n<h2 class=\"title-text\">功能</h2>\n<p>补血，滋阴，润肺，止血</p>\n<p> </p>\n<h2 class=\"title-text\">主治</h2>\n<div class=\"para\">1、血虚诸证：本品为血肉有情之品，甘平质润，为补血要药，多用治血虚诸证，尤以治疗出血而致血虚为佳。</div>\n<div class=\"para\">2、出血证：本品味甘质粘，为止血要药。</div>\n<div class=\"para\">3、肺阴虚燥咳：本品滋阴润肺。</div>\n<div class=\"para\">4、热病伤阴，心烦失眠，阴虚风动，手足瘈疭：本品养阴以滋肾水。</div>\n<div class=\"para\">5、西医诊为贫血属肝血亏虚者，功能性子宫出血、慢性胃肠道出血、痔疮出血、支气管扩张属血虚出血、肺结核、肾结核、甲状腺功能亢进、更年期综合征等属阴虚燥热者。</div>\n<div class=\"para\">\n<h2 class=\"title-text\">用法用量</h2>\n<p>内服：烊化兑服，5-10g；炒阿胶可入汤剂或丸、散。滋阴补血多生用，清肺化痰蛤粉炒，止血蒲黄炒</p>\n</div>', 'admin');
INSERT INTO `yaopin` VALUES ('3', '2101121617501', '999三九感冒灵颗粒', '/upload/051c54f066009f8c1fd347895d65638a.png', '2', '15.00', '100', '36', '<p>本品为浅棕色至深棕色的<a href=\"https://baike.baidu.com/item/%E9%A2%97%E7%B2%92/2342620\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"2342620\">颗粒</a>，味甜、微苦。每盒含9包，每包袋装10g<sup class=\"sup--normal\" data-sup=\"1\" data-ctrmap=\":1,\"> [1]</sup><a class=\"sup-anchor\" name=\"ref_%5B1%5D_4020053\"></a>  。<a href=\"https://baike.baidu.com/item/%E8%A7%A3%E7%83%AD/1522925\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"1522925\">解热</a><a href=\"https://baike.baidu.com/item/%E9%95%87%E7%97%9B/1902501\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"1902501\">镇痛</a>功效，用于因<a href=\"https://baike.baidu.com/item/%E6%84%9F%E5%86%92/502565\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"502565\">感冒</a>引起的头痛，<a href=\"https://baike.baidu.com/item/%E5%8F%91%E7%83%AD/35767\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"35767\">发热</a>，鼻塞，<a href=\"https://baike.baidu.com/item/%E6%B5%81%E6%B6%95/2616919\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"2616919\">流涕</a>，<a href=\"https://baike.baidu.com/item/%E5%92%BD%E7%97%9B/6356218\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"6356218\">咽痛</a>等症状</p>\n<h2 class=\"title-text\">主要成份</h2>\n<p>三叉苦、岗梅、<a href=\"https://baike.baidu.com/item/%E9%87%91%E7%9B%8F%E9%93%B6%E7%9B%98\" target=\"_blank\" rel=\"noopener\">金盏银盘</a>、薄荷油、<a href=\"https://baike.baidu.com/item/%E9%87%8E%E8%8F%8A%E8%8A%B1/8438\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"8438\">野菊花</a>、<a href=\"https://baike.baidu.com/item/%E9%A9%AC%E6%9D%A5%E9%85%B8%E6%B0%AF%E8%8B%AF%E9%82%A3%E6%95%8F\" target=\"_blank\" rel=\"noopener\">马来酸氯苯那敏</a>、咖啡因、<a href=\"https://baike.baidu.com/item/%E5%AF%B9%E4%B9%99%E9%85%B0%E6%B0%A8%E5%9F%BA%E9%85%9A\" target=\"_blank\" rel=\"noopener\">对乙酰氨基酚</a>。辅料为蔗糖粉</p>\n<h2 class=\"title-text\">产品性状</h2>\n<p>浅棕色至深棕色的颗粒，味甜、微苦。</p>\n<h2 class=\"title-text\">产品规格</h2>\n<p>10g*9包 袋装10克（含对乙酰氨基酚0.2克）；复合膜。</p>\n<h2 class=\"title-text\">适应症</h2>\n<p>本品解热镇痛。用于感冒引起的头痛，发热，鼻塞，流涕，咽痛等</p>\n<h2 class=\"title-text\">用法用量</h2>\n<p>开水冲服，一次1袋，一日3次。小儿减量或遵医嘱</p>', 'admin');
INSERT INTO `yaopin` VALUES ('4', '2101121620362', '连花清瘟胶囊', '/upload/ba81b516fef88c14b737810fb3719893.png', '2', '25.00', '100', '52', '<h2 class=\"title-text\">成份</h2>\n<p>连翘、金银花、炙麻黄、炒苦杏仁、石膏、板蓝根、绵马贯众、鱼腥草、广藿香、大黄、红景天、薄荷脑、甘草。辅料为：淀粉。</p>\n<h2 class=\"title-text\">性状</h2>\n<p>本品为胶囊剂，内容物为棕黄色至黄褐色颗粒和粉末，气微香，味微苦。</p>\n<h2 class=\"title-text\">功能主治</h2>\n<p>清瘟解毒，宣肺泄热。用于治疗流行性感冒属热毒袭肺证，症见：发热或高热，恶寒，肌肉酸痛，鼻塞流涕，咳嗽，头痛，咽干咽痛，舌偏红，苔黄或黄腻等。</p>\n<h2 class=\"title-text\">用法用量</h2>\n<p>口服。一次4粒，一日3次。</p>\n<h2 class=\"title-text\">注意事项</h2>\n<div class=\"para\">1.忌烟、酒及辛辣、生冷、油腻食物。</div>\n<div class=\"para\">2.不宜在服药期间同时服用滋补性中药。</div>\n<div class=\"para\">3.风寒感冒者不适用。</div>\n<div class=\"para\">4.高血压、心脏病患者慎用。有肝病、糖尿病、肾病等慢性病严重者应在医师指导下服用。</div>\n<div class=\"para\">5.儿童、孕妇、哺乳期妇女、年老体弱及脾虚便溏者应在医师指导下服用。</div>\n<div class=\"para\">6.发热体温超过38.5℃的患者，应去医院就诊。</div>\n<div class=\"para\">7.严格按用法用量服用，本品不宜长期服用。</div>\n<div class=\"para\">8.服药3天症状无缓解，应去医院就诊。</div>\n<div class=\"para\">9.对本品过敏者禁用，过敏体质者慎用。</div>\n<div class=\"para\">10.本品性状发生改变时禁止使用。</div>\n<div class=\"para\">11.儿童必须在成人监护下使用。</div>\n<div class=\"para\">12.请将本品放在儿童不能接触的地方。</div>\n<div class=\"para\">13.如正在使用其他药品，使用本品前请咨询医师或药师。</div>\n<div class=\"para\">14.运动员慎用。</div>\n<div class=\"para\">15.打开防潮袋后，请注意防潮。</div>', 'admin');
INSERT INTO `yaopin` VALUES ('5', '2101121623104', '双黄连口服液', '/upload/c86fd7e3bfe30391ac0bc4f74466fe30.png', '2', '25.00', '98', '55', '<h2 class=\"title-text\">性状</h2>\n<p>本品为棕红色的澄清液体；味甜，微苦</p>\n<h2 class=\"title-text\">主要功效</h2>\n<p>清热解毒、表里双清，抗病毒、抑菌、提高机体免疫</p>\n<h2 class=\"title-text\">适用病症</h2>\n<p>外感风热所致的感冒，症见发热，咳嗽，咽痛</p>\n<h2 class=\"title-text\">注意事项</h2>\n<div class=\"para\">1.忌烟、酒及辛辣、生冷、油腻食物。</div>\n<div class=\"para\">2.不宜在服药期间同时服用滋补性中药。</div>\n<div class=\"para\">3.风寒感冒者不适用。</div>\n<div class=\"para\">4.糖尿病患者及有高血压、心脏病、肝病、肾病等慢性病严重者应在医师指导下服用。</div>\n<div class=\"para\">5.儿童、孕妇、哺乳期妇女、年老体弱及脾虚便溏者应在医师指导下服用。</div>\n<div class=\"para\">6.发热体温超过38.5℃的患者，应去医院就诊。</div>\n<div class=\"para\">7.服药3天症状无缓解，应去医院就诊。</div>\n<div class=\"para\">8.对本品过敏者禁用，过敏体质者慎用。</div>\n<div class=\"para\">9.本品性状发生改变时禁止使用。</div>\n<div class=\"para\">10.儿童必须在成人监护下使用。</div>\n<div class=\"para\">11.请将本品放在儿童不能接触的地方。</div>\n<div class=\"para\">12.如正在使用其他药品，使用本品前请咨询医师或药师。</div>\n<div class=\"para\">13.使用时需注意吸管插入方式，如产生胶塞落屑，慎用。</div>', 'admin');
INSERT INTO `yaopin` VALUES ('6', '2101121625394', '陈李济胃疡宁丸', '/upload/f43a07ecb33669d1813cfd8d5b7f88e3.png', '1', '398.00', '98', '42', '<h2 class=\"title-text\">功能主治</h2>\n<p>温中散寒，理气止痛，制酸止血。用于胃脘胀痛或刺痛，呕吐泛酸</p>\n<h2 class=\"title-text\">用法用量</h2>\n<p>口服，一次1～2丸，一日2～3次，饭前或痛前用盐水送服</p>\n<h2 class=\"title-text\">注意事项</h2>\n<p>1.忌食生冷油腻不易消化食物。<br>2.忌情绪激动或生闷气。<br>3.不适用于脾胃阴虚，主要表现为口干、舌红少津、大便干。<br>4.孕妇慎用。<br>5.按照用法用量服用，小儿、年老体弱者应在医师指导下服用。<br>6.服药三天后症状无改善或有加重者，应立即停药并到医院就诊。<br>7.对本品过敏者禁用，过敏体质者慎用。<br>8.本品性状发生改变时禁止使用。<br>9.儿童必须在成人监护下使用。<br>10.请将本品放在儿童不能接触的地方。<br>11.如正在使用其他药品，使用本品前请咨询医师或药师。</p>', 'admin');
INSERT INTO `yaopin` VALUES ('7', '2101121629551', '京都念慈菴蜜炼川贝枇杷膏', '/upload/bc635a058c5515b7e18132353f011292.png', '1', '29.00', '100', '30', '<p>蜜炼川贝枇杷膏，中成药名。由川贝母、枇杷叶、桔梗、陈皮、水半夏、北沙参、五味子、款冬花、杏仁水、薄荷脑组成。具有清热润肺，止咳平喘，理气化痰的功效。用于肺燥之咳嗽，痰多，胸闷，咽喉痛痒，声音沙哑</p>\n<h2 class=\"title-text\">性状</h2>\n<p>本品为棕红色的稠厚半流体；气香，味甜，具清凉感</p>\n<h2 class=\"title-text\">主要功效</h2>\n<p>清热润肺，止咳平喘，理气化痰</p>\n<h2 class=\"title-text\">主要成分</h2>\n<p>川贝母、枇杷叶、桔梗、陈皮、水半夏、北沙参、五味子、款冬花、杏仁水、薄荷脑。辅料为蔗糖、蜂蜜</p>\n<h2 class=\"title-text\">注意事项</h2>\n<div class=\"para\">1、忌食辛辣、油腻食物。</div>\n<div class=\"para\">2、本品适用于肺燥咳嗽，其表现为干咳，咽喉疼痛，鼻唇干燥，痰少而质粘，不易咯出。</div>\n<div class=\"para\">3、支气管扩张、肺脓疡、肺心病、肺结核患者出现咳嗽时应去医院就诊。</div>\n<div class=\"para\">4、有高血压、心脏病、肝病、糖尿病、肾病等慢性病患者应在医师指导下服用。</div>\n<div class=\"para\">5、儿童、孕妇、年老体弱者慎用，并应在医师指导下服用。</div>\n<div class=\"para\">6、服药期间，若患者出现高热，体温超过38℃，或出现喘促气急者，或咳嗽加重、痰量明显增多者应到医院就诊。</div>\n<div class=\"para\">7、服用7天症状无缓解，应去医院就诊。</div>\n<div class=\"para\">8、严格按用法用量服用，本品不宜长期服用。</div>\n<div class=\"para\">9、对本品过敏者禁用，过敏体质者慎用。</div>\n<div class=\"para\">10、本品性状发生改变时禁止使用。</div>\n<div class=\"para\">11、儿童必须在成人监护下使用。</div>\n<div class=\"para\">12、请将本品放在儿童不能接触的地方。</div>\n<div class=\"para\">13、如正在使用其他药品，使用本品前请咨询医师或药师</div>', 'admin');
INSERT INTO `yaopin` VALUES ('8', '2101121633371', '江中健胃消食片', '/upload/cf8509cd034b4a7c16c8a5973faea864.png', '2', '19.00', '98', '25', '<p>与<a href=\"https://baike.baidu.com/item/%E5%90%97%E5%8F%AE%E5%95%89/2003842\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"2003842\">吗叮啉</a>、<a href=\"https://baike.baidu.com/item/%E6%B6%88%E5%8C%96%E9%85%B6/5269996\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"5269996\">消化酶</a>相比，健胃消食片为“<a href=\"https://baike.baidu.com/item/%E4%B8%AD%E6%88%90%E8%8D%AF/1523711\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"1523711\">中成药</a>”,且成分均由卫生部批准的“药食同源”中药配伍。在该药的成分中，山楂、麦芽为消食导滞药，太子参、山药为健胃益气药，陈皮为理气导滞药。而与吗叮啉相比，健胃消食片与消化酶均为“咀嚼片”,方便食用。健胃消食片为“国家中药保护品种”,2002年以前，全国共有<a href=\"https://baike.baidu.com/item/%E6%B1%9F%E4%B8%AD%E9%9B%86%E5%9B%A2/6669030\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"6669030\">江中集团</a>、<a href=\"https://baike.baidu.com/item/%E6%AD%A6%E6%B1%89%E5%81%A5%E6%B0%91/8744048\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"8744048\">武汉健民</a>、东阿阿胶、宛西制药等8家药厂生产。其中，江中集团以1亿多元的销量成为该品类的代表品牌</p>\n<h2 class=\"title-text\">产品性状</h2>\n<p>本产品为淡棕黄色的片或薄膜糖衣片，也可为异形片，薄膜衣片除去包衣后显淡棕黄色；气略香，味微甜、酸。</p>\n<h2 class=\"title-text\">服用方法</h2>\n<p>口服，可以咀嚼。每次3片，每日3次 。小儿酌减</p>\n<h2 class=\"title-text\">作用机理</h2>\n<p><a href=\"https://baike.baidu.com/item/%E5%B1%B1%E6%A5%82/200032\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"200032\">山楂</a>、麦芽消食化积，主治消化不良、不思饮食、脘腹胀闷等症； 陈皮行气导滞，具有运脾健胃之功效；<a href=\"https://baike.baidu.com/item/%E5%A4%AA%E5%AD%90%E5%8F%82/708747\" target=\"_blank\" rel=\"noopener\" data-lemmaid=\"708747\">太子参</a>、淮山药可健脾益气， 补而不燥，主治脾胃虚弱，食少倦怠等症</p>\n<h2 class=\"title-text\">产品特点</h2>\n<p>江中牌健胃消食片所选用的成份都是国家批准的药食两用原料，因此 非常适合日常使用。 1995年，健胃消食片被列入国家中药保护品种；1999年，健胃消食 片被列入第一批甲类OTC药；2003年，因其确切的效果和安全副作 用小，列入国家乙类OTC药。</p>', 'admin');

-- ----------------------------
-- Table structure for `yisheng`
-- ----------------------------
DROP TABLE IF EXISTS `yisheng`;
CREATE TABLE `yisheng` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `mima` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `zhicheng` varchar(50) NOT NULL DEFAULT '' COMMENT '职称',
  `youxiang` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `shouji` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `zhaopian` varchar(255) NOT NULL DEFAULT '' COMMENT '照片',
  `jianjie` longtext NOT NULL COMMENT '简介',
  `openid` varchar(50) NOT NULL DEFAULT '' COMMENT 'openid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='医生';

-- ----------------------------
-- Records of yisheng
-- ----------------------------
INSERT INTO `yisheng` VALUES ('1', '111', '111', '李晓冬', '副主任医师', '123456@qq.com', '13700137011', 'upload/d3306f43fa3d5fbb6e6254050628432a.png', '<p>李晓冬，深圳市罗湖区人民医院，消化内科，副主任医师，擅长消化内科常见疾病，尤其消化性溃疡、慢性胃炎、胃癌的诊治。</p>', '');
INSERT INTO `yisheng` VALUES ('2', '222', '222', '吴进峰', '副主任医师', '123457@qq.com', '13700137022', 'upload/07255509007b01cbfde4dbd9465473cb.png', '<p>医学博士，副主任医师，擅长胃肠及肝胆胰疾病的诊治，尤其是胆道结石、消化性溃疡、消化道出血、炎症性肠病、急慢性胰腺炎、肝炎、肝硬化等疾病的诊治。熟练掌握胃肠镜、胶囊内镜检查及胃肠息肉切除、消化道出血内镜下止血、ERCP等技术。</p>', '');
INSERT INTO `yisheng` VALUES ('3', '333', '333', '卢先红', '医师', '123458@qq.com', '13700137033', 'upload/c5a4e7b98ea85107531f8fbafd367b41.png', '<p>2011年毕业于中山大学中山医学院，2011-2014年于中山医系统参加内科住院医师规范化培训。坚持以病人为中心，应用生物、心理、社会新的医疗模式，全面综合分析诊治，全心全意为病人服务。</p>', '');
INSERT INTO `yisheng` VALUES ('4', '444', '444', '王红芳', '医师', '1234589@qq.com', '13700137044', 'upload/e22537ba6c3ee06065471e2bdec0e484.png', '<p>1993-1998年承德医学院临床医学系学士毕业，2005年取得硕士研究生学厉，从事临床医疗工作17年。</p>', '');
INSERT INTO `yisheng` VALUES ('5', '555', '555', '李海军', '主任医师', '1234565@qq.com', '13700137055', 'upload/6e5618ee78999ba1a4d724fe2c663fe9.png', '<p>医学博士、主任医师，教授、博导，中国医师协会胆道外科委员会委员、《中华实验外科杂志》特约编委和《中华现代临床医学杂志》常务编委。 精通普外科尤其是胃肠、肝胆胰外科疾病的诊断、手术、化疗、微创治疗、靶向治疗等。熟练完成左/右三叶肝叶切除术、左/右半肝切除术，肝中叶切除术、肝尾叶切除术、胆囊癌根治术，高位肝门部胆管癌根治术、中下段胆管癌根治术；胰腺癌根治术，胰腺内分泌肿瘤切除术、胰腺中段切除术等复杂的肝胆胰外科的手术。常规开展各种微创手术，如腹腔镜胃癌根治术、腹腔镜结直肠癌根治术、腹腔镜胆道镜联合胆总管取石术、腹腔镜部分肝切除术腹腔镜胰腺体尾部良恶性肿瘤切除术、腹腔镜脾脏切除术、甲状腺及肝脏肿瘤的微波消融术、无水酒精注射治疗、PTCD等。 曾担任外科学教研室主任，培养博士研究生1名、硕士研究生10名。参编肿瘤学教材3本，主持承担课题5项，其中国家自然基金1项，省级项目4项。发表核心期刊论文40余篇。</p>', '');
INSERT INTO `yisheng` VALUES ('6', '666', '666', '陈旭辉', ' 副主任医师', '1236445@qq.com', '13700137066', 'upload/19544b4e2db4aa1c843ab5c84eab984a.png', '<p>毕业于中山医科大学临床医学专业。从事普外科临床及教学教学工作多年，有丰富的临床经验。近年来致力于外科疾患的微创治疗，并积累了较丰富的临床经验。对普外科危重疾病、疑难病例有较丰富的诊断及治疗经验。2012年至2014年在美国密苏里Ellis Fischel Cancer Center访问学习。在全国知名专业杂志发表论文多篇。</p>', '');
INSERT INTO `yisheng` VALUES ('7', '777', '777', '龙隽', '副主任医师', '1234435@qq.com', '13700137077', 'upload/d709aff3c4a8b6cbf3249aaa3d6fb5fe.png', '<p>1991毕业于湖北省咸宁医学院医疗系，从事妇产科临床工作20多年，积累了较丰富的临床经验。现为妇产科副主任医师，对产科高危妊娠的识别、管理及临床处理有一定的经验，对产科急危重症的处理亦有一定的临床经验。参与省、市课题两项，承担区课题两项。</p>', '');
INSERT INTO `yisheng` VALUES ('8', '888', '888', '雷厉秀', '副主任医师', '1235745@qq.com', '13700137088', 'upload/11f66dafd534ea25d611654c944d754a.png', '<p>毕业于南华大学研究生学院，妇产科副主任医师。从事妇产科专业20年，在妇产科领域，有扎实的理论基础及较丰富的临床经验，擅长妊娠合并症及并发症的诊治，对产科营养学有一定研究和认识。在《中华妇产科杂志》等国家核心期刊发表论文多篇。</p>', '');

-- ----------------------------
-- Table structure for `yonghu`
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `mima` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `xingbie` varchar(10) NOT NULL DEFAULT '' COMMENT '性别',
  `shouji` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `jifen` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '积分',
  `shenfenzhenghao` varchar(50) NOT NULL DEFAULT '' COMMENT '身份证号',
  `shengao` varchar(50) NOT NULL DEFAULT '' COMMENT '身高',
  `tizhong` varchar(50) NOT NULL DEFAULT '' COMMENT '体重',
  `hunyinzhuangkuang` varchar(50) NOT NULL DEFAULT '' COMMENT '婚姻状况',
  `minzu` varchar(50) NOT NULL DEFAULT '' COMMENT '民族',
  `xianbingshi` varchar(50) NOT NULL DEFAULT '' COMMENT '现病史',
  `jiwangbingshi` varchar(50) NOT NULL DEFAULT '' COMMENT '既往病史',
  `jiazubingshi` varchar(50) NOT NULL DEFAULT '' COMMENT '家族病史',
  `touxiang` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES ('1', '001', '001', '张三', '女', '13700137001', '20.00', '430511196412112660', '170', '100', '未婚', '汉族', '无', '无', '无', 'upload/e3cd201518cc08f9e04c07dabc1b1310.png');
INSERT INTO `yonghu` VALUES ('2', '002', '002', '李四', '女', '13700137002', '0.00', '430421198405237082', '165', '102', '未婚', '汉族', '无', '无', '无', 'upload/752a1b5e3b53c280e6d24e3f5befc19b.png');
INSERT INTO `yonghu` VALUES ('3', '003', '003', '王五', '女', '13700137003', '0.00', '411281197704185460', '172', '105', '未婚', '汉族', '无', '无', '无', 'upload/d6a62ae94f60adf3c67ad0f232ce92b7.png');
INSERT INTO `yonghu` VALUES ('4', '006', '006', '李可', '女', '13700137006', '20.00', '310230196902143721', '172', '100', '未婚', '汉族', '无', '无', '无', '/upload/d93242172829fd3ea147c18d121d8fd7.png');

-- ----------------------------
-- Table structure for `yuyueguahao`
-- ----------------------------
DROP TABLE IF EXISTS `yuyueguahao`;
CREATE TABLE `yuyueguahao` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paibanid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排班id',
  `yishengid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '医生id',
  `zhanghao` varchar(50) NOT NULL DEFAULT '' COMMENT '账号',
  `xingming` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `zhicheng` varchar(50) NOT NULL DEFAULT '' COMMENT '职称',
  `shijianyuyue` varchar(25) NOT NULL DEFAULT '' COMMENT '时间预约',
  `huanzhexingming` varchar(50) NOT NULL DEFAULT '' COMMENT '患者姓名',
  `nianling` int(11) NOT NULL DEFAULT '0' COMMENT '年龄',
  `shouji` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `beizhu` text NOT NULL COMMENT '备注',
  `guahaoren` varchar(50) NOT NULL DEFAULT '' COMMENT '挂号人',
  `zhuangtai` varchar(50) NOT NULL DEFAULT '' COMMENT '状态',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '挂号时间',
  PRIMARY KEY (`id`),
  KEY `yuyueguahao_paibanid_index` (`paibanid`),
  KEY `yuyueguahao_yishengid_index` (`yishengid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='预约挂号';

-- ----------------------------
-- Records of yuyueguahao
-- ----------------------------
INSERT INTO `yuyueguahao` VALUES ('1', '1', '8', '888', '雷厉秀', '副主任医师', '2025-03-01 00:13:19', '张三', '23', '13700137001', '方式发生大发送到', '001', '已开处方', '2025-03-01 00:13:26');
INSERT INTO `yuyueguahao` VALUES ('2', '1', '8', '888', '雷厉秀', '副主任医师', '2025-03-01 13:59:02', '李可', '26', '13700137006', '城标枯荣', '006', '已开处方', '2025-03-01 13:59:09');
