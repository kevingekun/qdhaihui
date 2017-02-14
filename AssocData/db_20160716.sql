-- phpMyAdmin SQL Dump
-- version 4.4.15.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2016-07-16 09:38:31
-- 服务器版本： 5.6.29-log
-- PHP Version: 7.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jvyoujia.startsrun.com`
--

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_booking_action`
--

CREATE TABLE IF NOT EXISTS `hx_activity_booking_action` (
  `act_id` mediumint(8) unsigned NOT NULL COMMENT '活动id',
  `act_image` varchar(60) NOT NULL COMMENT '活动图片',
  `act_name` varchar(255) NOT NULL COMMENT '活动名称',
  `act_desc` text NOT NULL COMMENT '活动描述',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `is_finished` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否完成 0-预约 1-购买 2-结束',
  `price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '预售价格',
  `start_time` int(10) DEFAULT '0' COMMENT '正式售卖时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_booking_bespoke`
--

CREATE TABLE IF NOT EXISTS `hx_activity_booking_bespoke` (
  `id` int(10) unsigned NOT NULL,
  `act_id` mediumint(8) unsigned NOT NULL COMMENT '活动id',
  `openid` varchar(40) NOT NULL COMMENT '微信号唯一标识',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `mobile` varchar(11) NOT NULL DEFAULT '0' COMMENT '手机号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '预约时间',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_activity_booking_bespoke`
--

INSERT INTO `hx_activity_booking_bespoke` (`id`, `act_id`, `openid`, `name`, `mobile`, `create_time`, `goods_id`) VALUES
(1, 9, 'ov9ijuEglrC9oFtPsxW7jEv6q6iQ', '测试', '15318776618', 1453183062, 15),
(2, 9, 'ov9ijuGP0Imo3dNfLCnW4JzHyO8I', '闫怀堂', '15888838788', 1453187662, 15),
(3, 9, 'ov9ijuIwPyb3MH8jXyo-71sRb4Fk', '高仁华', '15318776618', 1453188768, 15);

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_group_action`
--

CREATE TABLE IF NOT EXISTS `hx_activity_group_action` (
  `act_id` mediumint(8) unsigned NOT NULL COMMENT '活动id',
  `act_image` varchar(60) NOT NULL COMMENT '活动图片',
  `act_name` varchar(255) NOT NULL COMMENT '活动名称',
  `goods_tags` varchar(200) NOT NULL COMMENT '商品标签',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截止日期',
  `act_desc` text NOT NULL COMMENT '活动描述',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `is_finished` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否完成 0-预约 1-购买 2-结束',
  `ext_info` text NOT NULL COMMENT '附加信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_group_bespoke`
--

CREATE TABLE IF NOT EXISTS `hx_activity_group_bespoke` (
  `id` int(10) unsigned NOT NULL,
  `act_id` mediumint(8) unsigned NOT NULL COMMENT '活动id',
  `openid` varchar(40) NOT NULL COMMENT '微信号唯一标识',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `mobile` varchar(11) NOT NULL DEFAULT '0' COMMENT '手机号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '预约时间',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '商品id'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_activity_group_bespoke`
--

INSERT INTO `hx_activity_group_bespoke` (`id`, `act_id`, `openid`, `name`, `mobile`, `create_time`, `goods_id`) VALUES
(1, 7, 'ov9ijuEglrC9oFtPsxW7jEv6q6iQ', '高仁华', '15318776618', 1453171006, 13),
(2, 7, 'ov9ijuBH3_8Q-fnf4an-678sEowc', '龙', '13173173323', 1453171111, 13),
(3, 7, 'ov9ijuIwPyb3MH8jXyo-71sRb4Fk', '高仁华', '18554851121', 1453171279, 13),
(4, 7, 'ov9ijuFR1WWdYpHJM5UdclWg3xuA', '', '0', 1453187384, 13),
(5, 7, 'ov9ijuGP0Imo3dNfLCnW4JzHyO8I', '闫怀堂', '15888838788', 1453187755, 13),
(6, 7, 'ov9ijuIdRGc9IV2_dHLPPOAzCnNM', '', '0', 1453190788, 13);

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_menu`
--

CREATE TABLE IF NOT EXISTS `hx_activity_menu` (
  `id` int(10) unsigned NOT NULL,
  `created_by` int(10) NOT NULL COMMENT '创建人id',
  `modified_by` int(10) NOT NULL COMMENT '菜单更改人id',
  `item_id` int(3) NOT NULL COMMENT '菜单项表中的id',
  `priority` int(1) NOT NULL COMMENT '菜单项位置，数值越大位置越靠上',
  `created_at` int(10) NOT NULL,
  `updated_at` int(10) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_menu_item`
--

CREATE TABLE IF NOT EXISTS `hx_activity_menu_item` (
  `id` int(3) unsigned NOT NULL,
  `title` varchar(16) NOT NULL,
  `url` varchar(512) NOT NULL COMMENT '菜单项链接'
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_activity_menu_item`
--

INSERT INTO `hx_activity_menu_item` (`id`, `title`, `url`) VALUES
(1, '秒杀', 'http://himall.hisense.com/mall/Index/seckill'),
(2, '优惠劵', 'http://himall.hisense.com/mall/Ucenter/coupon'),
(3, '预售', 'http://himall.hisense.com/Mall/Activity/booking.html'),
(4, '团购', 'http://himall.hisense.com/Mall/Activity/group.html');

-- --------------------------------------------------------

--
-- 表的结构 `hx_activity_seckill_action`
--

CREATE TABLE IF NOT EXISTS `hx_activity_seckill_action` (
  `action_id` int(11) unsigned NOT NULL,
  `action_name` varchar(20) NOT NULL COMMENT '活动名称',
  `action_header_img` text NOT NULL COMMENT '活动头部图片',
  `action_key` varchar(50) NOT NULL COMMENT '活动key',
  `action_sdate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动开始时间',
  `action_edate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '活动结束时间',
  `second_sdate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二阶段秒杀开始时间',
  `second_edate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二阶段秒杀结束时间',
  `third_sdate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '三阶段秒杀开始时间',
  `third_edate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '三阶段秒杀结束时间',
  `rand_min_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最小分享时间',
  `rand_max_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最大分享时间',
  `reply_pic` text NOT NULL COMMENT '活动图片',
  `action_token` varchar(50) NOT NULL COMMENT '活动发起人',
  `action_rule` text NOT NULL COMMENT '活动规则',
  `action_open` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '秒杀活动状态: 0-开启, 1-关闭',
  `reply_title` varchar(20) NOT NULL COMMENT '回复标题',
  `reply_content` varchar(200) NOT NULL COMMENT '回复简介',
  `reply_keyword` varchar(50) NOT NULL COMMENT '关键词',
  `action_is_reg` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否需要粉丝信息: 1-是, 0-否',
  `action_is_attention` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '未关注是否可以参与: 1-是, 0-否',
  `goods_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '秒杀商品id',
  `seckill_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '秒杀价格',
  `seckill_nums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '秒杀商品的数量'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_article`
--

CREATE TABLE IF NOT EXISTS `hx_article` (
  `id` tinyint(2) unsigned NOT NULL COMMENT '文章id',
  `type` varchar(20) NOT NULL COMMENT '文章标识',
  `content` text NOT NULL COMMENT '文章内容',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_article`
--

INSERT INTO `hx_article` (`id`, `type`, `content`, `create_time`) VALUES
(1, '合作人协议', '&lt;p&gt;的&lt;/p&gt;', 1458283651),
(3, '', '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_attribute`
--

CREATE TABLE IF NOT EXISTS `hx_attribute` (
  `id` smallint(5) unsigned NOT NULL,
  `type` varchar(40) NOT NULL COMMENT '类别(英文表示)',
  `title` varchar(20) NOT NULL COMMENT '名称',
  `value` varchar(255) NOT NULL COMMENT '值',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '开启状态: 0-开启, 1-关闭',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序, 越大越靠前'
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_attribute`
--

INSERT INTO `hx_attribute` (`id`, `type`, `title`, `value`, `status`, `sort`) VALUES
(1, 'label', '少校', '', 0, 0),
(2, 'label', '中校', '', 0, 0),
(3, 'label', '大校', '', 0, 0),
(4, 'label', '少将', '', 0, 0),
(5, 'label', '中将', '', 0, 0),
(6, 'label', '上将', '', 0, 0),
(7, 'group', '青铜合伙人', '', 0, 0),
(8, 'group', '白银合伙人', '', 0, 0),
(9, 'group', '黄金合伙人', '', 0, 0),
(10, 'group', '钻石合伙人', '', 0, 0),
(11, 'partner_rule', '成为合伙人规则', '{"dateline":"2016-03-03","amount":"0"}', 0, 0),
(12, 'commission_spread', '推广佣金设置', '{"spread":1,"withdraw":10}', 0, 0),
(13, 'commission_sale', '销售提成设置', '{"sale":10}', 0, 0),
(14, 'stock', '库存预警', '10', 0, 0),
(15, 'help_category', '常见问题', '活动规则、购买流程等', 0, 0),
(16, 'help_category', '账户问题', '注册、联系方式等', 0, 0),
(17, 'help_category', '订单问题', '下单收货、退货维权', 0, 0),
(18, 'help_category', '支付问题', '微信支付、支付凭证等', 0, 0),
(19, 'goods_group', '儿童组', '1', 0, 0),
(20, 'goods_group', '少年组', '2', 0, 0),
(21, 'goods_group', '青年组', '3', 0, 0),
(22, 'goods_group', '中年组', '400', 0, 0),
(23, 'follow_url', '关注链接', 'http://mp.weixin.qq.com/s?__biz=MzA3MDU5NTY5MQ==&mid=234041258&idx=1&sn=b33a935cbdb1ca2d6972c1bddd468971', 0, 0),
(24, 'close_mall', '关闭开启商城', '0', 0, 0),
(25, 'close_pay', '关闭开启支付', '0', 0, 0),
(26, 'partner_tag', '合伙人标签', '黄金合伙人', 0, 0),
(27, 'partner_tag', '合伙人标签', '钻石合伙人', 0, 0),
(29, 'partner_group', '合伙人分组', '潜水族', 0, 0),
(30, 'partner_group', '合伙人分组', '活跃族', 0, 0),
(31, 'commission_top', '顶级合伙人佣金比例', '9', 0, 0),
(32, 'commission_second', '二级合伙人佣金比例', '9', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_auth_access`
--

CREATE TABLE IF NOT EXISTS `hx_auth_access` (
  `role_id` smallint(6) unsigned NOT NULL,
  `node_id` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) NOT NULL,
  `module` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_auth_access`
--

INSERT INTO `hx_auth_access` (`role_id`, `node_id`, `level`, `module`) VALUES
(3, 62, 3, NULL),
(3, 61, 3, NULL),
(3, 60, 3, NULL),
(3, 59, 3, NULL),
(3, 58, 3, NULL),
(3, 57, 3, NULL),
(3, 56, 3, NULL),
(3, 55, 2, NULL),
(3, 3, 3, NULL),
(3, 2, 2, NULL),
(3, 1, 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `hx_auth_node`
--

CREATE TABLE IF NOT EXISTS `hx_auth_node` (
  `id` smallint(6) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `sort` smallint(6) unsigned DEFAULT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_auth_node`
--

INSERT INTO `hx_auth_node` (`id`, `name`, `title`, `status`, `remark`, `sort`, `pid`, `level`) VALUES
(1, 'Admin', '后台管理', 1, NULL, NULL, 0, 1),
(2, 'Index', '首页', 1, NULL, NULL, 1, 2),
(3, 'index', '首页', 1, NULL, NULL, 2, 3),
(4, 'Activity', '活动', 1, NULL, NULL, 1, 2),
(5, 'couponlist', '优惠券列表', 1, NULL, NULL, 4, 3),
(6, 'couponstop', '停止优惠券', 1, NULL, NULL, 4, 3),
(7, 'couponadd', '添加优惠券', 1, NULL, NULL, 4, 3),
(8, 'couponDetails', '优惠券详情', 1, NULL, NULL, 4, 3),
(9, 'Commission', '佣金', 1, NULL, NULL, 1, 2),
(10, 'index', '佣金首页', 1, NULL, NULL, 9, 3),
(11, 'partner', '合伙人销售佣金统计', 1, NULL, NULL, 9, 3),
(12, 'change', '调整佣金记录', 1, NULL, NULL, 9, 3),
(13, 'setting_sale', '设置销售提成', 1, NULL, NULL, 9, 3),
(14, 'setting_spread', '设置推广佣金', 1, NULL, NULL, 9, 3),
(15, 'checkList', '佣金发放审核', 1, NULL, NULL, 9, 3),
(16, 'fileList', '文件审核列表', 1, NULL, NULL, 9, 3),
(17, 'fileDetail', '文件详情', 1, NULL, NULL, 9, 3),
(18, 'fileDel', '删除文件', 1, NULL, NULL, 9, 3),
(19, 'fileCheck', '文件审核', 1, NULL, NULL, 9, 3),
(20, 'Goods', '商品', 1, NULL, NULL, 1, 2),
(21, 'index', '商品列表', 1, NULL, NULL, 20, 3),
(22, 'addGoods', '添加商品 ', 1, NULL, NULL, 20, 3),
(23, 'updateGoods', '修改商品', 1, NULL, NULL, 20, 3),
(24, 'delGood', '删除商品', 1, NULL, NULL, 20, 3),
(25, 'toTop', '置顶商品', 1, NULL, NULL, 20, 3),
(26, 'offsetTheShelf', '下架商品', 1, NULL, NULL, 20, 3),
(27, 'delFile', '删除图片', 1, NULL, NULL, 20, 3),
(28, 'updateBanner', '修改商品banner图', 1, NULL, NULL, 20, 3),
(29, 'Help', '常见问题', 1, NULL, NULL, 1, 2),
(30, 'index', '问题列表', 1, NULL, NULL, 29, 3),
(31, 'edit', '添加修改', 1, NULL, NULL, 29, 3),
(32, 'del', '删除问题', 1, NULL, NULL, 29, 3),
(33, 'Logistics', '物流', 1, NULL, NULL, 1, 2),
(34, 'index', '物流信息列表', 1, NULL, NULL, 33, 3),
(35, 'manual', '手动标记发货', 1, NULL, NULL, 33, 3),
(36, 'payComplete', '手动标记付款', 1, NULL, NULL, 33, 3),
(37, 'MallMenu', '商品分类', 1, NULL, NULL, 1, 2),
(38, 'index', '分类列表', 1, NULL, NULL, 37, 3),
(39, 'addMenu', '添加菜单', 1, NULL, NULL, 38, 3),
(40, 'updateMenu', '修改菜单', 1, NULL, NULL, 38, 3),
(41, 'delMenu', '删除菜单', 1, NULL, NULL, 38, 3),
(42, 'MallSetting', 'Banner设置', 1, NULL, NULL, 1, 2),
(43, 'bannerList', '列表', 1, NULL, NULL, 42, 3),
(44, 'addBanner', '添加', 1, NULL, NULL, 42, 3),
(45, 'updateBanner', '修改', 1, NULL, NULL, 42, 3),
(46, 'delBanner', '删除', 1, NULL, NULL, 42, 3),
(47, 'pushToHome', '推送至首页', 1, NULL, NULL, 42, 3),
(48, 'Orders', '订单', 1, NULL, NULL, 1, 2),
(49, 'index', '订单列表', 1, NULL, NULL, 48, 3),
(50, 'orderDetails', '订单详情', 1, NULL, NULL, 48, 3),
(51, 'del', '删除订单', 1, NULL, NULL, 48, 3),
(52, 'publish', '订单发货', 1, NULL, NULL, 48, 3),
(53, 'addRemarks', '添加备注', 1, NULL, NULL, 48, 3),
(54, 'updatePrice', '修改价格', 1, NULL, NULL, 48, 3),
(55, 'Partner', '合伙人', 1, NULL, NULL, 1, 2),
(56, 'index', '合伙人列表', 1, NULL, NULL, 55, 3),
(57, 'editPartner', '修改合伙人', 1, NULL, NULL, 55, 3),
(58, 'fans', '粉丝列表', 1, NULL, NULL, 55, 3),
(59, 'rule', '合伙人规则设置', 1, NULL, NULL, 55, 3),
(60, 'audit', '审核列表', 1, NULL, NULL, 55, 3),
(61, 'check', '审核操作', 1, NULL, NULL, 55, 3),
(62, 'label', '自定义标签', 1, NULL, NULL, 55, 3),
(63, 'Rbac', '权限控制', 1, NULL, NULL, 1, 2),
(64, 'userList', '用户列表', 1, NULL, NULL, 63, 3),
(65, 'addUser', '添加用户', 1, NULL, NULL, 63, 3),
(66, 'upUser', '修改用户', 1, NULL, NULL, 63, 3),
(67, 'delUser', '删除用户', 1, NULL, NULL, 63, 3),
(68, 'roleList', '角色列表', 1, NULL, NULL, 63, 3),
(69, 'addRole', '添加角色', 1, NULL, NULL, 63, 3),
(70, 'upRole', '修改角色', 1, NULL, NULL, 63, 3),
(71, 'giveAuth', '设置权限', 1, NULL, NULL, 63, 3),
(72, 'delRole', '删除角色', 1, NULL, NULL, 63, 3),
(73, 'nodeList', '节点列表', 1, NULL, NULL, 63, 3),
(74, 'addNode', '添加节点', 1, NULL, NULL, 63, 3),
(75, 'upNode', '修改节点', 1, NULL, NULL, 63, 3),
(76, 'delNode', '删除节点', 1, NULL, NULL, 63, 3),
(77, 'Refund', '退款', 1, NULL, NULL, 1, 2),
(78, 'index', '退款列表', 1, NULL, NULL, 77, 3),
(79, 'detail', '退款详情', 1, NULL, NULL, 77, 3),
(80, 'prove', '退款审核', 1, NULL, NULL, 77, 3),
(81, 'del', '删除退款', 1, NULL, NULL, 77, 3),
(82, 'User', '会员管理', 1, NULL, NULL, 1, 2),
(83, 'index', '会员列表', 1, NULL, NULL, 82, 3),
(84, 'edit', '修改会员', 1, NULL, NULL, 82, 3),
(85, 'del', '删除会员', 1, NULL, NULL, 82, 3),
(86, 'Workcard', '售后服务', 1, NULL, NULL, 1, 2),
(87, 'prove', '审核', 1, NULL, NULL, 86, 3),
(88, 'del', '删除', 1, NULL, NULL, 86, 3),
(89, 'WxMenu', '微信菜单', 1, NULL, NULL, 1, 2),
(90, 'index', '菜单配置', 1, NULL, NULL, 89, 3),
(91, 'class_add', '添加菜单', 1, NULL, NULL, 89, 3),
(92, 'class_del', '删除菜单', 1, NULL, NULL, 89, 3),
(93, 'class_edit', '修改菜单', 1, NULL, NULL, 89, 3),
(94, 'class_send', '菜单生效', 1, NULL, NULL, 89, 3),
(95, 'seckill', '秒杀活动列表', 1, NULL, NULL, 4, 3),
(96, 'seckillAdd', '添加秒杀活动', 1, NULL, NULL, 4, 3),
(97, 'seckillDel', '删除秒杀', 1, NULL, NULL, 4, 3),
(98, 'groupList', '团购活动列表', 1, NULL, NULL, 4, 3),
(99, 'addGroupGoods', '添加/编辑团购活动', 1, NULL, NULL, 4, 3),
(100, 'delGroup', '删除团购活动', 1, NULL, NULL, 4, 3),
(101, 'showDepositNums', '查看团购预约人数', 1, NULL, NULL, 4, 3),
(102, 'bookingList', '预售活动列表', 1, NULL, NULL, 4, 3),
(103, 'addBookingGoods', '添加/编辑预售活动', 1, NULL, NULL, 4, 3),
(104, 'delBooking', '删除预售活动', 1, NULL, NULL, 4, 3),
(105, 'showBookingNums', '查看预售预约人数', 1, NULL, NULL, 4, 3),
(106, 'changePassword', '修改密码', 1, '管理员可以后台修改自己的登录密码', NULL, 63, 2),
(107, 'signFor', '设为已签收', 1, '后台手动设置物流签收', 0, 33, 3),
(108, 'setPayComplete', '设为支付', 1, '把订单设置为已支付状态', 0, 48, 3),
(109, 'Advert', '广告位管理', 1, NULL, NULL, 1, 2),
(110, 'adList', '广告列表', 1, NULL, NULL, 109, 3),
(111, 'addAdvert', '添加广告', 1, NULL, NULL, 109, 3),
(112, 'editAdvert', '修改广告', 1, NULL, NULL, 109, 3),
(113, 'delAdvert', '删除广告', 1, NULL, NULL, 109, 3),
(114, 'topToAdvert', '启用禁用', 1, NULL, NULL, 109, 3);

-- --------------------------------------------------------

--
-- 表的结构 `hx_auth_role`
--

CREATE TABLE IF NOT EXISTS `hx_auth_role` (
  `id` smallint(6) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `pid` smallint(6) DEFAULT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_auth_role`
--

INSERT INTO `hx_auth_role` (`id`, `name`, `pid`, `status`, `remark`) VALUES
(3, '副管理', NULL, 1, '增查改删');

-- --------------------------------------------------------

--
-- 表的结构 `hx_auth_user`
--

CREATE TABLE IF NOT EXISTS `hx_auth_user` (
  `user_id` mediumint(8) unsigned NOT NULL,
  `fid` mediumint(8) unsigned NOT NULL,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `nickname` char(20) NOT NULL,
  `regdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastdate` int(10) unsigned NOT NULL DEFAULT '0',
  `regip` char(15) NOT NULL DEFAULT '',
  `lastip` char(15) NOT NULL DEFAULT '',
  `loginnum` smallint(5) unsigned NOT NULL DEFAULT '0',
  `email` char(32) NOT NULL DEFAULT '',
  `message` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `islock` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `vip` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `overduedate` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` char(11) NOT NULL DEFAULT '',
  `role_id` mediumint(8) NOT NULL DEFAULT '0' COMMENT '角色id'
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

--
-- 转存表中的数据 `hx_auth_user`
--

INSERT INTO `hx_auth_user` (`user_id`, `fid`, `username`, `password`, `nickname`, `regdate`, `lastdate`, `regip`, `lastip`, `loginnum`, `email`, `message`, `islock`, `vip`, `overduedate`, `mobile`, `role_id`) VALUES
(7, 0, 'admin', '4e4b792b68432d7035ff8ac86dfa1629', 'gaorenhua', 1444826229, 1449546031, '127.0.0.1', '172.16.13.184', 245, '597170962@qq.com', 0, 0, 0, 0, '15318776618', 0),
(11, 0, 'yanhuaitang', '94ce4b44b40eaca8d21aba6c6fdd77d3', '闫怀堂', 1449563886, 0, '58.56.178.142', '', 0, '468012316@qq.com', 0, 0, 0, 0, '15288838788', 3),
(12, 0, 'guanli', 'aa46613f4a470bc4c7a4c2b13d04e9dd', 'guanli', 1449799568, 0, '172.16.2.101', '', 0, 'caojie@hisense.com', 0, 0, 0, 0, '15954257300', 3),
(13, 0, 'chenyaodong', 'd06071fc526ea031bdff560b486b1696', '水煮鱼', 1451013939, 0, '172.16.5.130', '', 0, 'chenyaodong@hisense.com', 0, 0, 0, 0, '18561889141', 3);

-- --------------------------------------------------------

--
-- 表的结构 `hx_code_telephone`
--

CREATE TABLE IF NOT EXISTS `hx_code_telephone` (
  `id` int(10) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL,
  `code_style` varchar(30) NOT NULL DEFAULT '0' COMMENT '1-注册 2-修改密码',
  `telephone` varchar(11) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `code` char(6) NOT NULL,
  `expire_time` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_commission_file`
--

CREATE TABLE IF NOT EXISTS `hx_commission_file` (
  `id` mediumint(8) unsigned NOT NULL,
  `file_path` varchar(255) NOT NULL COMMENT '文件路径',
  `file_name` varchar(255) NOT NULL COMMENT '文件名',
  `commission_ids` text NOT NULL COMMENT '对应commission_log的id, 逗号隔开(excel中的id)',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态: 0-待审核, 1-已通过, 2-已拒绝',
  `reason` varchar(255) NOT NULL,
  `create_by` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '创建人id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `check_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '审核时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_commission_log`
--

CREATE TABLE IF NOT EXISTS `hx_commission_log` (
  `id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合伙人id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '佣金类型,  1-产品佣金, 2-销售提成, 3-推广佣金, 4-推广佣金提成, 5-激励佣金',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应订单表中的id',
  `money` int(10) NOT NULL DEFAULT '0' COMMENT '佣金金额 (单位:分)',
  `fans_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买者id',
  `desc` varchar(255) NOT NULL COMMENT '描述或理由',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态: 0-待结算, 1-待审核, 9-已结算(已发放)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `settle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结算时间',
  `relation_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联佣金的id',
  `invoice` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否开发票:0-否, 1-是'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_commission_task`
--

CREATE TABLE IF NOT EXISTS `hx_commission_task` (
  `id` mediumint(8) unsigned NOT NULL,
  `task_name` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态: 0-待结算, 1-待审核, 9-已结算(已发放)',
  `reason` varchar(255) NOT NULL,
  `create_by` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '创建人id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `check_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '审核时间'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `hx_commission_task`
--

INSERT INTO `hx_commission_task` (`id`, `task_name`, `status`, `reason`, `create_by`, `create_time`, `check_time`) VALUES
(1, '1453182756862', 0, '', 7, 1453182756, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_commission_task_data`
--

CREATE TABLE IF NOT EXISTS `hx_commission_task_data` (
  `id` int(10) unsigned NOT NULL,
  `task_id` int(10) unsigned NOT NULL DEFAULT '0',
  `commission_id` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合伙人id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '佣金类型,  1-产品佣金, 2-销售提成, 3-推广佣金, 4-推广佣金提成, 5-激励佣金',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应订单表中的id',
  `money` int(10) NOT NULL DEFAULT '0' COMMENT '佣金金额 (单位:分)',
  `fans_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买者id',
  `desc` varchar(255) NOT NULL COMMENT '描述或理由',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态: 0-待结算, 1-待审核, 9-已结算(已发放)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `settle_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结算时间',
  `relation_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联佣金的id'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_commission_task_data`
--

INSERT INTO `hx_commission_task_data` (`id`, `task_id`, `commission_id`, `uid`, `type`, `order_id`, `money`, `fans_id`, `desc`, `status`, `create_time`, `update_time`, `settle_time`, `relation_id`) VALUES
(1, 1, 1592, 2718, 1, 151, 20000, 2718, '购买商品', 0, 1453171501, 1453171501, 0, 0),
(2, 1, 1593, 2718, 1, 152, 20000, 2718, '购买商品', 0, 1453171501, 1453171501, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_ecp_base_region`
--

CREATE TABLE IF NOT EXISTS `hx_ecp_base_region` (
  `region_id` int(10) unsigned NOT NULL COMMENT '区域管理唯一标识',
  `province_code` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '省编码',
  `province_name` varchar(32) NOT NULL COMMENT '省名称',
  `city_code` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '市编码',
  `city_name` varchar(32) NOT NULL COMMENT '市名称',
  `district_code` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '区/县编码',
  `district_name` varchar(32) NOT NULL COMMENT '区/县名称',
  `region_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '区域的类型，标识区域是省、市还是区县。1:省 2:市 3:区县',
  `status` char(2) NOT NULL DEFAULT 'A' COMMENT '有效无效状态 A:有效 D:无效',
  `district_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '区/县类型 1:城区 2:郊县',
  `sap_code` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'SAP分公司编码',
  `sap_name` varchar(32) NOT NULL COMMENT 'SAP分公司名称',
  `warehouse_name` varchar(32) NOT NULL COMMENT '仓库名称',
  `warehouse_code` varchar(16) NOT NULL COMMENT '仓库代码'
) ENGINE=MyISAM AUTO_INCREMENT=77294155 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_ecp_base_region`
--

INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(101406, 130000, '河北省', 130600, '保定市', 130604, '南市区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101407, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 650204, '白碱滩区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101408, 420000, '湖北省', 420600, '襄阳市', 420601, '其它区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101409, 500000, '重庆', 500100, '重庆市', 500227, '璧山县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101410, 320000, '江苏省', 321000, '扬州市', 321003, '邗江区', 3, 'A', 1, 2663, '南通', '', ''),
(101411, 370000, '山东省', 371400, '德州市', 371422, '宁津县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(101412, 540000, '西藏自治区', 540100, '拉萨市', 540102, '城关区', 3, 'A', 1, 2636, '兰州', '', ''),
(101413, 230000, '黑龙江省', 230800, '佳木斯市', 230828, '汤原县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101414, 530000, '云南省', 530800, '普洱市', 530826, '江城哈尼族彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101415, 350000, '福建省', 350600, '漳州市', 350681, '龙海市', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101416, 420000, '湖北省', 420500, '宜昌市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(101417, 530000, '云南省', 532900, '大理白族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(101418, 340000, '安徽省', 340700, '铜陵市', 340721, '铜陵县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101419, 210000, '辽宁省', 210100, '沈阳市', 210106, '铁西区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101420, 230000, '黑龙江省', 230800, '佳木斯市', 230833, '抚远县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101421, 410000, '河南省', 410300, '洛阳市', 410301, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101422, 420000, '湖北省', 420500, '宜昌市', 420582, '当阳市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101423, 370000, '山东省', 370100, '济南市', 370103, '市中区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101424, 430000, '湖南省', 430700, '常德市', 430703, '鼎城区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101425, 340000, '安徽省', 341700, '池州市', 341701, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101426, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654226, '和布克赛尔蒙古自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101427, 520000, '贵州省', 520300, '遵义市', 520328, '湄潭县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101428, 430000, '湖南省', 431100, '永州市', 431126, '宁远县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101429, 440000, '广东省', 441800, '清远市', 441825, '连山壮族瑶族自治县', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101430, 430000, '湖南省', 431200, '怀化市', 431228, '芷江侗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101431, 410000, '河南省', 410100, '郑州市', 410184, '新郑市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101432, 630000, '青海省', 632200, '海北州', 632222, '祁连县', 3, 'A', 2, 2636, '兰州', '', ''),
(101433, 320000, '江苏省', 320900, '盐城市', 320923, '阜宁县', 3, 'A', 2, 2663, '南通', '', ''),
(101434, 440000, '广东省', 440200, '韶关市', 440204, '浈江区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101435, 370000, '山东省', 371600, '滨州市', 371601, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101436, 430000, '湖南省', 431200, '怀化市', 431281, '洪江市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101437, 510000, '四川省', 510500, '泸州市', 510502, '江阳区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(101438, 370000, '山东省', 370500, '东营市', 370521, '垦利县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(101439, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532530, '金平苗族瑶族傣族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101440, 330000, '浙江省', 330100, '杭州市', 330101, '其它区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101441, 460000, '海南省', 460100, '海口市', 460107, '琼山区', 3, 'A', 1, 2646, '海口', '', ''),
(101442, 410000, '河南省', 410900, '濮阳市', 410901, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101443, 370000, '山东省', 371100, '日照市', 371122, '莒县', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(101444, 450000, '广西壮族自治区', 451300, '来宾市', 451324, '金秀瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101445, 320000, '江苏省', 321300, '宿迁市', 321302, '宿城区', 3, 'A', 1, 2639, '徐州', '', ''),
(101446, 330000, '浙江省', 331100, '丽水市', 331101, '其它区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(101447, 350000, '福建省', 350600, '漳州市', 350627, '南靖县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101448, 630000, '青海省', 632300, '黄南藏族自治州', 632324, '河南蒙古族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101449, 510000, '四川省', 511600, '广安市', 511621, '岳池县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(101450, 430000, '湖南省', 430300, '湘潭市', 430382, '韶山市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101451, 370000, '山东省', 370200, '青岛市', 370283, '平度市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(101452, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653225, '策勒县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101453, 340000, '安徽省', 340300, '蚌埠市', 340322, '五河县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101454, 630000, '青海省', 632600, '果洛州', 632624, '达日县', 3, 'A', 2, 2636, '兰州', '', ''),
(101455, 340000, '安徽省', 340300, '蚌埠市', 340303, '蚌山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101456, 130000, '河北省', 130800, '承德市', 130826, '丰宁满族自治县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(101457, 530000, '云南省', 530100, '昆明市', 530111, '官渡区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101458, 620000, '甘肃省', 621000, '庆阳市', 621024, '合水县', 3, 'A', 2, 2636, '兰州', '', ''),
(101459, 330000, '浙江省', 331100, '丽水市', 331124, '松阳县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(101460, 210000, '辽宁省', 211200, '铁岭市', 211281, '调兵山市', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101461, 420000, '湖北省', 421100, '黄冈市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(101462, 320000, '江苏省', 320600, '南通市', 320602, '崇川区', 3, 'A', 1, 2663, '南通', '', ''),
(101463, 350000, '福建省', 350400, '三明市', 350430, '建宁县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101464, 630000, '青海省', 630100, '西宁市', 630105, '城北区', 3, 'A', 1, 2636, '兰州', '', ''),
(101465, 220000, '吉林省', 220400, '辽源市', 220401, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(101466, 410000, '河南省', 411400, '商丘市', 411401, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101467, 320000, '江苏省', 320500, '苏州市', 320503, '平江区', 3, 'A', 1, 2664, '无锡', '', ''),
(101468, 230000, '黑龙江省', 230300, '鸡西市', 230381, '虎林市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101469, 320000, '江苏省', 321300, '宿迁市', 321301, '其它区', 3, 'A', 1, 2639, '徐州', '', ''),
(101470, 140000, '山西省', 140700, '晋中市', 140722, '左权县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101471, 440000, '广东省', 440200, '韶关市', 440229, '翁源县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(101472, 370000, '山东省', 370100, '济南市', 370125, '济阳县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(101473, 130000, '河北省', 130200, '唐山市', 130227, '迁西县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(101474, 140000, '山西省', 140100, '太原市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(101475, 630000, '青海省', 632100, '海东市', 632127, '化隆回族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101476, 210000, '辽宁省', 210100, '沈阳市', 210124, '法库县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101477, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533102, '瑞丽市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101478, 370000, '山东省', 371300, '临沂市', 371327, '莒南县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(101479, 510000, '四川省', 511100, '乐山市', 511126, '夹江县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(101480, 220000, '吉林省', 220600, '白山市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101481, 130000, '河北省', 131100, '衡水市', 131121, '枣强县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101482, 410000, '河南省', 411200, '三门峡市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101483, 140000, '山西省', 140400, '长治市', 140411, '郊区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(101484, 210000, '辽宁省', 210700, '锦州市', 210702, '古塔区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101485, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(101486, 620000, '甘肃省', 620500, '天水市', 620502, '秦州区', 3, 'A', 1, 2636, '兰州', '', ''),
(101487, 320000, '江苏省', 320200, '无锡市', 320201, '其它区', 3, 'A', 1, 2664, '无锡', '', ''),
(101488, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522729, '长顺县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101489, 150000, '内蒙古自治区', 150200, '包头市', 150202, '东河区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(101490, 620000, '甘肃省', 620900, '酒泉市', 620924, '阿克塞哈萨克族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101491, 350000, '福建省', 350900, '宁德市', 350925, '周宁县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101492, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522727, '平塘县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101493, 350000, '福建省', 350800, '龙岩市', 350825, '连城县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101494, 430000, '湖南省', 430500, '邵阳市', 430503, '大祥区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101495, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653129, '伽师县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101496, 620000, '甘肃省', 620200, '嘉峪关市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101497, 610000, '陕西省', 610900, '安康市', 610925, '岚皋县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101498, 510000, '四川省', 510100, '成都市', 510108, '成华区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(101499, 630000, '青海省', 632500, '海南州', 632523, '贵德县', 3, 'A', 2, 2636, '兰州', '', ''),
(101500, 610000, '陕西省', 610800, '榆林市', 610821, '神木县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101501, 370000, '山东省', 370300, '淄博市', 370323, '沂源县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(101502, 410000, '河南省', 411400, '商丘市', 411402, '梁园区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101503, 520000, '贵州省', 520100, '贵阳市', 520111, '花溪区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101504, 510000, '四川省', 511700, '达州市', 511781, '万源市', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(101505, 230000, '黑龙江省', 231200, '绥化市', 231221, '望奎县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101506, 630000, '青海省', 632700, '玉树藏族自治州', 632723, '称多县', 3, 'A', 2, 2636, '兰州', '', ''),
(101507, 440000, '广东省', 441400, '梅州市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(101508, 320000, '江苏省', 320200, '无锡市', 320206, '惠山区', 3, 'A', 1, 2664, '无锡', '', ''),
(101509, 140000, '山西省', 140500, '晋城市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(101510, 230000, '黑龙江省', 230100, '哈尔滨市', 230125, '宾县', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101511, 410000, '河南省', 410700, '新乡市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101512, 530000, '云南省', 533300, '怒江傈僳族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(101513, 310000, '上海', 310100, '上海市', 310115, '浦东新区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(101514, 140000, '山西省', 140800, '运城市', 140824, '稷山县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101515, 620000, '甘肃省', 623000, '甘南藏族自治州', 623001, '合作市', 3, 'A', 1, 2636, '兰州', '', ''),
(101516, 410000, '河南省', 411500, '信阳市', 411525, '固始县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101517, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654023, '霍城县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101518, 420000, '湖北省', 421100, '黄冈市', 421121, '团风县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101519, 140000, '山西省', 140500, '晋城市', 140524, '陵川县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101520, 320000, '江苏省', 320800, '淮安市', 320804, '淮阴区', 3, 'A', 1, 2639, '徐州', '', ''),
(101521, 450000, '广西壮族自治区', 450300, '桂林市', 450328, '龙胜各族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101522, 450000, '广西壮族自治区', 450100, '南宁市', 450102, '兴宁区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101523, 340000, '安徽省', 340800, '安庆市', 340827, '望江县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101524, 230000, '黑龙江省', 230100, '哈尔滨市', 230126, '巴彦县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101525, 370000, '山东省', 370700, '潍坊市', 370785, '高密市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(101526, 510000, '四川省', 511800, '雅安市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(101527, 230000, '黑龙江省', 230600, '大庆市', 230601, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101528, 330000, '浙江省', 330600, '绍兴市', 330624, '新昌县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(101529, 420000, '湖北省', 420600, '襄阳市', 420625, '谷城县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101530, 320000, '江苏省', 321100, '镇江市', 321181, '丹阳市', 3, 'A', 1, 2604, '南京', '', ''),
(101531, 210000, '辽宁省', 210500, '本溪市', 210504, '明山区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101532, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654223, '沙湾县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101533, 140000, '山西省', 140100, '太原市', 140101, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(101534, 540000, '西藏自治区', 542600, '林芝地区', 542622, '工布江达县', 3, 'A', 1, 2308, '昆明', '', ''),
(101535, 410000, '河南省', 410600, '鹤壁市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101536, 440000, '广东省', 445300, '云浮市', 445301, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101537, 620000, '甘肃省', 620400, '白银市', 620402, '白银区', 3, 'A', 1, 2636, '兰州', '', ''),
(101538, 210000, '辽宁省', 210500, '本溪市', 210501, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101539, 360000, '江西省', 361000, '抚州市', 361023, '南丰县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101540, 360000, '江西省', 360100, '南昌市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(101541, 410000, '河南省', 0, '', 0, '', 1, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101542, 450000, '广西壮族自治区', 450700, '钦州市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(101543, 350000, '福建省', 350400, '三明市', 350429, '泰宁县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101544, 510000, '四川省', 511300, '南充市', 511381, '阆中市', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(101545, 540000, '西藏自治区', 542100, '昌都地区', 542129, '芒康县', 3, 'A', 2, 2636, '兰州', '', ''),
(101546, 220000, '吉林省', 220200, '吉林市', 220203, '龙潭区', 3, 'A', 1, 2625, '长春', '', ''),
(101547, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654025, '新源县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101548, 350000, '福建省', 350100, '福州市', 350101, '其它区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(101549, 440000, '广东省', 440600, '佛山市', 440604, '禅城区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101550, 460000, '海南省', 460100, '海口市', 460105, '秀英区', 3, 'A', 1, 2646, '海口', '', ''),
(101551, 510000, '四川省', 512000, '资阳市', 512022, '乐至县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(101552, 130000, '河北省', 130100, '石家庄市', 130185, '鹿泉市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101553, 540000, '西藏自治区', 542200, '山南地区', 542224, '桑日县', 3, 'A', 2, 2308, '昆明', '', ''),
(101554, 420000, '湖北省', 429005, '潜江市', 429005, '潜江市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101555, 450000, '广西壮族自治区', 450400, '梧州市', 450481, '岑溪市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101556, 210000, '辽宁省', 210800, '营口市', 210803, '西市区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101557, 360000, '江西省', 360800, '吉安市', 360828, '万安县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101558, 150000, '内蒙古自治区', 150200, '包头市', 150206, '白云鄂博矿区', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101559, 330000, '浙江省', 330400, '嘉兴市', 330424, '海盐县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101560, 130000, '河北省', 130500, '邢台市', 130527, '南和县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101561, 340000, '安徽省', 341300, '宿州市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(101562, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433126, '古丈县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101563, 360000, '江西省', 360400, '九江市', 360430, '彭泽县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101564, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533103, '潞西市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101565, 450000, '广西壮族自治区', 450300, '桂林市', 450301, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101566, 230000, '黑龙江省', 230800, '佳木斯市', 230822, '桦南县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101567, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422827, '来凤县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101568, 620000, '甘肃省', 620700, '张掖市', 620725, '山丹县', 3, 'A', 2, 2636, '兰州', '', ''),
(101569, 320000, '江苏省', 320700, '连云港市', 320701, '其它区', 3, 'A', 1, 2608, '临沂', '', ''),
(101570, 420000, '湖北省', 420900, '孝感市', 420984, '汉川市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101571, 510000, '四川省', 511100, '乐山市', 511112, '五通桥区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(101572, 530000, '云南省', 530700, '丽江市', 530702, '古城区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101573, 140000, '山西省', 140200, '大同市', 140211, '南郊区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(101574, 510000, '四川省', 511700, '达州市', 511702, '通川区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(101575, 620000, '甘肃省', 620900, '酒泉市', 620901, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(101576, 430000, '湖南省', 430700, '常德市', 430781, '津市市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101577, 410000, '河南省', 410800, '焦作市', 410883, '孟州市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101578, 650000, '新疆维吾尔自治区', 653000, '克孜勒苏柯尔克孜自治州', 653024, '乌恰县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101579, 540000, '西藏自治区', 540100, '拉萨市', 540122, '当雄县', 3, 'A', 2, 2636, '兰州', '', ''),
(101580, 410000, '河南省', 411300, '南阳市', 411326, '淅川县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101581, 340000, '安徽省', 341800, '宣城市', 341881, '宁国市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101582, 410000, '河南省', 410100, '郑州市', 410103, '二七区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101583, 430000, '湖南省', 430100, '长沙市', 430105, '开福区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101584, 450000, '广西壮族自治区', 450100, '南宁市', 450109, '邕宁区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101585, 360000, '江西省', 360900, '宜春市', 360926, '铜鼓县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101586, 410000, '河南省', 411700, '驻马店市', 411728, '遂平县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101587, 520000, '贵州省', 520200, '六盘水市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(101588, 430000, '湖南省', 430600, '岳阳市', 430626, '平江县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101589, 440000, '广东省', 440800, '湛江市', 440801, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101590, 420000, '湖北省', 420100, '武汉市', 420111, '洪山区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101591, 370000, '山东省', 371100, '日照市', 371103, '岚山区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(101592, 440000, '广东省', 440900, '茂名市', 440902, '茂南区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101593, 510000, '四川省', 511800, '雅安市', 511826, '芦山县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(101594, 360000, '江西省', 360400, '九江市', 360401, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101595, 540000, '西藏自治区', 542500, '阿里地区', 542521, '普兰县', 3, 'A', 2, 2636, '兰州', '', ''),
(101596, 410000, '河南省', 410700, '新乡市', 410701, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101597, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152501, '二连浩特市', 3, 'A', 2, 2633, '唐山', '', ''),
(101598, 120000, '天津', 120100, '天津市', 120223, '静海县', 3, 'A', 2, 2634, '天津', '', ''),
(101599, 500000, '重庆', 500100, '重庆市', 500230, '丰都县', 3, 'A', 2, 0, '', '重庆RDC电商库', 'D023'),
(101600, 540000, '西藏自治区', 542400, '那曲地区', 542427, '索县', 3, 'A', 1, 2308, '昆明', '', ''),
(101601, 530000, '云南省', 530400, '玉溪市', 530427, '新平彝族傣族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101602, 520000, '贵州省', 522200, '铜仁市', 522222, '江口县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101603, 640000, '宁夏回族自治区', 640300, '吴忠市', 640324, '同心县', 3, 'A', 2, 2647, '西安', '', ''),
(101604, 650000, '新疆维吾尔自治区', 652200, '哈密地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(101605, 510000, '四川省', 511400, '眉山市', 511401, '其它区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(101606, 210000, '辽宁省', 211300, '朝阳市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(101607, 610000, '陕西省', 610900, '安康市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(101608, 370000, '山东省', 371300, '临沂市', 371321, '沂南县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(101609, 610000, '陕西省', 610700, '汉中市', 610724, '西乡县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101610, 410000, '河南省', 410300, '洛阳市', 410304, '?河回族区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101611, 230000, '黑龙江省', 230300, '鸡西市', 230303, '恒山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101612, 530000, '云南省', 530100, '昆明市', 530122, '晋宁县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101613, 330000, '浙江省', 0, '', 0, '', 1, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(101614, 140000, '山西省', 140400, '长治市', 140425, '平顺县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101615, 440000, '广东省', 0, '', 0, '', 1, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(101616, 320000, '江苏省', 320800, '淮安市', 320801, '其它区', 3, 'A', 1, 2639, '徐州', '', ''),
(101617, 620000, '甘肃省', 621100, '定西市', 621101, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(101618, 360000, '江西省', 360500, '新余市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(101619, 540000, '西藏自治区', 542200, '山南地区', 542228, '洛扎县', 3, 'A', 2, 2308, '昆明', '', ''),
(101620, 520000, '贵州省', 520300, '遵义市', 520321, '遵义县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101621, 530000, '云南省', 530300, '曲靖市', 530328, '沾益县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101622, 360000, '江西省', 360700, '赣州市', 360781, '瑞金市', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101623, 430000, '湖南省', 430300, '湘潭市', 430381, '湘乡市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101624, 340000, '安徽省', 341000, '黄山市', 341022, '休宁县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101625, 410000, '河南省', 410300, '洛阳市', 410324, '栾川县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101626, 450000, '广西壮族自治区', 450200, '柳州市', 450204, '柳南区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101627, 230000, '黑龙江省', 230200, '齐齐哈尔市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(101628, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230227, '富裕县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101629, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653125, '莎车县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101630, 210000, '辽宁省', 210900, '阜新市', 210903, '新邱区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101631, 430000, '湖南省', 430500, '邵阳市', 430581, '武冈市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101632, 350000, '福建省', 350600, '漳州市', 350601, '其它区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101633, 370000, '山东省', 370100, '济南市', 370181, '章丘市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101634, 130000, '河北省', 130100, '石家庄市', 130182, '藁城市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101635, 210000, '辽宁省', 210200, '大连市', 210283, '庄河市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101636, 530000, '云南省', 530700, '丽江市', 530724, '宁蒗彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101637, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150785, '根河市', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(101638, 320000, '江苏省', 320400, '常州市', 320405, '戚墅堰区', 3, 'A', 1, 2604, '南京', '', ''),
(101639, 430000, '湖南省', 430900, '益阳市', 430901, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101640, 330000, '浙江省', 330200, '宁波市', 330203, '海曙区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(101641, 410000, '河南省', 410300, '洛阳市', 410325, '嵩县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101642, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532522, '蒙自市', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101643, 440000, '广东省', 440700, '江门市', 440704, '江海区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101644, 620000, '甘肃省', 620400, '白银市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101645, 410000, '河南省', 411600, '周口市', 411626, '淮阳县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101646, 450000, '广西壮族自治区', 450100, '南宁市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(101647, 440000, '广东省', 440200, '韶关市', 440203, '武江区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101648, 610000, '陕西省', 610500, '渭南市', 610528, '富平县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101649, 370000, '山东省', 370600, '烟台市', 370682, '莱阳市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(101650, 350000, '福建省', 350500, '泉州市', 350582, '晋江市', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101651, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532531, '绿春县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101652, 350000, '福建省', 350100, '福州市', 350105, '马尾区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(101653, 510000, '四川省', 510500, '泸州市', 510501, '其它区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(101654, 310000, '上海', 310100, '上海市', 310104, '徐汇区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(101655, 620000, '甘肃省', 620400, '白银市', 620421, '靖远县', 3, 'A', 2, 2636, '兰州', '', ''),
(101656, 620000, '甘肃省', 620500, '天水市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101657, 130000, '河北省', 130600, '保定市', 130602, '新市区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101658, 520000, '贵州省', 520400, '安顺市', 520422, '普定县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101659, 140000, '山西省', 140900, '忻州市', 140923, '代县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101660, 330000, '浙江省', 330300, '温州市', 330382, '乐清市', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(101661, 210000, '辽宁省', 210500, '本溪市', 210521, '本溪满族自治县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101662, 130000, '河北省', 130200, '唐山市', 130202, '路南区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(101663, 140000, '山西省', 140300, '阳泉市', 140302, '城区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(101664, 650000, '新疆维吾尔自治区', 659000, '自治区直辖县级行政区划', 659004, '五家渠市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101665, 120000, '天津', 120100, '天津市', 120106, '红桥区', 3, 'A', 1, 2634, '天津', '', ''),
(101666, 540000, '西藏自治区', 542600, '林芝地区', 542627, '朗县', 3, 'A', 1, 2308, '昆明', '', ''),
(101667, 230000, '黑龙江省', 231100, '黑河市', 231123, '逊克县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101668, 210000, '辽宁省', 211000, '辽阳市', 211003, '文圣区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101669, 140000, '山西省', 141100, '吕梁市', 141125, '柳林县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101670, 440000, '广东省', 441300, '惠州市', 441301, '其它区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(101671, 410000, '河南省', 410400, '平顶山市', 410404, '石龙区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101672, 420000, '湖北省', 420100, '武汉市', 420112, '东西湖区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101673, 450000, '广西壮族自治区', 451300, '来宾市', 451321, '忻城县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101674, 350000, '福建省', 350700, '南平市', 350725, '政和县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101675, 530000, '云南省', 530400, '玉溪市', 530402, '红塔区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101676, 440000, '广东省', 440900, '茂名市', 440983, '信宜市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101677, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522635, '麻江县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101678, 210000, '辽宁省', 211400, '葫芦岛市', 211422, '建昌县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101679, 210000, '辽宁省', 210600, '丹东市', 210601, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101680, 310000, '上海', 310100, '上海市', 310101, '黄浦区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(101681, 320000, '江苏省', 320400, '常州市', 320404, '钟楼区', 3, 'A', 1, 2604, '南京', '', ''),
(101682, 520000, '贵州省', 520300, '遵义市', 520325, '道真仡佬族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101683, 620000, '甘肃省', 620400, '白银市', 620423, '景泰县', 3, 'A', 2, 2636, '兰州', '', ''),
(101684, 360000, '江西省', 360400, '九江市', 360424, '修水县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101685, 510000, '四川省', 510100, '成都市', 510131, '蒲江县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(101686, 320000, '江苏省', 320100, '南京市', 320125, '高淳区', 3, 'A', 2, 2604, '南京', '', ''),
(101687, 450000, '广西壮族自治区', 450100, '南宁市', 450123, '隆安县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101688, 510000, '四川省', 513400, '凉山彝族自治州', 513434, '越西县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101689, 410000, '河南省', 410200, '开封市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101690, 350000, '福建省', 350100, '福州市', 350121, '闽侯县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101691, 630000, '青海省', 632200, '海北州', 632223, '海晏县', 3, 'A', 2, 2636, '兰州', '', ''),
(101692, 530000, '云南省', 530300, '曲靖市', 530325, '富源县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101693, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654024, '巩留县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101694, 360000, '江西省', 360500, '新余市', 360502, '渝水区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101695, 140000, '山西省', 140700, '晋中市', 140728, '平遥县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101696, 210000, '辽宁省', 210100, '沈阳市', 210122, '辽中县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101697, 140000, '山西省', 141100, '吕梁市', 141127, '岚县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101698, 340000, '安徽省', 341100, '滁州市', 341101, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101699, 210000, '辽宁省', 210100, '沈阳市', 210181, '新民市', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101700, 370000, '山东省', 370300, '淄博市', 370304, '博山区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101701, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654022, '察布查尔锡伯自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101702, 610000, '陕西省', 610900, '安康市', 610928, '旬阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101703, 340000, '安徽省', 340100, '合肥市', 340104, '蜀山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101704, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522722, '荔波县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101705, 460000, '海南省', 469000, '省直辖县级行政区划', 469023, '澄迈县', 3, 'D', 2, 0, '', '', ''),
(101706, 510000, '四川省', 510100, '成都市', 510183, '邛崃市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(101707, 370000, '山东省', 370700, '潍坊市', 370703, '寒亭区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(101708, 530000, '云南省', 532900, '大理白族自治州', 532931, '剑川县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101709, 450000, '广西壮族自治区', 450400, '梧州市', 450423, '蒙山县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101710, 530000, '云南省', 532900, '大理白族自治州', 532925, '弥渡县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101711, 220000, '吉林省', 220800, '白城市', 220821, '镇赉县', 3, 'A', 2, 2625, '长春', '', ''),
(101712, 410000, '河南省', 410700, '新乡市', 410704, '凤泉区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101713, 630000, '青海省', 632100, '海东市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101714, 440000, '广东省', 440900, '茂名市', 440923, '电白县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(101715, 420000, '湖北省', 420900, '孝感市', 420921, '孝昌县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101716, 630000, '青海省', 632700, '玉树藏族自治州', 632721, '玉树县', 3, 'A', 2, 2636, '兰州', '', ''),
(101717, 220000, '吉林省', 220100, '长春市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101718, 610000, '陕西省', 610400, '咸阳市', 610404, '渭城区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101719, 410000, '河南省', 410700, '新乡市', 410711, '牧野区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101720, 140000, '山西省', 140900, '忻州市', 140921, '定襄县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101721, 220000, '吉林省', 220200, '吉林市', 220204, '船营区', 3, 'A', 1, 2625, '长春', '', ''),
(101722, 530000, '云南省', 530800, '普洱市', 530828, '澜沧拉祜族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101723, 360000, '江西省', 360800, '吉安市', 360830, '永新县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101724, 130000, '河北省', 130600, '保定市', 130638, '雄县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101725, 610000, '陕西省', 610900, '安康市', 610927, '镇坪县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101726, 230000, '黑龙江省', 230300, '鸡西市', 230307, '麻山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101727, 620000, '甘肃省', 620300, '金昌市', 620321, '永昌县', 3, 'A', 2, 2636, '兰州', '', ''),
(101728, 510000, '四川省', 510600, '德阳市', 510681, '广汉市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(101729, 130000, '河北省', 130600, '保定市', 130622, '清苑县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101730, 450000, '广西壮族自治区', 451000, '百色市', 451029, '田林县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101731, 210000, '辽宁省', 210200, '大连市', 210202, '中山区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101732, 530000, '云南省', 530600, '昭通市', 530602, '昭阳区', 3, 'A', 1, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(101733, 340000, '安徽省', 341700, '池州市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(101734, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522728, '罗甸县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101735, 370000, '山东省', 371500, '聊城市', 371502, '东昌府区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101736, 510000, '四川省', 510400, '攀枝花市', 510411, '仁和区', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(101737, 340000, '安徽省', 341200, '阜阳市', 341201, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101738, 140000, '山西省', 140300, '阳泉市', 140321, '平定县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101739, 450000, '广西壮族自治区', 451400, '崇左市', 451421, '扶绥县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101740, 510000, '四川省', 513300, '甘孜藏族自治州', 513338, '得荣县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101741, 450000, '广西壮族自治区', 0, '', 0, '', 1, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(101742, 420000, '湖北省', 420200, '黄石市', 420222, '阳新县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101743, 410000, '河南省', 411400, '商丘市', 411424, '柘城县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101744, 320000, '江苏省', 320400, '常州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101745, 530000, '云南省', 532900, '大理白族自治州', 532927, '巍山彝族回族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101746, 510000, '四川省', 513300, '甘孜藏族自治州', 513329, '新龙县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101747, 350000, '福建省', 350600, '漳州市', 350624, '诏安县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101748, 350000, '福建省', 350100, '福州市', 350122, '连江县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101749, 210000, '辽宁省', 210500, '本溪市', 210505, '南芬区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101750, 620000, '甘肃省', 622900, '临夏回族自治州', 622923, '永靖县', 3, 'A', 2, 2636, '兰州', '', ''),
(101751, 330000, '浙江省', 330500, '湖州市', 330501, '其它区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101752, 540000, '西藏自治区', 542100, '昌都地区', 542121, '昌都县', 3, 'A', 2, 2636, '兰州', '', ''),
(101753, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150926, '察哈尔右翼前旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101754, 420000, '湖北省', 421100, '黄冈市', 421181, '麻城市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101755, 430000, '湖南省', 430500, '邵阳市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(101756, 410000, '河南省', 411700, '驻马店市', 411702, '驿城区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101757, 360000, '江西省', 360400, '九江市', 360403, '浔阳区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101758, 130000, '河北省', 130100, '石家庄市', 130127, '高邑县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101759, 350000, '福建省', 350500, '泉州市', 350525, '永春县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101760, 510000, '四川省', 513400, '凉山彝族自治州', 513422, '木里藏族自治县', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(101761, 370000, '山东省', 370900, '泰安市', 370911, '岱岳区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(101762, 420000, '湖北省', 420100, '武汉市', 420107, '青山区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101763, 130000, '河北省', 131100, '衡水市', 131124, '饶阳县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101764, 350000, '福建省', 350400, '三明市', 350425, '大田县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101765, 500000, '重庆', 500100, '重庆市', 500118, '永川区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101766, 620000, '甘肃省', 622900, '临夏回族自治州', 622926, '东乡族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101767, 310000, '上海', 0, '', 0, '', 1, 'A', 0, 0, '', '上海RDC电商库', 'D021'),
(101768, 510000, '四川省', 513400, '凉山彝族自治州', 513427, '宁南县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101769, 370000, '山东省', 371100, '日照市', 371102, '东港区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(101770, 230000, '黑龙江省', 230100, '哈尔滨市', 230110, '香坊区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101771, 370000, '山东省', 370400, '枣庄市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(101772, 350000, '福建省', 350100, '福州市', 350104, '仓山区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(101773, 540000, '西藏自治区', 542300, '日喀则地区', 542331, '康马县', 3, 'A', 2, 2636, '兰州', '', ''),
(101774, 540000, '西藏自治区', 542500, '阿里地区', 542527, '措勤县', 3, 'A', 2, 2636, '兰州', '', ''),
(101775, 620000, '甘肃省', 620400, '白银市', 620401, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(101776, 620000, '甘肃省', 620100, '兰州市', 620121, '永登县', 3, 'A', 2, 2636, '兰州', '', ''),
(101777, 510000, '四川省', 511300, '南充市', 511303, '高坪区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(101778, 440000, '广东省', 440300, '深圳市', 440308, '盐田区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(101779, 150000, '内蒙古自治区', 152900, '阿拉善盟', 152921, '阿拉善左旗', 3, 'A', 2, 2636, '兰州', '', ''),
(101780, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652822, '轮台县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101781, 130000, '河北省', 130200, '唐山市', 130224, '滦南县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(101782, 210000, '辽宁省', 210200, '大连市', 210212, '旅顺口区', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101783, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522624, '三穗县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101784, 410000, '河南省', 410100, '郑州市', 410183, '新密市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101785, 330000, '浙江省', 330500, '湖州市', 330521, '德清县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101786, 420000, '湖北省', 420900, '孝感市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(101787, 360000, '江西省', 360700, '赣州市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(101788, 360000, '江西省', 360100, '南昌市', 360111, '青山湖区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(101789, 140000, '山西省', 140200, '大同市', 140227, '大同县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101790, 510000, '四川省', 513400, '凉山彝族自治州', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(101791, 230000, '黑龙江省', 231000, '牡丹江市', 231001, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(101792, 450000, '广西壮族自治区', 450900, '玉林市', 450923, '博白县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101793, 230000, '黑龙江省', 231100, '黑河市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(101794, 350000, '福建省', 350600, '漳州市', 350628, '平和县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(101795, 610000, '陕西省', 611000, '商洛市', 611001, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101796, 340000, '安徽省', 340800, '安庆市', 340881, '桐城市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101797, 440000, '广东省', 445200, '揭阳市', 445202, '榕城区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(101798, 440000, '广东省', 440800, '湛江市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(101799, 210000, '辽宁省', 210800, '营口市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(101800, 500000, '重庆', 500100, '重庆市', 500116, '江津区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101801, 510000, '四川省', 511000, '内江市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(101802, 340000, '安徽省', 341100, '滁州市', 341182, '明光市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101803, 430000, '湖南省', 431200, '怀化市', 431227, '新晃侗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101804, 340000, '安徽省', 341500, '六安市', 341524, '金寨县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101805, 610000, '陕西省', 610400, '咸阳市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(101806, 230000, '黑龙江省', 230700, '伊春市', 230706, '翠峦区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101807, 610000, '陕西省', 610600, '延安市', 610629, '洛川县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101808, 440000, '广东省', 440800, '湛江市', 440803, '霞山区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101809, 340000, '安徽省', 341200, '阜阳市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(101810, 150000, '内蒙古自治区', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(101811, 320000, '江苏省', 320300, '徐州市', 320321, '丰县', 3, 'A', 1, 2639, '徐州', '', ''),
(101812, 430000, '湖南省', 431100, '永州市', 431124, '道县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101813, 370000, '山东省', 370600, '烟台市', 370687, '海阳市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(101814, 340000, '安徽省', 341700, '池州市', 341723, '青阳县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101815, 440000, '广东省', 441200, '肇庆市', 441284, '四会市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101816, 450000, '广西壮族自治区', 450900, '玉林市', 450921, '容县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101817, 450000, '广西壮族自治区', 450900, '玉林市', 450981, '北流市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101818, 220000, '吉林省', 220100, '长春市', 220103, '宽城区', 3, 'A', 1, 2625, '长春', '', ''),
(101819, 410000, '河南省', 410900, '濮阳市', 410923, '南乐县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101820, 530000, '云南省', 532900, '大理白族自治州', 532930, '洱源县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101821, 510000, '四川省', 512000, '资阳市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(101822, 340000, '安徽省', 341700, '池州市', 341722, '石台县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101823, 330000, '浙江省', 330300, '温州市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(101824, 440000, '广东省', 441400, '梅州市', 441421, '梅县', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(101825, 150000, '内蒙古自治区', 150300, '乌海市', 150304, '乌达区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(101826, 210000, '辽宁省', 211300, '朝阳市', 211324, '喀喇沁左翼蒙古族自治县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101827, 130000, '河北省', 130500, '邢台市', 130534, '清河县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101828, 510000, '四川省', 511500, '宜宾市', 511502, '翠屏区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(101829, 630000, '青海省', 632600, '果洛州', 632625, '久治县', 3, 'A', 2, 2636, '兰州', '', ''),
(101830, 210000, '辽宁省', 210700, '锦州市', 210727, '义县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101831, 140000, '山西省', 140400, '长治市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(101832, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150801, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(101833, 440000, '广东省', 440400, '珠海市', 440404, '金湾区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101834, 410000, '河南省', 410500, '安阳市', 410523, '汤阴县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101835, 360000, '江西省', 360700, '赣州市', 360722, '信丰县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101836, 430000, '湖南省', 430400, '衡阳市', 430405, '珠晖区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101837, 220000, '吉林省', 220200, '吉林市', 220221, '永吉县', 3, 'A', 2, 2625, '长春', '', ''),
(101838, 610000, '陕西省', 610600, '延安市', 610622, '延川县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101839, 450000, '广西壮族自治区', 450900, '玉林市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(101840, 210000, '辽宁省', 211300, '朝阳市', 211302, '双塔区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(101841, 340000, '安徽省', 341800, '宣城市', 341822, '广德县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101842, 620000, '甘肃省', 621100, '定西市', 621123, '渭源县', 3, 'A', 2, 2636, '兰州', '', ''),
(101843, 460000, '海南省', 460200, '三亚市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101844, 610000, '陕西省', 610300, '宝鸡市', 610327, '陇县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101845, 370000, '山东省', 370400, '枣庄市', 370405, '台儿庄区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(101846, 430000, '湖南省', 430500, '邵阳市', 430511, '北塔区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101847, 330000, '浙江省', 330100, '杭州市', 330110, '余杭区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101848, 220000, '吉林省', 220500, '通化市', 220502, '东昌区', 3, 'A', 1, 2625, '长春', '', ''),
(101849, 330000, '浙江省', 330400, '嘉兴市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(101850, 540000, '西藏自治区', 542600, '林芝地区', 542626, '察隅县', 3, 'A', 2, 2308, '昆明', '', ''),
(101851, 610000, '陕西省', 610700, '汉中市', 610722, '城固县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101852, 610000, '陕西省', 611000, '商洛市', 611024, '山阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101853, 410000, '河南省', 410500, '安阳市', 410526, '滑县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101854, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654027, '特克斯县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101855, 440000, '广东省', 440600, '佛山市', 440608, '高明区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101856, 540000, '西藏自治区', 542500, '阿里地区', 542525, '革吉县', 3, 'A', 2, 2636, '兰州', '', ''),
(101857, 610000, '陕西省', 610600, '延安市', 610625, '志丹县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101858, 370000, '山东省', 370100, '济南市', 370124, '平阴县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(101859, 530000, '云南省', 530600, '昭通市', 530629, '威信县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(101860, 530000, '云南省', 530600, '昭通市', 530601, '其它区', 3, 'A', 1, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(101861, 350000, '福建省', 350700, '南平市', 350721, '顺昌县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101862, 440000, '广东省', 440100, '广州市', 440115, '南沙区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101863, 630000, '青海省', 632500, '海南州', 632524, '兴海县', 3, 'A', 2, 2636, '兰州', '', ''),
(101864, 330000, '浙江省', 330700, '金华市', 330727, '磐安县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101865, 500000, '重庆', 500100, '重庆市', 500119, '南川区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101866, 610000, '陕西省', 610100, '西安市', 610102, '新城区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101867, 510000, '四川省', 511500, '宜宾市', 511501, '其它区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(101868, 140000, '山西省', 140600, '朔州市', 140621, '山阴县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101869, 430000, '湖南省', 430500, '邵阳市', 430523, '邵阳县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101870, 630000, '青海省', 632300, '黄南藏族自治州', 632323, '泽库县', 3, 'A', 2, 2636, '兰州', '', ''),
(101871, 510000, '四川省', 510100, '成都市', 510132, '新津县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(101872, 340000, '安徽省', 341500, '六安市', 341522, '霍邱县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101873, 540000, '西藏自治区', 542400, '那曲地区', 542426, '申扎县', 3, 'A', 2, 2308, '昆明', '', ''),
(101874, 130000, '河北省', 130800, '承德市', 130801, '其它区', 3, 'A', 1, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(101875, 410000, '河南省', 410500, '安阳市', 410505, '殷都区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101876, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532528, '元阳县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101877, 410000, '河南省', 411500, '信阳市', 411528, '息县', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101878, 220000, '吉林省', 220500, '通化市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101879, 360000, '江西省', 361000, '抚州市', 361001, '其它区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101880, 220000, '吉林省', 220800, '白城市', 220801, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(101881, 320000, '江苏省', 320500, '苏州市', 320506, '吴中区', 3, 'A', 1, 2664, '无锡', '', ''),
(101882, 230000, '黑龙江省', 230600, '大庆市', 230606, '大同区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101883, 420000, '湖北省', 420500, '宜昌市', 420526, '兴山县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101884, 120000, '天津', 120100, '天津市', 120104, '南开区', 3, 'A', 1, 2634, '天津', '', ''),
(101885, 140000, '山西省', 141000, '临汾市', 141024, '洪洞县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101886, 370000, '山东省', 371700, '菏泽市', 371724, '巨野县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(101887, 360000, '江西省', 360900, '宜春市', 360982, '樟树市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101888, 510000, '四川省', 510400, '攀枝花市', 510401, '其它区', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(101889, 340000, '安徽省', 341000, '黄山市', 341002, '屯溪区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101890, 530000, '云南省', 533400, '迪庆藏族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(101891, 340000, '安徽省', 340800, '安庆市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(101892, 350000, '福建省', 350100, '福州市', 350125, '永泰县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(101893, 210000, '辽宁省', 210400, '抚顺市', 210404, '望花区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101894, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150121, '土默特左旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101895, 610000, '陕西省', 610300, '宝鸡市', 610328, '千阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101896, 340000, '安徽省', 340400, '淮南市', 340405, '八公山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101897, 130000, '河北省', 130500, '邢台市', 130524, '柏乡县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101898, 610000, '陕西省', 610700, '汉中市', 610727, '略阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101899, 220000, '吉林省', 220800, '白城市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101900, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 632802, '德令哈市', 3, 'A', 1, 2636, '兰州', '', ''),
(101901, 620000, '甘肃省', 621200, '陇南市', 621225, '西和县', 3, 'A', 2, 2636, '兰州', '', ''),
(101902, 430000, '湖南省', 430300, '湘潭市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(101903, 130000, '河北省', 130200, '唐山市', 130201, '其它区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(101904, 430000, '湖南省', 430800, '张家界市', 430802, '永定区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101905, 320000, '江苏省', 320300, '徐州市', 320323, '铜山区', 3, 'A', 2, 2639, '徐州', '', ''),
(101906, 130000, '河北省', 130300, '秦皇岛市', 130322, '昌黎县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(101907, 450000, '广西壮族自治区', 450500, '北海市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(101908, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532523, '屏边苗族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101909, 420000, '湖北省', 420900, '孝感市', 420923, '云梦县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101910, 120000, '天津', 120100, '天津市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101911, 140000, '山西省', 141000, '临汾市', 141030, '大宁县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101912, 320000, '江苏省', 320900, '盐城市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101913, 500000, '重庆', 500100, '重庆市', 500232, '武隆县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101914, 220000, '吉林省', 220700, '松原市', 220724, '扶余县', 3, 'A', 2, 2625, '长春', '', ''),
(101915, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150928, '察哈尔右翼后旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101916, 220000, '吉林省', 220200, '吉林市', 220281, '蛟河市', 3, 'A', 2, 2625, '长春', '', ''),
(101917, 130000, '河北省', 130100, '石家庄市', 130103, '桥东区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101918, 520000, '贵州省', 520100, '贵阳市', 520122, '息烽县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(101919, 340000, '安徽省', 340600, '淮北市', 340603, '相山区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(101920, 130000, '河北省', 131000, '廊坊市', 131024, '香河县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(101921, 610000, '陕西省', 610500, '渭南市', 610582, '华阴市', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101922, 420000, '湖北省', 420200, '黄石市', 420205, '铁山区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101923, 330000, '浙江省', 331000, '台州市', 331024, '仙居县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(101924, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150101, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(101925, 210000, '辽宁省', 210100, '沈阳市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(101926, 540000, '西藏自治区', 542200, '山南地区', 542229, '加查县', 3, 'A', 2, 2308, '昆明', '', ''),
(101927, 350000, '福建省', 0, '', 0, '', 1, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(101928, 440000, '广东省', 440500, '汕头市', 440523, '南澳县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(101929, 320000, '江苏省', 321200, '泰州市', 321281, '兴化市', 3, 'A', 1, 2663, '南通', '', ''),
(101930, 330000, '浙江省', 330400, '嘉兴市', 330421, '嘉善县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(101931, 210000, '辽宁省', 210200, '大连市', 210224, '长海县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(101932, 430000, '湖南省', 430100, '长沙市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(101933, 330000, '浙江省', 330300, '温州市', 330304, '瓯海区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(101934, 410000, '河南省', 411400, '商丘市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(101935, 340000, '安徽省', 340400, '淮南市', 340402, '大通区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101936, 340000, '安徽省', 341300, '宿州市', 341302, '?桥区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(101937, 370000, '山东省', 371500, '聊城市', 371581, '临清市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(101938, 230000, '黑龙江省', 232700, '大兴安岭地区', 232722, '塔河县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101939, 620000, '甘肃省', 621000, '庆阳市', 621026, '宁县', 3, 'A', 1, 2636, '兰州', '', ''),
(101940, 430000, '湖南省', 430900, '益阳市', 430921, '南县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101941, 640000, '宁夏回族自治区', 640400, '固原市', 640422, '西吉县', 3, 'A', 2, 2647, '西安', '', ''),
(101942, 220000, '吉林省', 220400, '辽源市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101943, 430000, '湖南省', 430400, '衡阳市', 430423, '衡山县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101944, 360000, '江西省', 360500, '新余市', 360521, '分宜县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101945, 360000, '江西省', 361100, '上饶市', 361123, '玉山县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101946, 340000, '安徽省', 341500, '六安市', 341503, '裕安区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101947, 420000, '湖北省', 420300, '十堰市', 420323, '竹山县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(101948, 510000, '四川省', 513300, '甘孜藏族自治州', 513327, '炉霍县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101949, 530000, '云南省', 532900, '大理白族自治州', 532932, '鹤庆县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101950, 410000, '河南省', 411000, '许昌市', 411025, '襄城县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101951, 360000, '江西省', 360800, '吉安市', 360823, '峡江县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(101952, 410000, '河南省', 411300, '南阳市', 411381, '邓州市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101953, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150922, '化德县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101954, 510000, '四川省', 513300, '甘孜藏族自治州', 513331, '白玉县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101955, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230203, '建华区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101956, 610000, '陕西省', 610500, '渭南市', 610527, '白水县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101957, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654322, '富蕴县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(101958, 620000, '甘肃省', 620900, '酒泉市', 620923, '肃北蒙古族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101959, 510000, '四川省', 510700, '绵阳市', 510704, '游仙区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(101960, 440000, '广东省', 441800, '清远市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(101961, 210000, '辽宁省', 210300, '鞍山市', 210301, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(101962, 640000, '宁夏回族自治区', 640100, '银川市', 640104, '兴庆区', 3, 'A', 1, 2647, '西安', '', ''),
(101963, 510000, '四川省', 510500, '泸州市', 510521, '泸县', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(101964, 500000, '重庆', 500100, '重庆市', 500231, '垫江县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(101965, 530000, '云南省', 532600, '文山壮族苗族自治州', 532628, '富宁县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(101966, 230000, '黑龙江省', 230100, '哈尔滨市', 230101, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101967, 620000, '甘肃省', 622900, '临夏回族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(101968, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150601, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(101969, 370000, '山东省', 371300, '临沂市', 371328, '蒙阴县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(101970, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433125, '保靖县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101971, 230000, '黑龙江省', 230100, '哈尔滨市', 230124, '方正县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101972, 510000, '四川省', 511800, '雅安市', 511821, '名山县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(101973, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230208, '梅里斯达斡尔族区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101974, 510000, '四川省', 513400, '凉山彝族自治州', 513424, '德昌县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(101975, 430000, '湖南省', 431200, '怀化市', 431229, '靖州苗族侗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(101976, 370000, '山东省', 371700, '菏泽市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(101977, 130000, '河北省', 130100, '石家庄市', 130181, '辛集市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101978, 410000, '河南省', 419000, '济源市', 419001, '济源市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101979, 130000, '河北省', 130400, '邯郸市', 130435, '曲周县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(101980, 450000, '广西壮族自治区', 450400, '梧州市', 450421, '苍梧县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101981, 610000, '陕西省', 610600, '延安市', 610626, '吴起县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(101982, 510000, '四川省', 511100, '乐山市', 511101, '其它区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(101983, 360000, '江西省', 360400, '九江市', 360427, '星子县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(101984, 440000, '广东省', 440400, '珠海市', 440401, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(101985, 430000, '湖南省', 430600, '岳阳市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(101986, 410000, '河南省', 411000, '许昌市', 411024, '鄢陵县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(101987, 450000, '广西壮族自治区', 450500, '北海市', 450521, '合浦县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(101988, 410000, '河南省', 411200, '三门峡市', 411282, '灵宝市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(101989, 140000, '山西省', 140900, '忻州市', 140929, '岢岚县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(101990, 610000, '陕西省', 610500, '渭南市', 610581, '韩城市', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101991, 630000, '青海省', 632100, '海东市', 632122, '民和回族土族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(101992, 440000, '广东省', 441800, '清远市', 441821, '佛冈县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(101993, 230000, '黑龙江省', 232700, '大兴安岭地区', 232723, '漠河县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(101994, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150823, '乌拉特前旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(101995, 620000, '甘肃省', 620700, '张掖市', 0, '', 2, 'A', 0, 0, '', '', ''),
(101996, 340000, '安徽省', 340500, '马鞍山市', 340521, '当涂县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(101997, 610000, '陕西省', 610300, '宝鸡市', 610303, '金台区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(101998, 420000, '湖北省', 421000, '荆州市', 421087, '松滋市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(101999, 420000, '湖北省', 420500, '宜昌市', 420527, '秭归县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102000, 410000, '河南省', 411700, '驻马店市', 411724, '正阳县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102001, 210000, '辽宁省', 210900, '阜新市', 210904, '太平区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102002, 520000, '贵州省', 522200, '铜仁市', 522229, '松桃苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102003, 520000, '贵州省', 522400, '毕节市', 522422, '大方县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102004, 220000, '吉林省', 220700, '松原市', 220723, '乾安县', 3, 'A', 2, 2625, '长春', '', ''),
(102005, 140000, '山西省', 140200, '大同市', 140222, '天镇县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102006, 210000, '辽宁省', 210400, '抚顺市', 210421, '抚顺县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102007, 410000, '河南省', 410600, '鹤壁市', 410622, '淇县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102008, 330000, '浙江省', 330600, '绍兴市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(102009, 460000, '海南省', 469002, '琼海市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102010, 210000, '辽宁省', 210300, '鞍山市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(102011, 360000, '江西省', 360900, '宜春市', 360983, '高安市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102012, 610000, '陕西省', 610700, '汉中市', 610723, '洋县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102013, 130000, '河北省', 130800, '承德市', 130803, '双滦区', 3, 'A', 1, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(102014, 540000, '西藏自治区', 542200, '山南地区', 542226, '曲松县', 3, 'A', 2, 2308, '昆明', '', ''),
(102015, 430000, '湖南省', 431100, '永州市', 431127, '蓝山县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102016, 230000, '黑龙江省', 231200, '绥化市', 231224, '庆安县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102017, 450000, '广西壮族自治区', 450400, '梧州市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(102018, 130000, '河北省', 130100, '石家庄市', 130102, '长安区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102019, 230000, '黑龙江省', 230500, '双鸭山市', 230506, '宝山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102020, 320000, '江苏省', 320500, '苏州市', 320507, '相城区', 3, 'A', 1, 2664, '无锡', '', ''),
(102021, 130000, '河北省', 130200, '唐山市', 130230, '曹妃甸区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102022, 320000, '江苏省', 321300, '宿迁市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102023, 440000, '广东省', 441400, '梅州市', 441423, '丰顺县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102024, 460000, '海南省', 469000, '省直辖县级行政区划', 469025, '白沙黎族自治县', 3, 'D', 1, 0, '', '', ''),
(102025, 450000, '广西壮族自治区', 451000, '百色市', 451025, '靖西县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102026, 320000, '江苏省', 321200, '泰州市', 321201, '其它区', 3, 'A', 1, 2663, '南通', '', ''),
(102027, 370000, '山东省', 370600, '烟台市', 370684, '蓬莱市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102028, 500000, '重庆', 500100, '重庆市', 500228, '梁平县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102029, 440000, '广东省', 445100, '潮州市', 445122, '饶平县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102030, 410000, '河南省', 411300, '南阳市', 411323, '西峡县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102031, 630000, '青海省', 632700, '玉树藏族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(102032, 450000, '广西壮族自治区', 451300, '来宾市', 451323, '武宣县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102033, 440000, '广东省', 441200, '肇庆市', 441201, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102034, 420000, '湖北省', 420100, '武汉市', 420105, '汉阳区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102035, 410000, '河南省', 411600, '周口市', 411601, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102036, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222424, '汪清县', 3, 'A', 2, 2625, '长春', '', ''),
(102037, 320000, '江苏省', 320600, '南通市', 320612, '通州区', 3, 'A', 1, 2663, '南通', '', ''),
(102038, 340000, '安徽省', 340400, '淮南市', 340403, '田家庵区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102039, 230000, '黑龙江省', 231000, '牡丹江市', 231025, '林口县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102040, 620000, '甘肃省', 621100, '定西市', 621124, '临洮县', 3, 'A', 2, 2636, '兰州', '', ''),
(102041, 320000, '江苏省', 320800, '淮安市', 320829, '洪泽县', 3, 'A', 2, 2639, '徐州', '', ''),
(102042, 420000, '湖北省', 421200, '咸宁市', 421202, '咸安区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102043, 510000, '四川省', 511100, '乐山市', 511113, '金口河区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(102044, 420000, '湖北省', 420300, '十堰市', 420301, '其它区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102045, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(102046, 410000, '河南省', 410400, '平顶山市', 410423, '鲁山县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102047, 610000, '陕西省', 610600, '延安市', 610601, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102048, 330000, '浙江省', 330900, '舟山市', 330921, '岱山县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102049, 510000, '四川省', 510700, '绵阳市', 510703, '涪城区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102050, 370000, '山东省', 370200, '青岛市', 370214, '城阳区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102051, 500000, '重庆', 500100, '重庆市', 500243, '彭水苗族土家族自治县', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102052, 440000, '广东省', 445300, '云浮市', 445302, '云城区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102053, 420000, '湖北省', 420100, '武汉市', 420101, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102054, 220000, '吉林省', 220100, '长春市', 220122, '农安县', 3, 'A', 2, 2625, '长春', '', ''),
(102055, 210000, '辽宁省', 210600, '丹东市', 210604, '振安区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102056, 220000, '吉林省', 220500, '通化市', 220521, '通化县', 3, 'A', 2, 2625, '长春', '', ''),
(102057, 630000, '青海省', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(102058, 530000, '云南省', 530100, '昆明市', 530127, '嵩明县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102059, 320000, '江苏省', 320100, '南京市', 320103, '白下区', 3, 'A', 1, 2604, '南京', '', ''),
(102060, 450000, '广西壮族自治区', 451100, '贺州市', 451122, '钟山县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102061, 450000, '广西壮族自治区', 451100, '贺州市', 451101, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102062, 420000, '湖北省', 420900, '孝感市', 420902, '孝南区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102063, 530000, '云南省', 532300, '楚雄彝族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102064, 650000, '新疆维吾尔自治区', 659000, '自治区直辖县级行政区划', 659003, '图木舒克市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102065, 360000, '江西省', 361100, '上饶市', 361181, '德兴市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102066, 530000, '云南省', 532800, '西双版纳傣族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102067, 410000, '河南省', 410400, '平顶山市', 410421, '宝丰县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102068, 640000, '宁夏回族自治区', 640500, '中卫市', 640501, '其它区', 3, 'A', 1, 2647, '西安', '', ''),
(102069, 420000, '湖北省', 420100, '武汉市', 420104, '?口区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102070, 210000, '辽宁省', 210300, '鞍山市', 210311, '千山区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102071, 450000, '广西壮族自治区', 450500, '北海市', 450503, '银海区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102072, 230000, '黑龙江省', 230100, '哈尔滨市', 230111, '呼兰区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102073, 450000, '广西壮族自治区', 451300, '来宾市', 451381, '合山市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102074, 360000, '江西省', 360100, '南昌市', 360124, '进贤县', 3, 'A', 2, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(102075, 120000, '天津', 120100, '天津市', 120102, '河东区', 3, 'A', 1, 2634, '天津', '', ''),
(102076, 450000, '广西壮族自治区', 451000, '百色市', 451027, '凌云县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102077, 350000, '福建省', 350200, '厦门市', 350201, '其它区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102078, 440000, '广东省', 441300, '惠州市', 441303, '惠阳区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(102079, 230000, '黑龙江省', 230700, '伊春市', 230704, '友好区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102080, 140000, '山西省', 140100, '太原市', 140122, '阳曲县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102081, 610000, '陕西省', 610900, '安康市', 610922, '石泉县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102082, 330000, '浙江省', 330100, '杭州市', 330103, '下城区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102083, 350000, '福建省', 350100, '福州市', 350128, '平潭县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(102084, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230202, '龙沙区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102085, 510000, '四川省', 510900, '遂宁市', 510922, '射洪县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(102086, 620000, '甘肃省', 622900, '临夏回族自治州', 622924, '广河县', 3, 'A', 2, 2636, '兰州', '', ''),
(102087, 140000, '山西省', 140800, '运城市', 140829, '平陆县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102088, 360000, '江西省', 360600, '鹰潭市', 360622, '余江县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102089, 220000, '吉林省', 220100, '长春市', 220104, '朝阳区', 3, 'A', 1, 2625, '长春', '', ''),
(102090, 210000, '辽宁省', 211200, '铁岭市', 211223, '西丰县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102091, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150725, '陈巴尔虎旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(102092, 420000, '湖北省', 420300, '十堰市', 420381, '丹江口市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102093, 210000, '辽宁省', 210200, '大连市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(102094, 530000, '云南省', 530100, '昆明市', 530102, '五华区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102095, 620000, '甘肃省', 620300, '金昌市', 620302, '金川区', 3, 'A', 1, 2636, '兰州', '', ''),
(102096, 350000, '福建省', 350300, '莆田市', 350301, '其它区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(102097, 530000, '云南省', 532300, '楚雄彝族自治州', 532322, '双柏县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102098, 440000, '广东省', 445200, '揭阳市', 445222, '揭西县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102099, 370000, '山东省', 370800, '济宁市', 370831, '泗水县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102100, 350000, '福建省', 350200, '厦门市', 350206, '湖里区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102101, 210000, '辽宁省', 211000, '辽阳市', 211005, '弓长岭区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102102, 630000, '青海省', 632600, '果洛州', 632623, '甘德县', 3, 'A', 2, 2636, '兰州', '', ''),
(102103, 630000, '青海省', 632200, '海北州', 632221, '门源回族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(102104, 140000, '山西省', 140900, '忻州市', 140927, '神池县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102105, 150000, '内蒙古自治区', 150500, '通辽市', 150525, '奈曼旗', 3, 'A', 2, 2626, '沈阳', '', ''),
(102106, 360000, '江西省', 360400, '九江市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(102107, 370000, '山东省', 370900, '泰安市', 370982, '新泰市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102108, 450000, '广西壮族自治区', 450200, '柳州市', 450201, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102109, 620000, '甘肃省', 621200, '陇南市', 621223, '宕昌县', 3, 'A', 2, 2636, '兰州', '', ''),
(102110, 650000, '新疆维吾尔自治区', 653000, '克孜勒苏柯尔克孜自治州', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(102111, 410000, '河南省', 411300, '南阳市', 411303, '卧龙区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102112, 510000, '四川省', 510100, '成都市', 510124, '郫县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102113, 440000, '广东省', 441700, '阳江市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102114, 510000, '四川省', 513300, '甘孜藏族自治州', 513330, '德格县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102115, 500000, '重庆', 500100, '重庆市', 500110, '万盛区', 3, 'D', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102116, 340000, '安徽省', 341300, '宿州市', 341322, '萧县', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(102117, 320000, '江苏省', 320300, '徐州市', 320301, '其它区', 3, 'A', 1, 2639, '徐州', '', ''),
(102118, 650000, '新疆维吾尔自治区', 659000, '自治区直辖县级行政区划', 659001, '石河子市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102119, 330000, '浙江省', 331100, '丽水市', 331102, '莲都区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(102120, 610000, '陕西省', 610100, '西安市', 610124, '周至县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102121, 320000, '江苏省', 321100, '镇江市', 321111, '润州区', 3, 'A', 1, 2604, '南京', '', ''),
(102122, 150000, '内蒙古自治区', 150500, '通辽市', 150523, '开鲁县', 3, 'A', 2, 2626, '沈阳', '', ''),
(102123, 210000, '辽宁省', 210300, '鞍山市', 210302, '铁东区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102124, 210000, '辽宁省', 210100, '沈阳市', 210102, '和平区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102125, 130000, '河北省', 130800, '承德市', 130828, '围场满族蒙古族自治县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(102126, 410000, '河南省', 410100, '郑州市', 410102, '中原区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102127, 120000, '天津', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(102128, 140000, '山西省', 140400, '长治市', 140431, '沁源县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102129, 640000, '宁夏回族自治区', 640400, '固原市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102130, 510000, '四川省', 510600, '德阳市', 510682, '什邡市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102131, 520000, '贵州省', 522400, '毕节市', 522425, '织金县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102132, 530000, '云南省', 530100, '昆明市', 530128, '禄劝彝族苗族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102133, 620000, '甘肃省', 620100, '兰州市', 620123, '榆中县', 3, 'A', 2, 2636, '兰州', '', ''),
(102134, 320000, '江苏省', 320500, '苏州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102135, 510000, '四川省', 511500, '宜宾市', 511521, '宜宾县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(102136, 610000, '陕西省', 610400, '咸阳市', 610481, '兴平市', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102137, 230000, '黑龙江省', 231200, '绥化市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(102138, 610000, '陕西省', 610100, '西安市', 610103, '碑林区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102139, 410000, '河南省', 411700, '驻马店市', 411722, '上蔡县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102140, 440000, '广东省', 441600, '河源市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102141, 420000, '湖北省', 421000, '荆州市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(102142, 410000, '河南省', 411500, '信阳市', 411522, '光山县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102143, 640000, '宁夏回族自治区', 640200, '石嘴山市', 640205, '惠农区', 3, 'A', 1, 2647, '西安', '', ''),
(102144, 370000, '山东省', 371100, '日照市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(102145, 510000, '四川省', 511900, '巴中市', 511901, '其它区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(102146, 360000, '江西省', 360400, '九江市', 360423, '武宁县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102147, 500000, '重庆', 500100, '重庆市', 500224, '铜梁县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102148, 370000, '山东省', 371400, '德州市', 371423, '庆云县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102149, 440000, '广东省', 440600, '佛山市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102150, 320000, '江苏省', 321100, '镇江市', 321102, '京口区', 3, 'A', 1, 2604, '南京', '', ''),
(102151, 210000, '辽宁省', 211000, '辽阳市', 211004, '宏伟区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102152, 510000, '四川省', 513400, '凉山彝族自治州', 513431, '昭觉县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102153, 330000, '浙江省', 330800, '衢州市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(102154, 230000, '黑龙江省', 231100, '黑河市', 231121, '嫩江县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102155, 130000, '河北省', 130900, '沧州市', 130922, '青县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102156, 450000, '广西壮族自治区', 451000, '百色市', 451024, '德保县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102157, 450000, '广西壮族自治区', 450600, '防城港市', 450603, '防城区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102158, 410000, '河南省', 410100, '郑州市', 410181, '巩义市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102159, 140000, '山西省', 140400, '长治市', 140423, '襄垣县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102160, 210000, '辽宁省', 211000, '辽阳市', 211011, '太子河区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102161, 410000, '河南省', 411500, '信阳市', 411501, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102162, 370000, '山东省', 370500, '东营市', 370503, '河口区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102163, 350000, '福建省', 350600, '漳州市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(102164, 440000, '广东省', 441600, '河源市', 441625, '东源县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102165, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150624, '鄂托克旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102166, 640000, '宁夏回族自治区', 640300, '吴忠市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102167, 620000, '甘肃省', 621100, '定西市', 621102, '安定区', 3, 'A', 1, 2636, '兰州', '', ''),
(102168, 420000, '湖北省', 420700, '鄂州市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(102169, 410000, '河南省', 410700, '新乡市', 410781, '卫辉市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102170, 630000, '青海省', 630100, '西宁市', 630101, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(102171, 370000, '山东省', 370600, '烟台市', 370612, '牟平区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102172, 370000, '山东省', 371300, '临沂市', 371311, '罗庄区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102173, 310000, '上海', 310100, '上海市', 310116, '金山区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(102174, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230207, '碾子山区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102175, 540000, '西藏自治区', 542200, '山南地区', 542221, '乃东县', 3, 'A', 2, 2308, '昆明', '', ''),
(102176, 350000, '福建省', 350800, '龙岩市', 350823, '上杭县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102177, 130000, '河北省', 130900, '沧州市', 130930, '孟村回族自治县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102178, 330000, '浙江省', 330100, '杭州市', 330122, '桐庐县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102179, 330000, '浙江省', 330200, '宁波市', 330282, '慈溪市', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102180, 450000, '广西壮族自治区', 451400, '崇左市', 451423, '龙州县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102181, 320000, '江苏省', 320300, '徐州市', 320381, '新沂市', 3, 'A', 1, 2639, '徐州', '', ''),
(102182, 410000, '河南省', 410300, '洛阳市', 410305, '涧西区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102183, 370000, '山东省', 371600, '滨州市', 371602, '滨城区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102184, 130000, '河北省', 130700, '张家口市', 130722, '张北县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102185, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522322, '兴仁县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102186, 130000, '河北省', 130700, '张家口市', 130702, '桥东区', 3, 'A', 1, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102187, 630000, '青海省', 632200, '海北州', 0, '', 2, 'A', 0, 0, '', '', ''),
(102188, 540000, '西藏自治区', 542300, '日喀则地区', 542335, '吉隆县', 3, 'A', 2, 2636, '兰州', '', ''),
(102189, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 632821, '乌兰县', 3, 'A', 2, 2636, '兰州', '', ''),
(102190, 410000, '河南省', 410500, '安阳市', 410503, '北关区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102191, 430000, '湖南省', 430400, '衡阳市', 430482, '常宁市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102192, 420000, '湖北省', 420300, '十堰市', 420324, '竹溪县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102193, 370000, '山东省', 371300, '临沂市', 371312, '河东区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102194, 450000, '广西壮族自治区', 450300, '桂林市', 450325, '兴安县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102195, 310000, '上海', 310100, '上海市', 310112, '闵行区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(102196, 120000, '天津', 120100, '天津市', 120114, '武清区', 3, 'A', 1, 2634, '天津', '', ''),
(102197, 140000, '山西省', 140100, '太原市', 140110, '晋源区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102198, 510000, '四川省', 511500, '宜宾市', 511523, '江安县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(102199, 520000, '贵州省', 520300, '遵义市', 520324, '正安县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102200, 510000, '四川省', 513400, '凉山彝族自治州', 513428, '普格县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102201, 130000, '河北省', 131000, '廊坊市', 131001, '其它区', 3, 'A', 1, 2634, '天津', '石家庄RDC电商库', 'D311'),
(102202, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222406, '和龙市', 3, 'A', 2, 2625, '长春', '', ''),
(102203, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(102204, 540000, '西藏自治区', 540100, '拉萨市', 540125, '堆龙德庆县', 3, 'A', 1, 2636, '兰州', '', ''),
(102205, 420000, '湖北省', 429055, '潜江市', 0, '', 2, 'D', 0, 0, '', '武汉RDC电商库', 'D027'),
(102206, 340000, '安徽省', 340800, '安庆市', 340811, '宜秀区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102207, 230000, '黑龙江省', 230900, '七台河市', 230904, '茄子河区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102208, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522629, '剑河县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102209, 340000, '安徽省', 340300, '蚌埠市', 340321, '怀远县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102210, 410000, '河南省', 410600, '鹤壁市', 410611, '淇滨区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102211, 450000, '广西壮族自治区', 451000, '百色市', 451023, '平果县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102212, 340000, '安徽省', 341300, '宿州市', 341323, '灵璧县', 3, 'A', 2, 2639, '徐州', '合肥RDC电商库', 'D551'),
(102213, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(102214, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652325, '奇台县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102215, 340000, '安徽省', 341000, '黄山市', 341004, '徽州区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102216, 440000, '广东省', 440300, '深圳市', 440307, '龙岗区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(102217, 320000, '江苏省', 320700, '连云港市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102218, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653131, '塔什库尔干塔吉克自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102219, 210000, '辽宁省', 211100, '盘锦市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(102220, 210000, '辽宁省', 210900, '阜新市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(102221, 150000, '内蒙古自治区', 150200, '包头市', 150205, '石拐区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102222, 450000, '广西壮族自治区', 450300, '桂林市', 450326, '永福县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102223, 150000, '内蒙古自治区', 150500, '通辽市', 150502, '科尔沁区', 3, 'A', 1, 2626, '沈阳', '', ''),
(102224, 370000, '山东省', 370200, '青岛市', 370201, '其它区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102225, 360000, '江西省', 360900, '宜春市', 360925, '靖安县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102226, 420000, '湖北省', 420600, '襄阳市', 420624, '南漳县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102227, 620000, '甘肃省', 620800, '平凉市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102228, 410000, '河南省', 411600, '周口市', 411628, '鹿邑县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102229, 630000, '青海省', 632700, '玉树藏族自治州', 632725, '囊谦县', 3, 'A', 2, 2636, '兰州', '', ''),
(102230, 610000, '陕西省', 610900, '安康市', 610921, '汉阴县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102231, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433127, '永顺县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102232, 140000, '山西省', 140200, '大同市', 140225, '浑源县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102233, 370000, '山东省', 371600, '滨州市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(102234, 450000, '广西壮族自治区', 450700, '钦州市', 450703, '钦北区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102235, 530000, '云南省', 530400, '玉溪市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102236, 410000, '河南省', 410800, '焦作市', 410882, '沁阳市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102237, 140000, '山西省', 140100, '太原市', 140108, '尖草坪区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102238, 230000, '黑龙江省', 230300, '鸡西市', 230305, '梨树区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102239, 130000, '河北省', 130300, '秦皇岛市', 130303, '山海关区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102240, 140000, '山西省', 141100, '吕梁市', 141128, '方山县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102241, 330000, '浙江省', 331000, '台州市', 331001, '其它区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(102242, 440000, '广东省', 445200, '揭阳市', 445224, '惠来县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102243, 430000, '湖南省', 430800, '张家界市', 430801, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102244, 510000, '四川省', 511300, '南充市', 511302, '顺庆区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(102245, 640000, '宁夏回族自治区', 640400, '固原市', 640424, '泾源县', 3, 'A', 2, 2647, '西安', '', ''),
(102246, 420000, '湖北省', 420300, '十堰市', 420303, '张湾区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102247, 420000, '湖北省', 421200, '咸宁市', 421221, '嘉鱼县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102248, 310000, '上海', 310100, '上海市', 310110, '杨浦区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(102249, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522627, '天柱县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102250, 210000, '辽宁省', 210900, '阜新市', 210921, '阜新蒙古族自治县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102251, 360000, '江西省', 361100, '上饶市', 361122, '广丰县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102252, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150927, '察哈尔右翼中旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102253, 340000, '安徽省', 340500, '马鞍山市', 340501, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102254, 210000, '辽宁省', 210800, '营口市', 210804, '鲅鱼圈区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102255, 130000, '河北省', 130600, '保定市', 130637, '博野县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102256, 230000, '黑龙江省', 230800, '佳木斯市', 230805, '东风区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102257, 360000, '江西省', 360700, '赣州市', 360734, '寻乌县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102258, 210000, '辽宁省', 210400, '抚顺市', 210403, '东洲区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102259, 540000, '西藏自治区', 542400, '那曲地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(102260, 220000, '吉林省', 220100, '长春市', 220181, '九台市', 3, 'A', 1, 2625, '长春', '', ''),
(102261, 530000, '云南省', 530400, '玉溪市', 530428, '元江哈尼族彝族傣族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102262, 430000, '湖南省', 431000, '郴州市', 431025, '临武县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102263, 430000, '湖南省', 430100, '长沙市', 430101, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102264, 350000, '福建省', 350800, '龙岩市', 350821, '长汀县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102265, 320000, '江苏省', 321100, '镇江市', 321183, '句容市', 3, 'A', 1, 2604, '南京', '', ''),
(102266, 530000, '云南省', 530100, '昆明市', 530101, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102267, 230000, '黑龙江省', 231000, '牡丹江市', 231004, '爱民区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102268, 410000, '河南省', 410900, '濮阳市', 410927, '台前县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102269, 450000, '广西壮族自治区', 450400, '梧州市', 450405, '长洲区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102270, 340000, '安徽省', 340700, '铜陵市', 340701, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102271, 450000, '广西壮族自治区', 450200, '柳州市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(102272, 130000, '河北省', 130600, '保定市', 130603, '北市区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102273, 610000, '陕西省', 610600, '延安市', 610623, '子长县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102274, 350000, '福建省', 350600, '漳州市', 350626, '东山县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102275, 320000, '江苏省', 320100, '南京市', 320102, '玄武区', 3, 'A', 1, 2604, '南京', '', ''),
(102276, 350000, '福建省', 350500, '泉州市', 350526, '德化县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102277, 620000, '甘肃省', 620700, '张掖市', 620701, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(102278, 320000, '江苏省', 320400, '常州市', 320412, '武进区', 3, 'A', 1, 2604, '南京', '', ''),
(102279, 320000, '江苏省', 321000, '扬州市', 321081, '仪征市', 3, 'A', 1, 2663, '南通', '', ''),
(102280, 420000, '湖北省', 420500, '宜昌市', 420502, '西陵区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102281, 510000, '四川省', 510300, '自贡市', 510311, '沿滩区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(102282, 320000, '江苏省', 320100, '南京市', 320107, '下关区', 3, 'A', 1, 2604, '南京', '', ''),
(102283, 330000, '浙江省', 330400, '嘉兴市', 330482, '平湖市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102284, 210000, '辽宁省', 211300, '朝阳市', 211301, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102285, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152527, '太仆寺旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102286, 620000, '甘肃省', 622900, '临夏回族自治州', 622901, '临夏市', 3, 'A', 1, 2636, '兰州', '', ''),
(102287, 620000, '甘肃省', 620200, '嘉峪关市', 620201, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(102288, 420000, '湖北省', 421000, '荆州市', 421024, '江陵县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102289, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102290, 460000, '海南省', 469000, '省直辖县级行政区划', 0, '', 2, 'D', 0, 0, '', '', ''),
(102291, 610000, '陕西省', 610300, '宝鸡市', 610330, '凤县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102292, 150000, '内蒙古自治区', 150400, '赤峰市', 150404, '松山区', 3, 'A', 1, 2633, '唐山', '', ''),
(102293, 150000, '内蒙古自治区', 150400, '赤峰市', 150424, '林西县', 3, 'A', 2, 2633, '唐山', '', ''),
(102294, 320000, '江苏省', 321000, '扬州市', 321084, '高邮市', 3, 'A', 1, 2663, '南通', '', ''),
(102295, 360000, '江西省', 360800, '吉安市', 360826, '泰和县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102296, 440000, '广东省', 440900, '茂名市', 440982, '化州市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102297, 440000, '广东省', 440700, '江门市', 440701, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102298, 210000, '辽宁省', 210200, '大连市', 210211, '甘井子区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102299, 360000, '江西省', 361000, '抚州市', 361002, '临川区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102300, 540000, '西藏自治区', 542400, '那曲地区', 542429, '巴青县', 3, 'A', 2, 2308, '昆明', '', ''),
(102301, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654224, '托里县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102302, 410000, '河南省', 410100, '郑州市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102303, 130000, '河北省', 130100, '石家庄市', 130105, '新华区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102304, 230000, '黑龙江省', 230600, '大庆市', 230604, '让胡路区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102305, 320000, '江苏省', 321000, '扬州市', 321001, '其它区', 3, 'A', 1, 2663, '南通', '', ''),
(102306, 320000, '江苏省', 320600, '南通市', 320623, '如东县', 3, 'A', 2, 2663, '南通', '', ''),
(102307, 140000, '山西省', 140900, '忻州市', 140902, '忻府区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102308, 130000, '河北省', 130700, '张家口市', 130732, '赤城县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102309, 350000, '福建省', 350200, '厦门市', 350213, '翔安区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102310, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653130, '巴楚县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102311, 130000, '河北省', 131100, '衡水市', 131128, '阜城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102312, 330000, '浙江省', 330300, '温州市', 330326, '平阳县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(102313, 430000, '湖南省', 430800, '张家界市', 430811, '武陵源区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102314, 530000, '云南省', 530800, '普洱市', 530802, '思茅区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102315, 370000, '山东省', 371300, '临沂市', 371323, '沂水县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102316, 410000, '河南省', 410500, '安阳市', 410581, '林州市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102317, 510000, '四川省', 511400, '眉山市', 511422, '彭山县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(102318, 360000, '江西省', 360700, '赣州市', 360782, '南康市', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102319, 310000, '上海', 310100, '上海市', 310117, '松江区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(102320, 360000, '江西省', 360800, '吉安市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(102321, 420000, '湖北省', 0, '', 0, '', 1, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(102322, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150622, '准格尔旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102323, 610000, '陕西省', 610600, '延安市', 610632, '黄陵县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102324, 370000, '山东省', 370700, '潍坊市', 370724, '临朐县', 3, 'A', 2, 2601, '青岛', '济南RDC电商库', 'D531'),
(102325, 440000, '广东省', 445300, '云浮市', 445381, '罗定市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102326, 620000, '甘肃省', 623000, '甘南藏族自治州', 623022, '卓尼县', 3, 'A', 2, 2636, '兰州', '', ''),
(102327, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(102328, 430000, '湖南省', 430700, '常德市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(102329, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650106, '头屯河区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102330, 130000, '河北省', 130300, '秦皇岛市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(102331, 320000, '江苏省', 320700, '连云港市', 320703, '连云区', 3, 'A', 1, 2608, '临沂', '', ''),
(102332, 510000, '四川省', 511100, '乐山市', 511123, '犍为县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(102333, 510000, '四川省', 510500, '泸州市', 510522, '合江县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(102334, 130000, '河北省', 131100, '衡水市', 131123, '武强县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102335, 430000, '湖南省', 430600, '岳阳市', 430624, '湘阴县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102336, 540000, '西藏自治区', 542100, '昌都地区', 542125, '丁青县', 3, 'A', 2, 2636, '兰州', '', ''),
(102337, 360000, '江西省', 360200, '景德镇市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(102338, 140000, '山西省', 140200, '大同市', 140223, '广灵县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102339, 130000, '河北省', 130600, '保定市', 130627, '唐县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102340, 340000, '安徽省', 341200, '阜阳市', 341203, '颍东区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102341, 420000, '湖北省', 420300, '十堰市', 420321, '郧县', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102342, 220000, '吉林省', 220100, '长春市', 220101, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(102343, 230000, '黑龙江省', 230400, '鹤岗市', 230403, '工农区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102344, 210000, '辽宁省', 210600, '丹东市', 210603, '振兴区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102345, 360000, '江西省', 360400, '九江市', 360425, '永修县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102346, 440000, '广东省', 440800, '湛江市', 440883, '吴川市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102347, 440000, '广东省', 440200, '韶关市', 440281, '乐昌市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102348, 320000, '江苏省', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(102349, 530000, '云南省', 532600, '文山壮族苗族自治州', 532626, '丘北县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102350, 430000, '湖南省', 431300, '娄底市', 431382, '涟源市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102351, 540000, '西藏自治区', 542400, '那曲地区', 542424, '聂荣县', 3, 'A', 2, 2308, '昆明', '', ''),
(102352, 130000, '河北省', 130500, '邢台市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(102353, 530000, '云南省', 530100, '昆明市', 530125, '宜良县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102354, 520000, '贵州省', 520400, '安顺市', 520423, '镇宁布依族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102355, 330000, '浙江省', 330500, '湖州市', 330523, '安吉县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102356, 370000, '山东省', 370800, '济宁市', 370826, '微山县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102357, 370000, '山东省', 371500, '聊城市', 371525, '冠县', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102358, 360000, '江西省', 360100, '南昌市', 360121, '南昌县', 3, 'A', 2, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(102359, 370000, '山东省', 370400, '枣庄市', 370403, '薛城区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102360, 410000, '河南省', 411100, '漯河市', 411103, '郾城区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102361, 410000, '河南省', 410800, '焦作市', 410821, '修武县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102362, 210000, '辽宁省', 210300, '鞍山市', 210303, '铁西区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102363, 130000, '河北省', 130200, '唐山市', 130223, '滦县', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102364, 520000, '贵州省', 520100, '贵阳市', 520121, '开阳县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102365, 510000, '四川省', 513400, '凉山彝族自治州', 513430, '金阳县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102366, 140000, '山西省', 141000, '临汾市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(102367, 420000, '湖北省', 421000, '荆州市', 421022, '公安县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102368, 440000, '广东省', 445300, '云浮市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102369, 210000, '辽宁省', 210700, '锦州市', 210781, '凌海市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102370, 320000, '江苏省', 320800, '淮安市', 320803, '淮安区', 3, 'A', 1, 2639, '徐州', '', ''),
(102371, 520000, '贵州省', 520300, '遵义市', 520323, '绥阳县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102372, 510000, '四川省', 511900, '巴中市', 511922, '南江县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(102373, 320000, '江苏省', 321300, '宿迁市', 321322, '沭阳县', 3, 'A', 2, 2639, '徐州', '', ''),
(102374, 370000, '山东省', 370200, '青岛市', 370281, '胶州市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102375, 140000, '山西省', 140900, '忻州市', 140932, '偏关县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102376, 320000, '江苏省', 320300, '徐州市', 320305, '贾汪区', 3, 'A', 1, 2639, '徐州', '', ''),
(102377, 370000, '山东省', 371400, '德州市', 371425, '齐河县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102378, 450000, '广西壮族自治区', 450300, '桂林市', 450329, '资源县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102379, 360000, '江西省', 361000, '抚州市', 361030, '广昌县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102380, 520000, '贵州省', 520100, '贵阳市', 520101, '其它区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102381, 610000, '陕西省', 610200, '铜川市', 610204, '耀州区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102382, 230000, '黑龙江省', 231000, '牡丹江市', 231081, '绥芬河市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102383, 130000, '河北省', 131000, '廊坊市', 131025, '大城县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(102384, 430000, '湖南省', 430700, '常德市', 430701, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102385, 370000, '山东省', 370800, '济宁市', 370828, '金乡县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102386, 140000, '山西省', 141100, '吕梁市', 141182, '汾阳市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102387, 520000, '贵州省', 520200, '六盘水市', 520203, '六枝特区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102388, 420000, '湖北省', 421300, '随州市', 421381, '广水市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102389, 510000, '四川省', 511000, '内江市', 511001, '其它区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(102390, 500000, '重庆', 0, '', 0, '', 1, 'A', 0, 0, '', '重庆RDC电商库', 'D023'),
(102391, 440000, '广东省', 440100, '广州市', 440104, '越秀区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102392, 410000, '河南省', 410200, '开封市', 410203, '顺河回族区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102393, 210000, '辽宁省', 0, '', 0, '', 1, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(102394, 210000, '辽宁省', 210100, '沈阳市', 210112, '东陵区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102395, 330000, '浙江省', 330700, '金华市', 330726, '浦江县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102396, 350000, '福建省', 350400, '三明市', 350403, '三元区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(102397, 630000, '青海省', 632500, '海南州', 632522, '同德县', 3, 'A', 2, 2636, '兰州', '', ''),
(102398, 410000, '河南省', 410800, '焦作市', 410803, '中站区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102399, 440000, '广东省', 440100, '广州市', 440113, '番禺区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102400, 510000, '四川省', 511500, '宜宾市', 511529, '屏山县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(102401, 130000, '河北省', 130900, '沧州市', 130984, '河间市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102402, 230000, '黑龙江省', 230800, '佳木斯市', 230881, '同江市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102403, 410000, '河南省', 410200, '开封市', 410222, '通许县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102404, 370000, '山东省', 371000, '威海市', 371083, '乳山市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102405, 320000, '江苏省', 320300, '徐州市', 320382, '邳州市', 3, 'A', 1, 2639, '徐州', '', ''),
(102406, 520000, '贵州省', 520300, '遵义市', 520381, '赤水市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102407, 440000, '广东省', 441400, '梅州市', 441401, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102408, 610000, '陕西省', 610700, '汉中市', 610726, '宁强县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102409, 420000, '湖北省', 421200, '咸宁市', 421201, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102410, 340000, '安徽省', 341100, '滁州市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(102411, 410000, '河南省', 411700, '驻马店市', 411723, '平舆县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102412, 410000, '河南省', 411700, '驻马店市', 411725, '确山县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102413, 620000, '甘肃省', 621000, '庆阳市', 621021, '庆城县', 3, 'A', 2, 2636, '兰州', '', ''),
(102414, 330000, '浙江省', 330100, '杭州市', 330182, '建德市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102415, 450000, '广西壮族自治区', 450100, '南宁市', 450105, '江南区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102416, 440000, '广东省', 445200, '揭阳市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102417, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150701, '其它区', 3, 'A', 1, 2629, '哈尔滨', '', ''),
(102418, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150723, '鄂伦春自治旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(102419, 230000, '黑龙江省', 231200, '绥化市', 231222, '兰西县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102420, 510000, '四川省', 513300, '甘孜藏族自治州', 513332, '石渠县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102421, 540000, '西藏自治区', 542300, '日喀则地区', 542330, '仁布县', 3, 'A', 2, 2636, '兰州', '', ''),
(102422, 610000, '陕西省', 611000, '商洛市', 611021, '洛南县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102423, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230281, '讷河市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102424, 510000, '四川省', 510600, '德阳市', 510623, '中江县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102425, 510000, '四川省', 513400, '凉山彝族自治州', 513426, '会东县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102426, 530000, '云南省', 533400, '迪庆藏族自治州', 533423, '维西傈僳族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102427, 340000, '安徽省', 341600, '亳州市', 341601, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102428, 140000, '山西省', 140900, '忻州市', 140930, '河曲县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102429, 640000, '宁夏回族自治区', 640300, '吴忠市', 640303, '红寺堡区', 3, 'A', 1, 2647, '西安', '', ''),
(102430, 620000, '甘肃省', 622900, '临夏回族自治州', 622922, '康乐县', 3, 'A', 2, 2636, '兰州', '', ''),
(102431, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422802, '利川市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102432, 230000, '黑龙江省', 230500, '双鸭山市', 230524, '饶河县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102433, 530000, '云南省', 532600, '文山壮族苗族自治州', 532623, '西畴县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102434, 510000, '四川省', 513400, '凉山彝族自治州', 513423, '盐源县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102435, 330000, '浙江省', 330100, '杭州市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(102436, 330000, '浙江省', 331000, '台州市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(102437, 210000, '辽宁省', 210100, '沈阳市', 210103, '沈河区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102438, 440000, '广东省', 441800, '清远市', 441802, '清城区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102439, 500000, '重庆', 500100, '重庆市', 500106, '沙坪坝区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102440, 340000, '安徽省', 0, '', 0, '', 1, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(102441, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150921, '卓资县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102442, 510000, '四川省', 511700, '达州市', 511722, '宣汉县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(102443, 370000, '山东省', 371400, '德州市', 371481, '乐陵市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102444, 210000, '辽宁省', 211100, '盘锦市', 211121, '大洼县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102445, 360000, '江西省', 361000, '抚州市', 361029, '东乡县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102446, 340000, '安徽省', 341600, '亳州市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(102447, 210000, '辽宁省', 211000, '辽阳市', 211021, '辽阳县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102448, 230000, '黑龙江省', 230700, '伊春市', 230709, '金山屯区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102449, 510000, '四川省', 510700, '绵阳市', 510722, '三台县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102450, 210000, '辽宁省', 211000, '辽阳市', 211081, '灯塔市', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102451, 220000, '吉林省', 220300, '四平市', 220302, '铁西区', 3, 'A', 1, 2625, '长春', '', ''),
(102452, 620000, '甘肃省', 620300, '金昌市', 620301, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(102453, 150000, '内蒙古自治区', 150500, '通辽市', 150521, '科尔沁左翼中旗', 3, 'A', 2, 2626, '沈阳', '', ''),
(102454, 520000, '贵州省', 520300, '遵义市', 520330, '习水县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102455, 340000, '安徽省', 341100, '滁州市', 341181, '天长市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102456, 510000, '四川省', 513400, '凉山彝族自治州', 513401, '西昌市', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(102457, 420000, '湖北省', 429000, '省直辖县级行政区划', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(102458, 530000, '云南省', 532300, '楚雄彝族自治州', 532329, '武定县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102459, 610000, '陕西省', 610800, '榆林市', 610801, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102460, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102461, 460000, '海南省', 469000, '省直辖县级行政区划', 469021, '定安县', 3, 'D', 1, 0, '', '', ''),
(102462, 510000, '四川省', 511100, '乐山市', 511181, '峨眉山市', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(102463, 540000, '西藏自治区', 542300, '日喀则地区', 542332, '定结县', 3, 'A', 2, 2636, '兰州', '', ''),
(102464, 410000, '河南省', 411500, '信阳市', 411502, '?河区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102465, 150000, '内蒙古自治区', 150200, '包头市', 150222, '固阳县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102466, 430000, '湖南省', 430700, '常德市', 430722, '汉寿县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102467, 140000, '山西省', 140200, '大同市', 140203, '矿区', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102468, 420000, '湖北省', 429066, '天门市', 0, '', 2, 'D', 0, 0, '', '武汉RDC电商库', 'D027'),
(102469, 620000, '甘肃省', 620900, '酒泉市', 620982, '敦煌市', 3, 'A', 1, 2636, '兰州', '', '');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(102470, 230000, '黑龙江省', 230700, '伊春市', 230701, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102471, 330000, '浙江省', 330200, '宁波市', 330206, '北仑区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102472, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(102473, 350000, '福建省', 350400, '三明市', 350481, '永安市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(102474, 440000, '广东省', 441800, '清远市', 441826, '连南瑶族自治县', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102475, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150802, '临河区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102476, 420000, '湖北省', 429006, '天门市', 429006, '天门市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102477, 140000, '山西省', 140300, '阳泉市', 140322, '盂县', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102478, 130000, '河北省', 130700, '张家口市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(102479, 370000, '山东省', 371500, '聊城市', 371524, '东阿县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102480, 130000, '河北省', 130600, '保定市', 130601, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102481, 370000, '山东省', 370300, '淄博市', 370303, '张店区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102482, 130000, '河北省', 130500, '邢台市', 130535, '临西县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102483, 430000, '湖南省', 430900, '益阳市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(102484, 360000, '江西省', 360200, '景德镇市', 360222, '浮梁县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102485, 210000, '辽宁省', 211300, '朝阳市', 211381, '北票市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102486, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522623, '施秉县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102487, 450000, '广西壮族自治区', 450800, '贵港市', 450802, '港北区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102488, 410000, '河南省', 410700, '新乡市', 410782, '辉县市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102489, 510000, '四川省', 513300, '甘孜藏族自治州', 513322, '泸定县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102490, 330000, '浙江省', 330600, '绍兴市', 330602, '越城区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102491, 320000, '江苏省', 320700, '连云港市', 320723, '灌云县', 3, 'A', 2, 2608, '临沂', '', ''),
(102492, 370000, '山东省', 0, '', 0, '', 1, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(102493, 360000, '江西省', 360700, '赣州市', 360725, '崇义县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102494, 420000, '湖北省', 420900, '孝感市', 420922, '大悟县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102495, 450000, '广西壮族自治区', 451200, '河池市', 451226, '环江毛南族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102496, 210000, '辽宁省', 210800, '营口市', 210811, '老边区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102497, 340000, '安徽省', 341200, '阜阳市', 341202, '颍州区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102498, 110000, '北京', 110100, '北京市', 110103, '崇文区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(102499, 460000, '海南省', 469000, '省直辖县级行政区划', 469007, '东方市', 3, 'D', 1, 0, '', '', ''),
(102500, 210000, '辽宁省', 211400, '葫芦岛市', 211404, '南票区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102501, 330000, '浙江省', 331000, '台州市', 331023, '天台县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(102502, 540000, '西藏自治区', 542300, '日喀则地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(102503, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230225, '甘南县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102504, 130000, '河北省', 130700, '张家口市', 130724, '沽源县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102505, 510000, '四川省', 512000, '资阳市', 512081, '简阳市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102506, 510000, '四川省', 510700, '绵阳市', 510723, '盐亭县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102507, 540000, '西藏自治区', 542300, '日喀则地区', 542327, '昂仁县', 3, 'A', 2, 2636, '兰州', '', ''),
(102508, 520000, '贵州省', 520300, '遵义市', 520327, '凤冈县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102509, 350000, '福建省', 350800, '龙岩市', 350822, '永定县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102510, 220000, '吉林省', 220600, '白山市', 220621, '抚松县', 3, 'A', 2, 2625, '长春', '', ''),
(102511, 330000, '浙江省', 330400, '嘉兴市', 330483, '桐乡市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102512, 410000, '河南省', 411700, '驻马店市', 411726, '泌阳县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102513, 510000, '四川省', 511600, '广安市', 511602, '广安区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(102514, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230229, '克山县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102515, 530000, '云南省', 530300, '曲靖市', 530301, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102516, 230000, '黑龙江省', 230800, '佳木斯市', 230804, '前进区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102517, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522633, '从江县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102518, 540000, '西藏自治区', 542300, '日喀则地区', 542326, '拉孜县', 3, 'A', 2, 2636, '兰州', '', ''),
(102519, 440000, '广东省', 441600, '河源市', 441621, '紫金县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102520, 430000, '湖南省', 430300, '湘潭市', 430321, '湘潭县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102521, 430000, '湖南省', 430600, '岳阳市', 430681, '汨罗市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102522, 530000, '云南省', 530400, '玉溪市', 530401, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102523, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653201, '和田市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102524, 120000, '天津', 120100, '天津市', 120105, '河北区', 3, 'A', 1, 2634, '天津', '', ''),
(102525, 410000, '河南省', 411300, '南阳市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102526, 360000, '江西省', 360200, '景德镇市', 360201, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102527, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150122, '托克托县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102528, 210000, '辽宁省', 210100, '沈阳市', 210111, '苏家屯区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102529, 350000, '福建省', 350400, '三明市', 350424, '宁化县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(102530, 230000, '黑龙江省', 230800, '佳木斯市', 230811, '郊区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102531, 440000, '广东省', 445200, '揭阳市', 445201, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102532, 530000, '云南省', 532900, '大理白族自治州', 532929, '云龙县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102533, 350000, '福建省', 350500, '泉州市', 350583, '南安市', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102534, 430000, '湖南省', 430200, '株洲市', 430225, '炎陵县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102535, 440000, '广东省', 445200, '揭阳市', 445281, '普宁市', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102536, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652302, '阜康市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102537, 230000, '黑龙江省', 230700, '伊春市', 230702, '伊春区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102538, 430000, '湖南省', 430600, '岳阳市', 430623, '华容县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102539, 370000, '山东省', 371700, '菏泽市', 371722, '单县', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102540, 360000, '江西省', 360400, '九江市', 360428, '都昌县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102541, 440000, '广东省', 440200, '韶关市', 440222, '始兴县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(102542, 360000, '江西省', 360800, '吉安市', 360827, '遂川县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102543, 210000, '辽宁省', 210300, '鞍山市', 210323, '岫岩满族自治县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102544, 510000, '四川省', 510900, '遂宁市', 510901, '其它区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(102545, 370000, '山东省', 370900, '泰安市', 370983, '肥城市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102546, 340000, '安徽省', 341600, '亳州市', 341621, '涡阳县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102547, 410000, '河南省', 411400, '商丘市', 411422, '睢县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102548, 230000, '黑龙江省', 230700, '伊春市', 230710, '五营区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102549, 440000, '广东省', 441600, '河源市', 441622, '龙川县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102550, 420000, '湖北省', 420600, '襄阳市', 420682, '老河口市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102551, 410000, '河南省', 411300, '南阳市', 411328, '唐河县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102552, 530000, '云南省', 530600, '昭通市', 530621, '鲁甸县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(102553, 370000, '山东省', 370600, '烟台市', 370601, '其它区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102554, 340000, '安徽省', 340100, '合肥市', 340101, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102555, 370000, '山东省', 370800, '济宁市', 370829, '嘉祥县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102556, 210000, '辽宁省', 210200, '大连市', 210213, '金州区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102557, 620000, '甘肃省', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(102558, 450000, '广西壮族自治区', 451200, '河池市', 451225, '罗城仫佬族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102559, 140000, '山西省', 140200, '大同市', 140212, '新荣区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102560, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513221, '汶川县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102561, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152530, '正蓝旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102562, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650109, '米东区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102563, 430000, '湖南省', 431300, '娄底市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(102564, 230000, '黑龙江省', 230500, '双鸭山市', 230521, '集贤县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102565, 440000, '广东省', 441800, '清远市', 441823, '阳山县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(102566, 340000, '安徽省', 340100, '合肥市', 341401, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102567, 450000, '广西壮族自治区', 450300, '桂林市', 450331, '荔浦县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102568, 540000, '西藏自治区', 542300, '日喀则地区', 542337, '萨嘎县', 3, 'A', 2, 2636, '兰州', '', ''),
(102569, 530000, '云南省', 530800, '普洱市', 530829, '西盟佤族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102570, 430000, '湖南省', 430800, '张家界市', 430822, '桑植县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102571, 530000, '云南省', 530800, '普洱市', 530822, '墨江哈尼族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102572, 340000, '安徽省', 340600, '淮北市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(102573, 130000, '河北省', 130700, '张家口市', 130705, '宣化区', 3, 'A', 1, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102574, 620000, '甘肃省', 620100, '兰州市', 620102, '城关区', 3, 'A', 1, 2636, '兰州', '', ''),
(102575, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652829, '博湖县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102576, 140000, '山西省', 140900, '忻州市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(102577, 320000, '江苏省', 320200, '无锡市', 320202, '崇安区', 3, 'A', 1, 2664, '无锡', '', ''),
(102578, 320000, '江苏省', 320800, '淮安市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102579, 210000, '辽宁省', 211400, '葫芦岛市', 211402, '连山区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102580, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653224, '洛浦县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102581, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652328, '木垒哈萨克自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102582, 370000, '山东省', 371200, '莱芜市', 371203, '钢城区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102583, 500000, '重庆', 500100, '重庆市', 500241, '秀山土家族苗族自治县', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102584, 210000, '辽宁省', 211400, '葫芦岛市', 211481, '兴城市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102585, 610000, '陕西省', 610800, '榆林市', 610802, '榆阳区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102586, 140000, '山西省', 140600, '朔州市', 140622, '应县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102587, 520000, '贵州省', 520400, '安顺市', 520402, '西秀区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102588, 530000, '云南省', 530900, '临沧市', 530924, '镇康县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102589, 220000, '吉林省', 220700, '松原市', 220701, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(102590, 230000, '黑龙江省', 230600, '大庆市', 230622, '肇源县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102591, 520000, '贵州省', 520300, '遵义市', 520382, '仁怀市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102592, 410000, '河南省', 410900, '濮阳市', 410926, '范县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102593, 620000, '甘肃省', 620100, '兰州市', 620122, '皋兰县', 3, 'A', 2, 2636, '兰州', '', ''),
(102594, 370000, '山东省', 371600, '滨州市', 371623, '无棣县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102595, 530000, '云南省', 530600, '昭通市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(102596, 510000, '四川省', 510100, '成都市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102597, 350000, '福建省', 350500, '泉州市', 350502, '鲤城区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102598, 450000, '广西壮族自治区', 450300, '桂林市', 450304, '象山区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102599, 350000, '福建省', 350400, '三明市', 350426, '尤溪县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(102600, 430000, '湖南省', 430400, '衡阳市', 430412, '南岳区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102601, 420000, '湖北省', 429004, '仙桃市', 429004, '仙桃市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102602, 410000, '河南省', 410800, '焦作市', 410802, '解放区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102603, 420000, '湖北省', 420300, '十堰市', 420325, '房县', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102604, 370000, '山东省', 371300, '临沂市', 371301, '其它区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102605, 520000, '贵州省', 520400, '安顺市', 520424, '关岭布依族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102606, 370000, '山东省', 371000, '威海市', 371082, '荣成市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102607, 500000, '重庆', 500100, '重庆市', 500225, '大足区', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102608, 360000, '江西省', 360300, '萍乡市', 360321, '莲花县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102609, 610000, '陕西省', 610600, '延安市', 610631, '黄龙县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102610, 340000, '安徽省', 341700, '池州市', 341721, '东至县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102611, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150981, '丰镇市', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102612, 450000, '广西壮族自治区', 450300, '桂林市', 450311, '雁山区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102613, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 632823, '天峻县', 3, 'A', 2, 2636, '兰州', '', ''),
(102614, 140000, '山西省', 141100, '吕梁市', 141121, '文水县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102615, 530000, '云南省', 530300, '曲靖市', 530326, '会泽县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102616, 430000, '湖南省', 430200, '株洲市', 430281, '醴陵市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102617, 350000, '福建省', 350700, '南平市', 350724, '松溪县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(102618, 340000, '安徽省', 340800, '安庆市', 340824, '潜山县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102619, 350000, '福建省', 350600, '漳州市', 350622, '云霄县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102620, 410000, '河南省', 411000, '许昌市', 411081, '禹州市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102621, 430000, '湖南省', 430900, '益阳市', 430902, '资阳区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102622, 450000, '广西壮族自治区', 450600, '防城港市', 450621, '上思县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102623, 530000, '云南省', 530400, '玉溪市', 530423, '通海县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102624, 330000, '浙江省', 330300, '温州市', 330303, '龙湾区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(102625, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152529, '正镶白旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102626, 610000, '陕西省', 610800, '榆林市', 610823, '横山县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102627, 210000, '辽宁省', 211300, '朝阳市', 211321, '朝阳县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(102628, 630000, '青海省', 632600, '果洛州', 0, '', 2, 'A', 0, 0, '', '', ''),
(102629, 540000, '西藏自治区', 542500, '阿里地区', 542522, '札达县', 3, 'A', 2, 2636, '兰州', '', ''),
(102630, 410000, '河南省', 410300, '洛阳市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102631, 140000, '山西省', 140400, '长治市', 140429, '武乡县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102632, 320000, '江苏省', 320300, '徐州市', 320302, '鼓楼区', 3, 'A', 1, 2639, '徐州', '', ''),
(102633, 350000, '福建省', 350900, '宁德市', 350901, '其它区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(102634, 150000, '内蒙古自治区', 150200, '包头市', 150203, '昆都仑区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102635, 340000, '安徽省', 340800, '安庆市', 340823, '枞阳县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102636, 530000, '云南省', 530500, '保山市', 530524, '昌宁县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102637, 530000, '云南省', 530700, '丽江市', 530721, '玉龙纳西族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102638, 210000, '辽宁省', 211200, '铁岭市', 211224, '昌图县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102639, 430000, '湖南省', 430200, '株洲市', 430211, '天元区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102640, 540000, '西藏自治区', 542200, '山南地区', 542227, '措美县', 3, 'A', 2, 2308, '昆明', '', ''),
(102641, 140000, '山西省', 140500, '晋城市', 140525, '泽州县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102642, 130000, '河北省', 130600, '保定市', 130682, '定州市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102643, 510000, '四川省', 510800, '广元市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102644, 360000, '江西省', 360700, '赣州市', 360724, '上犹县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102645, 420000, '湖北省', 421200, '咸宁市', 421281, '赤壁市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102646, 510000, '四川省', 510100, '成都市', 510129, '大邑县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102647, 440000, '广东省', 445100, '潮州市', 445102, '湘桥区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102648, 410000, '河南省', 411600, '周口市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102649, 230000, '黑龙江省', 0, '', 0, '', 1, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(102650, 340000, '安徽省', 340200, '芜湖市', 340201, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102651, 130000, '河北省', 130400, '邯郸市', 130428, '肥乡县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102652, 650000, '新疆维吾尔自治区', 652200, '哈密地区', 652201, '哈密市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102653, 230000, '黑龙江省', 230700, '伊春市', 230711, '乌马河区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102654, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532526, '弥勒市', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102655, 330000, '浙江省', 330100, '杭州市', 330104, '江干区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102656, 450000, '广西壮族自治区', 450600, '防城港市', 450601, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102657, 330000, '浙江省', 330600, '绍兴市', 330683, '嵊州市', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102658, 370000, '山东省', 370200, '青岛市', 370213, '李沧区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102659, 610000, '陕西省', 610900, '安康市', 610902, '汉滨区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102660, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150784, '额尔古纳市', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(102661, 520000, '贵州省', 522200, '铜仁市', 522230, '万山区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102662, 150000, '内蒙古自治区', 150400, '赤峰市', 150403, '元宝山区', 3, 'A', 1, 2633, '唐山', '', ''),
(102663, 510000, '四川省', 511100, '乐山市', 511111, '沙湾区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(102664, 150000, '内蒙古自治区', 150500, '通辽市', 150524, '库伦旗', 3, 'A', 2, 2626, '沈阳', '', ''),
(102665, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522325, '贞丰县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102666, 210000, '辽宁省', 210800, '营口市', 210801, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102667, 510000, '四川省', 511100, '乐山市', 511133, '马边彝族自治县', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(102668, 340000, '安徽省', 340200, '芜湖市', 340207, '鸠江区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102669, 610000, '陕西省', 610300, '宝鸡市', 610326, '眉县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102670, 350000, '福建省', 350800, '龙岩市', 350881, '漳平市', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102671, 370000, '山东省', 371600, '滨州市', 371624, '沾化县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102672, 450000, '广西壮族自治区', 451000, '百色市', 451001, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102673, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654026, '昭苏县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102674, 350000, '福建省', 350400, '三明市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(102675, 330000, '浙江省', 330700, '金华市', 330702, '婺城区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102676, 230000, '黑龙江省', 231100, '黑河市', 231101, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102677, 450000, '广西壮族自治区', 450100, '南宁市', 450124, '马山县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102678, 130000, '河北省', 130100, '石家庄市', 130107, '井陉矿区', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102679, 510000, '四川省', 510100, '成都市', 510113, '青白江区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102680, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150103, '回民区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102681, 370000, '山东省', 371000, '威海市', 371001, '其它区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102682, 330000, '浙江省', 331000, '台州市', 331022, '三门县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(102683, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654325, '青河县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102684, 410000, '河南省', 411000, '许昌市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102685, 140000, '山西省', 141000, '临汾市', 141033, '蒲县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102686, 370000, '山东省', 371700, '菏泽市', 371728, '东明县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102687, 450000, '广西壮族自治区', 450200, '柳州市', 450205, '柳北区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102688, 610000, '陕西省', 610400, '咸阳市', 610430, '淳化县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102689, 320000, '江苏省', 320500, '苏州市', 320581, '常熟市', 3, 'A', 1, 2664, '无锡', '', ''),
(102690, 420000, '湖北省', 420800, '荆门市', 420801, '其它区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102691, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150902, '集宁区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102692, 540000, '西藏自治区', 542300, '日喀则地区', 542322, '南木林县', 3, 'A', 1, 2636, '兰州', '', ''),
(102693, 610000, '陕西省', 610200, '铜川市', 610222, '宜君县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102694, 370000, '山东省', 370300, '淄博市', 370306, '周村区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102695, 510000, '四川省', 510700, '绵阳市', 510726, '北川羌族自治县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102696, 620000, '甘肃省', 623000, '甘南藏族自治州', 623026, '碌曲县', 3, 'A', 2, 2636, '兰州', '', ''),
(102697, 370000, '山东省', 371100, '日照市', 371121, '五莲县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102698, 440000, '广东省', 441400, '梅州市', 441426, '平远县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102699, 130000, '河北省', 131100, '衡水市', 131127, '景县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102700, 420000, '湖北省', 421000, '荆州市', 421083, '洪湖市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102701, 410000, '河南省', 411300, '南阳市', 411302, '宛城区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102702, 500000, '重庆', 500100, '重庆市', 500103, '渝中区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102703, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653226, '于田县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102704, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522723, '贵定县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102705, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222426, '安图县', 3, 'A', 2, 2625, '长春', '', ''),
(102706, 130000, '河北省', 130900, '沧州市', 130903, '运河区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102707, 150000, '内蒙古自治区', 150400, '赤峰市', 150423, '巴林右旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102708, 140000, '山西省', 140700, '晋中市', 140702, '榆次区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102709, 440000, '广东省', 440500, '汕头市', 440513, '潮阳区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102710, 360000, '江西省', 361100, '上饶市', 361124, '铅山县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102711, 140000, '山西省', 140600, '朔州市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(102712, 410000, '河南省', 410200, '开封市', 410202, '龙亭区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102713, 510000, '四川省', 511500, '宜宾市', 511526, '珙县', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(102714, 510000, '四川省', 511500, '宜宾市', 511524, '长宁县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(102715, 440000, '广东省', 441700, '阳江市', 441723, '阳东县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(102716, 510000, '四川省', 511600, '广安市', 511623, '邻水县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(102717, 230000, '黑龙江省', 230100, '哈尔滨市', 230128, '通河县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102718, 370000, '山东省', 371700, '菏泽市', 371702, '牡丹区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102719, 510000, '四川省', 510100, '成都市', 510106, '金牛区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102720, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652923, '库车县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102721, 620000, '甘肃省', 620500, '天水市', 620524, '武山县', 3, 'A', 2, 2636, '兰州', '', ''),
(102722, 320000, '江苏省', 321200, '泰州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102723, 410000, '河南省', 410300, '洛阳市', 410323, '新安县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102724, 330000, '浙江省', 330100, '杭州市', 330105, '拱墅区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102725, 330000, '浙江省', 330200, '宁波市', 330211, '镇海区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102726, 320000, '江苏省', 321300, '宿迁市', 321311, '宿豫区', 3, 'A', 1, 2639, '徐州', '', ''),
(102727, 370000, '山东省', 370600, '烟台市', 370683, '莱州市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102728, 410000, '河南省', 410400, '平顶山市', 410403, '卫东区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102729, 150000, '内蒙古自治区', 150300, '乌海市', 150302, '海勃湾区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102730, 410000, '河南省', 410700, '新乡市', 410728, '长垣县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102731, 320000, '江苏省', 320500, '苏州市', 320584, '吴江区', 3, 'A', 1, 2664, '无锡', '', ''),
(102732, 640000, '宁夏回族自治区', 640100, '银川市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102733, 360000, '江西省', 360900, '宜春市', 360921, '奉新县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102734, 540000, '西藏自治区', 542500, '阿里地区', 542526, '改则县', 3, 'A', 2, 2636, '兰州', '', ''),
(102735, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650107, '达坂城区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102736, 220000, '吉林省', 220400, '辽源市', 220403, '西安区', 3, 'A', 1, 2625, '长春', '', ''),
(102737, 430000, '湖南省', 431100, '永州市', 431101, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102738, 410000, '河南省', 411300, '南阳市', 411322, '方城县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102739, 370000, '山东省', 370800, '济宁市', 370882, '兖州市', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102740, 450000, '广西壮族自治区', 450200, '柳州市', 450226, '三江侗族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102741, 520000, '贵州省', 522400, '毕节市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(102742, 140000, '山西省', 140200, '大同市', 140221, '阳高县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102743, 210000, '辽宁省', 210700, '锦州市', 210703, '凌河区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102744, 420000, '湖北省', 421100, '黄冈市', 421101, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102745, 410000, '河南省', 411700, '驻马店市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(102746, 330000, '浙江省', 330400, '嘉兴市', 330402, '南湖区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102747, 210000, '辽宁省', 211400, '葫芦岛市', 211403, '龙港区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(102748, 130000, '河北省', 131000, '廊坊市', 131023, '永清县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(102749, 370000, '山东省', 371500, '聊城市', 371526, '高唐县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102750, 360000, '江西省', 360700, '赣州市', 360728, '定南县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102751, 540000, '西藏自治区', 542600, '林芝地区', 542625, '波密县', 3, 'A', 2, 2308, '昆明', '', ''),
(102752, 130000, '河北省', 130100, '石家庄市', 130121, '井陉县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102753, 360000, '江西省', 360600, '鹰潭市', 360681, '贵溪市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102754, 610000, '陕西省', 610400, '咸阳市', 610423, '泾阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102755, 440000, '广东省', 440900, '茂名市', 440981, '高州市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102756, 440000, '广东省', 440500, '汕头市', 440511, '金平区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102757, 110000, '北京', 110100, '北京市', 110106, '丰台区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(102758, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(102759, 420000, '湖北省', 420500, '宜昌市', 420528, '长阳土家族自治县', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102760, 430000, '湖南省', 431000, '郴州市', 431026, '汝城县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102761, 410000, '河南省', 410100, '郑州市', 410104, '管城回族区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102762, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654002, '伊宁市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102763, 440000, '广东省', 440600, '佛山市', 440606, '顺德区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102764, 130000, '河北省', 130200, '唐山市', 130204, '古冶区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102765, 370000, '山东省', 370300, '淄博市', 370322, '高青县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102766, 510000, '四川省', 512000, '资阳市', 512001, '其它区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102767, 140000, '山西省', 140100, '太原市', 140121, '清徐县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102768, 410000, '河南省', 410500, '安阳市', 410502, '文峰区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102769, 360000, '江西省', 360400, '九江市', 360402, '庐山区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102770, 500000, '重庆', 500100, '重庆市', 500107, '九龙坡区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(102771, 620000, '甘肃省', 620300, '金昌市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102772, 410000, '河南省', 411400, '商丘市', 411425, '虞城县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102773, 530000, '云南省', 532800, '西双版纳傣族自治州', 532823, '勐腊县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102774, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652323, '呼图壁县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102775, 630000, '青海省', 632100, '海东市', 632121, '平安县', 3, 'A', 2, 2636, '兰州', '', ''),
(102776, 210000, '辽宁省', 210300, '鞍山市', 210304, '立山区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102777, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532501, '个旧市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102778, 130000, '河北省', 130700, '张家口市', 130726, '蔚县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102779, 620000, '甘肃省', 620100, '兰州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102780, 230000, '黑龙江省', 230900, '七台河市', 230902, '新兴区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102781, 620000, '甘肃省', 623000, '甘南藏族自治州', 623024, '迭部县', 3, 'A', 2, 2636, '兰州', '', ''),
(102782, 650000, '新疆维吾尔自治区', 659000, '自治区直辖县级行政区划', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(102783, 360000, '江西省', 360900, '宜春市', 360901, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102784, 510000, '四川省', 511400, '眉山市', 511425, '青神县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(102785, 340000, '安徽省', 340700, '铜陵市', 340711, '郊区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102786, 530000, '云南省', 530300, '曲靖市', 530323, '师宗县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102787, 370000, '山东省', 371500, '聊城市', 371523, '茌平县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102788, 420000, '湖北省', 420500, '宜昌市', 420505, '?亭区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102789, 140000, '山西省', 141000, '临汾市', 141023, '襄汾县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102790, 330000, '浙江省', 330200, '宁波市', 330212, '鄞州区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102791, 220000, '吉林省', 220300, '四平市', 220381, '公主岭市', 3, 'A', 2, 2625, '长春', '', ''),
(102792, 440000, '广东省', 441900, '东莞市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(102793, 360000, '江西省', 360300, '萍乡市', 360313, '湘东区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102794, 210000, '辽宁省', 211200, '铁岭市', 211202, '银州区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102795, 450000, '广西壮族自治区', 451100, '贺州市', 451123, '富川瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102796, 350000, '福建省', 350800, '龙岩市', 350801, '其它区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102797, 450000, '广西壮族自治区', 450900, '玉林市', 450901, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102798, 430000, '湖南省', 430200, '株洲市', 430221, '株洲县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102799, 370000, '山东省', 371600, '滨州市', 371622, '阳信县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102800, 510000, '四川省', 511300, '南充市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102801, 510000, '四川省', 510900, '遂宁市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102802, 410000, '河南省', 410700, '新乡市', 410702, '红旗区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102803, 610000, '陕西省', 610200, '铜川市', 610203, '印台区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102804, 430000, '湖南省', 431100, '永州市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(102805, 440000, '广东省', 440100, '广州市', 440183, '增城市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102806, 630000, '青海省', 630100, '西宁市', 630103, '城中区', 3, 'A', 1, 2636, '兰州', '', ''),
(102807, 370000, '山东省', 370100, '济南市', 370102, '历下区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(102808, 450000, '广西壮族自治区', 451000, '百色市', 451021, '田阳县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102809, 530000, '云南省', 533400, '迪庆藏族自治州', 533422, '德钦县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102810, 370000, '山东省', 370200, '青岛市', 370211, '黄岛区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102811, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150822, '磴口县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102812, 370000, '山东省', 370600, '烟台市', 370613, '莱山区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102813, 130000, '河北省', 130900, '沧州市', 130923, '东光县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102814, 320000, '江苏省', 321000, '扬州市', 321088, '江都区', 3, 'A', 1, 2663, '南通', '', ''),
(102815, 450000, '广西壮族自治区', 451200, '河池市', 451201, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102816, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230205, '昂昂溪区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102817, 220000, '吉林省', 220100, '长春市', 220102, '南关区', 3, 'A', 2, 2625, '长春', '', ''),
(102818, 370000, '山东省', 370300, '淄博市', 370321, '桓台县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102819, 360000, '江西省', 361000, '抚州市', 361028, '资溪县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102820, 360000, '江西省', 360200, '景德镇市', 360202, '昌江区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102821, 320000, '江苏省', 320100, '南京市', 320111, '浦口区', 3, 'A', 1, 2604, '南京', '', ''),
(102822, 350000, '福建省', 350600, '漳州市', 350629, '华安县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102823, 320000, '江苏省', 320800, '淮安市', 320802, '清河区', 3, 'A', 1, 2639, '徐州', '', ''),
(102824, 210000, '辽宁省', 210100, '沈阳市', 210114, '于洪区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102825, 510000, '四川省', 511700, '达州市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102826, 540000, '西藏自治区', 542300, '日喀则地区', 542333, '仲巴县', 3, 'A', 2, 2636, '兰州', '', ''),
(102827, 610000, '陕西省', 610400, '咸阳市', 610422, '三原县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102828, 230000, '黑龙江省', 230300, '鸡西市', 230306, '城子河区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102829, 450000, '广西壮族自治区', 451400, '崇左市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(102830, 330000, '浙江省', 330200, '宁波市', 330281, '余姚市', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(102831, 410000, '河南省', 410200, '开封市', 410211, '金明区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102832, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652922, '温宿县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102833, 150000, '内蒙古自治区', 152900, '阿拉善盟', 0, '', 2, 'A', 0, 0, '', '', ''),
(102834, 440000, '广东省', 440500, '汕头市', 440512, '濠江区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102835, 530000, '云南省', 530800, '普洱市', 530825, '镇沅彝族哈尼族拉祜族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102836, 220000, '吉林省', 220500, '通化市', 220523, '辉南县', 3, 'A', 2, 2625, '长春', '', ''),
(102837, 410000, '河南省', 410600, '鹤壁市', 410602, '鹤山区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102838, 620000, '甘肃省', 620500, '天水市', 620523, '甘谷县', 3, 'A', 2, 2636, '兰州', '', ''),
(102839, 440000, '广东省', 441500, '汕尾市', 441523, '陆河县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102840, 630000, '青海省', 630100, '西宁市', 630122, '湟中县', 3, 'A', 2, 2636, '兰州', '', ''),
(102841, 450000, '广西壮族自治区', 451100, '贺州市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(102842, 370000, '山东省', 371600, '滨州市', 371625, '博兴县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(102843, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152523, '苏尼特左旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102844, 140000, '山西省', 140700, '晋中市', 140724, '昔阳县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102845, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230224, '泰来县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102846, 130000, '河北省', 130600, '保定市', 130636, '顺平县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102847, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150623, '鄂托克前旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102848, 520000, '贵州省', 522400, '毕节市', 522427, '威宁彝族回族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102849, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152526, '西乌珠穆沁旗', 3, 'A', 2, 2633, '唐山', '', ''),
(102850, 460000, '海南省', 469000, '省直辖县级行政区划', 469001, '五指山市', 3, 'D', 1, 0, '', '', ''),
(102851, 140000, '山西省', 140900, '忻州市', 140981, '原平市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102852, 420000, '湖北省', 421100, '黄冈市', 421127, '黄梅县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102853, 430000, '湖南省', 431000, '郴州市', 431024, '嘉禾县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102854, 420000, '湖北省', 420800, '荆门市', 420822, '沙洋县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102855, 330000, '浙江省', 330700, '金华市', 330782, '义乌市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102856, 340000, '安徽省', 340100, '合肥市', 341421, '庐江县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102857, 340000, '安徽省', 340100, '合肥市', 340122, '肥东县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102858, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150726, '新巴尔虎左旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(102859, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522636, '丹寨县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102860, 610000, '陕西省', 610500, '渭南市', 610521, '华县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102861, 230000, '黑龙江省', 230400, '鹤岗市', 230407, '兴山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102862, 140000, '山西省', 140800, '运城市', 140882, '河津市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102863, 540000, '西藏自治区', 542100, '昌都地区', 542127, '八宿县', 3, 'A', 2, 2636, '兰州', '', ''),
(102864, 130000, '河北省', 130400, '邯郸市', 130401, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102865, 350000, '福建省', 350500, '泉州市', 350521, '惠安县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102866, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522731, '惠水县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102867, 420000, '湖北省', 420900, '孝感市', 420981, '应城市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102868, 530000, '云南省', 532300, '楚雄彝族自治州', 532327, '永仁县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102869, 610000, '陕西省', 610300, '宝鸡市', 610322, '凤翔县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(102870, 620000, '甘肃省', 623000, '甘南藏族自治州', 623027, '夏河县', 3, 'A', 2, 2636, '兰州', '', ''),
(102871, 540000, '西藏自治区', 542500, '阿里地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(102872, 440000, '广东省', 441200, '肇庆市', 441203, '鼎湖区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102873, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513228, '黑水县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(102874, 640000, '宁夏回族自治区', 640200, '石嘴山市', 640201, '其它区', 3, 'A', 1, 2647, '西安', '', ''),
(102875, 150000, '内蒙古自治区', 150300, '乌海市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102876, 610000, '陕西省', 610900, '安康市', 610901, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102877, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230221, '龙江县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102878, 440000, '广东省', 441900, '东莞市', 441901, '凤岗镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(102879, 110000, '北京', 110100, '北京市', 110105, '朝阳区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(102880, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522631, '黎平县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102881, 530000, '云南省', 530700, '丽江市', 530701, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102882, 140000, '山西省', 141100, '吕梁市', 141122, '交城县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102883, 360000, '江西省', 361100, '上饶市', 361129, '万年县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102884, 140000, '山西省', 140100, '太原市', 140107, '杏花岭区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102885, 130000, '河北省', 130200, '唐山市', 130283, '迁安市', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102886, 320000, '江苏省', 320700, '连云港市', 320705, '新浦区', 3, 'A', 1, 2608, '临沂', '', ''),
(102887, 370000, '山东省', 371300, '临沂市', 371329, '临沭县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(102888, 460000, '海南省', 469005, '文昌市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102889, 360000, '江西省', 360700, '赣州市', 360729, '全南县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(102890, 510000, '四川省', 513400, '凉山彝族自治州', 513425, '会理县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102891, 370000, '山东省', 371300, '临沂市', 371325, '费县', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102892, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230223, '依安县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102893, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150929, '四子王旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(102894, 120000, '天津', 120100, '天津市', 120111, '西青区', 3, 'A', 2, 2634, '天津', '', ''),
(102895, 140000, '山西省', 141000, '临汾市', 141028, '吉县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102896, 340000, '安徽省', 340200, '芜湖市', 340203, '弋江区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102897, 510000, '四川省', 511800, '雅安市', 511825, '天全县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(102898, 360000, '江西省', 361100, '上饶市', 361128, '鄱阳县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102899, 110000, '北京', 110100, '北京市', 110228, '密云县', 3, 'A', 2, 2602, '北京', '北京RDC电商库', 'D10'),
(102900, 330000, '浙江省', 330800, '衢州市', 330801, '其它区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102901, 130000, '河北省', 130500, '邢台市', 130522, '临城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102902, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422822, '建始县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102903, 130000, '河北省', 130100, '石家庄市', 130126, '灵寿县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102904, 430000, '湖南省', 430600, '岳阳市', 430611, '君山区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102905, 350000, '福建省', 350500, '泉州市', 350503, '丰泽区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(102906, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533123, '盈江县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102907, 220000, '吉林省', 220400, '辽源市', 220402, '龙山区', 3, 'A', 1, 2625, '长春', '', ''),
(102908, 130000, '河北省', 130200, '唐山市', 130208, '丰润区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(102909, 230000, '黑龙江省', 231200, '绥化市', 231201, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102910, 140000, '山西省', 140200, '大同市', 140201, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(102911, 360000, '江西省', 361100, '上饶市', 361121, '上饶县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102912, 340000, '安徽省', 340500, '马鞍山市', 340503, '花山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102913, 330000, '浙江省', 331100, '丽水市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(102914, 620000, '甘肃省', 621100, '定西市', 621125, '漳县', 3, 'A', 1, 2636, '兰州', '', ''),
(102915, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433122, '泸溪县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102916, 210000, '辽宁省', 211200, '铁岭市', 211201, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102917, 320000, '江苏省', 320100, '南京市', 320124, '溧水区', 3, 'A', 2, 2604, '南京', '', ''),
(102918, 360000, '江西省', 360500, '新余市', 360501, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(102919, 230000, '黑龙江省', 230600, '大庆市', 230623, '林甸县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(102920, 630000, '青海省', 630100, '西宁市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102921, 370000, '山东省', 370700, '潍坊市', 370782, '诸城市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(102922, 410000, '河南省', 411100, '漯河市', 411121, '舞阳县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102923, 530000, '云南省', 530900, '临沧市', 530922, '云县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102924, 110000, '北京', 110100, '北京市', 110117, '平谷区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(102925, 610000, '陕西省', 610400, '咸阳市', 610427, '彬县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102926, 330000, '浙江省', 331100, '丽水市', 331123, '遂昌县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(102927, 340000, '安徽省', 341500, '六安市', 341501, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102928, 610000, '陕西省', 610100, '西安市', 610112, '未央区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(102929, 340000, '安徽省', 341800, '宣城市', 341802, '宣州区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102930, 410000, '河南省', 410200, '开封市', 410223, '尉氏县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102931, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533124, '陇川县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(102932, 620000, '甘肃省', 620800, '平凉市', 620822, '灵台县', 3, 'A', 2, 2636, '兰州', '', ''),
(102933, 340000, '安徽省', 341000, '黄山市', 341021, '歙县', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102934, 510000, '四川省', 513400, '凉山彝族自治州', 513436, '美姑县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(102935, 460000, '海南省', 469000, '省直辖县级行政区划', 469050, '昌江黎族自治县', 3, 'D', 1, 0, '', '', ''),
(102936, 450000, '广西壮族自治区', 450300, '桂林市', 450305, '七星区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102937, 440000, '广东省', 440500, '汕头市', 440515, '澄海区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(102938, 510000, '四川省', 511300, '南充市', 511325, '西充县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(102939, 640000, '宁夏回族自治区', 640500, '中卫市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102940, 450000, '广西壮族自治区', 451300, '来宾市', 451302, '兴宾区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102941, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422826, '咸丰县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102942, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652324, '玛纳斯县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102943, 420000, '湖北省', 420600, '襄阳市', 420684, '宜城市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102944, 420000, '湖北省', 420800, '荆门市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(102945, 130000, '河北省', 130600, '保定市', 130623, '涞水县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102946, 420000, '湖北省', 420600, '襄阳市', 420683, '枣阳市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102947, 440000, '广东省', 441400, '梅州市', 441424, '五华县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102948, 460000, '海南省', 469022, '屯昌县', 0, '', 2, 'A', 0, 0, '', '', ''),
(102949, 440000, '广东省', 441300, '惠州市', 441323, '惠东县', 3, 'A', 2, 2660, '深圳', '广州RDC电商库', 'D020'),
(102950, 110000, '北京', 110100, '北京市', 110112, '通州区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(102951, 340000, '安徽省', 340700, '铜陵市', 340703, '狮子山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102952, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652928, '阿瓦提县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102953, 450000, '广西壮族自治区', 450300, '桂林市', 450323, '灵川县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(102954, 130000, '河北省', 130700, '张家口市', 130729, '万全县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(102955, 130000, '河北省', 130900, '沧州市', 130926, '肃宁县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102956, 130000, '河北省', 130400, '邯郸市', 130425, '大名县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102957, 430000, '湖南省', 431200, '怀化市', 431202, '鹤城区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102958, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654202, '乌苏市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102959, 430000, '湖南省', 431200, '怀化市', 431221, '中方县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102960, 420000, '湖北省', 421200, '咸宁市', 421222, '通城县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(102961, 440000, '广东省', 445100, '潮州市', 445121, '潮安区', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(102962, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652929, '柯坪县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102963, 430000, '湖南省', 431000, '郴州市', 431027, '桂东县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102964, 440000, '广东省', 445300, '云浮市', 445322, '郁南县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(102965, 410000, '河南省', 411300, '南阳市', 411325, '内乡县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(102966, 420000, '湖北省', 420800, '荆门市', 420881, '钟祥市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(102967, 640000, '宁夏回族自治区', 640200, '石嘴山市', 640221, '平罗县', 3, 'A', 2, 2647, '西安', '', ''),
(102968, 630000, '青海省', 632300, '黄南藏族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(102969, 440000, '广东省', 440300, '深圳市', 440303, '罗湖区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(102970, 510000, '四川省', 510500, '泸州市', 510503, '纳溪区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(102971, 650000, '新疆维吾尔自治区', 652200, '哈密地区', 652223, '伊吾县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102972, 130000, '河北省', 130600, '保定市', 130629, '容城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(102973, 210000, '辽宁省', 210400, '抚顺市', 210422, '新宾满族自治县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(102974, 410000, '河南省', 410500, '安阳市', 410522, '安阳县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102975, 340000, '安徽省', 340300, '蚌埠市', 340302, '龙子湖区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102976, 510000, '四川省', 511900, '巴中市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102977, 430000, '湖南省', 430500, '邵阳市', 430529, '城步苗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(102978, 540000, '西藏自治区', 542200, '山南地区', 542222, '扎囊县', 3, 'A', 2, 2308, '昆明', '', ''),
(102979, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150104, '玉泉区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(102980, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 650203, '克拉玛依区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(102981, 330000, '浙江省', 330500, '湖州市', 330522, '长兴县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(102982, 320000, '江苏省', 320600, '南通市', 320611, '港闸区', 3, 'A', 1, 2663, '南通', '', ''),
(102983, 140000, '山西省', 140700, '晋中市', 140721, '榆社县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(102984, 520000, '贵州省', 520400, '安顺市', 520421, '平坝县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(102985, 230000, '黑龙江省', 230500, '双鸭山市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(102986, 340000, '安徽省', 341000, '黄山市', 341023, '黟县', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(102987, 440000, '广东省', 440700, '江门市', 440703, '蓬江区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(102988, 230000, '黑龙江省', 230900, '七台河市', 230921, '勃利县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(102989, 460000, '海南省', 460200, '三亚市', 460201, '市辖区', 3, 'A', 1, 2646, '海口', '', ''),
(102990, 320000, '江苏省', 320900, '盐城市', 320901, '其它区', 3, 'A', 1, 2663, '南通', '', ''),
(102991, 510000, '四川省', 510100, '成都市', 510104, '锦江区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(102992, 370000, '山东省', 371700, '菏泽市', 371721, '曹县', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102993, 440000, '广东省', 440200, '韶关市', 440224, '仁化县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(102994, 620000, '甘肃省', 621000, '庆阳市', 0, '', 2, 'A', 0, 0, '', '', ''),
(102995, 420000, '湖北省', 420200, '黄石市', 420281, '大冶市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(102996, 510000, '四川省', 510600, '德阳市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(102997, 370000, '山东省', 370800, '济宁市', 370881, '曲阜市', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(102998, 410000, '河南省', 410100, '郑州市', 410101, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(102999, 610000, '陕西省', 610800, '榆林市', 610828, '佳县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103000, 440000, '广东省', 440800, '湛江市', 440823, '遂溪县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103001, 130000, '河北省', 130200, '唐山市', 130205, '开平区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(103002, 510000, '四川省', 511300, '南充市', 511322, '营山县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103003, 420000, '湖北省', 420800, '荆门市', 420804, '掇刀区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103004, 610000, '陕西省', 610500, '渭南市', 610522, '潼关县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103005, 130000, '河北省', 130500, '邢台市', 130526, '任县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103006, 130000, '河北省', 130700, '张家口市', 130701, '其它区', 3, 'A', 1, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(103007, 140000, '山西省', 140800, '运城市', 140881, '永济市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103008, 450000, '广西壮族自治区', 451400, '崇左市', 451401, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103009, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654323, '福海县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103010, 370000, '山东省', 371200, '莱芜市', 371201, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103011, 420000, '湖北省', 420100, '武汉市', 420117, '新洲区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103012, 210000, '辽宁省', 210600, '丹东市', 210602, '元宝区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(103013, 530000, '云南省', 533300, '怒江傈僳族自治州', 533323, '福贡县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103014, 360000, '江西省', 360700, '赣州市', 360702, '章贡区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103015, 510000, '四川省', 511400, '眉山市', 511402, '东坡区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(103016, 340000, '安徽省', 341000, '黄山市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103017, 230000, '黑龙江省', 230800, '佳木斯市', 230826, '桦川县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103018, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653221, '和田县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103019, 130000, '河北省', 130500, '邢台市', 130523, '内丘县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103020, 320000, '江苏省', 320200, '无锡市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103021, 370000, '山东省', 370700, '潍坊市', 0, '', 2, 'A', 0, 2601, '青岛', '济南RDC电商库', 'D531'),
(103022, 370000, '山东省', 371700, '菏泽市', 371727, '定陶县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(103023, 130000, '河北省', 131100, '衡水市', 131182, '深州市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103024, 370000, '山东省', 370900, '泰安市', 370902, '泰山区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103025, 620000, '甘肃省', 620900, '酒泉市', 620902, '肃州区', 3, 'A', 1, 2636, '兰州', '', ''),
(103026, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(103027, 370000, '山东省', 370700, '潍坊市', 370781, '青州市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103028, 140000, '山西省', 141100, '吕梁市', 141101, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103029, 540000, '西藏自治区', 540100, '拉萨市', 540123, '尼木县', 3, 'A', 2, 2636, '兰州', '', ''),
(103030, 140000, '山西省', 141000, '临汾市', 141031, '隰县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103031, 610000, '陕西省', 611000, '商洛市', 611025, '镇安县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103032, 530000, '云南省', 530800, '普洱市', 530823, '景东彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103033, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652924, '沙雅县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103034, 130000, '河北省', 130300, '秦皇岛市', 130302, '海港区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(103035, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513224, '松潘县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103036, 340000, '安徽省', 340200, '芜湖市', 340202, '镜湖区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103037, 510000, '四川省', 510300, '自贡市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(103038, 230000, '黑龙江省', 230100, '哈尔滨市', 230129, '延寿县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103039, 430000, '湖南省', 430400, '衡阳市', 430426, '祁东县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103040, 340000, '安徽省', 341800, '宣城市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103041, 330000, '浙江省', 330700, '金华市', 330784, '永康市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103042, 420000, '湖北省', 420800, '荆门市', 420802, '东宝区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103043, 360000, '江西省', 361100, '上饶市', 361130, '婺源县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103044, 510000, '四川省', 511500, '宜宾市', 511522, '南溪区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103045, 140000, '山西省', 141000, '临汾市', 141027, '浮山县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103046, 130000, '河北省', 130800, '承德市', 130825, '隆化县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(103047, 340000, '安徽省', 341600, '亳州市', 341622, '蒙城县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103048, 220000, '吉林省', 220100, '长春市', 220182, '榆树市', 3, 'A', 1, 2625, '长春', '', ''),
(103049, 610000, '陕西省', 610800, '榆林市', 610826, '绥德县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103050, 370000, '山东省', 370700, '潍坊市', 370786, '昌邑市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103051, 140000, '山西省', 140700, '晋中市', 140725, '寿阳县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103052, 130000, '河北省', 130100, '石家庄市', 130108, '裕华区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103053, 450000, '广西壮族自治区', 450200, '柳州市', 450225, '融水苗族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103054, 230000, '黑龙江省', 230100, '哈尔滨市', 230127, '木兰县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103055, 620000, '甘肃省', 620900, '酒泉市', 620981, '玉门市', 3, 'A', 1, 2636, '兰州', '', ''),
(103056, 610000, '陕西省', 610200, '铜川市', 610201, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103057, 370000, '山东省', 370300, '淄博市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(103058, 500000, '重庆', 500100, '重庆市', 500105, '江北区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103059, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103060, 530000, '云南省', 532600, '文山壮族苗族自治州', 532621, '文山市', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103061, 140000, '山西省', 141100, '吕梁市', 141129, '中阳县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103062, 340000, '安徽省', 341100, '滁州市', 341103, '南谯区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103063, 370000, '山东省', 370900, '泰安市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(103064, 620000, '甘肃省', 620800, '平凉市', 620824, '华亭县', 3, 'A', 2, 2636, '兰州', '', ''),
(103065, 510000, '四川省', 511900, '巴中市', 511902, '巴州区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(103066, 620000, '甘肃省', 620400, '白银市', 620422, '会宁县', 3, 'A', 2, 2636, '兰州', '', ''),
(103067, 620000, '甘肃省', 620800, '平凉市', 620823, '崇信县', 3, 'A', 2, 2636, '兰州', '', ''),
(103068, 330000, '浙江省', 330900, '舟山市', 330902, '定海区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103069, 340000, '安徽省', 341800, '宣城市', 341824, '绩溪县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103070, 220000, '吉林省', 220300, '四平市', 220322, '梨树县', 3, 'A', 2, 2625, '长春', '', ''),
(103071, 440000, '广东省', 441800, '清远市', 441881, '英德市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103072, 450000, '广西壮族自治区', 451200, '河池市', 451229, '大化瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103073, 230000, '黑龙江省', 230800, '佳木斯市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(103074, 360000, '江西省', 360800, '吉安市', 360824, '新干县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103075, 500000, '重庆', 500100, '重庆市', 500234, '开县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103076, 440000, '广东省', 440400, '珠海市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103077, 440000, '广东省', 441200, '肇庆市', 441223, '广宁县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103078, 370000, '山东省', 370800, '济宁市', 370830, '汶上县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(103079, 130000, '河北省', 130600, '保定市', 130625, '徐水县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103080, 330000, '浙江省', 330200, '宁波市', 330201, '其它区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103081, 510000, '四川省', 513400, '凉山彝族自治州', 513437, '雷波县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103082, 520000, '贵州省', 522200, '铜仁市', 522227, '德江县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103083, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222402, '图们市', 3, 'A', 2, 2625, '长春', '', ''),
(103084, 330000, '浙江省', 330300, '温州市', 330324, '永嘉县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103085, 130000, '河北省', 130600, '保定市', 130626, '定兴县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103086, 320000, '江苏省', 320100, '南京市', 320114, '雨花台区', 3, 'A', 1, 2604, '南京', '', ''),
(103087, 330000, '浙江省', 330800, '衢州市', 330803, '衢江区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103088, 360000, '江西省', 360900, '宜春市', 360922, '万载县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103089, 360000, '江西省', 0, '', 0, '', 1, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(103090, 430000, '湖南省', 430600, '岳阳市', 430682, '临湘市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103091, 430000, '湖南省', 430100, '长沙市', 430102, '芙蓉区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103092, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150826, '杭锦后旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103093, 520000, '贵州省', 522200, '铜仁市', 522224, '石阡县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103094, 610000, '陕西省', 610300, '宝鸡市', 610302, '渭滨区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103095, 410000, '河南省', 410700, '新乡市', 410727, '封丘县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103096, 130000, '河北省', 130900, '沧州市', 130921, '沧县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103097, 220000, '吉林省', 220700, '松原市', 220721, '前郭尔罗斯蒙古族自治县', 3, 'A', 2, 2625, '长春', '', ''),
(103098, 630000, '青海省', 630100, '西宁市', 630121, '大通回族土族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(103099, 460000, '海南省', 460100, '海口市', 460101, '其它区', 3, 'A', 1, 2646, '海口', '', ''),
(103100, 420000, '湖北省', 429021, '神农架林区', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(103101, 210000, '辽宁省', 210700, '锦州市', 210726, '黑山县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103102, 350000, '福建省', 350500, '泉州市', 350504, '洛江区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103103, 440000, '广东省', 441500, '汕尾市', 441502, '城区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103104, 520000, '贵州省', 522400, '毕节市', 522426, '纳雍县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103105, 140000, '山西省', 140700, '晋中市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(103106, 230000, '黑龙江省', 230300, '鸡西市', 230302, '鸡冠区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103107, 320000, '江苏省', 320300, '徐州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103108, 450000, '广西壮族自治区', 450200, '柳州市', 450221, '柳江县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103109, 630000, '青海省', 632500, '海南州', 632525, '贵南县', 3, 'A', 2, 2636, '兰州', '', ''),
(103110, 110000, '北京', 110100, '北京市', 110115, '大兴区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103111, 420000, '湖北省', 420100, '武汉市', 420114, '蔡甸区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103112, 320000, '江苏省', 320700, '连云港市', 320722, '东海县', 3, 'A', 2, 2608, '临沂', '', ''),
(103113, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513223, '茂县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103114, 230000, '黑龙江省', 230500, '双鸭山市', 230505, '四方台区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103115, 330000, '浙江省', 330900, '舟山市', 330922, '嵊泗县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103116, 620000, '甘肃省', 620900, '酒泉市', 620922, '瓜州县', 3, 'A', 2, 2636, '兰州', '', ''),
(103117, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533122, '梁河县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103118, 210000, '辽宁省', 211100, '盘锦市', 211122, '盘山县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103119, 320000, '江苏省', 321300, '宿迁市', 321324, '泗洪县', 3, 'A', 2, 2639, '徐州', '', ''),
(103120, 540000, '西藏自治区', 542100, '昌都地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(103121, 430000, '湖南省', 431200, '怀化市', 431226, '麻阳苗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103122, 510000, '四川省', 511400, '眉山市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(103123, 340000, '安徽省', 340200, '芜湖市', 340222, '繁昌县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103124, 450000, '广西壮族自治区', 451000, '百色市', 451031, '隆林各族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103125, 650000, '新疆维吾尔自治区', 652700, '博尔塔拉蒙古自治州', 652722, '精河县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103126, 510000, '四川省', 510700, '绵阳市', 510724, '安县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103127, 450000, '广西壮族自治区', 450200, '柳州市', 450202, '城中区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103128, 610000, '陕西省', 610400, '咸阳市', 610426, '永寿县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103129, 320000, '江苏省', 321200, '泰州市', 321284, '姜堰区', 3, 'A', 1, 2663, '南通', '', ''),
(103130, 320000, '江苏省', 320100, '南京市', 320113, '栖霞区', 3, 'A', 1, 2604, '南京', '', ''),
(103131, 530000, '云南省', 532900, '大理白族自治州', 532926, '南涧彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103132, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(103133, 450000, '广西壮族自治区', 450300, '桂林市', 450303, '叠彩区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103134, 510000, '四川省', 510900, '遂宁市', 510921, '蓬溪县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103135, 140000, '山西省', 141000, '临汾市', 141002, '尧都区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103136, 640000, '宁夏回族自治区', 640300, '吴忠市', 640381, '青铜峡市', 3, 'A', 1, 2647, '西安', '', ''),
(103137, 410000, '河南省', 410800, '焦作市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(103138, 520000, '贵州省', 522200, '铜仁市', 522201, '铜仁市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103139, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652801, '库尔勒市', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103140, 330000, '浙江省', 330100, '杭州市', 330183, '富阳市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103141, 220000, '吉林省', 220600, '白山市', 220602, '浑江区', 3, 'A', 1, 2625, '长春', '', ''),
(103142, 130000, '河北省', 130200, '唐山市', 130229, '玉田县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(103143, 620000, '甘肃省', 620500, '天水市', 620501, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(103144, 610000, '陕西省', 610300, '宝鸡市', 610324, '扶风县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103145, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433101, '吉首市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103146, 110000, '北京', 110100, '北京市', 110108, '海淀区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103147, 430000, '湖南省', 431300, '娄底市', 431321, '双峰县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103148, 410000, '河南省', 410900, '濮阳市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(103149, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522732, '三都水族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103150, 430000, '湖南省', 431000, '郴州市', 431022, '宜章县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103151, 220000, '吉林省', 220600, '白山市', 220601, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(103152, 140000, '山西省', 140600, '朔州市', 140603, '平鲁区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103153, 430000, '湖南省', 430700, '常德市', 430725, '桃源县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103154, 520000, '贵州省', 522200, '铜仁市', 522228, '沿河土家族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103155, 450000, '广西壮族自治区', 451200, '河池市', 451228, '都安瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103156, 450000, '广西壮族自治区', 451300, '来宾市', 451301, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103157, 430000, '湖南省', 431200, '怀化市', 431222, '沅陵县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103158, 410000, '河南省', 410500, '安阳市', 410501, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103159, 370000, '山东省', 370200, '青岛市', 0, '', 2, 'A', 0, 2601, '青岛', '济南RDC电商库', 'D531'),
(103160, 220000, '吉林省', 220300, '四平市', 220303, '铁东区', 3, 'A', 1, 2625, '长春', '', ''),
(103161, 430000, '湖南省', 430300, '湘潭市', 430304, '岳塘区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103162, 440000, '广东省', 445200, '揭阳市', 445221, '揭东区', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(103163, 450000, '广西壮族自治区', 450100, '南宁市', 450127, '横县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103164, 420000, '湖北省', 420700, '鄂州市', 420701, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103165, 620000, '甘肃省', 620700, '张掖市', 620721, '肃南裕固族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(103166, 150000, '内蒙古自治区', 150200, '包头市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103167, 510000, '四川省', 510500, '泸州市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(103168, 230000, '黑龙江省', 230800, '佳木斯市', 230801, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103169, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654225, '裕民县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103170, 340000, '安徽省', 340400, '淮南市', 340404, '谢家集区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103171, 500000, '重庆', 500100, '重庆市', 500109, '北碚区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103172, 130000, '河北省', 130800, '承德市', 130804, '鹰手营子矿区', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(103173, 440000, '广东省', 441700, '阳江市', 441781, '阳春市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103174, 410000, '河南省', 411200, '三门峡市', 411201, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103175, 340000, '安徽省', 340500, '马鞍山市', 340502, '金家庄区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103176, 520000, '贵州省', 520200, '六盘水市', 520221, '水城县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103177, 350000, '福建省', 350100, '福州市', 350124, '闽清县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(103178, 340000, '安徽省', 340800, '安庆市', 340803, '大观区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103179, 410000, '河南省', 410900, '濮阳市', 410928, '濮阳县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103180, 340000, '安徽省', 340400, '淮南市', 340401, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103181, 510000, '四川省', 513300, '甘孜藏族自治州', 513324, '九龙县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103182, 410000, '河南省', 411000, '许昌市', 411023, '许昌县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103183, 540000, '西藏自治区', 542100, '昌都地区', 542123, '贡觉县', 3, 'A', 2, 2636, '兰州', '', ''),
(103184, 360000, '江西省', 360700, '赣州市', 360701, '其它区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103185, 530000, '云南省', 530800, '普洱市', 530824, '景谷傣族彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103186, 410000, '河南省', 411700, '驻马店市', 411729, '新蔡县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103187, 420000, '湖北省', 420500, '宜昌市', 420525, '远安县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103188, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150925, '凉城县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103189, 140000, '山西省', 140400, '长治市', 140401, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103190, 640000, '宁夏回族自治区', 640500, '中卫市', 640502, '沙坡头区', 3, 'A', 1, 2647, '西安', '', ''),
(103191, 230000, '黑龙江省', 231100, '黑河市', 231124, '孙吴县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103192, 320000, '江苏省', 320800, '淮安市', 320831, '金湖县', 3, 'A', 2, 2639, '徐州', '', ''),
(103193, 530000, '云南省', 530700, '丽江市', 530722, '永胜县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103194, 450000, '广西壮族自治区', 450500, '北海市', 450502, '海城区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103195, 510000, '四川省', 510800, '广元市', 510822, '青川县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103196, 450000, '广西壮族自治区', 450200, '柳州市', 450224, '融安县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103197, 130000, '河北省', 130700, '张家口市', 130733, '崇礼县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(103198, 440000, '广东省', 440700, '江门市', 440783, '开平市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103199, 110000, '北京', 0, '', 0, '', 1, 'A', 0, 0, '', '北京RDC电商库', 'D10'),
(103200, 370000, '山东省', 370100, '济南市', 370104, '槐荫区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103201, 540000, '西藏自治区', 540100, '拉萨市', 540121, '林周县', 3, 'A', 2, 2636, '兰州', '', ''),
(103202, 520000, '贵州省', 520300, '遵义市', 520322, '桐梓县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103203, 530000, '云南省', 532900, '大理白族自治州', 532901, '大理市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103204, 130000, '河北省', 130900, '沧州市', 130929, '献县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103205, 610000, '陕西省', 610800, '榆林市', 610822, '府谷县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103206, 370000, '山东省', 370400, '枣庄市', 370404, '峄城区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103207, 130000, '河北省', 130300, '秦皇岛市', 130321, '青龙满族自治县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(103208, 230000, '黑龙江省', 230300, '鸡西市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(103209, 230000, '黑龙江省', 230600, '大庆市', 230603, '龙凤区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103210, 520000, '贵州省', 522200, '铜仁市', 522223, '玉屏侗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103211, 360000, '江西省', 361100, '上饶市', 361127, '余干县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103212, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433123, '凤凰县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103213, 330000, '浙江省', 330300, '温州市', 330322, '洞头县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103214, 360000, '江西省', 361000, '抚州市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(103215, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513222, '理县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103216, 210000, '辽宁省', 210900, '阜新市', 210905, '清河门区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(103217, 610000, '陕西省', 610400, '咸阳市', 610424, '乾县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103218, 340000, '安徽省', 341600, '亳州市', 341623, '利辛县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103219, 330000, '浙江省', 330700, '金华市', 330701, '其它区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103220, 350000, '福建省', 350200, '厦门市', 350203, '思明区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103221, 320000, '江苏省', 320100, '南京市', 320105, '建邺区', 3, 'A', 1, 2604, '南京', '', ''),
(103222, 370000, '山东省', 371400, '德州市', 371426, '平原县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103223, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654021, '伊宁县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103224, 440000, '广东省', 440200, '韶关市', 440282, '南雄市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103225, 520000, '贵州省', 520100, '贵阳市', 520103, '云岩区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103226, 130000, '河北省', 130500, '邢台市', 130531, '广宗县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103227, 510000, '四川省', 513300, '甘孜藏族自治州', 513325, '雅江县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103228, 530000, '云南省', 530100, '昆明市', 530181, '安宁市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103229, 440000, '广东省', 440300, '深圳市', 440305, '南山区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(103230, 150000, '内蒙古自治区', 150100, '呼和浩特市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103231, 410000, '河南省', 410400, '平顶山市', 410402, '新华区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103232, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650104, '新市区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103233, 130000, '河北省', 130100, '石家庄市', 130130, '无极县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103234, 310000, '上海', 310100, '上海市', 310230, '崇明县', 3, 'A', 2, 2642, '上海', '上海RDC电商库', 'D021'),
(103235, 450000, '广西壮族自治区', 450300, '桂林市', 450330, '平乐县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103236, 140000, '山西省', 141000, '临汾市', 141021, '曲沃县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103237, 340000, '安徽省', 340100, '合肥市', 340121, '长丰县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103238, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654326, '吉木乃县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103239, 370000, '山东省', 371300, '临沂市', 371326, '平邑县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(103240, 360000, '江西省', 361000, '抚州市', 361022, '黎川县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103241, 350000, '福建省', 350400, '三明市', 350402, '梅列区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103242, 210000, '辽宁省', 210100, '沈阳市', 210101, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103243, 530000, '云南省', 530300, '曲靖市', 530302, '麒麟区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103244, 540000, '西藏自治区', 542300, '日喀则地区', 542301, '日喀则市', 3, 'A', 1, 2636, '兰州', '', ''),
(103245, 420000, '湖北省', 421300, '随州市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(103246, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513226, '金川县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103247, 210000, '辽宁省', 210100, '沈阳市', 210189, '浑南新区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103248, 320000, '江苏省', 320200, '无锡市', 320205, '锡山区', 3, 'A', 1, 2664, '无锡', '', ''),
(103249, 120000, '天津', 120100, '天津市', 120113, '北辰区', 3, 'A', 1, 2634, '天津', '', ''),
(103250, 520000, '贵州省', 520100, '贵阳市', 520181, '清镇市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103251, 540000, '西藏自治区', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(103252, 210000, '辽宁省', 210500, '本溪市', 210522, '桓仁满族自治县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103253, 230000, '黑龙江省', 230600, '大庆市', 230621, '肇州县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103254, 640000, '宁夏回族自治区', 640500, '中卫市', 640521, '中宁县', 3, 'A', 2, 2647, '西安', '', ''),
(103255, 610000, '陕西省', 610500, '渭南市', 610502, '临渭区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103256, 540000, '西藏自治区', 542600, '林芝地区', 542621, '林芝县', 3, 'A', 2, 2308, '昆明', '', ''),
(103257, 420000, '湖北省', 420600, '襄阳市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(103258, 430000, '湖南省', 430300, '湘潭市', 430301, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103259, 510000, '四川省', 510100, '成都市', 510101, '其它区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103260, 620000, '甘肃省', 620900, '酒泉市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103261, 140000, '山西省', 140900, '忻州市', 140928, '五寨县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103262, 130000, '河北省', 131100, '衡水市', 131122, '武邑县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103263, 230000, '黑龙江省', 230400, '鹤岗市', 230406, '东山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103264, 220000, '吉林省', 220300, '四平市', 220301, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(103265, 430000, '湖南省', 431000, '郴州市', 431028, '安仁县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103266, 320000, '江苏省', 320600, '南通市', 320684, '海门市', 3, 'A', 1, 2663, '南通', '', ''),
(103267, 430000, '湖南省', 0, '', 0, '', 1, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(103268, 440000, '广东省', 441300, '惠州市', 441324, '龙门县', 3, 'A', 2, 2660, '深圳', '广州RDC电商库', 'D020'),
(103269, 510000, '四川省', 510100, '成都市', 510115, '温江区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103270, 340000, '安徽省', 340500, '马鞍山市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103271, 510000, '四川省', 511100, '乐山市', 511132, '峨边彝族自治县', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(103272, 620000, '甘肃省', 620600, '武威市', 620602, '凉州区', 3, 'A', 1, 2636, '兰州', '', ''),
(103273, 230000, '黑龙江省', 230600, '大庆市', 230602, '萨尔图区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103274, 510000, '四川省', 510500, '泸州市', 510504, '龙马潭区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103275, 360000, '江西省', 360400, '九江市', 360481, '瑞昌市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103276, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433130, '龙山县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103277, 220000, '吉林省', 220200, '吉林市', 220202, '昌邑区', 3, 'A', 1, 2625, '长春', '', ''),
(103278, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150722, '莫力达瓦达斡尔族自治旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(103279, 340000, '安徽省', 340400, '淮南市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103280, 410000, '河南省', 410800, '焦作市', 410823, '武陟县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103281, 510000, '四川省', 511300, '南充市', 511324, '仪陇县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103282, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150901, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(103283, 440000, '广东省', 440300, '深圳市', 440306, '宝安区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(103284, 410000, '河南省', 410700, '新乡市', 410725, '原阳县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103285, 330000, '浙江省', 330900, '舟山市', 330903, '普陀区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103286, 610000, '陕西省', 0, '', 0, '', 1, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(103287, 420000, '湖北省', 420100, '武汉市', 420103, '江汉区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103288, 140000, '山西省', 140400, '长治市', 140428, '长子县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103289, 430000, '湖南省', 430400, '衡阳市', 430408, '蒸湘区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103290, 410000, '河南省', 410800, '焦作市', 410822, '博爱县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103291, 620000, '甘肃省', 621000, '庆阳市', 621022, '环县', 3, 'A', 1, 2636, '兰州', '', ''),
(103292, 410000, '河南省', 411700, '驻马店市', 411721, '西平县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103293, 140000, '山西省', 140100, '太原市', 140109, '万柏林区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103294, 450000, '广西壮族自治区', 451100, '贺州市', 451121, '昭平县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103295, 440000, '广东省', 441200, '肇庆市', 441283, '高要市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103296, 610000, '陕西省', 610400, '咸阳市', 610429, '旬邑县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103297, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152524, '苏尼特右旗', 3, 'A', 2, 2633, '唐山', '', ''),
(103298, 210000, '辽宁省', 210200, '大连市', 210204, '沙河口区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(103299, 350000, '福建省', 350900, '宁德市', 350982, '福鼎市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103300, 440000, '广东省', 441500, '汕尾市', 441501, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103301, 340000, '安徽省', 340700, '铜陵市', 340702, '铜官山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103302, 610000, '陕西省', 610100, '西安市', 610104, '莲湖区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103303, 450000, '广西壮族自治区', 450400, '梧州市', 450401, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103304, 210000, '辽宁省', 210800, '营口市', 210882, '大石桥市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103305, 410000, '河南省', 410200, '开封市', 410204, '鼓楼区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103306, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652823, '尉犁县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103307, 460000, '海南省', 469000, '省直辖县级行政区划', 469051, '万宁市', 3, 'D', 1, 0, '', '', ''),
(103308, 140000, '山西省', 140800, '运城市', 140825, '新绛县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103309, 440000, '广东省', 441300, '惠州市', 441322, '博罗县', 3, 'A', 2, 2660, '深圳', '广州RDC电商库', 'D020'),
(103310, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650101, '其它区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103311, 370000, '山东省', 371500, '聊城市', 371522, '莘县', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103312, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532502, '开远市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103313, 340000, '安徽省', 340100, '合肥市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103314, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150125, '武川县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103315, 310000, '上海', 310100, '上海市', 310118, '青浦区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(103316, 450000, '广西壮族自治区', 451000, '百色市', 451026, '那坡县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103317, 440000, '广东省', 441200, '肇庆市', 441225, '封开县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103318, 130000, '河北省', 130600, '保定市', 130621, '满城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103319, 360000, '江西省', 360300, '萍乡市', 360323, '芦溪县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103320, 630000, '青海省', 630100, '西宁市', 630104, '城西区', 3, 'A', 1, 2636, '兰州', '', ''),
(103321, 530000, '云南省', 532300, '楚雄彝族自治州', 532323, '牟定县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103322, 540000, '西藏自治区', 540100, '拉萨市', 540126, '达孜县', 3, 'A', 2, 2636, '兰州', '', ''),
(103323, 440000, '广东省', 440100, '广州市', 440184, '从化市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103324, 440000, '广东省', 441300, '惠州市', 441302, '惠城区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(103325, 330000, '浙江省', 330300, '温州市', 330327, '苍南县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103326, 110000, '北京', 110100, '北京市', 110107, '石景山区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103327, 230000, '黑龙江省', 230400, '鹤岗市', 230402, '向阳区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103328, 420000, '湖北省', 420300, '十堰市', 420302, '茅箭区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103329, 130000, '河北省', 130100, '石家庄市', 130101, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103330, 350000, '福建省', 350500, '泉州市', 350524, '安溪县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103331, 430000, '湖南省', 430400, '衡阳市', 430407, '石鼓区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103332, 330000, '浙江省', 330200, '宁波市', 330283, '奉化市', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103333, 230000, '黑龙江省', 230500, '双鸭山市', 230502, '尖山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103334, 450000, '广西壮族自治区', 450600, '防城港市', 450602, '港口区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103335, 440000, '广东省', 440600, '佛山市', 440601, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103336, 370000, '山东省', 370100, '济南市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(103337, 510000, '四川省', 510800, '广元市', 510824, '苍溪县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103338, 610000, '陕西省', 610100, '西安市', 610125, '户县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103339, 370000, '山东省', 370700, '潍坊市', 370784, '安丘市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103340, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150924, '兴和县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103341, 410000, '河南省', 410300, '洛阳市', 410311, '洛龙区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103342, 510000, '四川省', 511800, '雅安市', 511823, '汉源县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103343, 510000, '四川省', 511900, '巴中市', 511923, '平昌县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103344, 610000, '陕西省', 610700, '汉中市', 610728, '镇巴县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103345, 370000, '山东省', 370100, '济南市', 370101, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103346, 620000, '甘肃省', 622900, '临夏回族自治州', 622921, '临夏县', 3, 'A', 2, 2636, '兰州', '', ''),
(103347, 530000, '云南省', 532900, '大理白族自治州', 532922, '漾濞彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103348, 610000, '陕西省', 610100, '西安市', 610126, '高陵县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103349, 630000, '青海省', 632700, '玉树藏族自治州', 632724, '治多县', 3, 'A', 2, 2636, '兰州', '', ''),
(103350, 130000, '河北省', 130400, '邯郸市', 130427, '磁县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103351, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222403, '敦化市', 3, 'A', 2, 2625, '长春', '', ''),
(103352, 620000, '甘肃省', 621200, '陇南市', 621228, '两当县', 3, 'A', 2, 2636, '兰州', '', ''),
(103353, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653101, '喀什市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103354, 430000, '湖南省', 430200, '株洲市', 430204, '石峰区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103355, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150625, '杭锦旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103356, 150000, '内蒙古自治区', 150900, '乌兰察布市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103357, 410000, '河南省', 411500, '信阳市', 411521, '罗山县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103358, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150824, '乌拉特中旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103359, 350000, '福建省', 350300, '莆田市', 350304, '荔城区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103360, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654221, '额敏县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103361, 510000, '四川省', 510900, '遂宁市', 510903, '船山区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(103362, 410000, '河南省', 410200, '开封市', 410205, '禹王台区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103363, 530000, '云南省', 532300, '楚雄彝族自治州', 532301, '楚雄市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103364, 370000, '山东省', 370500, '东营市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(103365, 430000, '湖南省', 430400, '衡阳市', 430481, '耒阳市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103366, 130000, '河北省', 130100, '石家庄市', 130125, '行唐县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103367, 510000, '四川省', 510700, '绵阳市', 510725, '梓潼县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103368, 460000, '海南省', 469006, '万宁市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103369, 340000, '安徽省', 340300, '蚌埠市', 340301, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103370, 430000, '湖南省', 430900, '益阳市', 430981, '沅江市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103371, 410000, '河南省', 410100, '郑州市', 410108, '惠济区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103372, 510000, '四川省', 510500, '泸州市', 510524, '叙永县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(103373, 430000, '湖南省', 430500, '邵阳市', 430501, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103374, 360000, '江西省', 361000, '抚州市', 361027, '金溪县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103375, 370000, '山东省', 370500, '东营市', 370523, '广饶县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103376, 410000, '河南省', 411400, '商丘市', 411481, '永城市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103377, 500000, '重庆', 500100, '重庆市', 500115, '长寿区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103378, 220000, '吉林省', 220200, '吉林市', 220284, '磐石市', 3, 'A', 2, 2625, '长春', '', ''),
(103379, 430000, '湖南省', 430700, '常德市', 430702, '武陵区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103380, 630000, '青海省', 632500, '海南州', 632521, '共和县', 3, 'A', 2, 2636, '兰州', '', ''),
(103381, 510000, '四川省', 511100, '乐山市', 511102, '市中区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(103382, 320000, '江苏省', 320500, '苏州市', 320504, '金阊区', 3, 'A', 1, 2664, '无锡', '', ''),
(103383, 140000, '山西省', 140400, '长治市', 140430, '沁县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103384, 110000, '北京', 110100, '北京市', 110113, '顺义区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103385, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522625, '镇远县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103386, 330000, '浙江省', 330400, '嘉兴市', 330401, '其它区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103387, 370000, '山东省', 371700, '菏泽市', 371726, '鄄城县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(103388, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654321, '布尔津县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103389, 610000, '陕西省', 610100, '西安市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(103390, 350000, '福建省', 350500, '泉州市', 350505, '泉港区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103391, 230000, '黑龙江省', 231000, '牡丹江市', 231003, '阳明区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103392, 620000, '甘肃省', 621200, '陇南市', 621227, '徽县', 3, 'A', 1, 2636, '兰州', '', ''),
(103393, 370000, '山东省', 370600, '烟台市', 370681, '龙口市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103394, 520000, '贵州省', 520100, '贵阳市', 520112, '乌当区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103395, 370000, '山东省', 371600, '滨州市', 371621, '惠民县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103396, 420000, '湖北省', 420900, '孝感市', 420982, '安陆市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103397, 420000, '湖北省', 421000, '荆州市', 421001, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103398, 340000, '安徽省', 340300, '蚌埠市', 340323, '固镇县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103399, 520000, '贵州省', 520300, '遵义市', 520303, '汇川区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103400, 350000, '福建省', 350500, '泉州市', 350501, '其它区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103401, 120000, '天津', 120100, '天津市', 120110, '东丽区', 3, 'A', 1, 2634, '天津', '', ''),
(103402, 520000, '贵州省', 520100, '贵阳市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(103403, 610000, '陕西省', 610200, '铜川市', 610202, '王益区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103404, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150702, '海拉尔区', 3, 'A', 1, 2629, '哈尔滨', '', ''),
(103405, 340000, '安徽省', 340100, '合肥市', 340181, '巢湖市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103406, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513230, '壤塘县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103407, 440000, '广东省', 440300, '深圳市', 440301, '其它区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(103408, 230000, '黑龙江省', 230600, '大庆市', 230624, '杜尔伯特蒙古族自治县', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103409, 440000, '广东省', 441200, '肇庆市', 441226, '德庆县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103410, 320000, '江苏省', 320500, '苏州市', 320585, '太仓市', 3, 'A', 1, 2664, '无锡', '', ''),
(103411, 230000, '黑龙江省', 230100, '哈尔滨市', 230108, '平房区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103412, 140000, '山西省', 140800, '运城市', 140822, '万荣县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103413, 410000, '河南省', 410400, '平顶山市', 410482, '汝州市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103414, 150000, '内蒙古自治区', 150200, '包头市', 150207, '九原区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(103415, 610000, '陕西省', 610400, '咸阳市', 610425, '礼泉县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103416, 530000, '云南省', 532600, '文山壮族苗族自治州', 532622, '砚山县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103417, 410000, '河南省', 419000, '济源市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(103418, 520000, '贵州省', 520400, '安顺市', 520401, '其它区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103419, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653123, '英吉沙县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103420, 440000, '广东省', 440700, '江门市', 440705, '新会区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103421, 430000, '湖南省', 431300, '娄底市', 431302, '娄星区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103422, 450000, '广西壮族自治区', 450900, '玉林市', 450924, '兴业县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103423, 440000, '广东省', 441200, '肇庆市', 441202, '端州区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103424, 460000, '海南省', 460100, '海口市', 460108, '美兰区', 3, 'A', 1, 2646, '海口', '', ''),
(103425, 540000, '西藏自治区', 542400, '那曲地区', 542425, '安多县', 3, 'A', 2, 2308, '昆明', '', ''),
(103426, 340000, '安徽省', 340200, '芜湖市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103427, 350000, '福建省', 350400, '三明市', 350423, '清流县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(103428, 610000, '陕西省', 610900, '安康市', 610926, '平利县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103429, 620000, '甘肃省', 621200, '陇南市', 621221, '成县', 3, 'A', 1, 2636, '兰州', '', ''),
(103430, 350000, '福建省', 350300, '莆田市', 350303, '涵江区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103431, 510000, '四川省', 512000, '资阳市', 512002, '雁江区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103432, 620000, '甘肃省', 620500, '天水市', 620521, '清水县', 3, 'A', 2, 2636, '兰州', '', ''),
(103433, 610000, '陕西省', 610300, '宝鸡市', 610323, '岐山县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103434, 360000, '江西省', 360100, '南昌市', 360103, '西湖区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(103435, 320000, '江苏省', 320100, '南京市', 320115, '江宁区', 3, 'A', 1, 2604, '南京', '', ''),
(103436, 410000, '河南省', 411000, '许昌市', 411001, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103437, 510000, '四川省', 513400, '凉山彝族自治州', 513432, '喜德县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103438, 530000, '云南省', 532600, '文山壮族苗族自治州', 532627, '广南县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103439, 310000, '上海', 310100, '上海市', 310103, '卢湾区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(103440, 620000, '甘肃省', 620500, '天水市', 620522, '秦安县', 3, 'A', 2, 2636, '兰州', '', ''),
(103441, 410000, '河南省', 411400, '商丘市', 411403, '睢阳区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103442, 320000, '江苏省', 320800, '淮安市', 320811, '清浦区', 3, 'A', 1, 2639, '徐州', '', ''),
(103443, 350000, '福建省', 350600, '漳州市', 350623, '漳浦县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103444, 140000, '山西省', 140700, '晋中市', 140723, '和顺县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103445, 220000, '吉林省', 220200, '吉林市', 220201, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(103446, 130000, '河北省', 131000, '廊坊市', 131026, '文安县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(103447, 130000, '河北省', 130700, '张家口市', 130731, '涿鹿县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(103448, 210000, '辽宁省', 210800, '营口市', 210881, '盖州市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103449, 340000, '安徽省', 340600, '淮北市', 340602, '杜集区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(103450, 360000, '江西省', 360900, '宜春市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(103451, 320000, '江苏省', 320100, '南京市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103452, 150000, '内蒙古自治区', 150500, '通辽市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103453, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652828, '和硕县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103454, 620000, '甘肃省', 620800, '平凉市', 620825, '庄浪县', 3, 'A', 2, 2636, '兰州', '', ''),
(103455, 140000, '山西省', 140400, '长治市', 140426, '黎城县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103456, 150000, '内蒙古自治区', 152900, '阿拉善盟', 152923, '额济纳旗', 3, 'A', 2, 2636, '兰州', '', ''),
(103457, 530000, '云南省', 533400, '迪庆藏族自治州', 533421, '香格里拉县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103458, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513227, '小金县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103459, 370000, '山东省', 371300, '临沂市', 371302, '兰山区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103460, 130000, '河北省', 130400, '邯郸市', 130481, '武安市', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103461, 330000, '浙江省', 330600, '绍兴市', 330621, '绍兴县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103462, 440000, '广东省', 440400, '珠海市', 440402, '香洲区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103463, 430000, '湖南省', 431000, '郴州市', 431003, '苏仙区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103464, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 0, '', 2, 'A', 0, 0, '', '', ''),
(103465, 610000, '陕西省', 611000, '商洛市', 611022, '丹凤县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103466, 520000, '贵州省', 520100, '贵阳市', 520114, '小河区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103467, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522725, '瓮安县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103468, 360000, '江西省', 360100, '南昌市', 360105, '湾里区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(103469, 500000, '重庆', 500100, '重庆市', 500226, '荣昌县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103470, 420000, '湖北省', 420900, '孝感市', 420901, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103471, 540000, '西藏自治区', 542400, '那曲地区', 542428, '班戈县', 3, 'A', 2, 2308, '昆明', '', ''),
(103472, 510000, '四川省', 513300, '甘孜藏族自治州', 513335, '巴塘县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103473, 370000, '山东省', 370200, '青岛市', 370282, '即墨市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103474, 130000, '河北省', 130400, '邯郸市', 130431, '鸡泽县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103475, 450000, '广西壮族自治区', 450300, '桂林市', 450321, '阳朔县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103476, 430000, '湖南省', 431000, '郴州市', 431021, '桂阳县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103477, 540000, '西藏自治区', 542200, '山南地区', 542231, '隆子县', 3, 'A', 2, 2308, '昆明', '', ''),
(103478, 430000, '湖南省', 431200, '怀化市', 431224, '溆浦县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103479, 530000, '云南省', 530900, '临沧市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(103480, 370000, '山东省', 370200, '青岛市', 370284, '胶南市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103481, 360000, '江西省', 360800, '吉安市', 360881, '井冈山市', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103482, 130000, '河北省', 130400, '邯郸市', 130430, '邱县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103483, 630000, '青海省', 632300, '黄南藏族自治州', 632321, '同仁县', 3, 'A', 2, 2636, '兰州', '', ''),
(103484, 330000, '浙江省', 330400, '嘉兴市', 330481, '海宁市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103485, 350000, '福建省', 350500, '泉州市', 350581, '石狮市', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103486, 530000, '云南省', 530600, '昭通市', 530628, '彝良县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(103487, 350000, '福建省', 350700, '南平市', 350702, '延平区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103488, 450000, '广西壮族自治区', 451200, '河池市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(103489, 130000, '河北省', 130900, '沧州市', 130925, '盐山县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103490, 320000, '江苏省', 320500, '苏州市', 320583, '昆山市', 3, 'A', 1, 2664, '无锡', '', ''),
(103491, 120000, '天津', 120100, '天津市', 120103, '河西区', 3, 'A', 1, 2634, '天津', '', ''),
(103492, 450000, '广西壮族自治区', 450800, '贵港市', 450803, '港南区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103493, 330000, '浙江省', 331100, '丽水市', 331126, '庆元县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103494, 510000, '四川省', 510800, '广元市', 510823, '剑阁县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(103495, 440000, '广东省', 440100, '广州市', 440112, '黄埔区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103496, 220000, '吉林省', 220500, '通化市', 220524, '柳河县', 3, 'A', 2, 2625, '长春', '', ''),
(103497, 420000, '湖北省', 421000, '荆州市', 421081, '石首市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103498, 610000, '陕西省', 610800, '榆林市', 610830, '清涧县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103499, 130000, '河北省', 130600, '保定市', 130683, '安国市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103500, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654003, '奎屯市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103501, 430000, '湖南省', 431200, '怀化市', 431225, '会同县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103502, 130000, '河北省', 130600, '保定市', 130634, '曲阳县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103503, 450000, '广西壮族自治区', 451000, '百色市', 451028, '乐业县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103504, 430000, '湖南省', 430100, '长沙市', 430121, '长沙县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103505, 510000, '四川省', 513300, '甘孜藏族自治州', 513336, '乡城县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103506, 530000, '云南省', 530600, '昭通市', 530624, '大关县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(103507, 230000, '黑龙江省', 230400, '鹤岗市', 230422, '绥滨县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103508, 360000, '江西省', 360700, '赣州市', 360733, '会昌县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103509, 430000, '湖南省', 430900, '益阳市', 430922, '桃江县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103510, 620000, '甘肃省', 623000, '甘南藏族自治州', 623023, '舟曲县', 3, 'A', 2, 2636, '兰州', '', ''),
(103511, 440000, '广东省', 441800, '清远市', 441827, '清新区', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103512, 440000, '广东省', 445100, '潮州市', 445101, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103513, 610000, '陕西省', 610800, '榆林市', 610829, '吴堡县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103514, 510000, '四川省', 513400, '凉山彝族自治州', 513429, '布拖县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103515, 540000, '西藏自治区', 542400, '那曲地区', 542430, '尼玛县', 3, 'A', 2, 2308, '昆明', '', ''),
(103516, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522327, '册亨县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103517, 140000, '山西省', 141000, '临汾市', 141022, '翼城县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103518, 450000, '广西壮族自治区', 450800, '贵港市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(103519, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152502, '锡林浩特市', 3, 'A', 2, 2633, '唐山', '', ''),
(103520, 410000, '河南省', 410800, '焦作市', 410801, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103521, 620000, '甘肃省', 620600, '武威市', 620623, '天祝藏族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(103522, 530000, '云南省', 532600, '文山壮族苗族自治州', 532624, '麻栗坡县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103523, 640000, '宁夏回族自治区', 640300, '吴忠市', 640323, '盐池县', 3, 'A', 2, 2647, '西安', '', '');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(103524, 330000, '浙江省', 330800, '衢州市', 330802, '柯城区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103525, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 650201, '其它区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103526, 330000, '浙江省', 330800, '衢州市', 330824, '开化县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103527, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653124, '泽普县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103528, 530000, '云南省', 532800, '西双版纳傣族自治州', 532801, '景洪市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103529, 230000, '黑龙江省', 231000, '牡丹江市', 231084, '宁安市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103530, 340000, '安徽省', 340100, '合肥市', 340123, '肥西县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103531, 510000, '四川省', 510600, '德阳市', 510683, '绵竹市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103532, 310000, '上海', 310100, '上海市', 0, '', 2, 'A', 0, 0, '', '上海RDC电商库', 'D021'),
(103533, 510000, '四川省', 510300, '自贡市', 510304, '大安区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103534, 530000, '云南省', 530900, '临沧市', 530901, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103535, 510000, '四川省', 511500, '宜宾市', 511527, '筠连县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(103536, 620000, '甘肃省', 620800, '平凉市', 620802, '崆峒区', 3, 'A', 1, 2636, '兰州', '', ''),
(103537, 320000, '江苏省', 320600, '南通市', 320621, '海安县', 3, 'A', 2, 2663, '南通', '', ''),
(103538, 130000, '河北省', 130100, '石家庄市', 130184, '新乐市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103539, 510000, '四川省', 511300, '南充市', 511321, '南部县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103540, 610000, '陕西省', 610600, '延安市', 610624, '安塞县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103541, 460000, '海南省', 460100, '海口市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103542, 320000, '江苏省', 321200, '泰州市', 321283, '泰兴市', 3, 'A', 1, 2663, '南通', '', ''),
(103543, 310000, '上海', 310100, '上海市', 310105, '长宁区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(103544, 610000, '陕西省', 611000, '商洛市', 611002, '商州区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103545, 360000, '江西省', 360800, '吉安市', 360825, '永丰县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103546, 230000, '黑龙江省', 230300, '鸡西市', 230382, '密山市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103547, 360000, '江西省', 360800, '吉安市', 360822, '吉水县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103548, 130000, '河北省', 130900, '沧州市', 130924, '海兴县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103549, 350000, '福建省', 350400, '三明市', 350427, '沙县', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103550, 140000, '山西省', 140500, '晋城市', 140501, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103551, 140000, '山西省', 141000, '临汾市', 141025, '古县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103552, 140000, '山西省', 140600, '朔州市', 140623, '右玉县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103553, 420000, '湖北省', 421100, '黄冈市', 421122, '红安县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103554, 410000, '河南省', 410300, '洛阳市', 410329, '伊川县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103555, 440000, '广东省', 441200, '肇庆市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103556, 220000, '吉林省', 220200, '吉林市', 220282, '桦甸市', 3, 'A', 2, 2625, '长春', '', ''),
(103557, 450000, '广西壮族自治区', 451400, '崇左市', 451425, '天等县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103558, 450000, '广西壮族自治区', 451400, '崇左市', 451481, '凭祥市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103559, 610000, '陕西省', 610700, '汉中市', 610702, '汉台区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103560, 370000, '山东省', 371400, '德州市', 371424, '临邑县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103561, 420000, '湖北省', 420100, '武汉市', 420113, '汉南区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103562, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532524, '建水县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103563, 530000, '云南省', 530400, '玉溪市', 530424, '华宁县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103564, 340000, '安徽省', 340400, '淮南市', 340421, '凤台县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103565, 150000, '内蒙古自治区', 150400, '赤峰市', 150422, '巴林左旗', 3, 'A', 2, 2633, '唐山', '', ''),
(103566, 610000, '陕西省', 611000, '商洛市', 611026, '柞水县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103567, 210000, '辽宁省', 210500, '本溪市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(103568, 150000, '内蒙古自治区', 150500, '通辽市', 150526, '扎鲁特旗', 3, 'A', 2, 2626, '沈阳', '', ''),
(103569, 130000, '河北省', 130900, '沧州市', 130928, '吴桥县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103570, 410000, '河南省', 410300, '洛阳市', 410306, '吉利区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103571, 350000, '福建省', 350600, '漳州市', 350603, '龙文区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103572, 510000, '四川省', 511000, '内江市', 511024, '威远县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(103573, 530000, '云南省', 530700, '丽江市', 530723, '华坪县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103574, 210000, '辽宁省', 210400, '抚顺市', 210423, '清原满族自治县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103575, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150626, '乌审旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103576, 360000, '江西省', 360800, '吉安市', 360829, '安福县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103577, 370000, '山东省', 371700, '菏泽市', 371701, '其它区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103578, 130000, '河北省', 130900, '沧州市', 130901, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103579, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522622, '黄平县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103580, 420000, '湖北省', 420500, '宜昌市', 420529, '五峰土家族自治县', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103581, 210000, '辽宁省', 211000, '辽阳市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(103582, 540000, '西藏自治区', 542500, '阿里地区', 542523, '噶尔县', 3, 'A', 2, 2636, '兰州', '', ''),
(103583, 110000, '北京', 110100, '北京市', 110229, '延庆县', 3, 'A', 2, 2602, '北京', '北京RDC电商库', 'D10'),
(103584, 410000, '河南省', 411300, '南阳市', 411301, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103585, 610000, '陕西省', 610600, '延安市', 610627, '甘泉县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103586, 510000, '四川省', 511400, '眉山市', 511424, '丹棱县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103587, 510000, '四川省', 511100, '乐山市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(103588, 450000, '广西壮族自治区', 450800, '贵港市', 450821, '平南县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103589, 210000, '辽宁省', 210300, '鞍山市', 210381, '海城市', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103590, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650105, '水磨沟区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103591, 130000, '河北省', 130100, '石家庄市', 130132, '元氏县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103592, 360000, '江西省', 360700, '赣州市', 360726, '安远县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103593, 130000, '河北省', 130400, '邯郸市', 130404, '复兴区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103594, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522701, '都匀市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103595, 220000, '吉林省', 220200, '吉林市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103596, 220000, '吉林省', 220300, '四平市', 220382, '双辽市', 3, 'A', 2, 2625, '长春', '', ''),
(103597, 220000, '吉林省', 220100, '长春市', 220105, '二道区', 3, 'A', 1, 2625, '长春', '', ''),
(103598, 530000, '云南省', 530100, '昆明市', 530129, '寻甸回族彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103599, 220000, '吉林省', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(103600, 430000, '湖南省', 430600, '岳阳市', 430621, '岳阳县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103601, 620000, '甘肃省', 620800, '平凉市', 620821, '泾川县', 3, 'A', 2, 2636, '兰州', '', ''),
(103602, 420000, '湖北省', 420100, '武汉市', 420106, '武昌区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103603, 610000, '陕西省', 610600, '延安市', 610628, '富县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103604, 330000, '浙江省', 330900, '舟山市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(103605, 310000, '上海', 310100, '上海市', 310106, '静安区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(103606, 350000, '福建省', 350700, '南平市', 350784, '建阳市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103607, 210000, '辽宁省', 211200, '铁岭市', 211221, '铁岭县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103608, 370000, '山东省', 371400, '德州市', 371401, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103609, 410000, '河南省', 411300, '南阳市', 411324, '镇平县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103610, 230000, '黑龙江省', 230800, '佳木斯市', 230803, '向阳区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103611, 340000, '安徽省', 341300, '宿州市', 341321, '砀山县', 3, 'A', 2, 2639, '徐州', '合肥RDC电商库', 'D551'),
(103612, 220000, '吉林省', 220200, '吉林市', 220211, '丰满区', 3, 'A', 1, 2625, '长春', '', ''),
(103613, 130000, '河北省', 130700, '张家口市', 130706, '下花园区', 3, 'A', 1, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(103614, 440000, '广东省', 441600, '河源市', 441624, '和平县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(103615, 650000, '新疆维吾尔自治区', 652100, '吐鲁番地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(103616, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150105, '赛罕区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(103617, 510000, '四川省', 511400, '眉山市', 511423, '洪雅县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103618, 140000, '山西省', 141100, '吕梁市', 141124, '临县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103619, 340000, '安徽省', 340500, '马鞍山市', 341424, '和县', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103620, 440000, '广东省', 440100, '广州市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103621, 140000, '山西省', 141000, '临汾市', 141034, '汾西县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103622, 620000, '甘肃省', 620100, '兰州市', 620104, '西固区', 3, 'A', 1, 2636, '兰州', '', ''),
(103623, 350000, '福建省', 350900, '宁德市', 350981, '福安市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103624, 370000, '山东省', 371400, '德州市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(103625, 110000, '北京', 110100, '北京市', 110114, '昌平区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103626, 530000, '云南省', 530500, '保山市', 530502, '隆阳区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103627, 540000, '西藏自治区', 542400, '那曲地区', 542423, '比如县', 3, 'A', 2, 2308, '昆明', '', ''),
(103628, 350000, '福建省', 350100, '福州市', 350181, '福清市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103629, 130000, '河北省', 131000, '廊坊市', 131028, '大厂回族自治县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(103630, 510000, '四川省', 511700, '达州市', 511701, '其它区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(103631, 140000, '山西省', 140300, '阳泉市', 140301, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103632, 510000, '四川省', 511100, '乐山市', 511129, '沐川县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103633, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522301, '兴义市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103634, 450000, '广西壮族自治区', 451200, '河池市', 451281, '宜州市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103635, 430000, '湖南省', 431100, '永州市', 431129, '江华瑶族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103636, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522323, '普安县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103637, 140000, '山西省', 140500, '晋城市', 140521, '沁水县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103638, 330000, '浙江省', 331100, '丽水市', 331127, '景宁畲族自治县', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(103639, 360000, '江西省', 360200, '景德镇市', 360203, '珠山区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103640, 640000, '宁夏回族自治区', 640100, '银川市', 640122, '贺兰县', 3, 'A', 2, 2647, '西安', '', ''),
(103641, 610000, '陕西省', 610300, '宝鸡市', 610331, '太白县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103642, 620000, '甘肃省', 620100, '兰州市', 620111, '红古区', 3, 'A', 1, 2636, '兰州', '', ''),
(103643, 230000, '黑龙江省', 230700, '伊春市', 230703, '南岔区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103644, 640000, '宁夏回族自治区', 640400, '固原市', 640425, '彭阳县', 3, 'A', 2, 2647, '西安', '', ''),
(103645, 650000, '新疆维吾尔自治区', 653000, '克孜勒苏柯尔克孜自治州', 653001, '阿图什市', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103646, 330000, '浙江省', 330700, '金华市', 330783, '东阳市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103647, 430000, '湖南省', 431100, '永州市', 431128, '新田县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103648, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422825, '宣恩县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103649, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(103650, 220000, '吉林省', 220400, '辽源市', 220422, '东辽县', 3, 'A', 2, 2625, '长春', '', ''),
(103651, 440000, '广东省', 440500, '汕头市', 440507, '龙湖区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103652, 330000, '浙江省', 330100, '杭州市', 330127, '淳安县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103653, 370000, '山东省', 371400, '德州市', 371427, '夏津县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103654, 140000, '山西省', 0, '', 0, '', 1, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(103655, 320000, '江苏省', 320900, '盐城市', 320902, '亭湖区', 3, 'A', 1, 2663, '南通', '', ''),
(103656, 330000, '浙江省', 330300, '温州市', 330329, '泰顺县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103657, 210000, '辽宁省', 210400, '抚顺市', 210402, '新抚区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103658, 510000, '四川省', 510100, '成都市', 510114, '新都区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103659, 210000, '辽宁省', 210100, '沈阳市', 210104, '大东区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103660, 320000, '江苏省', 320300, '徐州市', 320303, '云龙区', 3, 'A', 1, 2639, '徐州', '', ''),
(103661, 370000, '山东省', 370600, '烟台市', 370686, '栖霞市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103662, 430000, '湖南省', 430600, '岳阳市', 430602, '岳阳楼区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103663, 440000, '广东省', 440400, '珠海市', 440403, '斗门区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103664, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422823, '巴东县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103665, 230000, '黑龙江省', 230700, '伊春市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(103666, 150000, '内蒙古自治区', 152200, '兴安盟', 152224, '突泉县', 3, 'A', 2, 2625, '长春', '', ''),
(103667, 530000, '云南省', 530800, '普洱市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(103668, 370000, '山东省', 370700, '潍坊市', 370725, '昌乐县', 3, 'A', 2, 2601, '青岛', '济南RDC电商库', 'D531'),
(103669, 370000, '山东省', 370800, '济宁市', 370801, '其它区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103670, 510000, '四川省', 511700, '达州市', 511721, '达川区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(103671, 130000, '河北省', 130800, '承德市', 130822, '兴隆县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(103672, 220000, '吉林省', 220600, '白山市', 220623, '长白朝鲜族自治县', 3, 'A', 2, 2625, '长春', '', ''),
(103673, 440000, '广东省', 445300, '云浮市', 445321, '新兴县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(103674, 130000, '河北省', 130600, '保定市', 130628, '高阳县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103675, 230000, '黑龙江省', 231000, '牡丹江市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(103676, 320000, '江苏省', 320900, '盐城市', 320925, '建湖县', 3, 'A', 2, 2663, '南通', '', ''),
(103677, 510000, '四川省', 510300, '自贡市', 510301, '其它区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103678, 430000, '湖南省', 430100, '长沙市', 430122, '望城区', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103679, 230000, '黑龙江省', 231000, '牡丹江市', 231024, '东宁县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103680, 120000, '天津', 120100, '天津市', 120116, '滨海新区', 3, 'A', 2, 2634, '天津', '', ''),
(103681, 530000, '云南省', 533300, '怒江傈僳族自治州', 533321, '泸水县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103682, 410000, '河南省', 411000, '许昌市', 411002, '魏都区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103683, 460000, '海南省', 469000, '省直辖县级行政区划', 469005, '文昌市', 3, 'D', 1, 0, '', '', ''),
(103684, 440000, '广东省', 445100, '潮州市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103685, 410000, '河南省', 410100, '郑州市', 410185, '登封市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103686, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652926, '拜城县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103687, 140000, '山西省', 141000, '临汾市', 141001, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103688, 320000, '江苏省', 320800, '淮安市', 320830, '盱眙县', 3, 'A', 2, 2639, '徐州', '', ''),
(103689, 450000, '广西壮族自治区', 451400, '崇左市', 451422, '宁明县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103690, 530000, '云南省', 532600, '文山壮族苗族自治州', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(103691, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652825, '且末县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103692, 370000, '山东省', 370800, '济宁市', 370883, '邹城市', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103693, 370000, '山东省', 370600, '烟台市', 370685, '招远市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103694, 340000, '安徽省', 341800, '宣城市', 341825, '旌德县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103695, 220000, '吉林省', 220400, '辽源市', 220421, '东丰县', 3, 'A', 2, 2625, '长春', '', ''),
(103696, 370000, '山东省', 370500, '东营市', 370522, '利津县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103697, 130000, '河北省', 130900, '沧州市', 130927, '南皮县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103698, 370000, '山东省', 370200, '青岛市', 370205, '四方区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103699, 410000, '河南省', 411500, '信阳市', 411527, '淮滨县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103700, 530000, '云南省', 532900, '大理白族自治州', 532923, '祥云县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103701, 510000, '四川省', 511400, '眉山市', 511421, '仁寿县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103702, 340000, '安徽省', 341100, '滁州市', 341122, '来安县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103703, 450000, '广西壮族自治区', 450800, '贵港市', 450804, '覃塘区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103704, 620000, '甘肃省', 620700, '张掖市', 620724, '高台县', 3, 'A', 2, 2636, '兰州', '', ''),
(103705, 230000, '黑龙江省', 230400, '鹤岗市', 230421, '萝北县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103706, 440000, '广东省', 440500, '汕头市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103707, 430000, '湖南省', 430700, '常德市', 430726, '石门县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103708, 370000, '山东省', 370400, '枣庄市', 370402, '市中区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103709, 360000, '江西省', 361000, '抚州市', 361024, '崇仁县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103710, 420000, '湖北省', 420300, '十堰市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(103711, 440000, '广东省', 440700, '江门市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(103712, 420000, '湖北省', 429000, '省直辖县级行政区划', 429021, '神农架林区', 3, 'D', 1, 0, '', '武汉RDC电商库', 'D027'),
(103713, 130000, '河北省', 131000, '廊坊市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(103714, 500000, '重庆', 500100, '重庆市', 500114, '黔江区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103715, 220000, '吉林省', 220500, '通化市', 220501, '其它区', 3, 'A', 1, 2625, '长春', '', ''),
(103716, 370000, '山东省', 370700, '潍坊市', 370702, '潍城区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103717, 500000, '重庆', 500100, '重庆市', 500112, '渝北区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103718, 530000, '云南省', 532300, '楚雄彝族自治州', 532326, '大姚县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103719, 140000, '山西省', 140400, '长治市', 140421, '长治县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103720, 330000, '浙江省', 330800, '衢州市', 330822, '常山县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103721, 360000, '江西省', 360800, '吉安市', 360801, '其它区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103722, 210000, '辽宁省', 211200, '铁岭市', 211282, '开原市', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103723, 320000, '江苏省', 320500, '苏州市', 320502, '沧浪区', 3, 'A', 1, 2664, '无锡', '', ''),
(103724, 130000, '河北省', 130900, '沧州市', 130902, '新华区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103725, 440000, '广东省', 440700, '江门市', 440784, '鹤山市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103726, 650000, '新疆维吾尔自治区', 654200, '塔城地区', 654201, '塔城市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103727, 450000, '广西壮族自治区', 451200, '河池市', 451221, '南丹县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103728, 370000, '山东省', 370600, '烟台市', 370602, '芝罘区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103729, 230000, '黑龙江省', 230100, '哈尔滨市', 230182, '双城市', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103730, 330000, '浙江省', 330100, '杭州市', 330185, '临安市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103731, 110000, '北京', 110100, '北京市', 110104, '宣武区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(103732, 210000, '辽宁省', 211400, '葫芦岛市', 211421, '绥中县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103733, 330000, '浙江省', 330200, '宁波市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(103734, 310000, '上海', 310100, '上海市', 310114, '嘉定区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(103735, 330000, '浙江省', 330700, '金华市', 330781, '兰溪市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103736, 340000, '安徽省', 340800, '安庆市', 340801, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103737, 140000, '山西省', 141100, '吕梁市', 141102, '离石区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103738, 120000, '天津', 120100, '天津市', 120112, '津南区', 3, 'A', 1, 2634, '天津', '', ''),
(103739, 140000, '山西省', 140100, '太原市', 140181, '古交市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103740, 210000, '辽宁省', 211000, '辽阳市', 211001, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(103741, 540000, '西藏自治区', 542100, '昌都地区', 542126, '察雅县', 3, 'A', 2, 2636, '兰州', '', ''),
(103742, 340000, '安徽省', 341800, '宣城市', 341821, '郎溪县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103743, 130000, '河北省', 130600, '保定市', 130635, '蠡县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103744, 620000, '甘肃省', 620800, '平凉市', 620801, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(103745, 440000, '广东省', 440100, '广州市', 440114, '花都区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103746, 330000, '浙江省', 330600, '绍兴市', 330601, '其它区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(103747, 460000, '海南省', 460076, '南沙群岛', 0, '', 2, 'D', 0, 0, '', '', ''),
(103748, 130000, '河北省', 130500, '邢台市', 130521, '邢台县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103749, 140000, '山西省', 140900, '忻州市', 140925, '宁武县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103750, 330000, '浙江省', 330300, '温州市', 330381, '瑞安市', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(103751, 530000, '云南省', 530800, '普洱市', 530827, '孟连傣族拉祜族佤族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103752, 330000, '浙江省', 331000, '台州市', 331021, '玉环县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(103753, 430000, '湖南省', 431000, '郴州市', 431002, '北湖区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103754, 210000, '辽宁省', 210700, '锦州市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(103755, 140000, '山西省', 140600, '朔州市', 140602, '朔城区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103756, 130000, '河北省', 130400, '邯郸市', 130426, '涉县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103757, 610000, '陕西省', 610700, '汉中市', 610730, '佛坪县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103758, 340000, '安徽省', 341200, '阜阳市', 341221, '临泉县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103759, 430000, '湖南省', 430700, '常德市', 430724, '临澧县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103760, 220000, '吉林省', 220800, '白城市', 220881, '洮南市', 3, 'A', 1, 2625, '长春', '', ''),
(103761, 510000, '四川省', 510700, '绵阳市', 510781, '江油市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103762, 610000, '陕西省', 610500, '渭南市', 610525, '澄城县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103763, 620000, '甘肃省', 620100, '兰州市', 620105, '安宁区', 3, 'A', 1, 2636, '兰州', '', ''),
(103764, 650000, '新疆维吾尔自治区', 652100, '吐鲁番地区', 652123, '托克逊县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103765, 230000, '黑龙江省', 230500, '双鸭山市', 230522, '友谊县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103766, 140000, '山西省', 140800, '运城市', 140801, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103767, 130000, '河北省', 130400, '邯郸市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(103768, 410000, '河南省', 410400, '平顶山市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(103769, 370000, '山东省', 370700, '潍坊市', 370701, '其它区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103770, 130000, '河北省', 130600, '保定市', 130630, '涞源县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103771, 420000, '湖北省', 421000, '荆州市', 421003, '荆州区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103772, 370000, '山东省', 370300, '淄博市', 370305, '临淄区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103773, 330000, '浙江省', 330500, '湖州市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(103774, 350000, '福建省', 350900, '宁德市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(103775, 320000, '江苏省', 320600, '南通市', 320601, '其它区', 3, 'A', 1, 2663, '南通', '', ''),
(103776, 440000, '广东省', 440500, '汕头市', 440501, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103777, 610000, '陕西省', 610100, '西安市', 610101, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103778, 340000, '安徽省', 340600, '淮北市', 340604, '烈山区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(103779, 130000, '河北省', 131100, '衡水市', 131181, '冀州市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103780, 340000, '安徽省', 341000, '黄山市', 341001, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103781, 230000, '黑龙江省', 230400, '鹤岗市', 230404, '南山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103782, 120000, '天津', 120100, '天津市', 120225, '蓟县', 3, 'A', 2, 2634, '天津', '', ''),
(103783, 340000, '安徽省', 340600, '淮北市', 340621, '濉溪县', 3, 'A', 2, 2639, '徐州', '合肥RDC电商库', 'D551'),
(103784, 220000, '吉林省', 220100, '长春市', 220106, '绿园区', 3, 'A', 2, 2625, '长春', '', ''),
(103785, 450000, '广西壮族自治区', 450400, '梧州市', 450406, '龙圩区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103786, 610000, '陕西省', 610300, '宝鸡市', 610301, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103787, 530000, '云南省', 530400, '玉溪市', 530426, '峨山彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103788, 230000, '黑龙江省', 231200, '绥化市', 231202, '北林区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103789, 340000, '安徽省', 340800, '安庆市', 340825, '太湖县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103790, 120000, '天津', 120100, '天津市', 120221, '宁河县', 3, 'A', 2, 2634, '天津', '', ''),
(103791, 350000, '福建省', 350600, '漳州市', 350602, '芗城区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103792, 460000, '海南省', 469026, '昌江黎族自治县', 469032, '南沙群岛', 3, 'A', 1, 2646, '海口', '', ''),
(103793, 320000, '江苏省', 321100, '镇江市', 321182, '扬中市', 3, 'A', 1, 2604, '南京', '', ''),
(103794, 530000, '云南省', 530300, '曲靖市', 530381, '宣威市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103795, 620000, '甘肃省', 621100, '定西市', 621122, '陇西县', 3, 'A', 2, 2636, '兰州', '', ''),
(103796, 420000, '湖北省', 420100, '武汉市', 420102, '江岸区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103797, 620000, '甘肃省', 620400, '白银市', 620403, '平川区', 3, 'A', 1, 2636, '兰州', '', ''),
(103798, 150000, '内蒙古自治区', 152200, '兴安盟', 152202, '阿尔山市', 3, 'A', 2, 2625, '长春', '', ''),
(103799, 130000, '河北省', 130100, '石家庄市', 130183, '晋州市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103800, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230206, '富拉尔基区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103801, 540000, '西藏自治区', 542300, '日喀则地区', 542338, '岗巴县', 3, 'A', 2, 2636, '兰州', '', ''),
(103802, 410000, '河南省', 410300, '洛阳市', 410327, '宜阳县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103803, 370000, '山东省', 371100, '日照市', 371101, '其它区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103804, 500000, '重庆', 500100, '重庆市', 500111, '双桥区', 3, 'D', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103805, 430000, '湖南省', 430100, '长沙市', 430181, '浏阳市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103806, 220000, '吉林省', 220600, '白山市', 220622, '靖宇县', 3, 'A', 2, 2625, '长春', '', ''),
(103807, 450000, '广西壮族自治区', 451200, '河池市', 451227, '巴马瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103808, 430000, '湖南省', 431300, '娄底市', 431322, '新化县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103809, 130000, '河北省', 130900, '沧州市', 130982, '任丘市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103810, 330000, '浙江省', 330700, '金华市', 330723, '武义县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103811, 520000, '贵州省', 520100, '贵阳市', 520123, '修文县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103812, 370000, '山东省', 370400, '枣庄市', 370481, '滕州市', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(103813, 450000, '广西壮族自治区', 451300, '来宾市', 451322, '象州县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103814, 540000, '西藏自治区', 542200, '山南地区', 542233, '浪卡子县', 3, 'A', 1, 2308, '昆明', '', ''),
(103815, 450000, '广西壮族自治区', 450100, '南宁市', 450108, '良庆区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103816, 130000, '河北省', 130500, '邢台市', 130525, '隆尧县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103817, 410000, '河南省', 410300, '洛阳市', 410328, '洛宁县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103818, 410000, '河南省', 410100, '郑州市', 410105, '金水区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103819, 350000, '福建省', 350800, '龙岩市', 350824, '武平县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103820, 530000, '云南省', 530500, '保山市', 530501, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103821, 130000, '河北省', 130300, '秦皇岛市', 130324, '卢龙县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(103822, 130000, '河北省', 130600, '保定市', 130632, '安新县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103823, 150000, '内蒙古自治区', 150200, '包头市', 150223, '达尔罕茂明安联合旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103824, 130000, '河北省', 130600, '保定市', 130684, '高碑店市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103825, 450000, '广西壮族自治区', 450400, '梧州市', 450403, '万秀区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103826, 410000, '河南省', 411200, '三门峡市', 411224, '卢氏县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103827, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650102, '天山区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103828, 150000, '内蒙古自治区', 150400, '赤峰市', 150430, '敖汉旗', 3, 'A', 2, 2633, '唐山', '', ''),
(103829, 360000, '江西省', 360100, '南昌市', 360102, '东湖区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(103830, 610000, '陕西省', 610800, '榆林市', 610831, '子洲县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(103831, 230000, '黑龙江省', 230500, '双鸭山市', 230503, '岭东区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103832, 510000, '四川省', 510100, '成都市', 510112, '龙泉驿区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103833, 430000, '湖南省', 430500, '邵阳市', 430521, '邵东县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103834, 500000, '重庆', 500100, '重庆市', 500117, '合川区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103835, 320000, '江苏省', 321200, '泰州市', 321202, '海陵区', 3, 'A', 1, 2663, '南通', '', ''),
(103836, 430000, '湖南省', 430200, '株洲市', 430201, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103837, 540000, '西藏自治区', 540100, '拉萨市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103838, 620000, '甘肃省', 622900, '临夏回族自治州', 622925, '和政县', 3, 'A', 2, 2636, '兰州', '', ''),
(103839, 350000, '福建省', 350700, '南平市', 350701, '其它区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103840, 630000, '青海省', 630100, '西宁市', 630123, '湟源县', 3, 'A', 2, 2636, '兰州', '', ''),
(103841, 340000, '安徽省', 341500, '六安市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(103842, 410000, '河南省', 410800, '焦作市', 410811, '山阳区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103843, 320000, '江苏省', 320200, '无锡市', 320281, '江阴市', 3, 'A', 1, 2664, '无锡', '', ''),
(103844, 370000, '山东省', 370300, '淄博市', 370302, '淄川区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(103845, 320000, '江苏省', 320900, '盐城市', 320922, '滨海县', 3, 'A', 2, 2663, '南通', '', ''),
(103846, 430000, '湖南省', 430400, '衡阳市', 430422, '衡南县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103847, 540000, '西藏自治区', 542500, '阿里地区', 542524, '日土县', 3, 'A', 2, 2636, '兰州', '', ''),
(103848, 540000, '西藏自治区', 542600, '林芝地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(103849, 130000, '河北省', 130600, '保定市', 130624, '阜平县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103850, 520000, '贵州省', 522400, '毕节市', 522423, '黔西县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103851, 130000, '河北省', 130700, '张家口市', 130703, '桥西区', 3, 'A', 1, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(103852, 510000, '四川省', 510100, '成都市', 510184, '崇州市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103853, 220000, '吉林省', 220500, '通化市', 220581, '梅河口市', 3, 'A', 2, 2625, '长春', '', ''),
(103854, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522632, '榕江县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103855, 330000, '浙江省', 330800, '衢州市', 330825, '龙游县', 3, 'A', 2, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103856, 370000, '山东省', 371400, '德州市', 371428, '武城县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103857, 410000, '河南省', 410100, '郑州市', 410122, '中牟县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103858, 130000, '河北省', 130800, '承德市', 130802, '双桥区', 3, 'A', 1, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(103859, 230000, '黑龙江省', 231000, '牡丹江市', 231085, '穆棱市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103860, 230000, '黑龙江省', 231200, '绥化市', 231283, '海伦市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103861, 620000, '甘肃省', 621000, '庆阳市', 621002, '西峰区', 3, 'A', 1, 2636, '兰州', '', ''),
(103862, 410000, '河南省', 411700, '驻马店市', 411727, '汝南县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103863, 340000, '安徽省', 340100, '合肥市', 341402, '居巢区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103864, 150000, '内蒙古自治区', 152200, '兴安盟', 0, '', 2, 'A', 0, 0, '', '', ''),
(103865, 420000, '湖北省', 421200, '咸宁市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(103866, 610000, '陕西省', 610400, '咸阳市', 610401, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103867, 440000, '广东省', 441800, '清远市', 441801, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103868, 220000, '吉林省', 220500, '通化市', 220503, '二道江区', 3, 'A', 1, 2625, '长春', '', ''),
(103869, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230201, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103870, 330000, '浙江省', 330400, '嘉兴市', 330411, '秀洲区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103871, 510000, '四川省', 510800, '广元市', 510802, '利州区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103872, 530000, '云南省', 530300, '曲靖市', 530324, '罗平县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103873, 370000, '山东省', 371000, '威海市', 371002, '环翠区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103874, 140000, '山西省', 140200, '大同市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(103875, 450000, '广西壮族自治区', 450200, '柳州市', 450203, '鱼峰区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103876, 140000, '山西省', 141000, '临汾市', 141026, '安泽县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103877, 530000, '云南省', 530100, '昆明市', 530113, '东川区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103878, 610000, '陕西省', 610800, '榆林市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(103879, 540000, '西藏自治区', 542100, '昌都地区', 542132, '洛隆县', 3, 'A', 2, 2636, '兰州', '', ''),
(103880, 460000, '海南省', 469000, '省直辖县级行政区划', 469022, '屯昌县', 3, 'D', 2, 0, '', '', ''),
(103881, 430000, '湖南省', 430200, '株洲市', 430223, '攸县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103882, 140000, '山西省', 141000, '临汾市', 141082, '霍州市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103883, 350000, '福建省', 350200, '厦门市', 350212, '同安区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103884, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150621, '达拉特旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103885, 430000, '湖南省', 430800, '张家界市', 430821, '慈利县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103886, 230000, '黑龙江省', 230100, '哈尔滨市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(103887, 610000, '陕西省', 610500, '渭南市', 610501, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103888, 510000, '四川省', 511000, '内江市', 511002, '市中区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103889, 620000, '甘肃省', 621000, '庆阳市', 621027, '镇原县', 3, 'A', 2, 2636, '兰州', '', ''),
(103890, 410000, '河南省', 410300, '洛阳市', 410303, '西工区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103891, 150000, '内蒙古自治区', 152200, '兴安盟', 152222, '科尔沁右翼中旗', 3, 'A', 2, 2625, '长春', '', ''),
(103892, 360000, '江西省', 360200, '景德镇市', 360281, '乐平市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103893, 130000, '河北省', 130100, '石家庄市', 130123, '正定县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103894, 640000, '宁夏回族自治区', 640400, '固原市', 640402, '原州区', 3, 'A', 1, 2647, '西安', '', ''),
(103895, 360000, '江西省', 361100, '上饶市', 361101, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(103896, 360000, '江西省', 361100, '上饶市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(103897, 440000, '广东省', 440800, '湛江市', 440802, '赤坎区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103898, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522726, '独山县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103899, 430000, '湖南省', 430400, '衡阳市', 430401, '其它区', 3, 'A', 1, 0, '', '长沙RDC电商库', 'D731'),
(103900, 340000, '安徽省', 341200, '阜阳市', 341226, '颍上县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103901, 450000, '广西壮族自治区', 450700, '钦州市', 450721, '灵山县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103902, 350000, '福建省', 350100, '福州市', 350111, '晋安区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103903, 510000, '四川省', 510800, '广元市', 510811, '昭化区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103904, 330000, '浙江省', 330100, '杭州市', 330102, '上城区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(103905, 140000, '山西省', 140500, '晋城市', 140581, '高平市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103906, 320000, '江苏省', 320700, '连云港市', 320706, '海州区', 3, 'A', 1, 2608, '临沂', '', ''),
(103907, 410000, '河南省', 411600, '周口市', 411625, '郸城县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103908, 350000, '福建省', 350100, '福州市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(103909, 370000, '山东省', 371700, '菏泽市', 371723, '成武县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(103910, 340000, '安徽省', 341200, '阜阳市', 341282, '界首市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103911, 530000, '云南省', 530100, '昆明市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(103912, 510000, '四川省', 513400, '凉山彝族自治州', 513433, '冕宁县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103913, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532529, '红河县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103914, 360000, '江西省', 360800, '吉安市', 360821, '吉安县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103915, 510000, '四川省', 510400, '攀枝花市', 510422, '盐边县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103916, 410000, '河南省', 410500, '安阳市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(103917, 430000, '湖南省', 431100, '永州市', 431102, '零陵区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103918, 420000, '湖北省', 420600, '襄阳市', 420626, '保康县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103919, 510000, '四川省', 513300, '甘孜藏族自治州', 513334, '理塘县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103920, 510000, '四川省', 510900, '遂宁市', 510923, '大英县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103921, 370000, '山东省', 370200, '青岛市', 370202, '市南区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(103922, 510000, '四川省', 511300, '南充市', 511323, '蓬安县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(103923, 410000, '河南省', 410700, '新乡市', 410703, '卫滨区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103924, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150721, '阿荣旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(103925, 460000, '海南省', 469000, '省直辖县级行政区划', 469002, '琼海市', 3, 'D', 1, 0, '', '', ''),
(103926, 640000, '宁夏回族自治区', 640400, '固原市', 640401, '其它区', 3, 'A', 1, 2647, '西安', '', ''),
(103927, 140000, '山西省', 140600, '朔州市', 140601, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103928, 500000, '重庆', 500100, '重庆市', 500113, '巴南区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(103929, 340000, '安徽省', 341000, '黄山市', 341003, '黄山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103930, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152531, '多伦县', 3, 'A', 2, 2633, '唐山', '', ''),
(103931, 370000, '山东省', 370900, '泰安市', 370923, '东平县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(103932, 220000, '吉林省', 220700, '松原市', 0, '', 2, 'A', 0, 0, '', '', ''),
(103933, 410000, '河南省', 411300, '南阳市', 411329, '新野县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103934, 130000, '河北省', 130400, '邯郸市', 130424, '成安县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103935, 440000, '广东省', 440100, '广州市', 440116, '萝岗区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103936, 450000, '广西壮族自治区', 451000, '百色市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(103937, 450000, '广西壮族自治区', 450800, '贵港市', 450801, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103938, 440000, '广东省', 441600, '河源市', 441602, '源城区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103939, 420000, '湖北省', 420300, '十堰市', 420322, '郧西县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(103940, 130000, '河北省', 130800, '承德市', 130821, '承德县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(103941, 140000, '山西省', 140100, '太原市', 140106, '迎泽区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(103942, 520000, '贵州省', 520300, '遵义市', 520329, '余庆县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103943, 150000, '内蒙古自治区', 152200, '兴安盟', 152221, '科尔沁右翼前旗', 3, 'A', 2, 2625, '长春', '', ''),
(103944, 320000, '江苏省', 320300, '徐州市', 320304, '九里区', 3, 'A', 1, 2639, '徐州', '', ''),
(103945, 510000, '四川省', 511500, '宜宾市', 511528, '兴文县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(103946, 440000, '广东省', 441600, '河源市', 441601, '其它区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(103947, 130000, '河北省', 130500, '邢台市', 130533, '威县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103948, 350000, '福建省', 350200, '厦门市', 350211, '集美区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(103949, 130000, '河北省', 130400, '邯郸市', 130433, '馆陶县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103950, 320000, '江苏省', 320600, '南通市', 320682, '如皋市', 3, 'A', 1, 2663, '南通', '', ''),
(103951, 210000, '辽宁省', 210600, '丹东市', 210681, '东港市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(103952, 340000, '安徽省', 341800, '宣城市', 341823, '泾县', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103953, 360000, '江西省', 360700, '赣州市', 360731, '于都县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(103954, 440000, '广东省', 440100, '广州市', 440105, '海珠区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103955, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522702, '福泉市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(103956, 530000, '云南省', 530900, '临沧市', 530902, '临翔区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103957, 340000, '安徽省', 341800, '宣城市', 341801, '其它区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(103958, 440000, '广东省', 440300, '深圳市', 440304, '福田区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(103959, 530000, '云南省', 532800, '西双版纳傣族自治州', 532822, '勐海县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103960, 620000, '甘肃省', 620500, '天水市', 620503, '麦积区', 3, 'A', 1, 2636, '兰州', '', ''),
(103961, 450000, '广西壮族自治区', 450900, '玉林市', 450902, '玉州区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103962, 410000, '河南省', 410700, '新乡市', 410724, '获嘉县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103963, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150825, '乌拉特后旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(103964, 130000, '河北省', 130100, '石家庄市', 130104, '桥西区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(103965, 450000, '广西壮族自治区', 451000, '百色市', 451022, '田东县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(103966, 410000, '河南省', 410600, '鹤壁市', 410621, '浚县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(103967, 320000, '江苏省', 320100, '南京市', 320106, '鼓楼区', 3, 'A', 1, 2604, '南京', '', ''),
(103968, 460000, '海南省', 469000, '省直辖县级行政区划', 469027, '澄迈县', 3, 'D', 1, 0, '', '', ''),
(103969, 510000, '四川省', 510100, '成都市', 510181, '都江堰市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(103970, 410000, '河南省', 411600, '周口市', 411681, '项城市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103971, 140000, '山西省', 141000, '临汾市', 141029, '乡宁县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(103972, 330000, '浙江省', 330300, '温州市', 330302, '鹿城区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(103973, 540000, '西藏自治区', 542600, '林芝地区', 542624, '墨脱县', 3, 'A', 2, 2308, '昆明', '', ''),
(103974, 130000, '河北省', 131000, '廊坊市', 131003, '广阳区', 3, 'A', 1, 2634, '天津', '石家庄RDC电商库', 'D311'),
(103975, 230000, '黑龙江省', 231000, '牡丹江市', 231083, '海林市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103976, 510000, '四川省', 511800, '雅安市', 511827, '宝兴县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103977, 440000, '广东省', 441800, '清远市', 441882, '连州市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(103978, 130000, '河北省', 130800, '承德市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(103979, 510000, '四川省', 513300, '甘孜藏族自治州', 513337, '稻城县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(103980, 430000, '湖南省', 430900, '益阳市', 430903, '赫山区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103981, 610000, '陕西省', 610100, '西安市', 610114, '阎良区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(103982, 350000, '福建省', 350700, '南平市', 350783, '建瓯市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103983, 220000, '吉林省', 220800, '白城市', 220822, '通榆县', 3, 'A', 2, 2625, '长春', '', ''),
(103984, 640000, '宁夏回族自治区', 640400, '固原市', 640423, '隆德县', 3, 'A', 2, 2647, '西安', '', ''),
(103985, 510000, '四川省', 510300, '自贡市', 510321, '荣县', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(103986, 430000, '湖南省', 431200, '怀化市', 431223, '辰溪县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(103987, 650000, '新疆维吾尔自治区', 653200, '和田地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(103988, 410000, '河南省', 410400, '平顶山市', 410425, '郏县', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(103989, 530000, '云南省', 532300, '楚雄彝族自治州', 532324, '南华县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103990, 350000, '福建省', 350300, '莆田市', 350305, '秀屿区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(103991, 420000, '湖北省', 421100, '黄冈市', 421123, '罗田县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(103992, 530000, '云南省', 530800, '普洱市', 530821, '宁洱哈尼族彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(103993, 650000, '新疆维吾尔自治区', 652700, '博尔塔拉蒙古自治州', 652701, '博乐市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(103994, 230000, '黑龙江省', 230800, '佳木斯市', 230882, '富锦市', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(103995, 230000, '黑龙江省', 231200, '绥化市', 231282, '肇东市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(103996, 510000, '四川省', 511800, '雅安市', 511824, '石棉县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(103997, 530000, '云南省', 530600, '昭通市', 530625, '永善县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(103998, 340000, '安徽省', 341300, '宿州市', 341301, '其它区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(103999, 320000, '江苏省', 320400, '常州市', 320411, '新北区', 3, 'A', 1, 2604, '南京', '', ''),
(104000, 320000, '江苏省', 321000, '扬州市', 321002, '广陵区', 3, 'A', 1, 2663, '南通', '', ''),
(104001, 430000, '湖南省', 430600, '岳阳市', 430603, '云溪区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104002, 430000, '湖南省', 430900, '益阳市', 430923, '安化县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104003, 410000, '河南省', 411600, '周口市', 411624, '沈丘县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104004, 360000, '江西省', 360300, '萍乡市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(104005, 210000, '辽宁省', 210600, '丹东市', 210624, '宽甸满族自治县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104006, 140000, '山西省', 140800, '运城市', 140821, '临猗县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104007, 450000, '广西壮族自治区', 450500, '北海市', 450501, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104008, 320000, '江苏省', 320100, '南京市', 320116, '六合区', 3, 'A', 1, 2604, '南京', '', ''),
(104009, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150102, '新城区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104010, 340000, '安徽省', 341500, '六安市', 341521, '寿县', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104011, 130000, '河北省', 130500, '邢台市', 130581, '南宫市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104012, 320000, '江苏省', 320100, '南京市', 320101, '其它区', 3, 'A', 1, 2604, '南京', '', ''),
(104013, 360000, '江西省', 360900, '宜春市', 360923, '上高县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104014, 350000, '福建省', 350300, '莆田市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(104015, 420000, '湖北省', 420500, '宜昌市', 420501, '其它区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104016, 210000, '辽宁省', 211200, '铁岭市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(104017, 530000, '云南省', 530100, '昆明市', 530124, '富民县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104018, 500000, '重庆', 500100, '重庆市', 500101, '万州区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104019, 130000, '河北省', 130400, '邯郸市', 130429, '永年县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104020, 360000, '江西省', 360900, '宜春市', 360924, '宜丰县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104021, 420000, '湖北省', 421100, '黄冈市', 421125, '浠水县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104022, 220000, '吉林省', 220500, '通化市', 220582, '集安市', 3, 'A', 2, 2625, '长春', '', ''),
(104023, 420000, '湖北省', 421100, '黄冈市', 421126, '蕲春县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104024, 520000, '贵州省', 520400, '安顺市', 520425, '紫云苗族布依族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104025, 340000, '安徽省', 341700, '池州市', 341702, '贵池区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104026, 210000, '辽宁省', 210900, '阜新市', 210902, '海州区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104027, 230000, '黑龙江省', 231000, '牡丹江市', 231002, '东安区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104028, 130000, '河北省', 130700, '张家口市', 130730, '怀来县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104029, 540000, '西藏自治区', 542100, '昌都地区', 542133, '边坝县', 3, 'A', 2, 2636, '兰州', '', ''),
(104030, 410000, '河南省', 410300, '洛阳市', 410322, '孟津县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104031, 510000, '四川省', 510400, '攀枝花市', 510403, '西区', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(104032, 130000, '河北省', 130100, '石家庄市', 130133, '赵县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104033, 440000, '广东省', 440500, '汕头市', 440514, '潮南区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(104034, 430000, '湖南省', 430500, '邵阳市', 430527, '绥宁县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104035, 370000, '山东省', 370800, '济宁市', 370827, '鱼台县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(104036, 320000, '江苏省', 320100, '南京市', 320104, '秦淮区', 3, 'A', 1, 2604, '南京', '', ''),
(104037, 320000, '江苏省', 321000, '扬州市', 321011, '维扬区', 3, 'A', 1, 2663, '南通', '', ''),
(104038, 510000, '四川省', 510300, '自贡市', 510322, '富顺县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(104039, 420000, '湖北省', 420100, '武汉市', 420116, '黄陂区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104040, 360000, '江西省', 360900, '宜春市', 360981, '丰城市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104041, 210000, '辽宁省', 211300, '朝阳市', 211382, '凌源市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104042, 330000, '浙江省', 330500, '湖州市', 330503, '南浔区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104043, 610000, '陕西省', 610700, '汉中市', 610725, '勉县', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104044, 410000, '河南省', 411200, '三门峡市', 411222, '陕县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104045, 510000, '四川省', 511000, '内江市', 511011, '东兴区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(104046, 500000, '重庆', 500100, '重庆市', 500229, '城口县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104047, 230000, '黑龙江省', 230400, '鹤岗市', 230401, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104048, 520000, '贵州省', 520300, '遵义市', 520302, '红花岗区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104049, 360000, '江西省', 360100, '南昌市', 360104, '青云谱区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(104050, 410000, '河南省', 411100, '漯河市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(104051, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532525, '石屏县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104052, 350000, '福建省', 350100, '福州市', 350102, '鼓楼区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(104053, 420000, '湖北省', 420500, '宜昌市', 420504, '点军区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104054, 450000, '广西壮族自治区', 450100, '南宁市', 450122, '武鸣县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104055, 210000, '辽宁省', 210900, '阜新市', 210901, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104056, 420000, '湖北省', 420700, '鄂州市', 420703, '华容区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104057, 410000, '河南省', 410300, '洛阳市', 410381, '偃师市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104058, 350000, '福建省', 350600, '漳州市', 350625, '长泰县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(104059, 140000, '山西省', 140200, '大同市', 140226, '左云县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104060, 230000, '黑龙江省', 230700, '伊春市', 230705, '西林区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104061, 420000, '湖北省', 420200, '黄石市', 420204, '下陆区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104062, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104063, 440000, '广东省', 441400, '梅州市', 441422, '大埔县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(104064, 520000, '贵州省', 522400, '毕节市', 522424, '金沙县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104065, 620000, '甘肃省', 621100, '定西市', 621121, '通渭县', 3, 'A', 2, 2636, '兰州', '', ''),
(104066, 230000, '黑龙江省', 230100, '哈尔滨市', 230183, '尚志市', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104067, 450000, '广西壮族自治区', 450300, '桂林市', 450327, '灌阳县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104068, 370000, '山东省', 371200, '莱芜市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(104069, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513231, '阿坝县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104070, 370000, '山东省', 371500, '聊城市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(104071, 430000, '湖南省', 431100, '永州市', 431121, '祁阳县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104072, 500000, '重庆', 500100, '重庆市', 500108, '南岸区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104073, 150000, '内蒙古自治区', 150200, '包头市', 150201, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104074, 330000, '浙江省', 330800, '衢州市', 330881, '江山市', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104075, 440000, '广东省', 440200, '韶关市', 440233, '新丰县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(104076, 370000, '山东省', 371200, '莱芜市', 371202, '莱城区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104077, 370000, '山东省', 371400, '德州市', 371402, '德城区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104078, 140000, '山西省', 140700, '晋中市', 140726, '太谷县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104079, 440000, '广东省', 441400, '梅州市', 441481, '兴宁市', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(104080, 370000, '山东省', 371500, '聊城市', 371521, '阳谷县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(104081, 450000, '广西壮族自治区', 450700, '钦州市', 450701, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104082, 330000, '浙江省', 330900, '舟山市', 330901, '其它区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104083, 420000, '湖北省', 420800, '荆门市', 420821, '京山县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104084, 530000, '云南省', 530900, '临沧市', 530921, '凤庆县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104085, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230230, '克东县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104086, 440000, '广东省', 440100, '广州市', 440106, '天河区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104087, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653126, '叶城县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104088, 410000, '河南省', 410200, '开封市', 410225, '兰考县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104089, 130000, '河北省', 130900, '沧州市', 130983, '黄骅市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104090, 430000, '湖南省', 430400, '衡阳市', 430421, '衡阳县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104091, 440000, '广东省', 440300, '深圳市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104092, 330000, '浙江省', 330300, '温州市', 330301, '其它区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104093, 420000, '湖北省', 421100, '黄冈市', 421102, '黄州区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104094, 140000, '山西省', 140100, '太原市', 140105, '小店区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104095, 320000, '江苏省', 321300, '宿迁市', 321323, '泗阳县', 3, 'A', 2, 2639, '徐州', '', ''),
(104096, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522326, '望谟县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104097, 510000, '四川省', 513300, '甘孜藏族自治州', 513321, '康定县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104098, 410000, '河南省', 410300, '洛阳市', 410302, '老城区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104099, 520000, '贵州省', 520400, '安顺市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(104100, 320000, '江苏省', 320600, '南通市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104101, 340000, '安徽省', 341200, '阜阳市', 341222, '太和县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104102, 140000, '山西省', 140300, '阳泉市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(104103, 360000, '江西省', 360700, '赣州市', 360735, '石城县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104104, 610000, '陕西省', 610300, '宝鸡市', 610329, '麟游县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104105, 450000, '广西壮族自治区', 450300, '桂林市', 450322, '临桂区', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104106, 650000, '新疆维吾尔自治区', 653000, '克孜勒苏柯尔克孜自治州', 653022, '阿克陶县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104107, 350000, '福建省', 350900, '宁德市', 350926, '柘荣县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104108, 210000, '辽宁省', 210300, '鞍山市', 210321, '台安县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104109, 530000, '云南省', 532900, '大理白族自治州', 532928, '永平县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104110, 370000, '山东省', 371300, '临沂市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(104111, 420000, '湖北省', 420200, '黄石市', 420202, '黄石港区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104112, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522630, '台江县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104113, 320000, '江苏省', 321200, '泰州市', 321282, '靖江市', 3, 'A', 1, 2663, '南通', '', ''),
(104114, 220000, '吉林省', 222400, '延边朝鲜族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(104115, 640000, '宁夏回族自治区', 640200, '石嘴山市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104116, 370000, '山东省', 371400, '德州市', 371482, '禹城市', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104117, 530000, '云南省', 530900, '临沧市', 530925, '双江拉祜族佤族布朗族傣族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104118, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652824, '若羌县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104119, 630000, '青海省', 632600, '果洛州', 632621, '玛沁县', 3, 'A', 2, 2636, '兰州', '', ''),
(104120, 410000, '河南省', 410400, '平顶山市', 410422, '叶县', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104121, 410000, '河南省', 410500, '安阳市', 410527, '内黄县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104122, 650000, '新疆维吾尔自治区', 652700, '博尔塔拉蒙古自治州', 652723, '温泉县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104123, 360000, '江西省', 360300, '萍乡市', 360302, '安源区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104124, 540000, '西藏自治区', 542300, '日喀则地区', 542328, '谢通门县', 3, 'A', 1, 2636, '兰州', '', ''),
(104125, 430000, '湖南省', 431000, '郴州市', 431081, '资兴市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104126, 530000, '云南省', 530100, '昆明市', 530121, '呈贡区', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104127, 350000, '福建省', 350200, '厦门市', 350205, '海沧区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(104128, 510000, '四川省', 511300, '南充市', 511304, '嘉陵区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104129, 130000, '河北省', 130700, '张家口市', 130727, '阳原县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104130, 410000, '河南省', 410700, '新乡市', 410726, '延津县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104131, 320000, '江苏省', 320800, '淮安市', 320826, '涟水县', 3, 'A', 2, 2639, '徐州', '', ''),
(104132, 440000, '广东省', 440800, '湛江市', 440825, '徐闻县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(104133, 370000, '山东省', 370400, '枣庄市', 370401, '其它区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(104134, 510000, '四川省', 511600, '广安市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104135, 540000, '西藏自治区', 542300, '日喀则地区', 542325, '萨迦县', 3, 'A', 2, 2636, '兰州', '', ''),
(104136, 230000, '黑龙江省', 230500, '双鸭山市', 230501, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104137, 510000, '四川省', 510400, '攀枝花市', 510402, '东区', 3, 'A', 1, 2308, '昆明', '成都RDC电商库', 'D028'),
(104138, 320000, '江苏省', 320200, '无锡市', 320282, '宜兴市', 3, 'A', 1, 2664, '无锡', '', ''),
(104139, 370000, '山东省', 370700, '潍坊市', 370704, '坊子区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104140, 540000, '西藏自治区', 542200, '山南地区', 542223, '贡嘎县', 3, 'A', 2, 2308, '昆明', '', ''),
(104141, 360000, '江西省', 360300, '萍乡市', 360301, '其它区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104142, 370000, '山东省', 370600, '烟台市', 0, '', 2, 'A', 0, 2601, '青岛', '济南RDC电商库', 'D531'),
(104143, 620000, '甘肃省', 621200, '陇南市', 621222, '文县', 3, 'A', 1, 2636, '兰州', '', ''),
(104144, 410000, '河南省', 411100, '漯河市', 411104, '召陵区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104145, 330000, '浙江省', 331000, '台州市', 331082, '临海市', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104146, 510000, '四川省', 511800, '雅安市', 511801, '其它区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(104147, 320000, '江苏省', 320900, '盐城市', 320981, '东台市', 3, 'A', 1, 2663, '南通', '', ''),
(104148, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652327, '吉木萨尔县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104149, 140000, '山西省', 140300, '阳泉市', 140303, '矿区', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104150, 130000, '河北省', 130200, '唐山市', 130281, '遵化市', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104151, 540000, '西藏自治区', 542100, '昌都地区', 542122, '江达县', 3, 'A', 2, 2636, '兰州', '', ''),
(104152, 610000, '陕西省', 610400, '咸阳市', 610403, '杨陵区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104153, 440000, '广东省', 440800, '湛江市', 440804, '坡头区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104154, 210000, '辽宁省', 211300, '朝阳市', 211322, '建平县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104155, 360000, '江西省', 360700, '赣州市', 360730, '宁都县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104156, 350000, '福建省', 350700, '南平市', 350781, '邵武市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104157, 350000, '福建省', 350400, '三明市', 350401, '其它区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104158, 610000, '陕西省', 610100, '西安市', 610111, '灞桥区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104159, 440000, '广东省', 445300, '云浮市', 445323, '云安县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(104160, 530000, '云南省', 530500, '保山市', 530522, '腾冲县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104161, 110000, '北京', 110100, '北京市', 110101, '东城区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(104162, 520000, '贵州省', 520100, '贵阳市', 520102, '南明区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104163, 540000, '西藏自治区', 542400, '那曲地区', 542421, '那曲县', 3, 'A', 2, 2308, '昆明', '', ''),
(104164, 350000, '福建省', 350900, '宁德市', 350921, '霞浦县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104165, 500000, '重庆', 500100, '重庆市', 500223, '潼南县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104166, 370000, '山东省', 371000, '威海市', 371081, '文登市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104167, 410000, '河南省', 410600, '鹤壁市', 410601, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104168, 510000, '四川省', 510100, '成都市', 510105, '青羊区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104169, 370000, '山东省', 371600, '滨州市', 371626, '邹平县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(104170, 150000, '内蒙古自治区', 150500, '通辽市', 150501, '其它区', 3, 'A', 1, 2626, '沈阳', '', ''),
(104171, 440000, '广东省', 441500, '汕尾市', 441521, '海丰县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(104172, 440000, '广东省', 442000, '中山市', 442001, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104173, 430000, '湖南省', 430400, '衡阳市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(104174, 630000, '青海省', 632100, '海东市', 632128, '循化撒拉族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(104175, 110000, '北京', 110100, '北京市', 110116, '怀柔区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(104176, 620000, '甘肃省', 621000, '庆阳市', 621025, '正宁县', 3, 'A', 2, 2636, '兰州', '', ''),
(104177, 630000, '青海省', 632600, '果洛州', 632626, '玛多县', 3, 'A', 2, 2636, '兰州', '', ''),
(104178, 320000, '江苏省', 321100, '镇江市', 321112, '丹徒区', 3, 'A', 1, 2604, '南京', '', ''),
(104179, 450000, '广西壮族自治区', 451200, '河池市', 451223, '凤山县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104180, 450000, '广西壮族自治区', 451200, '河池市', 451202, '金城江区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104181, 320000, '江苏省', 320500, '苏州市', 320582, '张家港市', 3, 'A', 1, 2664, '无锡', '', ''),
(104182, 610000, '陕西省', 610600, '延安市', 610621, '延长县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104183, 610000, '陕西省', 610300, '宝鸡市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104184, 340000, '安徽省', 341200, '阜阳市', 341225, '阜南县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104185, 430000, '湖南省', 430300, '湘潭市', 430302, '雨湖区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104186, 130000, '河北省', 130100, '石家庄市', 130131, '平山县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104187, 610000, '陕西省', 610200, '铜川市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104188, 500000, '重庆', 500100, '重庆市', 500240, '石柱土家族自治县', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104189, 130000, '河北省', 131000, '廊坊市', 131081, '霸州市', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(104190, 330000, '浙江省', 330200, '宁波市', 330204, '江东区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104191, 370000, '山东省', 371300, '临沂市', 371322, '郯城县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(104192, 610000, '陕西省', 610500, '渭南市', 610526, '蒲城县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104193, 230000, '黑龙江省', 230300, '鸡西市', 230304, '滴道区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104194, 640000, '宁夏回族自治区', 640300, '吴忠市', 640302, '利通区', 3, 'A', 1, 2647, '西安', '', ''),
(104195, 130000, '河北省', 130700, '张家口市', 130721, '宣化县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104196, 510000, '四川省', 511800, '雅安市', 511822, '荥经县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(104197, 130000, '河北省', 130300, '秦皇岛市', 130301, '其它区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104198, 420000, '湖北省', 421000, '荆州市', 421002, '沙市区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104199, 420000, '湖北省', 420500, '宜昌市', 420583, '枝江市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104200, 460000, '海南省', 469000, '省直辖县级行政区划', 469029, '保亭黎族苗族自治县', 3, 'D', 1, 0, '', '', ''),
(104201, 150000, '内蒙古自治区', 150400, '赤峰市', 150421, '阿鲁科尔沁旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104202, 220000, '吉林省', 220300, '四平市', 220323, '伊通满族自治县', 3, 'A', 2, 2625, '长春', '', ''),
(104203, 140000, '山西省', 140600, '朔州市', 140624, '怀仁县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104204, 510000, '四川省', 510100, '成都市', 510182, '彭州市', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104205, 620000, '甘肃省', 621000, '庆阳市', 621001, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(104206, 210000, '辽宁省', 210400, '抚顺市', 210401, '其它区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104207, 150000, '内蒙古自治区', 150400, '赤峰市', 150426, '翁牛特旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104208, 360000, '江西省', 360700, '赣州市', 360727, '龙南县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104209, 140000, '山西省', 140900, '忻州市', 140922, '五台县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104210, 230000, '黑龙江省', 230100, '哈尔滨市', 230109, '松北区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104211, 520000, '贵州省', 522200, '铜仁市', 522225, '思南县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104212, 140000, '山西省', 140800, '运城市', 140826, '绛县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104213, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230204, '铁锋区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104214, 510000, '四川省', 511700, '达州市', 511725, '渠县', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104215, 540000, '西藏自治区', 542300, '日喀则地区', 542329, '白朗县', 3, 'A', 2, 2636, '兰州', '', ''),
(104216, 450000, '广西壮族自治区', 451400, '崇左市', 451402, '江州区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104217, 230000, '黑龙江省', 230300, '鸡西市', 230321, '鸡东县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104218, 340000, '安徽省', 341500, '六安市', 341525, '霍山县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104219, 450000, '广西壮族自治区', 450200, '柳州市', 450223, '鹿寨县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104220, 320000, '江苏省', 320900, '盐城市', 320924, '射阳县', 3, 'A', 2, 2663, '南通', '', ''),
(104221, 320000, '江苏省', 320900, '盐城市', 320982, '大丰市', 3, 'A', 1, 2663, '南通', '', ''),
(104222, 330000, '浙江省', 331000, '台州市', 331003, '黄岩区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104223, 320000, '江苏省', 320200, '无锡市', 320211, '滨湖区', 3, 'A', 1, 2664, '无锡', '', ''),
(104224, 110000, '北京', 110100, '北京市', 110109, '门头沟区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(104225, 340000, '安徽省', 341100, '滁州市', 341126, '凤阳县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104226, 230000, '黑龙江省', 231200, '绥化市', 231226, '绥棱县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104227, 360000, '江西省', 361100, '上饶市', 361102, '信州区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104228, 340000, '安徽省', 341100, '滁州市', 341102, '琅琊区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104229, 230000, '黑龙江省', 232700, '大兴安岭地区', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(104230, 340000, '安徽省', 340600, '淮北市', 340601, '其它区', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(104231, 130000, '河北省', 130600, '保定市', 130633, '易县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104232, 410000, '河南省', 411300, '南阳市', 411330, '桐柏县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104233, 620000, '甘肃省', 620700, '张掖市', 620702, '甘州区', 3, 'A', 1, 2636, '兰州', '', ''),
(104234, 510000, '四川省', 511600, '广安市', 511681, '华蓥市', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104235, 420000, '湖北省', 421300, '随州市', 421303, '曾都区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104236, 130000, '河北省', 131100, '衡水市', 131101, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104237, 540000, '西藏自治区', 542200, '山南地区', 0, '', 2, 'A', 0, 0, '', '', ''),
(104238, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222401, '延吉市', 3, 'A', 2, 2625, '长春', '', ''),
(104239, 360000, '江西省', 361000, '抚州市', 361021, '南城县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104240, 530000, '云南省', 533300, '怒江傈僳族自治州', 533325, '兰坪白族普米族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104241, 140000, '山西省', 140700, '晋中市', 140781, '介休市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104242, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222405, '龙井市', 3, 'A', 2, 2625, '长春', '', ''),
(104243, 450000, '广西壮族自治区', 451200, '河池市', 451222, '天峨县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104244, 370000, '山东省', 370800, '济宁市', 0, '', 2, 'A', 0, 0, '', '济南RDC电商库', 'D531'),
(104245, 330000, '浙江省', 330200, '宁波市', 330205, '江北区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104246, 530000, '云南省', 530300, '曲靖市', 530322, '陆良县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104247, 410000, '河南省', 411500, '信阳市', 411524, '商城县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104248, 440000, '广东省', 440100, '广州市', 440103, '荔湾区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104249, 620000, '甘肃省', 620600, '武威市', 620622, '古浪县', 3, 'A', 2, 2636, '兰州', '', ''),
(104250, 440000, '广东省', 441300, '惠州市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104251, 440000, '广东省', 440800, '湛江市', 440811, '麻章区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104252, 620000, '甘肃省', 622900, '临夏回族自治州', 622927, '积石山保安族东乡族撒拉族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(104253, 410000, '河南省', 411600, '周口市', 411602, '川汇区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104254, 430000, '湖南省', 430500, '邵阳市', 430524, '隆回县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104255, 610000, '陕西省', 610400, '咸阳市', 610431, '武功县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104256, 510000, '四川省', 510100, '成都市', 510121, '金堂县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104257, 450000, '广西壮族自治区', 450600, '防城港市', 450681, '东兴市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104258, 630000, '青海省', 632100, '海东市', 632126, '互助土族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(104259, 510000, '四川省', 510600, '德阳市', 510626, '罗江县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104260, 210000, '辽宁省', 211000, '辽阳市', 211002, '白塔区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104261, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522324, '晴隆县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104262, 430000, '湖南省', 430500, '邵阳市', 430528, '新宁县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104263, 210000, '辽宁省', 210400, '抚顺市', 210411, '顺城区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104264, 340000, '安徽省', 340700, '铜陵市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(104265, 230000, '黑龙江省', 230900, '七台河市', 230901, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104266, 620000, '甘肃省', 621200, '陇南市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104267, 460000, '海南省', 469000, '省直辖县级行政区划', 469003, '儋州市', 3, 'D', 1, 0, '', '', ''),
(104268, 360000, '江西省', 360600, '鹰潭市', 360601, '其它区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104269, 430000, '湖南省', 431200, '怀化市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(104270, 410000, '河南省', 410900, '濮阳市', 410902, '华龙区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104271, 360000, '江西省', 360100, '南昌市', 360101, '其它区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(104272, 430000, '湖南省', 431200, '怀化市', 431230, '通道侗族自治县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104273, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653121, '疏附县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104274, 460000, '海南省', 469063, '儋州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104275, 230000, '黑龙江省', 231100, '黑河市', 231182, '五大连池市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104276, 450000, '广西壮族自治区', 450100, '南宁市', 450125, '上林县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104277, 530000, '云南省', 532300, '楚雄彝族自治州', 532331, '禄丰县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104278, 370000, '山东省', 370600, '烟台市', 370634, '长岛县', 3, 'A', 2, 2601, '青岛', '济南RDC电商库', 'D531'),
(104279, 230000, '黑龙江省', 230700, '伊春市', 230714, '乌伊岭区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104280, 210000, '辽宁省', 210700, '锦州市', 210782, '北镇市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104281, 140000, '山西省', 140800, '运城市', 140827, '垣曲县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104282, 650000, '新疆维吾尔自治区', 652200, '哈密地区', 652222, '巴里坤哈萨克自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104283, 130000, '河北省', 130100, '石家庄市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104284, 510000, '四川省', 513300, '甘孜藏族自治州', 513333, '色达县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104285, 370000, '山东省', 370200, '青岛市', 370212, '崂山区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104286, 430000, '湖南省', 431000, '郴州市', 431023, '永兴县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104287, 450000, '广西壮族自治区', 450100, '南宁市', 450107, '西乡塘区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104288, 360000, '江西省', 360400, '九江市', 360421, '九江县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104289, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653122, '疏勒县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104290, 540000, '西藏自治区', 542200, '山南地区', 542232, '错那县', 3, 'A', 2, 2308, '昆明', '', ''),
(104291, 410000, '河南省', 411400, '商丘市', 411423, '宁陵县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104292, 450000, '广西壮族自治区', 450700, '钦州市', 450702, '钦南区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104293, 640000, '宁夏回族自治区', 640200, '石嘴山市', 640202, '大武口区', 3, 'A', 1, 2647, '西安', '', ''),
(104294, 230000, '黑龙江省', 230300, '鸡西市', 230301, '其它区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104295, 520000, '贵州省', 0, '', 0, '', 1, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(104296, 430000, '湖南省', 430700, '常德市', 430721, '安乡县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104297, 350000, '福建省', 350900, '宁德市', 350902, '蕉城区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104298, 620000, '甘肃省', 621200, '陇南市', 621202, '武都区', 3, 'A', 1, 2636, '兰州', '', ''),
(104299, 340000, '安徽省', 340100, '合肥市', 340103, '庐阳区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104300, 430000, '湖南省', 430600, '岳阳市', 430601, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104301, 450000, '广西壮族自治区', 450800, '贵港市', 450881, '桂平市', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104302, 530000, '云南省', 530400, '玉溪市', 530422, '澄江县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104303, 130000, '河北省', 130600, '保定市', 130681, '涿州市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104304, 530000, '云南省', 530600, '昭通市', 530626, '绥江县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(104305, 430000, '湖南省', 431300, '娄底市', 431381, '冷水江市', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104306, 430000, '湖南省', 431000, '郴州市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(104307, 540000, '西藏自治区', 542300, '日喀则地区', 542323, '江孜县', 3, 'A', 2, 2636, '兰州', '', ''),
(104308, 230000, '黑龙江省', 230700, '伊春市', 230713, '带岭区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104309, 520000, '贵州省', 522200, '铜仁市', 522226, '印江土家族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104310, 510000, '四川省', 510700, '绵阳市', 510727, '平武县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104311, 340000, '安徽省', 340200, '芜湖市', 340223, '南陵县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104312, 130000, '河北省', 130500, '邢台市', 130582, '沙河市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104313, 410000, '河南省', 410200, '开封市', 410224, '开封县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104314, 350000, '福建省', 350700, '南平市', 350782, '武夷山市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104315, 120000, '天津', 120100, '天津市', 120101, '和平区', 3, 'A', 1, 2634, '天津', '', ''),
(104316, 510000, '四川省', 510500, '泸州市', 510525, '古蔺县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(104317, 130000, '河北省', 130400, '邯郸市', 130434, '魏县', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104318, 130000, '河北省', 130600, '保定市', 130631, '望都县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104319, 220000, '吉林省', 220600, '白山市', 220681, '临江市', 3, 'A', 2, 2625, '长春', '', ''),
(104320, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 632801, '格尔木市', 3, 'A', 1, 2636, '兰州', '', ''),
(104321, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513225, '九寨沟县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104322, 350000, '福建省', 350800, '龙岩市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(104323, 360000, '江西省', 360600, '鹰潭市', 0, '', 2, 'A', 0, 0, '', '南昌RDC电商库', 'D791'),
(104324, 350000, '福建省', 350500, '泉州市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(104325, 140000, '山西省', 141100, '吕梁市', 141126, '石楼县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104326, 130000, '河北省', 130300, '秦皇岛市', 130304, '北戴河区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104327, 520000, '贵州省', 520300, '遵义市', 520326, '务川仡佬族苗族自治县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104328, 610000, '陕西省', 610700, '汉中市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104329, 230000, '黑龙江省', 230900, '七台河市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(104330, 130000, '河北省', 131100, '衡水市', 131125, '安平县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104331, 230000, '黑龙江省', 230700, '伊春市', 230781, '铁力市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104332, 510000, '四川省', 511700, '达州市', 511724, '大竹县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(104333, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650103, '沙依巴克区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104334, 610000, '陕西省', 610400, '咸阳市', 610428, '长武县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104335, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 654028, '尼勒克县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104336, 330000, '浙江省', 330200, '宁波市', 330226, '宁海县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104337, 150000, '内蒙古自治区', 150900, '乌兰察布市', 150923, '商都县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104338, 360000, '江西省', 360400, '九江市', 360429, '湖口县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104339, 210000, '辽宁省', 210400, '抚顺市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(104340, 330000, '浙江省', 330600, '绍兴市', 330682, '上虞区', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104341, 510000, '四川省', 510600, '德阳市', 510603, '旌阳区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104342, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653223, '皮山县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104343, 530000, '云南省', 530600, '昭通市', 530622, '巧家县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(104344, 650000, '新疆维吾尔自治区', 652100, '吐鲁番地区', 652101, '吐鲁番市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104345, 540000, '西藏自治区', 542200, '山南地区', 542225, '琼结县', 3, 'A', 2, 2308, '昆明', '', ''),
(104346, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654324, '哈巴河县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104347, 510000, '四川省', 511900, '巴中市', 511921, '通江县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(104348, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652925, '新和县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104349, 510000, '四川省', 511000, '内江市', 511025, '资中县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(104350, 150000, '内蒙古自治区', 152200, '兴安盟', 152223, '扎赉特旗', 3, 'A', 2, 2625, '长春', '', ''),
(104351, 530000, '云南省', 530600, '昭通市', 530627, '镇雄县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(104352, 610000, '陕西省', 610600, '延安市', 610602, '宝塔区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104353, 370000, '山东省', 371500, '聊城市', 371501, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104354, 410000, '河南省', 410800, '焦作市', 410825, '温县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104355, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152522, '阿巴嘎旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104356, 360000, '江西省', 360800, '吉安市', 360802, '吉州区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104357, 530000, '云南省', 532300, '楚雄彝族自治州', 532325, '姚安县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104358, 320000, '江苏省', 321100, '镇江市', 321101, '其它区', 3, 'A', 1, 2604, '南京', '', ''),
(104359, 410000, '河南省', 411400, '商丘市', 411426, '夏邑县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104360, 220000, '吉林省', 222400, '延边朝鲜族自治州', 222404, '珲春市', 3, 'A', 2, 2625, '长春', '', ''),
(104361, 320000, '江苏省', 320300, '徐州市', 320324, '睢宁县', 3, 'A', 2, 2639, '徐州', '', ''),
(104362, 530000, '云南省', 530600, '昭通市', 530623, '盐津县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(104363, 430000, '湖南省', 430500, '邵阳市', 430522, '新邵县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104364, 130000, '河北省', 130700, '张家口市', 130725, '尚义县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104365, 370000, '山东省', 370100, '济南市', 370112, '历城区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104366, 320000, '江苏省', 320600, '南通市', 320681, '启东市', 3, 'A', 1, 2663, '南通', '', ''),
(104367, 510000, '四川省', 511500, '宜宾市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104368, 510000, '四川省', 513300, '甘孜藏族自治州', 513328, '甘孜县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104369, 210000, '辽宁省', 210800, '营口市', 210802, '站前区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104370, 530000, '云南省', 530800, '普洱市', 530801, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104371, 230000, '黑龙江省', 231200, '绥化市', 231223, '青冈县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104372, 340000, '安徽省', 340400, '淮南市', 340406, '潘集区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104373, 210000, '辽宁省', 210200, '大连市', 210203, '西岗区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104374, 230000, '黑龙江省', 230400, '鹤岗市', 230405, '兴安区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104375, 530000, '云南省', 532600, '文山壮族苗族自治州', 532625, '马关县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104376, 140000, '山西省', 140400, '长治市', 140424, '屯留县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104377, 140000, '山西省', 140100, '太原市', 140123, '娄烦县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104378, 370000, '山东省', 370200, '青岛市', 370285, '莱西市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104379, 230000, '黑龙江省', 230700, '伊春市', 230707, '新青区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104380, 330000, '浙江省', 330100, '杭州市', 330109, '萧山区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104381, 410000, '河南省', 411600, '周口市', 411627, '太康县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104382, 620000, '甘肃省', 620600, '武威市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104383, 340000, '安徽省', 340800, '安庆市', 340826, '宿松县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104384, 450000, '广西壮族自治区', 450100, '南宁市', 450101, '其它区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104385, 510000, '四川省', 512000, '资阳市', 512021, '安岳县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104386, 340000, '安徽省', 341100, '滁州市', 341124, '全椒县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104387, 530000, '云南省', 532900, '大理白族自治州', 532924, '宾川县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104388, 220000, '吉林省', 220100, '长春市', 220112, '双阳区', 3, 'A', 2, 2625, '长春', '', ''),
(104389, 620000, '甘肃省', 620700, '张掖市', 620722, '民乐县', 3, 'A', 2, 2636, '兰州', '', ''),
(104390, 210000, '辽宁省', 210500, '本溪市', 210502, '平山区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104391, 500000, '重庆', 500100, '重庆市', 500236, '奉节县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104392, 220000, '吉林省', 220600, '白山市', 220605, '江源区', 3, 'A', 1, 2625, '长春', '', ''),
(104393, 430000, '湖南省', 430200, '株洲市', 430202, '荷塘区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104394, 440000, '广东省', 440200, '韶关市', 440201, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104395, 610000, '陕西省', 610900, '安康市', 610923, '宁陕县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104396, 210000, '辽宁省', 210200, '大连市', 210282, '普兰店市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104397, 230000, '黑龙江省', 231100, '黑河市', 231102, '爱辉区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104398, 110000, '北京', 110100, '北京市', 110111, '房山区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(104399, 340000, '安徽省', 340100, '合肥市', 340111, '包河区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104400, 340000, '安徽省', 340300, '蚌埠市', 340304, '禹会区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104401, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152528, '镶黄旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104402, 130000, '河北省', 130500, '邢台市', 130503, '桥西区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104403, 140000, '山西省', 140800, '运城市', 140823, '闻喜县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104404, 620000, '甘肃省', 623000, '甘南藏族自治州', 623021, '临潭县', 3, 'A', 2, 2636, '兰州', '', ''),
(104405, 370000, '山东省', 371400, '德州市', 371421, '陵县', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104406, 210000, '辽宁省', 210500, '本溪市', 210503, '溪湖区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104407, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150124, '清水河县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104408, 140000, '山西省', 140200, '大同市', 140224, '灵丘县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104409, 310000, '上海', 310100, '上海市', 310120, '奉贤区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104410, 440000, '广东省', 441500, '汕尾市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104411, 340000, '安徽省', 341000, '黄山市', 341024, '祁门县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104412, 510000, '四川省', 510700, '绵阳市', 510701, '其它区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104413, 530000, '云南省', 530500, '保山市', 530521, '施甸县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104414, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(104415, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422828, '鹤峰县', 3, 'A', 2, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104416, 150000, '内蒙古自治区', 150200, '包头市', 150221, '土默特右旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104417, 530000, '云南省', 530400, '玉溪市', 530421, '江川县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104418, 430000, '湖南省', 431100, '永州市', 431122, '东安县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104419, 420000, '湖北省', 421200, '咸宁市', 421223, '崇阳县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104420, 410000, '河南省', 411300, '南阳市', 411327, '社旗县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104421, 310000, '上海', 310100, '上海市', 310108, '闸北区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104422, 370000, '山东省', 370700, '潍坊市', 370783, '寿光市', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104423, 140000, '山西省', 140200, '大同市', 140202, '城区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104424, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150602, '东胜区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104425, 430000, '湖南省', 430200, '株洲市', 430203, '芦淞区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104426, 510000, '四川省', 511700, '达州市', 511723, '开江县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(104427, 360000, '江西省', 360700, '赣州市', 360732, '兴国县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104428, 620000, '甘肃省', 620600, '武威市', 620601, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(104429, 340000, '安徽省', 340100, '合肥市', 340102, '瑶海区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104430, 510000, '四川省', 511300, '南充市', 511301, '其它区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104431, 350000, '福建省', 350200, '厦门市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(104432, 450000, '广西壮族自治区', 451000, '百色市', 451002, '右江区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104433, 210000, '辽宁省', 211300, '朝阳市', 211303, '龙城区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104434, 620000, '甘肃省', 620100, '兰州市', 620103, '七里河区', 3, 'A', 1, 2636, '兰州', '', ''),
(104435, 610000, '陕西省', 610500, '渭南市', 610523, '大荔县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104436, 320000, '江苏省', 320400, '常州市', 320402, '天宁区', 3, 'A', 1, 2604, '南京', '', ''),
(104437, 320000, '江苏省', 320700, '连云港市', 320721, '赣榆县', 3, 'A', 2, 2608, '临沂', '', ''),
(104438, 330000, '浙江省', 330600, '绍兴市', 330681, '诸暨市', 3, 'A', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104439, 360000, '江西省', 360700, '赣州市', 360721, '赣县', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104440, 420000, '湖北省', 420200, '黄石市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(104441, 350000, '福建省', 350100, '福州市', 350182, '长乐市', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104442, 350000, '福建省', 350500, '泉州市', 350527, '金门县', 3, 'A', 2, 2617, '厦门', '厦门RDC电商库', 'D592'),
(104443, 440000, '广东省', 440900, '茂名市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104444, 530000, '云南省', 530700, '丽江市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(104445, 450000, '广西壮族自治区', 450300, '桂林市', 450324, '全州县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104446, 430000, '湖南省', 430200, '株洲市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(104447, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 150627, '伊金霍洛旗', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104448, 420000, '湖北省', 421100, '黄冈市', 421124, '英山县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104449, 130000, '河北省', 130400, '邯郸市', 130402, '邯山区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104450, 430000, '湖南省', 430100, '长沙市', 430124, '宁乡县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104451, 340000, '安徽省', 341600, '亳州市', 341602, '谯城区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104452, 210000, '辽宁省', 211100, '盘锦市', 211102, '双台子区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104453, 130000, '河北省', 131100, '衡水市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104454, 140000, '山西省', 140700, '晋中市', 140701, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104455, 140000, '山西省', 140800, '运城市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(104456, 620000, '甘肃省', 620700, '张掖市', 620723, '临泽县', 3, 'A', 2, 2636, '兰州', '', ''),
(104457, 350000, '福建省', 350700, '南平市', 350723, '光泽县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104458, 510000, '四川省', 513300, '甘孜藏族自治州', 513326, '道孚县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104459, 640000, '宁夏回族自治区', 640100, '银川市', 640106, '金凤区', 3, 'A', 1, 2647, '西安', '', ''),
(104460, 440000, '广东省', 441600, '河源市', 441623, '连平县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(104461, 360000, '江西省', 360100, '南昌市', 360122, '新建县', 3, 'A', 2, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(104462, 350000, '福建省', 350300, '莆田市', 350302, '城厢区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104463, 210000, '辽宁省', 210200, '大连市', 210281, '瓦房店市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104464, 510000, '四川省', 510300, '自贡市', 510302, '自流井区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(104465, 320000, '江苏省', 320400, '常州市', 320481, '溧阳市', 3, 'A', 1, 2604, '南京', '', ''),
(104466, 520000, '贵州省', 522300, '黔西南布依族苗族自治州', 522328, '安龙县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104467, 230000, '黑龙江省', 230600, '大庆市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(104468, 530000, '云南省', 530100, '昆明市', 530126, '石林彝族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104469, 610000, '陕西省', 610800, '榆林市', 610825, '定边县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104470, 430000, '湖南省', 431100, '永州市', 431125, '江永县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104471, 500000, '重庆', 500100, '重庆市', 500104, '大渡口区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104472, 130000, '河北省', 130500, '邢台市', 130501, '其它区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104473, 340000, '安徽省', 340800, '安庆市', 340802, '迎江区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104474, 230000, '黑龙江省', 230100, '哈尔滨市', 230112, '阿城区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104475, 360000, '江西省', 360800, '吉安市', 360803, '青原区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104476, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522628, '锦屏县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104477, 310000, '上海', 310100, '上海市', 310113, '宝山区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104478, 320000, '江苏省', 321000, '扬州市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104479, 440000, '广东省', 442000, '中山市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104480, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652827, '和静县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104481, 620000, '甘肃省', 621200, '陇南市', 621226, '礼县', 3, 'A', 1, 2636, '兰州', '', ''),
(104482, 140000, '山西省', 140900, '忻州市', 140931, '保德县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104483, 610000, '陕西省', 610700, '汉中市', 610729, '留坝县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104484, 360000, '江西省', 360400, '九江市', 360426, '德安县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104485, 130000, '河北省', 130500, '邢台市', 130530, '新河县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104486, 530000, '云南省', 533300, '怒江傈僳族自治州', 533324, '贡山独龙族怒族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104487, 610000, '陕西省', 611000, '商洛市', 611023, '商南县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104488, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653127, '麦盖提县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104489, 440000, '广东省', 440600, '佛山市', 440605, '南海区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104490, 420000, '湖北省', 421300, '随州市', 421321, '随县', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104491, 540000, '西藏自治区', 540100, '拉萨市', 540101, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(104492, 340000, '安徽省', 340800, '安庆市', 340822, '怀宁县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104493, 450000, '广西壮族自治区', 451300, '来宾市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(104494, 140000, '山西省', 140800, '运城市', 140828, '夏县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104495, 370000, '山东省', 370600, '烟台市', 370611, '福山区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104496, 350000, '福建省', 350700, '南平市', 350722, '浦城县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104497, 120000, '天津', 120100, '天津市', 120115, '宝坻区', 3, 'A', 2, 2634, '天津', '', ''),
(104498, 330000, '浙江省', 331000, '台州市', 331081, '温岭市', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104499, 630000, '青海省', 632500, '海南州', 0, '', 2, 'A', 0, 0, '', '', ''),
(104500, 350000, '福建省', 350300, '莆田市', 350322, '仙游县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104501, 440000, '广东省', 441700, '阳江市', 441701, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104502, 130000, '河北省', 130100, '石家庄市', 130128, '深泽县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104503, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 150821, '五原县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104504, 420000, '湖北省', 420500, '宜昌市', 420581, '宜都市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104505, 460000, '海南省', 469026, '昌江黎族自治县', 469031, '西沙群岛', 3, 'D', 1, 2646, '海口', '', ''),
(104506, 150000, '内蒙古自治区', 152500, '锡林郭勒盟', 152525, '东乌珠穆沁旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104507, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150781, '满洲里市', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(104508, 520000, '贵州省', 522400, '毕节市', 522428, '赫章县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104509, 330000, '浙江省', 330100, '杭州市', 330106, '西湖区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104510, 410000, '河南省', 411000, '许昌市', 411082, '长葛市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104511, 410000, '河南省', 411100, '漯河市', 411101, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104512, 510000, '四川省', 510100, '成都市', 510122, '双流县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104513, 130000, '河北省', 130800, '承德市', 130827, '宽城满族自治县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(104514, 440000, '广东省', 440200, '韶关市', 440205, '曲江区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104515, 230000, '黑龙江省', 230700, '伊春市', 230715, '红星区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104516, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 652826, '焉耆回族自治县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104517, 330000, '浙江省', 330700, '金华市', 330703, '金东区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104518, 650000, '新疆维吾尔自治区', 652800, '巴音郭楞蒙古自治州', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104519, 230000, '黑龙江省', 230100, '哈尔滨市', 230184, '五常市', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104520, 630000, '青海省', 632100, '海东市', 632123, '乐都区', 3, 'A', 2, 2636, '兰州', '', ''),
(104521, 410000, '河南省', 411300, '南阳市', 411321, '南召县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104522, 130000, '河北省', 0, '', 0, '', 1, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104523, 410000, '河南省', 410100, '郑州市', 410106, '上街区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104524, 530000, '云南省', 530900, '临沧市', 530927, '沧源佤族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104525, 370000, '山东省', 370300, '淄博市', 370301, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104526, 540000, '西藏自治区', 542300, '日喀则地区', 542336, '聂拉木县', 3, 'A', 1, 2636, '兰州', '', ''),
(104527, 210000, '辽宁省', 210200, '大连市', 210201, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104528, 350000, '福建省', 350400, '三明市', 350421, '明溪县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104529, 140000, '山西省', 141000, '临汾市', 141081, '侯马市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104530, 620000, '甘肃省', 621100, '定西市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104531, 460000, '海南省', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(104532, 140000, '山西省', 140500, '晋城市', 140502, '城区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104533, 530000, '云南省', 530500, '保山市', 530523, '龙陵县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104534, 140000, '山西省', 140900, '忻州市', 140924, '繁峙县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104535, 230000, '黑龙江省', 230100, '哈尔滨市', 230102, '道里区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104536, 650000, '新疆维吾尔自治区', 659000, '自治区直辖县级行政区划', 659002, '阿拉尔市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104537, 430000, '湖南省', 430700, '常德市', 430723, '澧县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104538, 430000, '湖南省', 430200, '株洲市', 430224, '茶陵县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104539, 230000, '黑龙江省', 230700, '伊春市', 230722, '嘉荫县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104540, 430000, '湖南省', 433100, '湘西土家族苗族自治州', 433124, '花垣县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104541, 420000, '湖北省', 420700, '鄂州市', 420704, '鄂城区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104542, 370000, '山东省', 370800, '济宁市', 370802, '市中区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(104543, 230000, '黑龙江省', 231200, '绥化市', 231281, '安达市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104544, 410000, '河南省', 411500, '信阳市', 411523, '新县', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104545, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522601, '凯里市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104546, 230000, '黑龙江省', 230900, '七台河市', 230903, '桃山区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104547, 450000, '广西壮族自治区', 450100, '南宁市', 450103, '青秀区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104548, 520000, '贵州省', 522200, '铜仁市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(104549, 140000, '山西省', 140400, '长治市', 140481, '潞城市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104550, 410000, '河南省', 411700, '驻马店市', 411701, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104551, 150000, '内蒙古自治区', 150800, '巴彦淖尔市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104552, 340000, '安徽省', 340200, '芜湖市', 340221, '芜湖县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104553, 370000, '山东省', 370700, '潍坊市', 370705, '奎文区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104554, 140000, '山西省', 140500, '晋城市', 140522, '阳城县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104555, 510000, '四川省', 511500, '宜宾市', 511525, '高县', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(104556, 430000, '湖南省', 430500, '邵阳市', 430525, '洞口县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104557, 410000, '河南省', 410900, '濮阳市', 410922, '清丰县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104558, 440000, '广东省', 440700, '江门市', 440785, '恩平市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104559, 510000, '四川省', 510400, '攀枝花市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104560, 630000, '青海省', 632700, '玉树藏族自治州', 632722, '杂多县', 3, 'A', 2, 2636, '兰州', '', ''),
(104561, 420000, '湖北省', 421100, '黄冈市', 421182, '武穴市', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104562, 540000, '西藏自治区', 540100, '拉萨市', 540127, '墨竹工卡县', 3, 'A', 1, 2636, '兰州', '', ''),
(104563, 640000, '宁夏回族自治区', 640300, '吴忠市', 640301, '其它区', 3, 'A', 1, 2647, '西安', '', ''),
(104564, 440000, '广东省', 441700, '阳江市', 441702, '江城区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104565, 320000, '江苏省', 321200, '泰州市', 321203, '高港区', 3, 'A', 1, 2663, '南通', '', ''),
(104566, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522626, '岑巩县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104567, 630000, '青海省', 632600, '果洛州', 632622, '班玛县', 3, 'A', 2, 2636, '兰州', '', ''),
(104568, 210000, '辽宁省', 210900, '阜新市', 210911, '细河区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104569, 530000, '云南省', 530300, '曲靖市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(104570, 610000, '陕西省', 610100, '西安市', 610113, '雁塔区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104571, 320000, '江苏省', 320500, '苏州市', 320508, '园区', 3, 'A', 1, 2664, '无锡', '', ''),
(104572, 510000, '四川省', 511600, '广安市', 511622, '武胜县', 3, 'A', 2, 2310, '南充', '成都RDC电商库', 'D028'),
(104573, 500000, '重庆', 500100, '重庆市', 500222, '綦江区', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104574, 510000, '四川省', 0, '', 0, '', 1, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104575, 440000, '广东省', 441400, '梅州市', 441402, '梅江区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(104576, 140000, '山西省', 140900, '忻州市', 140901, '其它区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104577, 220000, '吉林省', 220700, '松原市', 220722, '长岭县', 3, 'A', 2, 2625, '长春', '', ''),
(104578, 430000, '湖南省', 430500, '邵阳市', 430502, '双清区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104579, 450000, '广西壮族自治区', 450400, '梧州市', 450422, '藤县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104580, 360000, '江西省', 361000, '抚州市', 361025, '乐安县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(104581, 430000, '湖南省', 430400, '衡阳市', 430406, '雁峰区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104582, 150000, '内蒙古自治区', 150400, '赤峰市', 150425, '克什克腾旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104583, 620000, '甘肃省', 620100, '兰州市', 620101, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(104584, 130000, '河北省', 130600, '保定市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104585, 530000, '云南省', 530100, '昆明市', 530103, '盘龙区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104586, 350000, '福建省', 350900, '宁德市', 350922, '古田县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104587, 130000, '河北省', 130500, '邢台市', 130502, '桥东区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104588, 520000, '贵州省', 520200, '六盘水市', 520201, '钟山区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104589, 630000, '青海省', 632800, '海西蒙古族藏族自治州', 632822, '都兰县', 3, 'A', 2, 2636, '兰州', '', ''),
(104590, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532532, '河口瑶族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104591, 420000, '湖北省', 420600, '襄阳市', 420606, '樊城区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104592, 370000, '山东省', 370400, '枣庄市', 370406, '山亭区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(104593, 640000, '宁夏回族自治区', 640100, '银川市', 640105, '西夏区', 3, 'A', 1, 2647, '西安', '', ''),
(104594, 610000, '陕西省', 610100, '西安市', 610122, '蓝田县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104595, 440000, '广东省', 440200, '韶关市', 440232, '乳源瑶族自治县', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104596, 430000, '湖南省', 431300, '娄底市', 431301, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104597, 150000, '内蒙古自治区', 150500, '通辽市', 150581, '霍林郭勒市', 3, 'A', 2, 2626, '沈阳', '', ''),
(104598, 330000, '浙江省', 331100, '丽水市', 331125, '云和县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(104599, 140000, '山西省', 141100, '吕梁市', 0, '', 2, 'A', 0, 0, '', '太原RDC电商库', 'D351'),
(104600, 430000, '湖南省', 431200, '怀化市', 431201, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104601, 370000, '山东省', 371700, '菏泽市', 371725, '郓城县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(104602, 330000, '浙江省', 330700, '金华市', 0, '', 2, 'A', 0, 0, '', '宁波RDC电商库', 'D574'),
(104603, 370000, '山东省', 370100, '济南市', 370113, '长清区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104604, 620000, '甘肃省', 623000, '甘南藏族自治州', 623025, '玛曲县', 3, 'A', 2, 2636, '兰州', '', ''),
(104605, 310000, '上海', 310100, '上海市', 310150, '南汇区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104606, 210000, '辽宁省', 210100, '沈阳市', 210123, '康平县', 3, 'A', 2, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104607, 410000, '河南省', 411200, '三门峡市', 411221, '渑池县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104608, 230000, '黑龙江省', 230700, '伊春市', 230716, '上甘岭区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104609, 340000, '安徽省', 340500, '马鞍山市', 341423, '含山县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104610, 530000, '云南省', 530600, '昭通市', 530630, '水富县', 3, 'A', 2, 2302, '贵阳', '昆明RDC电商库', 'D871'),
(104611, 230000, '黑龙江省', 230400, '鹤岗市', 0, '', 2, 'A', 0, 0, '', '哈尔滨RDC电商库', 'D451'),
(104612, 150000, '内蒙古自治区', 150300, '乌海市', 150303, '海南区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104613, 220000, '吉林省', 220800, '白城市', 220802, '洮北区', 3, 'A', 1, 2625, '长春', '', ''),
(104614, 440000, '广东省', 440200, '韶关市', 0, '', 2, 'A', 0, 0, '', '广州RDC电商库', 'D020'),
(104615, 540000, '西藏自治区', 540100, '拉萨市', 540124, '曲水县', 3, 'A', 2, 2636, '兰州', '', ''),
(104616, 430000, '湖南省', 430100, '长沙市', 430111, '雨花区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104617, 330000, '浙江省', 330100, '杭州市', 330108, '滨江区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104618, 370000, '山东省', 370500, '东营市', 370501, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104619, 510000, '四川省', 510800, '广元市', 510821, '旺苍县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104620, 130000, '河北省', 131000, '廊坊市', 131002, '安次区', 3, 'A', 1, 2634, '天津', '石家庄RDC电商库', 'D311'),
(104621, 150000, '内蒙古自治区', 152200, '兴安盟', 152201, '乌兰浩特市', 3, 'A', 2, 2625, '长春', '', ''),
(104622, 420000, '湖北省', 420700, '鄂州市', 420702, '梁子湖区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104623, 510000, '四川省', 511000, '内江市', 511028, '隆昌县', 3, 'A', 2, 2306, '泸州', '成都RDC电商库', 'D028'),
(104624, 420000, '湖北省', 421000, '荆州市', 421023, '监利县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104625, 350000, '福建省', 350900, '宁德市', 350924, '寿宁县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104626, 440000, '广东省', 440800, '湛江市', 440881, '廉江市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104627, 340000, '安徽省', 340200, '芜湖市', 341422, '无为县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104628, 610000, '陕西省', 610700, '汉中市', 610701, '其它区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104629, 410000, '河南省', 411100, '漯河市', 411102, '源汇区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104630, 130000, '河北省', 131100, '衡水市', 131102, '桃城区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104631, 320000, '江苏省', 320900, '盐城市', 320903, '盐都区', 3, 'A', 1, 2663, '南通', '', ''),
(104632, 320000, '江苏省', 320300, '徐州市', 320311, '泉山区', 3, 'A', 1, 2639, '徐州', '', ''),
(104633, 340000, '安徽省', 341300, '宿州市', 341324, '泗县', 3, 'A', 1, 2639, '徐州', '合肥RDC电商库', 'D551'),
(104634, 220000, '吉林省', 220700, '松原市', 220702, '宁江区', 3, 'A', 1, 2625, '长春', '', ''),
(104635, 320000, '江苏省', 321100, '镇江市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104636, 360000, '江西省', 360100, '南昌市', 360123, '安义县', 3, 'A', 2, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(104637, 350000, '福建省', 350900, '宁德市', 350923, '屏南县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104638, 130000, '河北省', 130500, '邢台市', 130532, '平乡县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104639, 310000, '上海', 310100, '上海市', 310109, '虹口区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104640, 510000, '四川省', 510400, '攀枝花市', 510421, '米易县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104641, 320000, '江苏省', 320200, '无锡市', 320203, '南长区', 3, 'A', 1, 2664, '无锡', '', ''),
(104642, 440000, '广东省', 441200, '肇庆市', 441224, '怀集县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(104643, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(104644, 610000, '陕西省', 611000, '商洛市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104645, 450000, '广西壮族自治区', 451000, '百色市', 451030, '西林县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104646, 610000, '陕西省', 610500, '渭南市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104647, 530000, '云南省', 532500, '红河哈尼族彝族自治州', 532527, '泸西县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104648, 430000, '湖南省', 430800, '张家界市', 0, '', 2, 'A', 0, 0, '', '长沙RDC电商库', 'D731'),
(104649, 500000, '重庆', 500100, '重庆市', 500237, '巫山县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104650, 650000, '新疆维吾尔自治区', 652300, '昌吉回族自治州', 652301, '昌吉市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104651, 230000, '黑龙江省', 230700, '伊春市', 230708, '美溪区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104652, 460000, '海南省', 469026, '昌江黎族自治县', 0, '', 2, 'A', 0, 0, '', '', ''),
(104653, 420000, '湖北省', 420600, '襄阳市', 420602, '襄城区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104654, 140000, '山西省', 141100, '吕梁市', 141181, '孝义市', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104655, 330000, '浙江省', 331000, '台州市', 331002, '椒江区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104656, 210000, '辽宁省', 210600, '丹东市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(104657, 130000, '河北省', 130900, '沧州市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104658, 150000, '内蒙古自治区', 150400, '赤峰市', 150429, '宁城县', 3, 'A', 2, 2633, '唐山', '', ''),
(104659, 620000, '甘肃省', 623000, '甘南藏族自治州', 0, '', 2, 'A', 0, 0, '', '', ''),
(104660, 320000, '江苏省', 320300, '徐州市', 320322, '沛县', 3, 'A', 1, 2639, '徐州', '', ''),
(104661, 510000, '四川省', 513300, '甘孜藏族自治州', 513323, '丹巴县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104662, 610000, '陕西省', 610900, '安康市', 610924, '紫阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104663, 650000, '新疆维吾尔自治区', 0, '', 0, '', 1, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104664, 130000, '河北省', 130700, '张家口市', 130728, '怀安县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104665, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150783, '扎兰屯市', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(104666, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150727, '新巴尔虎右旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(104667, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653222, '墨玉县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104668, 410000, '河南省', 411500, '信阳市', 411503, '平桥区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104669, 450000, '广西壮族自治区', 450500, '北海市', 450512, '铁山港区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104670, 460000, '海南省', 469000, '省直辖县级行政区划', 469028, '陵水黎族自治县', 3, 'D', 1, 0, '', '', ''),
(104671, 450000, '广西壮族自治区', 450300, '桂林市', 450302, '秀峰区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104672, 510000, '四川省', 510800, '广元市', 510812, '朝天区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104673, 410000, '河南省', 410800, '焦作市', 410804, '马村区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104674, 360000, '江西省', 361000, '抚州市', 361026, '宜黄县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104675, 350000, '福建省', 350400, '三明市', 350428, '将乐县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104676, 360000, '江西省', 360600, '鹰潭市', 360602, '月湖区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104677, 500000, '重庆', 500100, '重庆市', 500238, '巫溪县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104678, 410000, '河南省', 410600, '鹤壁市', 410603, '山城区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104679, 140000, '山西省', 140400, '长治市', 140402, '城区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104680, 220000, '吉林省', 220100, '长春市', 220183, '德惠市', 3, 'A', 1, 2625, '长春', '', ''),
(104681, 340000, '安徽省', 340800, '安庆市', 340828, '岳西县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104682, 230000, '黑龙江省', 230100, '哈尔滨市', 230103, '南岗区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104683, 500000, '重庆', 500100, '重庆市', 500235, '云阳县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104684, 360000, '江西省', 360300, '萍乡市', 360322, '上栗县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104685, 510000, '四川省', 510800, '广元市', 510801, '其它区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104686, 610000, '陕西省', 610100, '西安市', 610115, '临潼区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104687, 230000, '黑龙江省', 231100, '黑河市', 231181, '北安市', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104688, 130000, '河北省', 130200, '唐山市', 130207, '丰南区', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104689, 130000, '河北省', 130900, '沧州市', 130981, '泊头市', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104690, 510000, '四川省', 513300, '甘孜藏族自治州', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104691, 520000, '贵州省', 522600, '黔东南苗族侗族自治州', 522634, '雷山县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104692, 330000, '浙江省', 331000, '台州市', 331004, '路桥区', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104693, 450000, '广西壮族自治区', 450700, '钦州市', 450722, '浦北县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104694, 440000, '广东省', 440100, '广州市', 440111, '白云区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104695, 340000, '安徽省', 340300, '蚌埠市', 0, '', 2, 'A', 0, 0, '', '合肥RDC电商库', 'D551'),
(104696, 370000, '山东省', 370900, '泰安市', 370901, '其它区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104697, 150000, '内蒙古自治区', 152900, '阿拉善盟', 152922, '阿拉善右旗', 3, 'A', 2, 2636, '兰州', '', ''),
(104698, 440000, '广东省', 441700, '阳江市', 441721, '阳西县', 3, 'A', 2, 2618, '广州', '广州RDC电商库', 'D020'),
(104699, 410000, '河南省', 410700, '新乡市', 410721, '新乡县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104700, 110000, '北京', 110100, '北京市', 0, '', 2, 'A', 0, 0, '', '北京RDC电商库', 'D10'),
(104701, 330000, '浙江省', 331100, '丽水市', 331122, '缙云县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(104702, 150000, '内蒙古自治区', 150200, '包头市', 150204, '青山区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104703, 420000, '湖北省', 421200, '咸宁市', 421224, '通山县', 3, 'A', 2, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104704, 350000, '福建省', 350100, '福州市', 350103, '台江区', 3, 'A', 1, 2616, '福州', '厦门RDC电商库', 'D592'),
(104705, 640000, '宁夏回族自治区', 640500, '中卫市', 640522, '海原县', 3, 'A', 2, 2647, '西安', '', ''),
(104706, 320000, '江苏省', 320400, '常州市', 320482, '金坛市', 3, 'A', 1, 2604, '南京', '', ''),
(104707, 450000, '广西壮族自治区', 450900, '玉林市', 450922, '陆川县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104708, 410000, '河南省', 410500, '安阳市', 410506, '龙安区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104709, 430000, '湖南省', 430100, '长沙市', 430104, '岳麓区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104710, 610000, '陕西省', 610700, '汉中市', 610721, '南郑县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104711, 450000, '广西壮族自治区', 450200, '柳州市', 450222, '柳城县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104712, 510000, '四川省', 510700, '绵阳市', 0, '', 2, 'A', 0, 0, '', '成都RDC电商库', 'D028'),
(104713, 410000, '河南省', 411600, '周口市', 411621, '扶沟县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104714, 140000, '山西省', 141000, '临汾市', 141032, '永和县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104715, 650000, '新疆维吾尔自治区', 652100, '吐鲁番地区', 652122, '鄯善县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104716, 420000, '湖北省', 420500, '宜昌市', 420506, '夷陵区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104717, 210000, '辽宁省', 210700, '锦州市', 210701, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104718, 210000, '辽宁省', 211200, '铁岭市', 211204, '清河区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104719, 630000, '青海省', 632300, '黄南藏族自治州', 632322, '尖扎县', 3, 'A', 2, 2636, '兰州', '', ''),
(104720, 510000, '四川省', 510300, '自贡市', 510303, '贡井区', 3, 'A', 1, 2306, '泸州', '成都RDC电商库', 'D028'),
(104721, 620000, '甘肃省', 620800, '平凉市', 620826, '静宁县', 3, 'A', 2, 2636, '兰州', '', ''),
(104722, 210000, '辽宁省', 211400, '葫芦岛市', 211401, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104723, 130000, '河北省', 131100, '衡水市', 131126, '故城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104724, 140000, '山西省', 140700, '晋中市', 140729, '灵石县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104725, 130000, '河北省', 130200, '唐山市', 130225, '乐亭县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104726, 650000, '新疆维吾尔自治区', 653000, '克孜勒苏柯尔克孜自治州', 653023, '阿合奇县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104727, 370000, '山东省', 370800, '济宁市', 370832, '梁山县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(104728, 110000, '北京', 110100, '北京市', 110102, '西城区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(104729, 150000, '内蒙古自治区', 150100, '呼和浩特市', 150123, '和林格尔县', 3, 'A', 2, 2632, '呼和浩特', '', ''),
(104730, 410000, '河南省', 410100, '郑州市', 410182, '荥阳市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104731, 530000, '云南省', 0, '', 0, '', 1, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(104732, 410000, '河南省', 411100, '漯河市', 411122, '临颍县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104733, 440000, '广东省', 440900, '茂名市', 440903, '茂港区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104734, 130000, '河北省', 130400, '邯郸市', 130403, '丛台区', 3, 'A', 1, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104735, 650000, '新疆维吾尔自治区', 654300, '阿勒泰地区', 654301, '阿勒泰市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104736, 500000, '重庆', 500100, '重庆市', 500102, '涪陵区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104737, 510000, '四川省', 513400, '凉山彝族自治州', 513435, '甘洛县', 3, 'A', 2, 2308, '昆明', '成都RDC电商库', 'D028'),
(104738, 610000, '陕西省', 610400, '咸阳市', 610402, '秦都区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104739, 420000, '湖北省', 420500, '宜昌市', 420503, '伍家岗区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104740, 420000, '湖北省', 420600, '襄阳市', 420607, '襄州区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104741, 370000, '山东省', 370500, '东营市', 370502, '东营区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104742, 410000, '河南省', 411500, '信阳市', 0, '', 2, 'A', 0, 0, '', '郑州RDC电商库', 'D371'),
(104743, 130000, '河北省', 130100, '石家庄市', 130124, '栾城县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104744, 530000, '云南省', 530300, '曲靖市', 530321, '马龙县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104745, 130000, '河北省', 131000, '廊坊市', 131082, '三河市', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(104746, 610000, '陕西省', 610800, '榆林市', 610824, '靖边县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104747, 420000, '湖北省', 420100, '武汉市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(104748, 130000, '河北省', 130500, '邢台市', 130529, '巨鹿县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104749, 140000, '山西省', 140800, '运城市', 140830, '芮城县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104750, 420000, '湖北省', 422800, '恩施土家族苗族自治州', 422801, '恩施市', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(104751, 610000, '陕西省', 610900, '安康市', 610929, '白河县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104752, 620000, '甘肃省', 621200, '陇南市', 621224, '康县', 3, 'A', 1, 2636, '兰州', '', ''),
(104753, 440000, '广东省', 440800, '湛江市', 440882, '雷州市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104754, 210000, '辽宁省', 210700, '锦州市', 210711, '太和区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104755, 230000, '黑龙江省', 230200, '齐齐哈尔市', 230231, '拜泉县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104756, 230000, '黑龙江省', 231200, '绥化市', 231225, '明水县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104757, 520000, '贵州省', 522700, '黔南布依族苗族自治州', 522730, '龙里县', 3, 'A', 2, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104758, 520000, '贵州省', 520100, '贵阳市', 520113, '白云区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104759, 610000, '陕西省', 610100, '西安市', 610116, '长安区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104760, 410000, '河南省', 410400, '平顶山市', 410401, '其它区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104761, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513233, '红原县', 3, 'A', 2, 2301, '成都', '成都RDC电商库', 'D028'),
(104762, 620000, '甘肃省', 620600, '武威市', 620621, '民勤县', 3, 'A', 2, 2636, '兰州', '', ''),
(104763, 230000, '黑龙江省', 230100, '哈尔滨市', 230104, '道外区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104764, 210000, '辽宁省', 210600, '丹东市', 210682, '凤城市', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104765, 370000, '山东省', 370900, '泰安市', 370921, '宁阳县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(104766, 420000, '湖北省', 420100, '武汉市', 420115, '江夏区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104767, 420000, '湖北省', 420200, '黄石市', 420203, '西塞山区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104768, 530000, '云南省', 530900, '临沧市', 530923, '永德县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104769, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 650205, '乌尔禾区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104770, 450000, '广西壮族自治区', 451100, '贺州市', 451102, '八步区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104771, 120000, '天津', 120100, '天津市', 120107, '塘沽区', 3, 'A', 2, 2634, '天津', '', ''),
(104772, 450000, '广西壮族自治区', 450600, '防城港市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(104773, 450000, '广西壮族自治区', 451400, '崇左市', 451424, '大新县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104774, 510000, '四川省', 511600, '广安市', 511601, '其它区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104775, 540000, '西藏自治区', 542100, '昌都地区', 542128, '左贡县', 3, 'A', 2, 2636, '兰州', '', ''),
(104776, 320000, '江苏省', 320900, '盐城市', 320921, '响水县', 3, 'A', 2, 2663, '南通', '', ''),
(104777, 510000, '四川省', 511800, '雅安市', 511802, '雨城区', 3, 'A', 1, 2307, '乐山', '成都RDC电商库', 'D028'),
(104778, 340000, '安徽省', 341100, '滁州市', 341125, '定远县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104779, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150782, '牙克石市', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(104780, 350000, '福建省', 350700, '南平市', 0, '', 2, 'A', 0, 0, '', '厦门RDC电商库', 'D592'),
(104781, 430000, '湖南省', 431000, '郴州市', 431001, '其它区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104782, 340000, '安徽省', 340300, '蚌埠市', 340311, '淮上区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104783, 340000, '安徽省', 341200, '阜阳市', 341204, '颍泉区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104784, 460000, '海南省', 469000, '省直辖县级行政区划', 469030, '琼中黎族苗族自治县', 3, 'D', 1, 0, '', '', ''),
(104785, 420000, '湖北省', 421300, '随州市', 421301, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104786, 430000, '湖南省', 430100, '长沙市', 430103, '天心区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104787, 640000, '宁夏回族自治区', 640100, '银川市', 640121, '永宁县', 3, 'A', 2, 2647, '西安', '', ''),
(104788, 210000, '辽宁省', 211100, '盘锦市', 211101, '其它区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104789, 140000, '山西省', 140400, '长治市', 140427, '壶关县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104790, 370000, '山东省', 371000, '威海市', 0, '', 2, 'A', 0, 2601, '青岛', '济南RDC电商库', 'D531'),
(104791, 130000, '河北省', 130200, '唐山市', 130203, '路北区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104792, 150000, '内蒙古自治区', 150400, '赤峰市', 150402, '红山区', 3, 'A', 1, 2633, '唐山', '', ''),
(104793, 140000, '山西省', 140800, '运城市', 140802, '盐湖区', 3, 'A', 1, 2611, '太原', '太原RDC电商库', 'D351'),
(104794, 420000, '湖北省', 420200, '黄石市', 420201, '其它区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(104795, 340000, '安徽省', 340200, '芜湖市', 340208, '三山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104796, 640000, '宁夏回族自治区', 640100, '银川市', 640181, '灵武市', 3, 'A', 1, 2647, '西安', '', ''),
(104797, 130000, '河北省', 130300, '秦皇岛市', 130323, '抚宁县', 3, 'A', 2, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(104798, 530000, '云南省', 530100, '昆明市', 530112, '西山区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104799, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652927, '乌什县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104800, 130000, '河北省', 130200, '唐山市', 0, '', 2, 'A', 0, 0, '', '石家庄RDC电商库', 'D311'),
(104801, 340000, '安徽省', 341500, '六安市', 341502, '金安区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104802, 340000, '安徽省', 340500, '马鞍山市', 340504, '雨山区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104803, 130000, '河北省', 130400, '邯郸市', 130432, '广平县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104804, 130000, '河北省', 130400, '邯郸市', 130406, '峰峰矿区', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104805, 620000, '甘肃省', 621000, '庆阳市', 621023, '华池县', 3, 'A', 2, 2636, '兰州', '', ''),
(104806, 410000, '河南省', 410200, '开封市', 410201, '其它区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104807, 370000, '山东省', 371300, '临沂市', 371324, '苍山县', 3, 'A', 2, 2608, '临沂', '济南RDC电商库', 'D531'),
(104808, 440000, '广东省', 440600, '佛山市', 440607, '三水区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104809, 410000, '河南省', 410400, '平顶山市', 410481, '舞钢市', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104810, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104811, 140000, '山西省', 140700, '晋中市', 140727, '祁县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104812, 410000, '河南省', 411600, '周口市', 411622, '西华县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104813, 150000, '内蒙古自治区', 150500, '通辽市', 150522, '科尔沁左翼后旗', 3, 'A', 2, 2626, '沈阳', '', ''),
(104814, 420000, '湖北省', 429054, '仙桃市', 0, '', 2, 'D', 0, 0, '', '武汉RDC电商库', 'D027'),
(104815, 620000, '甘肃省', 620500, '天水市', 620525, '张家川回族自治县', 3, 'A', 1, 2636, '兰州', '', ''),
(104816, 410000, '河南省', 411400, '商丘市', 411421, '民权县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104817, 630000, '青海省', 632700, '玉树藏族自治州', 632726, '曲麻莱县', 3, 'A', 1, 2636, '兰州', '', ''),
(104818, 320000, '江苏省', 320500, '苏州市', 320501, '其它区', 3, 'A', 1, 2664, '无锡', '', ''),
(104819, 440000, '广东省', 440900, '茂名市', 440901, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104820, 140000, '山西省', 141100, '吕梁市', 141130, '交口县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104821, 540000, '西藏自治区', 542300, '日喀则地区', 542324, '定日县', 3, 'A', 2, 2636, '兰州', '', ''),
(104822, 620000, '甘肃省', 620900, '酒泉市', 620921, '金塔县', 3, 'A', 2, 2636, '兰州', '', ''),
(104823, 440000, '广东省', 440100, '广州市', 440101, '其它区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104824, 330000, '浙江省', 331100, '丽水市', 331121, '青田县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(104825, 210000, '辽宁省', 211400, '葫芦岛市', 0, '', 2, 'A', 0, 0, '', '大连RDC电商库', 'D411'),
(104826, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513229, '马尔康县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104827, 130000, '河北省', 130500, '邢台市', 130528, '宁晋县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104828, 520000, '贵州省', 520200, '六盘水市', 520222, '盘县', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104829, 430000, '湖南省', 430400, '衡阳市', 430424, '衡东县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104830, 650000, '新疆维吾尔自治区', 650200, '克拉玛依市', 650202, '独山子区', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104831, 330000, '浙江省', 331100, '丽水市', 331181, '龙泉市', 3, 'A', 1, 2619, '温州', '宁波RDC电商库', 'D574'),
(104832, 410000, '河南省', 411200, '三门峡市', 411281, '义马市', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104833, 440000, '广东省', 441400, '梅州市', 441427, '蕉岭县', 3, 'A', 2, 2645, '汕头', '广州RDC电商库', 'D020'),
(104834, 430000, '湖南省', 431100, '永州市', 431103, '冷水滩区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104835, 230000, '黑龙江省', 232700, '大兴安岭地区', 232724, '加格达奇区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104836, 220000, '吉林省', 220800, '白城市', 220882, '大安市', 3, 'A', 1, 2625, '长春', '', ''),
(104837, 320000, '江苏省', 320700, '连云港市', 320724, '灌南县', 3, 'A', 2, 2608, '临沂', '', ''),
(104838, 130000, '河北省', 130800, '承德市', 130823, '平泉县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(104839, 650000, '新疆维吾尔自治区', 653200, '和田地区', 653227, '民丰县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104840, 320000, '江苏省', 320200, '无锡市', 320204, '北塘区', 3, 'A', 1, 2664, '无锡', '', ''),
(104841, 650000, '新疆维吾尔自治区', 652700, '博尔塔拉蒙古自治州', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104842, 370000, '山东省', 370100, '济南市', 370126, '商河县', 3, 'A', 2, 2605, '济南', '济南RDC电商库', 'D531'),
(104843, 140000, '山西省', 141100, '吕梁市', 141123, '兴县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104844, 530000, '云南省', 530500, '保山市', 0, '', 2, 'A', 0, 0, '', '昆明RDC电商库', 'D871'),
(104845, 130000, '河北省', 131000, '廊坊市', 131022, '固安县', 3, 'A', 2, 2634, '天津', '石家庄RDC电商库', 'D311'),
(104846, 230000, '黑龙江省', 230500, '双鸭山市', 230523, '宝清县', 3, 'A', 2, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104847, 610000, '陕西省', 610300, '宝鸡市', 610304, '陈仓区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(104848, 360000, '江西省', 361100, '上饶市', 361125, '横峰县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104849, 620000, '甘肃省', 621200, '陇南市', 621201, '其它区', 3, 'A', 1, 2636, '兰州', '', ''),
(104850, 540000, '西藏自治区', 542300, '日喀则地区', 542334, '亚东县', 3, 'A', 2, 2636, '兰州', '', ''),
(104851, 210000, '辽宁省', 210900, '阜新市', 210922, '彰武县', 3, 'A', 2, 2627, '大连', '大连RDC电商库', 'D411'),
(104852, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 150724, '鄂温克族自治旗', 3, 'A', 2, 2629, '哈尔滨', '', ''),
(104853, 410000, '河南省', 411200, '三门峡市', 411202, '湖滨区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104854, 360000, '江西省', 360700, '赣州市', 360723, '大余县', 3, 'A', 2, 2641, '赣州', '南昌RDC电商库', 'D791'),
(104855, 150000, '内蒙古自治区', 150300, '乌海市', 150301, '其它区', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(104856, 500000, '重庆', 500100, '重庆市', 500242, '酉阳土家族苗族自治县', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104857, 410000, '河南省', 410400, '平顶山市', 410411, '湛河区', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104858, 210000, '辽宁省', 211100, '盘锦市', 211103, '兴隆台区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(104859, 630000, '青海省', 632200, '海北州', 632224, '刚察县', 3, 'A', 2, 2636, '兰州', '', ''),
(104860, 650000, '新疆维吾尔自治区', 653100, '喀什地区', 653128, '岳普湖县', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104861, 510000, '四川省', 513200, '阿坝藏族羌族自治州', 513232, '若尔盖县', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104862, 350000, '福建省', 350100, '福州市', 350123, '罗源县', 3, 'A', 2, 2616, '福州', '厦门RDC电商库', 'D592'),
(104863, 520000, '贵州省', 520300, '遵义市', 0, '', 2, 'A', 0, 0, '', '贵阳RDC电商库', 'D851'),
(104864, 130000, '河北省', 130800, '承德市', 130824, '滦平县', 3, 'A', 2, 2633, '承德市', '石家庄RDC电商库', 'D311'),
(104865, 530000, '云南省', 530900, '临沧市', 530926, '耿马傣族佤族自治县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104866, 310000, '上海', 310100, '上海市', 310107, '普陀区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(104867, 410000, '河南省', 410300, '洛阳市', 410326, '汝阳县', 3, 'A', 2, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104868, 230000, '黑龙江省', 230100, '哈尔滨市', 230123, '依兰县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104869, 610000, '陕西省', 610800, '榆林市', 610827, '米脂县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104870, 410000, '河南省', 410200, '开封市', 410221, '杞县', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(104871, 130000, '河北省', 130400, '邯郸市', 130421, '邯郸县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104872, 650000, '新疆维吾尔自治区', 652900, '阿克苏地区', 652901, '阿克苏市', 3, 'A', 2, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104873, 460000, '海南省', 460100, '海口市', 460106, '龙华新区', 3, 'A', 1, 2646, '海口', '', ''),
(104874, 330000, '浙江省', 330500, '湖州市', 330502, '吴兴区', 3, 'A', 1, 2603, '杭州', '宁波RDC电商库', 'D574'),
(104875, 540000, '西藏自治区', 542600, '林芝地区', 542623, '米林县', 3, 'A', 2, 2308, '昆明', '', ''),
(104876, 230000, '黑龙江省', 230600, '大庆市', 230605, '红岗区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104877, 340000, '安徽省', 341500, '六安市', 341523, '舒城县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(104878, 410000, '河南省', 411600, '周口市', 411623, '商水县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104879, 640000, '宁夏回族自治区', 640100, '银川市', 640101, '其它区', 3, 'A', 1, 2647, '西安', '', ''),
(104880, 150000, '内蒙古自治区', 150700, '呼伦贝尔市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104881, 610000, '陕西省', 610500, '渭南市', 610524, '合阳县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104882, 150000, '内蒙古自治区', 150400, '赤峰市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104883, 500000, '重庆', 500100, '重庆市', 0, '', 2, 'A', 0, 0, '', '重庆RDC电商库', 'D023'),
(104884, 150000, '内蒙古自治区', 150400, '赤峰市', 150428, '喀喇沁旗', 3, 'A', 2, 2633, '唐山', '', ''),
(104885, 650000, '新疆维吾尔自治区', 654000, '伊犁哈萨克自治州', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(104886, 650000, '新疆维吾尔自治区', 650100, '乌鲁木齐市', 650121, '乌鲁木齐县', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(104887, 370000, '山东省', 370800, '济宁市', 370811, '任城区', 3, 'A', 1, 2608, '临沂', '济南RDC电商库', 'D531'),
(104888, 440000, '广东省', 441500, '汕尾市', 441581, '陆丰市', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(104889, 210000, '辽宁省', 210100, '沈阳市', 210113, '沈北新区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104890, 450000, '广西壮族自治区', 450300, '桂林市', 450332, '恭城瑶族自治县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104891, 530000, '云南省', 532300, '楚雄彝族自治州', 532328, '元谋县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104892, 320000, '江苏省', 320400, '常州市', 320401, '其它区', 3, 'A', 1, 2604, '南京', '', ''),
(104893, 330000, '浙江省', 330200, '宁波市', 330225, '象山县', 3, 'A', 2, 2643, '宁波', '宁波RDC电商库', 'D574'),
(104894, 140000, '山西省', 140300, '阳泉市', 140311, '郊区', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104895, 230000, '黑龙江省', 232700, '大兴安岭地区', 232721, '呼玛县', 3, 'A', 2, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104896, 450000, '广西壮族自治区', 450300, '桂林市', 0, '', 2, 'A', 0, 0, '', '南宁RDC电商库', 'D771'),
(104897, 510000, '四川省', 510100, '成都市', 510107, '武侯区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104898, 330000, '浙江省', 330300, '温州市', 330328, '文成县', 3, 'A', 2, 2619, '温州', '宁波RDC电商库', 'D574'),
(104899, 140000, '山西省', 140900, '忻州市', 140926, '静乐县', 3, 'A', 2, 2611, '太原', '太原RDC电商库', 'D351'),
(104900, 410000, '河南省', 411500, '信阳市', 411526, '潢川县', 3, 'A', 2, 2610, '漯河', '郑州RDC电商库', 'D371'),
(104901, 530000, '云南省', 530400, '玉溪市', 530425, '易门县', 3, 'A', 2, 2308, '昆明', '昆明RDC电商库', 'D871'),
(104902, 460000, '海南省', 469000, '省直辖县级行政区划', 469024, '临高县', 3, 'D', 1, 0, '', '', ''),
(104903, 130000, '河北省', 130700, '张家口市', 130723, '康保县', 3, 'A', 2, 2632, '呼和浩特', '石家庄RDC电商库', 'D311'),
(104904, 150000, '内蒙古自治区', 150400, '赤峰市', 150401, '其它区', 3, 'A', 1, 2633, '唐山', '', ''),
(104905, 610000, '陕西省', 610600, '延安市', 610630, '宜川县', 3, 'A', 2, 2647, '西安', '西安RDC电商库', 'D029'),
(104906, 640000, '宁夏回族自治区', 0, '', 0, '', 1, 'A', 0, 0, '', '', ''),
(104907, 460000, '海南省', 469001, '五指山市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104908, 540000, '西藏自治区', 542400, '那曲地区', 542422, '嘉黎县', 3, 'A', 2, 2308, '昆明', '', ''),
(104909, 220000, '吉林省', 220200, '吉林市', 220283, '舒兰市', 3, 'A', 2, 2625, '长春', '', ''),
(104910, 320000, '江苏省', 321000, '扬州市', 321023, '宝应县', 3, 'A', 2, 2663, '南通', '', ''),
(104911, 440000, '广东省', 440700, '江门市', 440781, '台山市', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(104912, 130000, '河北省', 130100, '石家庄市', 130129, '赞皇县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104913, 210000, '辽宁省', 210100, '沈阳市', 210105, '皇姑区', 3, 'A', 1, 2626, '沈阳', '大连RDC电商库', 'D411'),
(104914, 520000, '贵州省', 520300, '遵义市', 520301, '其它区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104915, 510000, '四川省', 511100, '乐山市', 511124, '井研县', 3, 'A', 2, 2307, '乐山', '成都RDC电商库', 'D028'),
(104916, 540000, '西藏自治区', 542100, '昌都地区', 542124, '类乌齐县', 3, 'A', 1, 2636, '兰州', '', ''),
(104917, 430000, '湖南省', 431100, '永州市', 431123, '双牌县', 3, 'A', 2, 2620, '长沙', '长沙RDC电商库', 'D731'),
(104918, 230000, '黑龙江省', 231000, '牡丹江市', 231005, '西安区', 3, 'A', 1, 2630, '牡丹江', '哈尔滨RDC电商库', 'D451'),
(104919, 370000, '山东省', 370200, '青岛市', 370203, '市北区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(104920, 220000, '吉林省', 220300, '四平市', 0, '', 2, 'A', 0, 0, '', '', ''),
(104921, 510000, '四川省', 510600, '德阳市', 510601, '其它区', 3, 'A', 1, 2301, '成都', '成都RDC电商库', 'D028'),
(104922, 230000, '黑龙江省', 230700, '伊春市', 230712, '汤旺河区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(104923, 630000, '青海省', 630100, '西宁市', 630102, '城东区', 3, 'A', 1, 2636, '兰州', '', ''),
(104924, 360000, '江西省', 361100, '上饶市', 361126, '弋阳县', 3, 'A', 2, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104925, 500000, '重庆', 500100, '重庆市', 500233, '忠县', 3, 'A', 2, 2303, '重庆', '重庆RDC电商库', 'D023'),
(104926, 320000, '江苏省', 320500, '苏州市', 320505, '虎丘区', 3, 'A', 1, 2664, '无锡', '', ''),
(104927, 130000, '河北省', 130400, '邯郸市', 130423, '临漳县', 3, 'A', 2, 2624, '石家庄', '石家庄RDC电商库', 'D311'),
(104928, 450000, '广西壮族自治区', 450100, '南宁市', 450126, '宾阳县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104929, 450000, '广西壮族自治区', 451200, '河池市', 451224, '东兰县', 3, 'A', 2, 2304, '南宁', '南宁RDC电商库', 'D771'),
(104930, 370000, '山东省', 370100, '济南市', 370105, '天桥区', 3, 'A', 1, 2605, '济南', '济南RDC电商库', 'D531'),
(104931, 610000, '陕西省', 610600, '延安市', 0, '', 2, 'A', 0, 0, '', '西安RDC电商库', 'D029'),
(104932, 360000, '江西省', 360900, '宜春市', 360902, '袁州区', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(104933, 520000, '贵州省', 522400, '毕节市', 522401, '毕节市', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(104934, 620000, '甘肃省', 621100, '定西市', 621126, '岷县', 3, 'A', 1, 2636, '兰州', '', ''),
(104935, 460000, '海南省', 469026, '昌江黎族自治县', 469033, '中沙群岛的岛礁及其海域', 3, 'D', 1, 0, '', '', ''),
(104936, 510000, '四川省', 510900, '遂宁市', 510904, '安居区', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(104937, 350000, '福建省', 350800, '龙岩市', 350802, '新罗区', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(213855, 530000, '云南省', 532300, '楚雄彝族自治州', 1, '其它区', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(215556, 310000, '上海', 310100, '上海市', 1, '其它区', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(328873, 110000, '北京', 110100, '北京市', 1, '其它区', 3, 'A', 1, 2602, '北京', '北京RDC电商库', 'D10'),
(329221, 120000, '天津', 120100, '天津市', 1, '其它区', 3, 'A', 1, 2634, '天津', '', ''),
(343693, 440000, '广东省', 441900, '东莞市', 1, '虎门镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(538202, 500000, '重庆', 500100, '重庆市', 1, '其它区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(1313889, 340000, '安徽省', 340100, '合肥市', 340124, '庐江县', 3, 'A', 2, 2621, '合肥', '合肥RDC电商库', 'D551'),
(1337060, 230000, '黑龙江省', 232700, '大兴安岭地区', 1, '其它区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(4993400, 420000, '湖北省', 429004, '仙桃市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(4993404, 420000, '湖北省', 429006, '天门市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(4993410, 420000, '湖北省', 429005, '潜江市', 0, '', 2, 'A', 0, 0, '', '武汉RDC电商库', 'D027'),
(5731245, 340000, '安徽省', 340100, '合肥市', 341400, '巢湖市', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(39574222, 520000, '贵州省', 522400, '毕节市', 520502, '七星关区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(39676132, 460000, '海南省', 460200, '三亚市', 16777215, '河东区', 3, 'A', 1, 2646, '海口', '', ''),
(39676228, 360000, '江西省', 360400, '九江市', 360482, '共青城市', 3, 'A', 1, 2613, '南昌', '南昌RDC电商库', 'D791'),
(39679607, 460000, '海南省', 469000, '省直辖县级行政区划', 16777215, '澄迈县', 3, 'D', 1, 0, '', '', ''),
(39679839, 440000, '广东省', 440300, '深圳市', 440309, '龙华新区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(39687218, 420000, '湖北省', 429004, '仙桃市', 429010, '杨林尾镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(39717705, 460000, '海南省', 469001, '五指山市', 469001, '通什镇', 3, 'A', 1, 2646, '海口', '', ''),
(39739326, 460000, '海南省', 469006, '万宁市', 469006, '南桥镇', 3, 'A', 1, 2646, '海口', '', ''),
(39744562, 460000, '海南省', 469063, '儋州市', 469063, '新州镇', 3, 'A', 1, 2646, '海口', '', ''),
(39747343, 320000, '江苏省', 320200, '无锡市', 320207, '新区', 3, 'A', 1, 2664, '无锡', '', ''),
(39751997, 210000, '辽宁省', 210200, '大连市', 210214, '大连市开发区', 3, 'A', 1, 2627, '大连', '大连RDC电商库', 'D411'),
(39752161, 520000, '贵州省', 522200, '铜仁市', 520602, '碧江区', 3, 'A', 1, 2302, '贵阳', '贵阳RDC电商库', 'D851'),
(39752365, 360000, '江西省', 360100, '南昌市', 360125, '红谷滩新区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(39756322, 320000, '江苏省', 320500, '苏州市', 320509, '新区', 3, 'A', 1, 2664, '无锡', '', ''),
(39756376, 440000, '广东省', 440300, '深圳市', 440310, '光明新区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(39756518, 130000, '河北省', 130300, '秦皇岛市', 130305, '经济技术开发区', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(39756538, 320000, '江苏省', 321000, '扬州市', 321004, '经济开发区', 3, 'A', 1, 2663, '南通', '', ''),
(39759343, 460000, '海南省', 460200, '三亚市', 16777215, '凤凰镇', 3, 'A', 1, 2646, '海口', '', ''),
(39769898, 420000, '湖北省', 429006, '天门市', 429006, '黄潭镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(39769948, 460000, '海南省', 469063, '儋州市', 469063, '那大镇', 3, 'A', 1, 2646, '海口', '', ''),
(39785378, 440000, '广东省', 441900, '东莞市', 441902, '南城区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(39786094, 230000, '黑龙江省', 232700, '大兴安岭地区', 2, '新林区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(39795589, 460000, '海南省', 469063, '儋州市', 469063, '白马井镇', 3, 'A', 1, 2646, '海口', '', ''),
(39846358, 460000, '海南省', 469000, '省直辖县级行政区划', 4690017, '东方市', 3, 'D', 1, 0, '', '', ''),
(39857065, 440000, '广东省', 441900, '东莞市', 16777215, '塘厦镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(39861704, 440000, '广东省', 440300, '深圳市', 440311, '坪山新区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(39861870, 420000, '湖北省', 429006, '天门市', 429007, '小板镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(39862013, 360000, '江西省', 360100, '南昌市', 360126, '昌北区', 3, 'A', 1, 2613, '南昌市', '南昌RDC电商库', 'D791'),
(39862018, 430000, '湖南省', 430500, '邵阳市', 430533, '城步县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(39925794, 120000, '天津', 120100, '天津市', 23, '大港区', 3, 'A', 1, 2634, '天津', '', ''),
(39977811, 460000, '海南省', 1, '东方市', 0, '', 2, 'A', 0, 0, '', '', ''),
(40265257, 460000, '海南省', 469000, '省直辖县级行政区划', 898, '定安县', 3, 'D', 2, 0, '', '', ''),
(40265720, 360000, '江西省', 360700, '赣州市', 797, '黄金区', 3, 'A', 1, 2641, '赣州', '南昌RDC电商库', 'D791'),
(40268099, 230000, '黑龙江省', 232700, '大兴安岭地区', 457, '松岭区', 3, 'A', 1, 2629, '哈尔滨', '哈尔滨RDC电商库', 'D451'),
(40914804, 460000, '海南省', 469005, '文昌市', 16777215, '文城镇', 3, 'A', 1, 2646, '海口', '', ''),
(40916780, 620000, '甘肃省', 620200, '嘉峪关市', 937002, '镜铁区', 3, 'A', 1, 2636, '兰州', '', ''),
(40917818, 460000, '海南省', 1, '东方市', 898002, '八所镇', 3, 'A', 2, 2646, '海口', '', ''),
(40918778, 340000, '安徽省', 340100, '合肥市', 230608, '经济技术开发区', 3, 'A', 1, 2621, '合肥', '合肥RDC电商库', 'D551'),
(40919803, 440000, '广东省', 441900, '东莞市', 79605, '桥头镇', 3, 'A', 2, 2660, '深圳', '广州RDC电商库', 'D020'),
(40919828, 450000, '广西壮族自治区', 450300, '桂林市', 77302, '恭城县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(40919829, 460000, '海南省', 460100, '海口市', 89803, '龙华区', 3, 'A', 1, 2646, '海口', '', ''),
(40919840, 370000, '山东省', 370600, '烟台市', 53503, '招远市城区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(40919841, 460000, '海南省', 460200, '三亚市', 89804, '天涯镇', 3, 'A', 1, 2646, '海口', '', ''),
(40919842, 150000, '内蒙古自治区', 150400, '赤峰市', 47604, '巴林左旗林东镇', 3, 'A', 1, 2633, '唐山', '', ''),
(40919843, 310000, '上海', 310100, '上海市', 2105, '新区川沙新镇', 3, 'A', 1, 2642, '上海', '上海RDC电商库', 'D021'),
(40919844, 440000, '广东省', 441900, '东莞市', 79606, '樟木头镇白果洞樟罗第二工业区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(40919864, 350000, '福建省', 350500, '泉州市', 59505, '南安市金淘镇', 3, 'A', 1, 2617, '厦门', '厦门RDC电商库', 'D592'),
(40921014, 410000, '河南省', 411600, '周口市', 16777215, '项城市孙店镇', 3, 'A', 1, 2610, '漯河', '郑州RDC电商库', 'D371'),
(40921184, 320000, '江苏省', 320500, '苏州市', 51202, '昆山市花桥经济开发区', 3, 'A', 1, 2664, '无锡', '', ''),
(40921185, 370000, '山东省', 370700, '潍坊市', 16777215, '安丘市大盛镇大盛便民服务中心对面金湖社区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(40921186, 620000, '甘肃省', 621200, '陇南市', 47102, '文县城关镇', 3, 'A', 1, 2636, '兰州', '', ''),
(40921205, 430000, '湖南省', 430500, '邵阳市', 73905, '武冈市城区', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(40921228, 440000, '广东省', 440900, '茂名市', 51001, '宜信市', 3, 'A', 1, 2618, '关注', '广州RDC电商库', 'D020'),
(40922545, 460000, '海南省', 460200, '三亚市', 89801, '三亚市', 3, 'A', 1, 2646, '海口', '', ''),
(40922546, 440000, '广东省', 442000, '中山市', 16777215, '火炬开发区', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(40922547, 420000, '湖北省', 420100, '武汉市', 16777215, '桥口区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(40922548, 420000, '湖北省', 420600, '襄阳市', 55102, '襄阳区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(40922551, 530000, '云南省', 532900, '大理白族自治州', 87201, '南涧县', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(40922552, 320000, '江苏省', 321000, '扬州市', 51402, '江都市', 3, 'A', 1, 2663, '南通', '', ''),
(40922553, 420000, '湖北省', 429004, '仙桃市', 72802, '主城区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(40922566, 220000, '吉林省', 220600, '白山市', 43901, '八道江区', 3, 'A', 1, 2625, '长春', '', ''),
(40924216, 460000, '海南省', 89801, '直辖陵水县', 0, '', 2, 'D', 0, 0, '', '', ''),
(40924217, 460000, '海南省', 469026, '昌江黎族自治县', 89802, '石碌镇', 3, 'A', 1, 2646, '海口', '', ''),
(40924218, 460000, '海南省', 89801, '直辖陵水县', 898101, '椰林镇', 3, 'D', 1, 0, '', '', ''),
(40924219, 320000, '江苏省', 320500, '苏州市', 51201, '吴江市', 3, 'A', 1, 2664, '无锡', '', ''),
(40924737, 460000, '海南省', 469000, '省直辖县级行政区划', 89806, '保亭县', 3, 'D', 1, 0, '', '', ''),
(40924738, 370000, '山东省', 370600, '烟台市', 53501, '开发区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(40925422, 630000, '青海省', 632100, '海东市', 97201, '互助县', 3, 'A', 1, 2636, '兰州', '', ''),
(40925434, 150000, '内蒙古自治区', 150600, '鄂尔多斯市', 47701, '伊旗乌兰木伦镇', 3, 'A', 1, 2632, '呼和浩特', '', ''),
(40925435, 320000, '江苏省', 321200, '泰州市', 52301, '姜堰市', 3, 'A', 1, 2663, '南通', '', ''),
(40925436, 440000, '广东省', 441900, '东莞市', 79602, '东城区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(40927001, 320000, '江苏省', 320800, '淮安市', 51702, '楚州区', 3, 'A', 1, 2639, '徐州', '', ''),
(40927006, 130000, '河北省', 130300, '秦皇岛市', 33502, '青龙县', 3, 'A', 1, 2633, '唐山', '石家庄RDC电商库', 'D311'),
(40927022, 460000, '海南省', 89801, '直辖陵水县', 89807, '英州镇', 3, 'D', 1, 0, '', '', ''),
(40928012, 460000, '海南省', 89804, '乐东县', 0, '', 2, 'A', 0, 0, '', '', ''),
(40928262, 460000, '海南省', 89804, '乐东县', 898401, '黄流镇', 3, 'A', 1, 2646, '海口', '', ''),
(40928299, 150000, '内蒙古自治区', 150400, '赤峰市', 47606, '克什克腾旗经棚镇', 3, 'A', 1, 2633, '唐山', '', ''),
(40932784, 460000, '海南省', 460200, '三亚市', 898025, '主城区', 3, 'A', 1, 2646, '海口', '', ''),
(40934800, 460000, '海南省', 469006, '万宁市', 89805, '万城镇', 3, 'A', 1, 2646, '海口', '', ''),
(40934925, 440000, '广东省', 442000, '中山市', 76002, '板芙镇', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(40940074, 440000, '广东省', 441900, '东莞市', 76901, '茶山镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(40940783, 410000, '河南省', 410100, '郑州市', 410125, '高新技术开发区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(40941899, 370000, '山东省', 370700, '潍坊市', 370712, '高新区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(40943498, 460000, '海南省', 460200, '三亚市', 89809, '崖城镇', 3, 'A', 1, 2646, '海口', '', ''),
(40943652, 460000, '海南省', 469006, '万宁市', 89800, '礼纪镇', 3, 'A', 1, 2646, '海口', '', ''),
(40949214, 220000, '吉林省', 220100, '长春市', 220123, '高新技术产业开发区', 3, 'A', 1, 2625, '长春', '', ''),
(40955393, 430000, '湖南省', 431200, '怀化市', 74501, '麻阳县', 3, 'A', 1, 2620, '长沙', '长沙RDC电商库', 'D731'),
(40962035, 220000, '吉林省', 220100, '长春市', 220109, '经济技术开发区', 3, 'A', 1, 2625, '长春', '', ''),
(40962070, 530000, '云南省', 533100, '德宏傣族景颇族自治州', 533126, '芒市', 3, 'A', 1, 2308, '昆明', '昆明RDC电商库', 'D871'),
(40962071, 320000, '江苏省', 320600, '南通市', 320628, '开发区', 3, 'A', 1, 2663, '南通', '', ''),
(40962361, 220000, '吉林省', 220100, '长春市', 220119, '净月旅游开发区', 3, 'A', 1, 2625, '长春', '', ''),
(40963181, 440000, '广东省', 445200, '揭阳市', 445228, '东山区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(40964171, 410000, '河南省', 410100, '郑州市', 410135, '郑东新区', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(40964648, 440000, '广东省', 445100, '潮州市', 445129, '枫溪区', 3, 'A', 1, 2645, '汕头', '广州RDC电商库', 'D020'),
(40965775, 420000, '湖北省', 421200, '咸宁市', 421209, '温泉城区', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(40976777, 330000, '浙江省', 330600, '绍兴市', 16777215, '上虞市', 3, 'D', 1, 2643, '宁波', '宁波RDC电商库', 'D574'),
(41011844, 460000, '海南省', 469005, '文昌市', 571300, '龙楼镇', 3, 'A', 1, 2646, '海口', '', ''),
(41016718, 440000, '广东省', 440300, '深圳市', 16777215, '大鹏新区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41016726, 500000, '重庆', 500100, '重庆市', 16777215, '万盛区', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(41024022, 370000, '山东省', 370200, '青岛市', 370209, '开发区', 3, 'A', 1, 2601, '青岛', '济南RDC电商库', 'D531'),
(41036875, 500000, '重庆', 500100, '重庆市', 16777215, '彭水县', 3, 'A', 1, 2303, '重庆', '重庆RDC电商库', 'D023'),
(41037960, 440000, '广东省', 441900, '东莞市', 441909, '莞城区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41038282, 460000, '海南省', 89804, '乐东县', 469026, '乐东黎族自治县', 3, 'D', 1, 0, '', '', ''),
(41166871, 450000, '广西壮族自治区', 451100, '贺州市', 451103, '平桂管理区', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(41172846, 610000, '陕西省', 610100, '西安市', 610405, '杨凌农业示范区', 3, 'A', 1, 2647, '西安', '西安RDC电商库', 'D029'),
(41185256, 460000, '海南省', 460200, '三亚市', 460203, '立才农场', 3, 'A', 1, 2646, '海口', '', ''),
(41185267, 460000, '海南省', 460200, '三亚市', 460204, '河西区', 3, 'A', 1, 2646, '海口', '', ''),
(41187117, 510000, '四川省', 511700, '达州市', 511705, '达县', 3, 'A', 1, 2310, '南充', '成都RDC电商库', 'D028'),
(41187274, 440000, '广东省', 441900, '东莞市', 441905, '石龙镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41187392, 420000, '湖北省', 429006, '天门市', 429008, '彭市镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(41259151, 420000, '湖北省', 429006, '天门市', 429009, '张港镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(41275022, 410000, '河南省', 419000, '济源市', 419002, '轵城镇', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(41408696, 440000, '广东省', 441900, '东莞市', 441912, '企石镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41425131, 440000, '广东省', 441900, '东莞市', 441911, '石碣镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41425347, 460000, '海南省', 469005, '文昌市', 469009, '清谰镇', 3, 'A', 1, 2646, '海口', '', ''),
(41425536, 450000, '广西壮族自治区', 450200, '柳州市', 450206, '融水县', 3, 'A', 1, 2304, '南宁', '南宁RDC电商库', 'D771'),
(41426829, 460000, '海南省', 469000, '省直辖县级行政区划', 469016, '老城镇', 3, 'D', 1, 0, '', '', ''),
(41426840, 440000, '广东省', 441900, '东莞市', 441913, '厚街镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41426879, 460000, '海南省', 469005, '文昌市', 469015, '锦山镇', 3, 'A', 1, 2646, '海口', '', ''),
(41480773, 440000, '广东省', 441900, '东莞市', 441907, '中堂镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41771812, 420000, '湖北省', 429004, '仙桃市', 4290049, '毛嘴镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(41772246, 440000, '广东省', 441900, '东莞市', 441915, '寮步镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(41772548, 440000, '广东省', 442000, '中山市', 442008, '横栏镇', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(41772555, 460000, '海南省', 460200, '三亚市', 460208, '吉阳镇', 3, 'A', 1, 2646, '海口', '', ''),
(41776902, 420000, '湖北省', 429006, '天门市', 4290061, '蒋场镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(41776903, 460000, '海南省', 469006, '万宁市', 4690061, '东澳镇', 3, 'A', 1, 2646, '海口', '', ''),
(41777060, 460000, '海南省', 469005, '文昌市', 4690051, '东郊镇', 3, 'A', 1, 2646, '海口', '', ''),
(41777113, 420000, '湖北省', 429004, '仙桃市', 4290042, '通海口镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(41777126, 460000, '海南省', 469006, '万宁市', 4690062, '和乐镇', 3, 'A', 1, 2646, '海口', '', ''),
(42013579, 440000, '广东省', 441900, '东莞市', 441918, '常平镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(42158521, 440000, '广东省', 441900, '东莞市', 441917, '长安镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(42158522, 440000, '广东省', 441900, '东莞市', 441916, '沙田镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(42477973, 650000, '新疆维吾尔自治区', 16777215, '阿拉尔市', 0, '', 2, 'A', 0, 0, '', '乌鲁木齐RDC电商库', 'D991'),
(42580252, 440000, '广东省', 441900, '东莞市', 441919, '清溪镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(43100716, 440000, '广东省', 441900, '东莞市', 441921, '大岭山镇', 3, 'A', 2, 2660, '深圳', '广州RDC电商库', 'D020'),
(43177293, 440000, '广东省', 441900, '东莞市', 441922, '万江区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(43177304, 440000, '广东省', 441900, '东莞市', 441923, '其它区', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(43310867, 460000, '海南省', 469001, '五指山市', 469001, '南圣镇', 3, 'A', 1, 2646, '海口', '', ''),
(43313846, 420000, '湖北省', 429004, '仙桃市', 16777215, '郭河镇', 3, 'A', 1, 2615, '武汉', '武汉RDC电商库', 'D027'),
(43452705, 460000, '海南省', 469001, '五指山市', 496110, '五指山市', 3, 'A', 1, 2646, '海口', '', ''),
(43453166, 460000, '海南省', 469114, '澄迈县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43453255, 460000, '海南省', 469112, '定安县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43453340, 460000, '海南省', 469002, '琼海市', 469113, '琼海市', 3, 'A', 1, 2646, '海口', '', ''),
(43454887, 460000, '海南省', 469115, '神农架林区', 0, '', 2, 'D', 0, 0, '', '', ''),
(43454998, 460000, '海南省', 469116, '白沙黎族自治县', 469116, '白沙黎族自治县', 3, 'A', 1, 2646, '海口', '', ''),
(43455604, 460000, '海南省', 465115, '陵水县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43455635, 460000, '海南省', 469117, '保亭黎族苗族自治县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43455683, 460000, '海南省', 469118, '临高县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43455744, 460000, '海南省', 469119, '琼中黎族苗族自治县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43455819, 460000, '海南省', 469120, '老城镇', 0, '', 2, 'A', 0, 0, '', '', ''),
(43455898, 460000, '海南省', 469122, '保亭县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43456377, 460000, '海南省', 469022, '屯昌县', 469124, '屯昌县', 3, 'A', 1, 2646, '海口', '', ''),
(43528152, 460000, '海南省', 469112, '定安县', 469109, '定安县', 3, 'A', 1, 2646, '海口', '', ''),
(43593045, 460000, '海南省', 469116, '白沙黎族自治县', 0, '', 2, 'A', 0, 0, '', '', ''),
(43692012, 420000, '湖北省', 429021, '神农架林区', 429021, '神农架林区', 3, 'A', 1, 2622, '襄阳', '武汉RDC电商库', 'D027'),
(43740399, 460000, '海南省', 465115, '陵水县', 89811, '陵水县', 3, 'A', 1, 2646, '海口', '', ''),
(43771377, 460000, '海南省', 469114, '澄迈县', 469128, '澄迈县', 3, 'A', 1, 2646, '海口', '', ''),
(44104087, 460000, '海南省', 469006, '万宁市', 469006, '万宁市', 3, 'A', 1, 2646, '海口', '', ''),
(44163637, 460000, '海南省', 89804, '乐东县', 89814, '乐东县', 3, 'A', 1, 2646, '海口', '', ''),
(44355201, 460000, '海南省', 469026, '昌江黎族自治县', 469126, '昌江黎族自治县', 3, 'A', 1, 2646, '海口', '', ''),
(44930813, 460000, '海南省', 469122, '保亭县', 16777215, '保亭县', 3, 'A', 1, 2646, '海口', '', ''),
(45366850, 460000, '海南省', 469119, '琼中黎族苗族自治县', 469129, '琼中黎族苗族自治县', 3, 'A', 1, 2646, '海口', '', ''),
(45366851, 460000, '海南省', 469063, '儋州市', 469063, '西流农场', 3, 'A', 1, 2646, '海口', '', ''),
(45562253, 410000, '河南省', 419000, '济源市', 419003, '五龙口镇', 3, 'A', 1, 2623, '郑州', '郑州RDC电商库', 'D371'),
(46065037, 460000, '海南省', 469118, '临高县', 469218, '临城镇', 3, 'A', 1, 2646, '海口', '', '');
INSERT INTO `hx_ecp_base_region` (`region_id`, `province_code`, `province_name`, `city_code`, `city_name`, `district_code`, `district_name`, `region_type`, `status`, `district_type`, `sap_code`, `sap_name`, `warehouse_name`, `warehouse_code`) VALUES
(46401541, 460000, '海南省', 469118, '临高县', 469318, '新盈镇', 3, 'A', 1, 2646, '海口', '', ''),
(47028070, 460000, '海南省', 469118, '临高县', 469228, '和舍镇', 3, 'A', 1, 2646, '海口', '', ''),
(47427698, 650000, '新疆维吾尔自治区', 16777215, '阿拉尔市', 16777215, '阿拉尔县', 3, 'A', 1, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991'),
(59631726, 440000, '广东省', 442000, '中山市', 442021, '沙溪镇', 3, 'A', 1, 2618, '广州', '广州RDC电商库', 'D020'),
(68099834, 460000, '海南省', 469002, '琼海市', 469052, '嘉积镇', 3, 'A', 1, 2646, '海口', '', ''),
(68184017, 460000, '海南省', 469063, '儋州市', 469063, '其它区', 3, 'A', 1, 2646, '海口', '', ''),
(70377771, 440000, '广东省', 441900, '东莞市', 441990, '大朗镇', 3, 'A', 1, 2660, '深圳', '广州RDC电商库', 'D020'),
(74854485, 460000, '海南省', 1, '东方市', 898001, '其它区', 3, 'A', 1, 2646, '海口', '', ''),
(77294154, 650000, '新疆维吾尔自治区', 659010, '五家渠市', 0, '', 2, 'D', 0, 2635, '乌鲁木齐', '乌鲁木齐RDC电商库', 'D991');

-- --------------------------------------------------------

--
-- 表的结构 `hx_ecp_inventory`
--

CREATE TABLE IF NOT EXISTS `hx_ecp_inventory` (
  `id` int(10) unsigned NOT NULL,
  `sku_id` varchar(16) NOT NULL COMMENT 'sku编号',
  `product_count` int(10) unsigned NOT NULL COMMENT '库存',
  `warehouse_code` varchar(8) NOT NULL COMMENT '仓库编号',
  `warehouse_name` varchar(32) NOT NULL COMMENT '仓库名称',
  `created_at` int(10) NOT NULL COMMENT '创建时间',
  `updated_at` int(10) NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='库存表';

--
-- 转存表中的数据 `hx_ecp_inventory`
--

INSERT INTO `hx_ecp_inventory` (`id`, `sku_id`, `product_count`, `warehouse_code`, `warehouse_name`, `created_at`, `updated_at`) VALUES
(19, '1TE6004TCNCB', 0, 'D571', '杭州RDC电商库', 1447314580, 1447381131),
(20, '1TE6004TCNCB', 5081, 'D532', '青岛RDC电商库', 1447314580, 1447381131),
(21, '1TE6004TCNCB', 1000, 'D029', '西安RDC电商库', 1447314580, 1447381131),
(22, '1TE6004TCNCB', 0, 'D020', '广州RDC电商库', 1447314580, 1447381131),
(23, '1TE6004TCNCB', 0, 'D991', '乌鲁木齐RDC电商库', 1447314580, 1447381131),
(24, '1TE6004TCNCB', 0, 'D010', '北京RDC电商库', 1447314580, 1447381131),
(25, '1TE50E0TCNCW', 50, 'D029', '西安RDC电商库', 1447322314, 1447381131),
(26, '1TE50E0TCNCW', 0, 'D571', '杭州RDC电商库', 1447322314, 1447381131),
(27, '1TE50E0TCNCW', 0, 'D851', '贵阳RDC电商库', 1447322314, 1447381131),
(28, '1TE50E0TCNCW', 4576, 'D532', '青岛RDC电商库', 1447322314, 1447381131),
(29, '1TE32Q7TCN9B', 7, 'D024', '沈阳RDC电商库', 1449741056, 1453193870),
(30, '1TE32Q7TCN9B', 0, 'D591', '福州RDC电商库', 1449741056, 1453193870),
(31, '1TE32Q7TCN9B', 17, 'D532', '青岛RDC电商库', 1449741056, 1453193870),
(32, '1TE32Q7TCN9B', 14, 'D010', '北京RDC电商库', 1449741056, 1453193870),
(33, '1TE32Q7TCN9B', 6, 'D571', '杭州RDC电商库', 1449741056, 1453193870),
(34, '1TE32Q7TCN9B', 10, 'D020', '广州RDC电商库', 1449741056, 1453193870),
(35, '1TE32Q7TCN9B', 67, 'D029', '西安RDC电商库', 1449741056, 1453193870),
(36, '1TE32Q7TCN9B', 0, 'D731', '长沙RDC电商库', 1449741056, 1453193870),
(37, '1TE32Q7TCN9B', 0, 'D771', '南宁RDC电商库', 1449741056, 1453193870),
(38, '1TE32Q7TCN9B', 58, 'D023', '重庆RDC电商库', 1449741056, 1453193870),
(39, '1TE32Q7TCN9B', 0, 'D871', '昆明RDC电商库', 1449741056, 1453193870),
(40, '1TE32Q7TCN9B', 7, 'D991', '乌鲁木齐RDC电商库', 1449741056, 1453193870),
(41, '1TE32Q7TCN9B', 0, 'D851', '贵阳CDC电商库', 1449741056, 1453193870),
(42, '1TE4308TCNEB', 103, 'D020', '广州RDC电商库', 1449741141, 1449741430),
(43, '1TE4308TCNEB', 10, 'D871', '昆明RDC电商库', 1449741141, 1449741430),
(44, '1TE4308TCNEB', 27, 'D591', '福州RDC电商库', 1449741141, 1449741430),
(45, '1TE4308TCNEB', 0, 'D731', '长沙RDC电商库', 1449741141, 1449741430),
(46, '1TE4308TCNEB', 6, 'D023', '重庆RDC电商库', 1449741141, 1449741430),
(47, '1TE4308TCNEB', 0, 'D024', '沈阳RDC电商库', 1449741141, 1449741430),
(48, '1TE4308TCNEB', 0, 'D029', '西安RDC电商库', 1449741141, 1449741430),
(49, '1TE4308TCNEB', 88, 'D532', '青岛RDC电商库', 1449741141, 1449741430),
(50, '1TE4308TCNEB', 10, 'D851', '贵阳CDC电商库', 1449741141, 1449741430),
(51, '1TE4308TCNEB', 14, 'D991', '乌鲁木齐RDC电商库', 1449741141, 1449741430),
(52, '1TE4308TCNEB', 7, 'D010', '北京RDC电商库', 1449741141, 1449741430),
(53, '1TE4308TCNEB', 5, 'D771', '南宁RDC电商库', 1449741141, 1449741430),
(54, '1TE4308TCNEB', 4, 'D571', '杭州RDC电商库', 1449741141, 1449741430),
(55, '1TE4834TCNMV', 26, 'D029', '西安RDC电商库', 1449741141, 1453193869),
(56, '1TE4834TCNMV', 121, 'D851', '贵阳CDC电商库', 1449741141, 1453193869),
(57, '1TE4834TCNMV', 29, 'D010', '北京RDC电商库', 1449741141, 1453193869),
(58, '1TE4834TCNMV', 0, 'D591', '福州RDC电商库', 1449741141, 1453193869),
(59, '1TE4834TCNMV', 0, 'D020', '广州RDC电商库', 1449741141, 1453193869),
(60, '1TE4834TCNMV', 0, 'D871', '昆明RDC电商库', 1449741141, 1453193869),
(61, '1TE4834TCNMV', 10, 'D532', '青岛RDC电商库', 1449741141, 1453193869),
(62, '1TE4834TCNMV', 0, 'D731', '长沙RDC电商库', 1449741141, 1453193869),
(63, '1TE4834TCNMV', 0, 'D991', '乌鲁木齐RDC电商库', 1449741141, 1453193869),
(64, '1TE4834TCNMV', 18, 'D771', '南宁RDC电商库', 1449741141, 1453193869),
(65, '1TE4834TCNMV', 176, 'D571', '杭州RDC电商库', 1449741141, 1453193869),
(66, '1TE4834TCNMV', 204, 'D023', '重庆RDC电商库', 1449741141, 1453193869),
(67, '1TE4834TCNMV', 14, 'D024', '沈阳RDC电商库', 1449741141, 1453193869),
(68, '1TE55G7TCNPV', 0, 'D010', '北京RDC电商库', 1449741142, 1449741431),
(69, '1TE55G7TCNPV', 0, 'D991', '乌鲁木齐RDC电商库', 1449741142, 1449741431),
(70, '1TE55G7TCNPV', 15, 'D020', '广州RDC电商库', 1449741142, 1449741431),
(71, '1TE55G7TCNPV', 0, 'D851', '贵阳CDC电商库', 1449741142, 1449741431),
(72, '1TE55G7TCNPV', 0, 'D771', '南宁RDC电商库', 1449741142, 1449741431),
(73, '1TE55G7TCNPV', 0, 'D571', '杭州RDC电商库', 1449741142, 1449741431),
(74, '1TE55G7TCNPV', 81, 'D532', '青岛RDC电商库', 1449741142, 1449741431),
(75, '1TE55G7TCNPV', 6, 'D731', '长沙RDC电商库', 1449741142, 1449741431),
(76, '1TE55G7TCNPV', 5, 'D023', '重庆RDC电商库', 1449741142, 1449741431),
(77, '1TE55G7TCNPV', 0, 'D029', '西安RDC电商库', 1449741142, 1449741431),
(78, '1TE55G7TCNPV', 5, 'D591', '福州RDC电商库', 1449741142, 1449741431),
(79, '1TE55G7TCNPV', 12, 'D024', '沈阳RDC电商库', 1449741142, 1449741431),
(80, '1TE55G7TCNPV', 0, 'D871', '昆明RDC电商库', 1449741142, 1449741431),
(81, '1TE50AMTCNPB', 82, 'D731', '长沙RDC电商库', 1449741142, 1449741431),
(82, '1TE50AMTCNPB', 162, 'D532', '青岛RDC电商库', 1449741142, 1449741431),
(83, '1TE50AMTCNPB', 151, 'D010', '北京RDC电商库', 1449741142, 1449741431),
(84, '1TE50AMTCNPB', 53, 'D871', '昆明RDC电商库', 1449741142, 1449741431),
(85, '1TE50AMTCNPB', 110, 'D020', '广州RDC电商库', 1449741142, 1449741431),
(86, '1TE50AMTCNPB', 41, 'D771', '南宁RDC电商库', 1449741142, 1449741431),
(87, '1TE50AMTCNPB', 107, 'D571', '杭州RDC电商库', 1449741142, 1449741431),
(88, '1TE50AMTCNPB', 38, 'D024', '沈阳RDC电商库', 1449741142, 1449741431),
(89, '1TE50AMTCNPB', 29, 'D023', '重庆RDC电商库', 1449741142, 1449741431),
(90, '1TE50AMTCNPB', 86, 'D029', '西安RDC电商库', 1449741142, 1449741431),
(91, '1TE50AMTCNPB', 83, 'D591', '福州RDC电商库', 1449741142, 1449741431),
(92, '1TE50AMTCNPB', 39, 'D991', '乌鲁木齐RDC电商库', 1449741142, 1449741431),
(93, '1TE50AMTCNPB', 30, 'D851', '贵阳CDC电商库', 1449741142, 1449741431),
(94, '1TE55AETCNPB', 153, 'D532', '青岛RDC电商库', 1449741142, 1449741431),
(95, '1TE55AETCNPB', 64, 'D024', '沈阳RDC电商库', 1449741142, 1449741431),
(96, '1TE55AETCNPB', 42, 'D851', '贵阳CDC电商库', 1449741142, 1449741431),
(97, '1TE55AETCNPB', 193, 'D571', '杭州RDC电商库', 1449741142, 1449741431),
(98, '1TE55AETCNPB', 135, 'D591', '福州RDC电商库', 1449741142, 1449741431),
(99, '1TE55AETCNPB', 66, 'D023', '重庆RDC电商库', 1449741142, 1449741431),
(100, '1TE55AETCNPB', 150, 'D771', '南宁RDC电商库', 1449741142, 1449741431),
(101, '1TE55AETCNPB', 127, 'D731', '长沙RDC电商库', 1449741142, 1449741431),
(102, '1TE55AETCNPB', 99, 'D020', '广州RDC电商库', 1449741142, 1449741431),
(103, '1TE55AETCNPB', 35, 'D991', '乌鲁木齐RDC电商库', 1449741142, 1449741431),
(104, '1TE55AETCNPB', 111, 'D871', '昆明RDC电商库', 1449741142, 1449741431),
(105, '1TE55AETCNPB', 178, 'D029', '西安RDC电商库', 1449741142, 1449741431),
(106, '1TE55AETCNPB', 231, 'D010', '北京RDC电商库', 1449741142, 1449741431),
(107, '1TE5823TCNCB', 7, 'D024', '沈阳RDC电商库', 1449741142, 1449741431),
(108, '1TE5823TCNCB', 4, 'D532', '青岛RDC电商库', 1449741142, 1449741431),
(109, '1TE5823TCNCB', 30, 'D871', '昆明RDC电商库', 1449741142, 1449741431),
(110, '1TE5823TCNCB', 7, 'D991', '乌鲁木齐RDC电商库', 1449741142, 1449741431),
(111, '1TE5823TCNCB', 62, 'D020', '广州RDC电商库', 1449741142, 1449741431),
(112, '1TE5823TCNCB', 38, 'D591', '福州RDC电商库', 1449741142, 1449741431),
(113, '1TE5823TCNCB', 0, 'D029', '西安RDC电商库', 1449741142, 1449741431),
(114, '1TE5823TCNCB', 57, 'D731', '长沙RDC电商库', 1449741142, 1449741431),
(115, '1TE5823TCNCB', 0, 'D851', '贵阳CDC电商库', 1449741142, 1449741431),
(116, '1TE5823TCNCB', 6, 'D010', '北京RDC电商库', 1449741142, 1449741431),
(117, '1TE5823TCNCB', 17, 'D023', '重庆RDC电商库', 1449741142, 1449741431),
(118, '1TE5823TCNCB', 0, 'D771', '南宁RDC电商库', 1449741142, 1449741431),
(119, '1TE5823TCNCB', 0, 'D571', '杭州RDC电商库', 1449741142, 1449741431),
(120, '1TE5825TCNCB', 0, 'D771', '南宁RDC电商库', 1449741142, 1453193869),
(121, '1TE5825TCNCB', 0, 'D571', '杭州RDC电商库', 1449741142, 1453193869),
(122, '1TE5825TCNCB', 0, 'D020', '广州RDC电商库', 1449741142, 1453193869),
(123, '1TE5825TCNCB', 36, 'D029', '西安RDC电商库', 1449741142, 1453193869),
(124, '1TE5825TCNCB', 0, 'D731', '长沙RDC电商库', 1449741142, 1453193869),
(125, '1TE5825TCNCB', 0, 'D851', '贵阳CDC电商库', 1449741142, 1453193869),
(126, '1TE5825TCNCB', 131, 'D010', '北京RDC电商库', 1449741142, 1453193869),
(127, '1TE5825TCNCB', 6, 'D991', '乌鲁木齐RDC电商库', 1449741142, 1453193869),
(128, '1TE5825TCNCB', 34, 'D024', '沈阳RDC电商库', 1449741142, 1453193869),
(129, '1TE5825TCNCB', 15, 'D023', '重庆RDC电商库', 1449741142, 1453193869),
(130, '1TE5825TCNCB', 10, 'D591', '福州RDC电商库', 1449741142, 1453193869),
(131, '1TE5825TCNCB', 9, 'D871', '昆明RDC电商库', 1449741142, 1453193869),
(132, '1TE5825TCNCB', 121, 'D532', '青岛RDC电商库', 1449741142, 1453193869),
(133, '1TE6548TCNCB', 0, 'D532', '青岛RDC电商库', 1449741142, 1449741432);

-- --------------------------------------------------------

--
-- 表的结构 `hx_ecp_warehouse`
--

CREATE TABLE IF NOT EXISTS `hx_ecp_warehouse` (
  `id` int(11) unsigned NOT NULL,
  `warehouse_code` varchar(16) NOT NULL COMMENT '仓库编码',
  `warehouse_name` varchar(32) NOT NULL COMMENT '仓库名称',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_ecp_warehouse`
--

INSERT INTO `hx_ecp_warehouse` (`id`, `warehouse_code`, `warehouse_name`, `created_at`, `updated_at`) VALUES
(2, 'D020', '广州RDC电商库', 0, 0),
(3, 'D021', '上海RDC电商库', 0, 0),
(4, 'D023', '重庆RDC电商库', 0, 0),
(5, 'D028', '成都RDC电商库', 0, 0),
(6, 'D029', '西安RDC电商库', 0, 0),
(7, 'D311', '石家庄RDC电商库', 0, 0),
(8, 'D351', '太原RDC电商库', 0, 0),
(9, 'D371', '郑州RDC电商库', 0, 0),
(10, 'D411', '大连RDC电商库', 0, 0),
(11, 'D451', '哈尔滨RDC电商库', 0, 0),
(12, 'D551', '合肥RDC电商库', 0, 0),
(13, 'D851', '贵阳CDC电商库', 0, 0),
(14, 'D574', '宁波RDC电商库', 0, 0),
(15, 'D010', '北京RDC电商库', 0, 0),
(16, 'D592', '厦门RDC电商库', 0, 0),
(17, 'D771', '南宁RDC电商库', 0, 0),
(18, 'D791', '南昌RDC电商库', 0, 0),
(19, 'D871', '昆明RDC电商库', 0, 0),
(20, 'D022', '天津RDC电商库', 0, 0),
(21, 'D027', '武汉RDC电商库', 0, 0),
(22, 'D431', '长春RDC电商库', 0, 0),
(23, 'D731', '长沙RDC电商库', 0, 0),
(24, 'D931', '兰州RDC电商库', 0, 0),
(25, 'D991', '乌鲁木齐RDC电商库', 0, 0),
(26, 'D510', '无锡RDC电商库', 0, 0),
(27, 'D531', '济南RDC电商库', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_help`
--

CREATE TABLE IF NOT EXISTS `hx_help` (
  `id` smallint(5) unsigned NOT NULL,
  `category` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '问题分类',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `content` text NOT NULL,
  `create_by` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_address`
--

CREATE TABLE IF NOT EXISTS `hx_mall_address` (
  `id` mediumint(10) unsigned NOT NULL COMMENT '地址id',
  `user_id` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '微信用户id',
  `name` varchar(20) NOT NULL COMMENT '收货人',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省市区id, 对应海信那个表',
  `full_address` varchar(100) NOT NULL COMMENT '详细地址',
  `default` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-正常  1-默认地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-正常 1-弃用',
  `fullname` varchar(32) NOT NULL COMMENT '收货人',
  `telephone` varchar(32) DEFAULT NULL COMMENT '固定电话',
  `mobile` varchar(32) DEFAULT NULL COMMENT '移动电话',
  `create_at` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_address`
--

INSERT INTO `hx_mall_address` (`id`, `user_id`, `name`, `region_id`, `full_address`, `default`, `status`, `fullname`, `telephone`, `mobile`, `create_at`, `update_time`) VALUES
(1, 1000, '闫', 0, '青岛市市北区', 1, 0, '', NULL, '18706483964', 1468466601, 1468466601),
(2, 1001, '张测试', 103921, '劲松一路', 1, 0, '', NULL, '18706483964', 1468489374, 1468489374);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_advert`
--

CREATE TABLE IF NOT EXISTS `hx_mall_advert` (
  `id` mediumint(8) unsigned NOT NULL,
  `title` varchar(100) NOT NULL COMMENT '广告标题',
  `description` varchar(250) NOT NULL COMMENT '广告描述',
  `image` varchar(50) NOT NULL COMMENT '广告图片地址',
  `url` varchar(100) NOT NULL COMMENT '跳转地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 - 正常 1 - 推荐到首页',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- 转存表中的数据 `hx_mall_advert`
--

INSERT INTO `hx_mall_advert` (`id`, `title`, `description`, `image`, `url`, `status`, `create_time`, `uid`) VALUES
(1, '1', '1', '20151222/5678c00bcaf73.jpg', 'http://himall.hisense.com/', 1, 1450754059, 7);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_alipay`
--

CREATE TABLE IF NOT EXISTS `hx_mall_alipay` (
  `id` int(11) NOT NULL,
  `alipayname` varchar(100) DEFAULT NULL COMMENT '支付宝名称',
  `partner` varchar(100) DEFAULT NULL COMMENT '合作身份者id',
  `key` varchar(100) DEFAULT NULL COMMENT '安全检验码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_banner`
--

CREATE TABLE IF NOT EXISTS `hx_mall_banner` (
  `id` mediumint(8) unsigned NOT NULL,
  `title` varchar(100) NOT NULL COMMENT 'banner标题',
  `description` varchar(250) NOT NULL COMMENT 'banner描述',
  `banner` varchar(50) NOT NULL COMMENT 'Banner图片地址',
  `url` varchar(2000) NOT NULL COMMENT '跳转地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 - 正常 1 - 推荐到首页',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建人'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_cart`
--

CREATE TABLE IF NOT EXISTS `hx_mall_cart` (
  `id` int(10) unsigned NOT NULL COMMENT '购物车商品id',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_num` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '购买商品数量',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入购物车时间',
  `remark` varchar(200) NOT NULL COMMENT '备注',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态  0-正常 1-删除'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_coupon`
--

CREATE TABLE IF NOT EXISTS `hx_mall_coupon` (
  `id` int(11) NOT NULL,
  `coupon_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `coupon_pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `allow_class_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `use_rule` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `start_time` int(10) unsigned NOT NULL,
  `end_time` int(10) unsigned NOT NULL,
  `money_over` int(10) unsigned NOT NULL COMMENT '单位分',
  `money_cut` int(10) unsigned NOT NULL,
  `total_num` int(10) unsigned NOT NULL COMMENT '0-不限制',
  `per_num` int(11) NOT NULL COMMENT '每人可领数量',
  `status` int(11) NOT NULL COMMENT '0-待投放  1-已投放  2-已结束',
  `sku_ids` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_coupon_record`
--

CREATE TABLE IF NOT EXISTS `hx_mall_coupon_record` (
  `id` int(11) NOT NULL,
  `coupon_id` int(10) unsigned NOT NULL,
  `card_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `card_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `used` int(11) NOT NULL COMMENT '0-未使用 1-已使用',
  `use_time` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `order_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `deleted` int(11) NOT NULL COMMENT '删除标识',
  `expire_remind` int(11) NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_good`
--

CREATE TABLE IF NOT EXISTS `hx_mall_good` (
  `id` int(10) unsigned NOT NULL COMMENT '商品id',
  `pid` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '一级菜单id',
  `menu_id` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '栏目id',
  `group_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '分组id',
  `name` char(100) NOT NULL COMMENT '商品名称',
  `spec` varchar(100) NOT NULL COMMENT '产品规格',
  `promotion` varchar(250) NOT NULL COMMENT '促销信息',
  `description` varchar(200) NOT NULL COMMENT '商品描述',
  `price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品价格',
  `old_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品原价',
  `image` varchar(500) NOT NULL COMMENT '商品图片地址',
  `detail` text NOT NULL COMMENT '商品描述',
  `sku_id` char(64) NOT NULL COMMENT '海信对接SKU',
  `is_ecp` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否从ECP搜索 0-不同步 1-同步',
  `stock` int(8) unsigned NOT NULL COMMENT '库存',
  `sales_volume` int(10) unsigned NOT NULL COMMENT '总销量',
  `tags` varchar(50) NOT NULL COMMENT '自由标签 分号隔开',
  `shelves_time` int(10) unsigned NOT NULL DEFAULT '0',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品排序',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '商品状态 0-下架 1-正常售卖 2-删除',
  `commission` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '佣金',
  `code_69` varchar(64) NOT NULL COMMENT '69码',
  `show_images` text NOT NULL COMMENT '商品banner',
  `sku_name` varchar(128) NOT NULL COMMENT 'sku名称',
  `click` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '置顶 0-正常 1-置顶',
  `with_invoice` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 有发票 1 无发票',
  `prompt` text NOT NULL COMMENT '提示',
  `on_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上架时间',
  `off_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下架时间',
  `ad_ids` varchar(100) NOT NULL COMMENT '广告id集合'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_good`
--

INSERT INTO `hx_mall_good` (`id`, `pid`, `menu_id`, `group_id`, `name`, `spec`, `promotion`, `description`, `price`, `old_price`, `image`, `detail`, `sku_id`, `is_ecp`, `stock`, `sales_volume`, `tags`, `shelves_time`, `create_time`, `sort`, `status`, `commission`, `code_69`, `show_images`, `sku_name`, `click`, `top`, `with_invoice`, `prompt`, `on_time`, `off_time`, `ad_ids`) VALUES
(1, 13, 14, 400, '海王电视机', '42寸', '买一送一', '极致LED体验', 428800, 430000, '', '&lt;p&gt;内容测试&lt;/p&gt;', '', 0, 86, 0, '4', 1468396578, 1468396578, 1, 1, 20000, '', '["\\/uploads\\/nullnull"]', '', 29, 1, 0, '', 0, 0, '1'),
(2, 13, 14, 400, '华三大电视', '43寸', '买10送1', '飞一般的享受', 410000, 420000, '', '&lt;p&gt;华三 电视啊&lt;/p&gt;', '', 0, 99, 0, '4', 1468490810, 1468490810, 1, 1, 1000, '', 'null', '', 12, 0, 0, '', 0, 0, '1'),
(3, 13, 14, 400, '大电视', '85寸', '买20送1', '超级大电视', 80000000, 90000000, '', '&lt;p&gt;大电视&lt;/p&gt;', '', 0, 200, 0, '4', 1468547188, 1468547188, 0, 1, 20000, '', 'null', '', 200, 0, 0, '', 0, 0, ''),
(4, 15, 18, 3, 'B142', '4.2寸', '买1 送0', '好玩', 100000, 1000000, '20160715/57888ba0e50ce.jpg', '&lt;p&gt;123&lt;/p&gt;', '', 0, 120, 0, '4', 1468549295, 1468549295, 0, 1, 12300, '', 'null', '', 125, 0, 0, '', 0, 0, ''),
(5, 15, 18, 2, '华为C213', '3.2', '买一送以', '这个手机还行', 10000, 10000, '20160715/578885ace25a2.jpg', '&lt;p&gt;测试怎么样&lt;/p&gt;', '', 0, 85, 0, '4', 1468564908, 1468564908, 1, 1, 0, '', 'null', '', 128, 0, 0, '', 0, 0, ''),
(6, 13, 14, 0, '超牛电视', '42寸', '买10个送1个', '牛牛的电视', 300000, 300000, '20160715/5788b204be90d.jpg', '&lt;p&gt;测试商品&lt;/p&gt;', '', 0, 97, 0, '4', 1468576260, 1468576260, 1, 1, 0, '', 'null', '', 101, 0, 0, '', 0, 0, '');

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_info`
--

CREATE TABLE IF NOT EXISTS `hx_mall_info` (
  `id` int(10) unsigned NOT NULL,
  `name` text NOT NULL,
  `notification` text NOT NULL,
  `theme` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_invoice`
--

CREATE TABLE IF NOT EXISTS `hx_mall_invoice` (
  `id` int(11) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_number` varchar(64) NOT NULL DEFAULT '0' COMMENT '订单编号',
  `serial_no` varchar(32) DEFAULT NULL COMMENT '路由编号',
  `invoice_type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 -纸质发票 1-电子发票',
  `normal_title` varchar(128) DEFAULT NULL COMMENT '普票抬头',
  `electronic_invoice_no` varchar(32) DEFAULT NULL COMMENT '运单号',
  `anti_fake_code` varchar(56) DEFAULT NULL COMMENT '订单号',
  `created_at` int(11) unsigned DEFAULT '0' COMMENT '记录生成时间',
  `ecp_body` text,
  `vat_taxpaper_ident` varchar(128) DEFAULT NULL COMMENT '增值税-纳税人识别号',
  `vat_registered_address` varchar(128) DEFAULT NULL COMMENT '增值税-注册地址',
  `vat_registered_phone` varchar(16) DEFAULT NULL COMMENT '增值税-注册电话',
  `vat_deposit_bank` varchar(128) DEFAULT NULL COMMENT '增值税-开户银行',
  `vat_bank_account` varchar(128) DEFAULT NULL COMMENT '增值税-银行帐户',
  `ecp_echo_time` int(11) DEFAULT NULL,
  `plain_title` varchar(128) DEFAULT NULL COMMENT '普通发票抬头'
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_invoice`
--

INSERT INTO `hx_mall_invoice` (`id`, `user_id`, `order_number`, `serial_no`, `invoice_type`, `normal_title`, `electronic_invoice_no`, `anti_fake_code`, `created_at`, `ecp_body`, `vat_taxpaper_ident`, `vat_registered_address`, `vat_registered_phone`, `vat_deposit_bank`, `vat_bank_account`, `ecp_echo_time`, `plain_title`) VALUES
(1, 1000, 'P160714153638277', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(2, 1000, 'P160714153959253', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(3, 1000, 'P160714154002123', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(4, 1000, 'P160714154015986', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(5, 1000, 'P160714154256509', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(6, 1001, 'P160714174303477', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(7, 1001, 'P160714175757539', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(8, 1001, 'P160714175854381', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(9, 1001, 'P160715145039717', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(10, 1001, 'P160715151146349', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(11, 1001, 'P160715152730113', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(12, 1001, 'P160715162811592', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(13, 1001, 'P160715163010386', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(14, 1001, 'P160715163020777', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(15, 1001, 'P160715163038772', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(16, 1001, 'P160715163047119', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(17, 1001, 'P160715164123973', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人'),
(18, 1001, 'P160715170424723', NULL, 1, '个人', NULL, NULL, 0, NULL, '', '', '', '', '', NULL, '个人');

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_mail`
--

CREATE TABLE IF NOT EXISTS `hx_mall_mail` (
  `id` int(10) unsigned NOT NULL,
  `smtp` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `on` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_menu`
--

CREATE TABLE IF NOT EXISTS `hx_mall_menu` (
  `id` int(10) unsigned NOT NULL,
  `name` text NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_menu`
--

INSERT INTO `hx_mall_menu` (`id`, `name`, `pid`) VALUES
(2, '家用电器', 1),
(3, '电视机', 2),
(4, '冰箱', 2),
(6, '电脑办公', 0),
(7, '手机数码', 0),
(8, '家用电器', 0),
(9, '厨房小电', 8),
(10, '厨卫大电', 8),
(11, '个护健康', 8),
(12, '料理机', 9),
(13, '大家电', 8),
(14, '平板电视', 13),
(15, '手机通讯', 7),
(16, '运营商', 7),
(17, '手机配件', 7),
(18, '华为手机', 15);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_notice`
--

CREATE TABLE IF NOT EXISTS `hx_mall_notice` (
  `id` int(10) unsigned NOT NULL,
  `created_by` int(10) NOT NULL COMMENT '公告创建者id',
  `content` varchar(256) NOT NULL COMMENT '公告内容',
  `created_at` int(10) NOT NULL COMMENT '创建时间',
  `updated_at` int(10) NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_notice`
--

INSERT INTO `hx_mall_notice` (`id`, `created_by`, `content`, `created_at`, `updated_at`) VALUES
(1, 7, '欢迎来到合伙人商城', 1450855671, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_order`
--

CREATE TABLE IF NOT EXISTS `hx_mall_order` (
  `id` int(10) unsigned NOT NULL COMMENT '订单id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_number` varchar(32) NOT NULL COMMENT '订单编号',
  `total_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品总价',
  `pay_style` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付方式  0-货到付款  1-微信支付',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态 0-未支付 1-已支付',
  `order_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态 1-待付款  2-待发货  3-待收货  4-已关闭  5-未付款删除  6-已付款删除  9-交易完成',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单创建时间',
  `cart_data` text NOT NULL COMMENT '购物车数据',
  `delivery_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '送货（日期）类型（1-只工作日送货(双休日、假日不用送);2-只双休日、假日送货(工作日不用送);3-工作日、双休日与假日均可送货;其他值-返回"任意时间"）',
  `is_elec` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0-纸质发票  1-电子发票',
  `is_normal` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-普通  1-增值税',
  `activity_id` varchar(50) NOT NULL COMMENT '订单参加的活动编号，由ECP统一编号',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单更新时间',
  `pay_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '确认付款的时间',
  `return_order` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '换货单标识 0-非换货订单 1-换货订单',
  `invoice` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否已开票  0-未开    1-已开出',
  `note` varchar(200) NOT NULL COMMENT '买家备注信息',
  `sellers_note` varchar(200) NOT NULL COMMENT '卖家留言',
  `complete_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单完成时间',
  `need_invoice` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要发票   0-不需要  1-需要',
  `address_id` int(10) unsigned NOT NULL COMMENT '收货地址 hx_mall_address',
  `commission_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-未收取佣金  1-收取佣金',
  `commission` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '佣金',
  `coupon_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券id',
  `is_coupon` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用优惠券',
  `real_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '实付金额  总价减掉 优惠金额',
  `prompt` text NOT NULL COMMENT '提示',
  `pay_remind` int(11) NOT NULL DEFAULT '0',
  `urge_time` int(11) DEFAULT NULL,
  `delivery_time` int(10) unsigned NOT NULL,
  `remark` text NOT NULL,
  `order_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单类型:1-秒杀,2-团购,3.抢购,4.预售',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '活动id,对应不同的活动表中的id'
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_order`
--

INSERT INTO `hx_mall_order` (`id`, `user_id`, `order_number`, `total_price`, `pay_style`, `pay_status`, `order_status`, `create_time`, `cart_data`, `delivery_type`, `is_elec`, `is_normal`, `activity_id`, `update_time`, `pay_time`, `return_order`, `invoice`, `note`, `sellers_note`, `complete_time`, `need_invoice`, `address_id`, `commission_status`, `commission`, `coupon_id`, `is_coupon`, `real_price`, `prompt`, `pay_remind`, `urge_time`, `delivery_time`, `remark`, `order_type`, `action_id`) VALUES
(18, 1001, 'P160715170424723', 10000, 1, 0, 1, 1468573464, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","warehouse_code":"","is_ecp":0,"commission":10000,"price":"10000","sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 1, 2, 0, 10000, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(19, 1001, 'P160715181424477', 10000, 0, 0, 1, 1468577664, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","warehouse_code":"","is_ecp":0,"commission":0,"price":"10000","sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(20, 1001, 'P160715181514603', 10000, 0, 0, 1, 1468577714, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","warehouse_code":"","is_ecp":0,"commission":0,"price":"10000","sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(21, 1001, 'P160715181526643', 10000, 0, 0, 1, 1468577726, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","warehouse_code":"","is_ecp":0,"commission":0,"price":"10000","sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(22, 1001, 'P160715184118155', 10000, 0, 0, 1, 1468579278, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(23, 1001, 'P160715184250579', 10000, 0, 0, 1, 1468579370, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(24, 1001, 'P160715184301311', 10000, 0, 0, 1, 1468579381, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 0, 0, 0, 10000, '', 0, NULL, 0, '', 0, 0),
(25, 1001, 'P160715184337353', 410000, 0, 0, 1, 1468579417, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""},{"id":"4","name":"B142","num":"1","image":"\\/uploads\\/20160715\\/57888ba0e50ce.jpg","description":"\\u597d\\u73a9","price":"100000","warehouse_code":"","is_ecp":0,"commission":12300,"sku_id":""},{"id":"6","name":"\\u8d85\\u725b\\u7535\\u89c6","num":"1","image":"\\/uploads\\/20160715\\/5788b204be90d.jpg","description":"\\u725b\\u725b\\u7684\\u7535\\u89c6","price":"300000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 12300, 0, 0, 410000, '', 0, NULL, 0, '', 0, 0),
(26, 1001, 'P160715184606714', 410000, 0, 0, 1, 1468579566, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""},{"id":"4","name":"B142","num":"1","image":"\\/uploads\\/20160715\\/57888ba0e50ce.jpg","description":"\\u597d\\u73a9","price":"100000","warehouse_code":"","is_ecp":0,"commission":12300,"sku_id":""},{"id":"6","name":"\\u8d85\\u725b\\u7535\\u89c6","num":"1","image":"\\/uploads\\/20160715\\/5788b204be90d.jpg","description":"\\u725b\\u725b\\u7684\\u7535\\u89c6","price":"300000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 12300, 0, 0, 410000, '', 0, NULL, 0, '', 0, 0),
(27, 1001, 'P160715185309395', 410000, 0, 0, 1, 1468579989, '[{"id":"5","name":"\\u534e\\u4e3aC213","num":"1","image":"\\/uploads\\/20160715\\/578885ace25a2.jpg","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""},{"id":"4","name":"B142","num":"1","image":"\\/uploads\\/20160715\\/57888ba0e50ce.jpg","description":"\\u597d\\u73a9","price":"100000","warehouse_code":"","is_ecp":0,"commission":12300,"sku_id":""},{"id":"6","name":"\\u8d85\\u725b\\u7535\\u89c6","num":"1","image":"\\/uploads\\/20160715\\/5788b204be90d.jpg","description":"\\u725b\\u725b\\u7684\\u7535\\u89c6","price":"300000","warehouse_code":"","is_ecp":0,"commission":0,"sku_id":""}]', 0, 1, 0, '', 0, 0, 0, 0, '', '', 0, 0, 2, 0, 12300, 0, 0, 410000, '', 0, NULL, 0, '', 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_order_shop`
--

CREATE TABLE IF NOT EXISTS `hx_mall_order_shop` (
  `id` int(10) unsigned NOT NULL COMMENT '单独商品订单ID',
  `order_number` varchar(32) NOT NULL COMMENT '关联订单编号',
  `good_number` varchar(32) NOT NULL COMMENT '单独商品订单编号',
  `good_id` int(10) NOT NULL COMMENT '商品ID',
  `good_name` char(100) NOT NULL COMMENT '商品名称',
  `good_image` varchar(500) NOT NULL COMMENT '商品缩略图',
  `good_description` varchar(200) NOT NULL COMMENT '商品描述',
  `good_price` int(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `hx_mall_order_shop`
--

INSERT INTO `hx_mall_order_shop` (`id`, `order_number`, `good_number`, `good_id`, `good_name`, `good_image`, `good_description`, `good_price`) VALUES
(1, 'P160715185309395', 'G160715185309246', 5, '华为C213', '/uploads/20160715/578885ace25a2.jpg', '这个手机还行', 10000),
(2, 'P160715185309395', 'G160715185309384', 4, 'B142', '/uploads/20160715/57888ba0e50ce.jpg', '好玩', 100000),
(3, 'P160715185309395', 'G160715185309874', 6, '超牛电视', '/uploads/20160715/5788b204be90d.jpg', '牛牛的电视', 300000);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_refund`
--

CREATE TABLE IF NOT EXISTS `hx_mall_refund` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `mobile` varchar(16) DEFAULT NULL,
  `order_number` varchar(32) NOT NULL,
  `sku_id` varchar(32) NOT NULL,
  `good_id` int(10) unsigned NOT NULL COMMENT '商品表id',
  `type` tinyint(1) NOT NULL COMMENT '1:退货退款 2:仅退款',
  `good_status` tinyint(1) NOT NULL COMMENT '1:拒收，2:商品已退回',
  `reason` tinyint(1) NOT NULL COMMENT '1:未收到货2:未按约定时间发货3:协商一致退款4:缺货5:收到商品破损6:商品错发漏发7:收到商品与描述不符8:质量问题9:多拍错拍不想要了',
  `first_at` int(11) NOT NULL,
  `first_note` varchar(256) DEFAULT NULL,
  `first_money` int(10) NOT NULL,
  `first_admin_note` varchar(256) DEFAULT NULL,
  `second_at` int(11) DEFAULT NULL,
  `second_note` varchar(256) DEFAULT NULL,
  `second_money` int(10) DEFAULT NULL,
  `second_admin_note` varchar(256) DEFAULT NULL,
  `third_at` int(11) DEFAULT NULL,
  `third_note` varchar(256) DEFAULT NULL,
  `third_money` int(10) DEFAULT NULL,
  `third_admin_note` varchar(256) DEFAULT NULL,
  `step_status` enum('first','second','third') DEFAULT 'first' COMMENT '步进状态123标识',
  `over_time` int(11) DEFAULT NULL,
  `check_username` varchar(32) NOT NULL,
  `admin_note` varchar(1024) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '1.买家提出申请4.卖家同意申请5.卖家收到退货9.卖家已打款',
  `create_at` int(11) NOT NULL,
  `check_at` int(11) DEFAULT NULL,
  `refond_num` int(2) NOT NULL DEFAULT '1' COMMENT '退款数量',
  `updated_at` int(11) NOT NULL,
  `proved_at` int(10) unsigned NOT NULL COMMENT '审核通过时间',
  `returned_at` int(10) unsigned NOT NULL COMMENT '货品回仓时间',
  `paid_at` int(10) unsigned NOT NULL COMMENT '卖家打款时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_spread`
--

CREATE TABLE IF NOT EXISTS `hx_mall_spread` (
  `id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合伙人id(推广人)',
  `fans_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '被推广人',
  `money` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '推广佣金',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '推广佣金状态: 0-冻结, 1-可提取',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_tag`
--

CREATE TABLE IF NOT EXISTS `hx_mall_tag` (
  `id` mediumint(8) unsigned NOT NULL,
  `tag` varchar(32) NOT NULL COMMENT '标签名称',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_tag`
--

INSERT INTO `hx_mall_tag` (`id`, `tag`, `status`) VALUES
(4, 'LED', 0),
(5, 'ULED', 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_workcard`
--

CREATE TABLE IF NOT EXISTS `hx_mall_workcard` (
  `id` int(11) NOT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `type` varchar(32) NOT NULL COMMENT '服务类型  install=安装 repair=维修',
  `create_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '申请时间',
  `need_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '客户期望时间',
  `sub_type` varchar(32) NOT NULL COMMENT '子类型 可空 (安装方式:1-挂装, 2-坐装)',
  `note` varchar(1024) NOT NULL COMMENT '用户备注',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0',
  `address` varchar(256) NOT NULL COMMENT '详细地址',
  `mobile` varchar(16) NOT NULL COMMENT '联系电话',
  `contact_name` varchar(32) NOT NULL COMMENT '联系人姓名',
  `ecp_get` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'ecp拉取时间',
  `status` int(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态  0:默认  1:ecp已抓取  9:已完成',
  `progress` int(1) NOT NULL COMMENT '1买家已申请4卖家已同意9已结单',
  `sku_id` varchar(64) NOT NULL COMMENT '商品SKU',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0',
  `is_proved` tinyint(1) unsigned NOT NULL COMMENT '1通过0未通过',
  `admin_note` varchar(1024) NOT NULL,
  `receive_time` int(11) unsigned NOT NULL DEFAULT '0',
  `ecp_body` varchar(1024) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `proved_at` int(10) unsigned NOT NULL COMMENT '审核时间',
  `closed_at` int(10) unsigned NOT NULL COMMENT '结单时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_wxconfig`
--

CREATE TABLE IF NOT EXISTS `hx_mall_wxconfig` (
  `id` int(5) NOT NULL,
  `num` text NOT NULL,
  `token` text NOT NULL,
  `appid` text NOT NULL,
  `appsecret` text NOT NULL,
  `encodingaeskey` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_wxconfig`
--

INSERT INTO `hx_mall_wxconfig` (`id`, `num`, `token`, `appid`, `appsecret`, `encodingaeskey`) VALUES
(1, 'wemall', 'wemall', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_wxmenu`
--

CREATE TABLE IF NOT EXISTS `hx_mall_wxmenu` (
  `id` int(5) NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `name` varchar(10) NOT NULL,
  `key` varchar(200) NOT NULL,
  `url` varchar(300) NOT NULL,
  `pid` int(5) NOT NULL DEFAULT '0',
  `listorder` varchar(5) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_wxmenu`
--

INSERT INTO `hx_mall_wxmenu` (`id`, `type`, `name`, `key`, `url`, `pid`, `listorder`, `status`) VALUES
(1, 'click', '进入商城', 'BUY', '', 0, '1', 1),
(2, 'view', '关于我们', '', 'http://m.baidu.com', 0, '3', 1);

-- --------------------------------------------------------

--
-- 表的结构 `hx_mall_wxmessage`
--

CREATE TABLE IF NOT EXISTS `hx_mall_wxmessage` (
  `id` int(10) unsigned NOT NULL,
  `type` text NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `picurl` text NOT NULL,
  `url` text NOT NULL,
  `key` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_mall_wxmessage`
--

INSERT INTO `hx_mall_wxmessage` (`id`, `type`, `title`, `description`, `picurl`, `url`, `key`) VALUES
(1, '0', 'wemall', '欢迎来到wemall', '538d80973f66e.jpg', 'http://www.xxx.com/index.php?g=App&m=Index&a=index', 'BUY');

-- --------------------------------------------------------

--
-- 表的结构 `hx_msg_log`
--

CREATE TABLE IF NOT EXISTS `hx_msg_log` (
  `id` int(11) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  `code_style` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `result` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_msg_queue_error`
--

CREATE TABLE IF NOT EXISTS `hx_msg_queue_error` (
  `id` int(11) NOT NULL,
  `lx` int(11) NOT NULL,
  `temp_arr` varchar(255) DEFAULT NULL,
  `user_arr` varchar(255) DEFAULT NULL,
  `msg_arr` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_msg_template`
--

CREATE TABLE IF NOT EXISTS `hx_msg_template` (
  `id` int(10) unsigned NOT NULL,
  `temp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_style` int(11) NOT NULL COMMENT '1-短信模板  2-',
  `temp_class` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_variable` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_first` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `temp_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_msg_template`
--

INSERT INTO `hx_msg_template` (`id`, `temp_name`, `temp_code`, `temp_style`, `temp_class`, `temp_content`, `temp_desc`, `temp_variable`, `temp_first`, `temp_remark`, `status`) VALUES
(1, '发送注册验证码', 'reg_msg', 1, 'instant', '您的验证码是：【@verify_code@】。请不要把验证码泄露给其他人。', '用于编辑发送短信验证码的模板，可自行设计内容，验证码部分使用 @verify_code@ 代替', 'verify_code|', '', '', 1),
(2, '购买成功短信', 'buy_ok', 1, 'instant', '恭喜您，您购买的商品：@product_name@已付款成功，订单号@order_num@。', '', 'product_name|order_num', '', '', 0),
(3, '验证码下发通知', 'TM00178', 2, '', '@first@，手机动态验证码为@numbe@<br>@remark@', 'first为微信模板头，remark为微信模版尾，number为系统自动调取', 'first|number|remark', '尊敬的用户', '验证码5分钟内有效', 1),
(4, '订单发货提醒', 'OPENTM200565259', 2, '', '@first@<br>\n订单编号：@keyword1@<br>\n物流公司：@keyword2@<br>\n物流单号：@keyword3@<br>\n@remark@', 'first为微信模板头，remark为微信模版尾，keyword1-3为系统自动调取', 'first|keyword1|keyword2|keyword3|remark', '', '', 1),
(5, '售后服务处理进度提醒', 'TM00254', 2, '', '@first@<br>\r\n服务类型：@HandleType@<br>\r\n处理状态：@Status@<br>\r\n提交时间：@RowCreateDate@<br>\r\n当前进度：@LogType@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|HandleType|Status|RowCreateDate|LogType|remark', '', '', 1),
(6, '会员资料审核提醒', 'OPENTM201057607', 2, '', '@first@<br>\r\n审核结果：@keyword1@<br>\r\n原因：@keyword2@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|keyword1|keyword2|remark', '', '', 1),
(7, '商品支付成功通知', 'OPENTM202183094', 2, '', '@first@<br>\r\n付款金额：@keyword1@<br>\r\n商品详情：@keyword2@<br>\r\n支付方式：@keyword3@<br>\r\n交易单号：@keyword4@<br>\r\n交易时间：@keyword5@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|keyword1|keyword2|keyword3|keyword4|keyword5|remark', '', '', 1),
(8, '发货通知', 'deliver_msg', 1, '', '您的订单【@order_num@】已经发货，承运公司：【@express@】，快递单号【@express_num@】', '用于编辑发送发货通知信息的模板，可自行设计内容。<br>订单号使用 @order_num@ 代替，承运公司采用@express@代替，快递单号使用 @express_num@ 代替', 'order_num|express|express_num', '', '', 1),
(9, '订单未付款通知', 'TM00701', 2, '', '@frist@<br>\r\n订单金额：@orderProductPrice@<br>\r\n商品详情：@orderProductName@<br>\r\n收货信息：@orderAddress@<br>\r\n订单编号：@orderName@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|orderProductPrice|orderProductName|orderAddress|orderName|remark', '', '', 1),
(10, '优惠券到期提醒', 'coupon_expire', 1, '', '您有一张优惠券【@coupon@】将于【@expire_time@】过期，请尽快使用！', '用于编辑发送优惠券过期提醒的模板，可自行设计内容。<br>\n优惠券名称使用@coupon@代替，过期时间使用@expire_time@代替', 'coupon|expire_time', '', '', 1),
(11, '电子发票开票成功提醒', 'invoice_remind', 1, '', '尊敬的用户，您的订单【@order_number@】电子发票已开票成功，请登录查询！', '用于编辑发送发货通知信息的模板，可自行设计内容。<br>订单号使用 @order_num@ 代替', 'order_number|', '', '', 1),
(12, '订单未付款通知', 'TM00427', 2, '', '@first@<br>\r\n订单金额：@orderProductPrice@<br>\r\n商品详情：@orderProductName@<br>\r\n收货信息：@orderAddress@<br>\r\n订单编号：@orderName@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|orderProductPrice|orderProductName|orderAddress|orderName|remark', '您好，您有一笔订单已经可以正式付款了。', '现在付款，商家可更快发货！', 1),
(13, '审核成功通知', 'OPENTM206164559', 2, '', '@first@<br>\r\n用户名：@keyword1@<br>\r\n标题：@keyword2@<br>\r\n时间：@keyword3@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|keyword1|keyword2|keyword3|remark', '', '', 1),
(14, '订单改价通知', 'OPENTM203998003', 2, '', '@first@<br>\r\n订单号：@keyword1@<br>\r\n商品名称：@keyword2@<br>\r\n下单时间：@keyword3@<br>\r\n订单总价：@keyword4@<br>\r\n订单状态：@keyword5@<br>\r\n@remark@', 'first为微信模板头，remark为微信模版尾，其余参数为系统自动调取', 'first|keyword1|keyword2|keyword3|keyword4|keyword5|remark', '', '', 1);

-- --------------------------------------------------------

--
-- 表的结构 `hx_msg_wechat_template`
--

CREATE TABLE IF NOT EXISTS `hx_msg_wechat_template` (
  `id` int(10) unsigned NOT NULL,
  `template_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `template_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `use_times` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_msg_wechat_template`
--

INSERT INTO `hx_msg_wechat_template` (`id`, `template_code`, `template_id`, `use_times`) VALUES
(15, 'OPENTM201057607', '', 34),
(16, 'TM00427', '', 77),
(17, 'OPENTM206164559', '', 3),
(13, 'OPENTM200565259', '', 79),
(14, 'OPENTM202183094', '', 80);

-- --------------------------------------------------------

--
-- 表的结构 `hx_msj_operation_log`
--

CREATE TABLE IF NOT EXISTS `hx_msj_operation_log` (
  `operation_log` int(8) unsigned NOT NULL COMMENT '操作记录主键',
  `operation_uid` int(4) unsigned NOT NULL DEFAULT '0' COMMENT '操作人/如果是接口返回-1暂不记录接口请求人',
  `operation_node` char(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '操作节点',
  `operation_ip` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '记录操作IP,省市,等信息',
  `operation_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_operate_log`
--

CREATE TABLE IF NOT EXISTS `hx_operate_log` (
  `id` bigint(20) unsigned NOT NULL,
  `table_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '对应的记录的主键id',
  `table_name` varchar(100) NOT NULL COMMENT '对应操作的表名',
  `admin_uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作人',
  `type` tinyint(1) NOT NULL COMMENT '1-insert, 2-update, 3-delete',
  `content` text NOT NULL,
  `create_time` datetime NOT NULL COMMENT '操作时间'
) ENGINE=MyISAM AUTO_INCREMENT=150 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_operate_log`
--

INSERT INTO `hx_operate_log` (`id`, `table_id`, `table_name`, `admin_uid`, `type`, `content`, `create_time`) VALUES
(1, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 10:56:42'),
(2, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 11:04:48'),
(3, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 11:08:44'),
(4, 3003, 'user', 7, 2, '{"uid":"3003","openid":"oa5IFt2hVDiuzqJOioO80BWMKQYQ","nickname":"\\u897f\\u6606\\u4ed1","sex":"1","city":"\\u9752\\u5c9b","country":"\\u4e2d\\u56fd","province":"\\u5c71\\u4e1c","language":"zh_CN","headimgurl":"http:\\/\\/wx.qlogo.cn\\/mmopen\\/6wNdlqwWJHlHoq3jENZNGvCZYrJia8I817cW7LE9gicBUKUsvYsvTQX1tB04VfibebovyNcvfmqhyty1L1pUamm8uU2JicZrwibpM\\/0","subscribe":"0","subscribe_time":"1451979163","unionid":"","remark":"","groupid":"0","realname":"\\u897f\\u6606\\u4ed1","phone":"15288838788","reason":"\\u540c\\u610f","credit":"0","balance":"0","award":"0","invite_id":"3123","qrcode":"","label_id":"0","tag_id":"","group_id":"0","create_time":"1447234294","apply_time":"1453433653","audit_time":"1449751602","update_time":"1451979163","check_status":"9","check_reason":"test","partner_status":"9","commission_status":"1","client_ip":"","address":"","qq":"468012316","user_info_temp":"a:6:{s:8:\\"realname\\";s:9:\\"\\u897f\\u6606\\u4ed1\\";s:5:\\"phone\\";s:11:\\"15288838788\\";s:2:\\"qq\\";s:9:\\"468012316\\";s:7:\\"pay_way\\";s:6:\\"alipay\\";s:7:\\"account\\";s:16:\\"yht_0616@126.com\\";s:11:\\"authen_name\\";s:9:\\"\\u95eb\\u6000\\u5802\\";}"}', '2016-01-22 11:34:29'),
(5, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 15:02:59'),
(6, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 15:03:11'),
(7, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-22 15:29:36'),
(8, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 09:33:11'),
(9, 3003, 'user', 7, 2, '{"uid":"3003","openid":"oa5IFt2hVDiuzqJOioO80BWMKQYQ","nickname":"\\u897f\\u6606\\u4ed1","sex":"1","city":"\\u9752\\u5c9b","country":"\\u4e2d\\u56fd","province":"\\u5c71\\u4e1c","language":"zh_CN","headimgurl":"http:\\/\\/wx.qlogo.cn\\/mmopen\\/6wNdlqwWJHlHoq3jENZNGvCZYrJia8I817cW7LE9gicBUKUsvYsvTQX1tB04VfibebovyNcvfmqhyty1L1pUamm8uU2JicZrwibpM\\/0","subscribe":"0","subscribe_time":"1451979163","unionid":"","remark":"","groupid":"0","realname":"\\u95eb\\u6000\\u5802","phone":"15288838788","reason":"\\u540c\\u610f","credit":"0","balance":"0","award":"0","invite_id":"3123","qrcode":"","label_id":"0","tag_id":"","group_id":"0","create_time":"1447234294","apply_time":"1453685570","audit_time":"1449751602","update_time":"1451979163","check_status":"9","check_reason":"test1","partner_status":"9","commission_status":"1","client_ip":"","address":"","qq":"468012316","user_info_temp":"a:6:{s:8:\\"realname\\";s:9:\\"\\u95eb\\u6000\\u5802\\";s:5:\\"phone\\";s:11:\\"15288838788\\";s:2:\\"qq\\";s:9:\\"468012316\\";s:7:\\"pay_way\\";s:6:\\"alipay\\";s:7:\\"account\\";s:16:\\"yht_0616@126.com\\";s:11:\\"authen_name\\";s:9:\\"\\u95eb\\u6000\\u5802\\";}"}', '2016-01-25 09:34:30'),
(10, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 09:43:56'),
(11, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 10:38:58'),
(12, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 11:21:38'),
(13, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 13:51:10'),
(14, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 13:54:31'),
(15, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 16:15:34'),
(16, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-25 16:52:02'),
(17, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-26 09:29:47'),
(18, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-26 13:13:12'),
(19, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-26 17:00:18'),
(20, 12042, 'user', 7, 2, '{"uid":"12042","openid":"oa5IFtzADjBBLIkIchhPTqu0Mmn8","nickname":"\\u5fc3\\u610f","sex":"1","city":"\\u6dc4\\u535a","country":"\\u4e2d\\u56fd","province":"\\u5c71\\u4e1c","language":"zh_CN","headimgurl":"http:\\/\\/wx.qlogo.cn\\/mmopen\\/6wNdlqwWJHlHoq3jENZNGpIqFIRc0IHlqvvIAG08WTfaQbZZWMeobUu0GG6ib2e8uib5IA0KiavviartIzYC7EsKtMUYQzcWPUjd\\/0","subscribe":"0","subscribe_time":"1438305760","unionid":"","remark":"","groupid":"0","realname":"\\u5cb3\\u5174\\u653e","phone":"18905337886","reason":"","credit":"0","balance":"0","award":"0","invite_id":"0","qrcode":"","label_id":"0","tag_id":"","group_id":"0","create_time":"1438305760","apply_time":"1453640790","audit_time":"1438492569","update_time":"0","check_status":"9","check_reason":"ok","partner_status":"9","commission_status":"1","client_ip":"","address":"","qq":"728385937","user_info_temp":"a:6:{s:8:\\"realname\\";s:9:\\"\\u5cb3\\u5174\\u653e\\";s:5:\\"phone\\";s:11:\\"18905337886\\";s:2:\\"qq\\";s:9:\\"728385937\\";s:7:\\"pay_way\\";s:6:\\"alipay\\";s:7:\\"account\\";s:11:\\"xiaoyue0008\\";s:11:\\"authen_name\\";s:9:\\"\\u5cb3\\u5174\\u653e\\";}"}', '2016-01-26 17:01:59'),
(21, 15854, 'user', 7, 2, '{"uid":"15854","openid":"oa5IFt8BRqyeGwMbNxd6vmlud0ts","nickname":"\\u8042\\u4fee\\u56fd","sex":"1","city":"\\u4e1c\\u8425","country":"\\u4e2d\\u56fd","province":"\\u5c71\\u4e1c","language":"zh_CN","headimgurl":"http:\\/\\/wx.qlogo.cn\\/mmopen\\/Gzh98jzNDbYAria8VIOPIRPgficRdgZabTrzQjBG4Eqic2wePRO6MSP5pvL1wGe2zW7Bp0xs2mE9QlA6TaKk4nLbxpJibicxq0VwG\\/0","subscribe":"1","subscribe_time":"1453335706","unionid":"","remark":"","groupid":"0","realname":"\\u8042\\u4fee\\u56fd","phone":"18854623168","reason":"","credit":"0","balance":"0","award":"0","invite_id":"0","qrcode":"","label_id":"0","tag_id":"","group_id":"0","create_time":"1452170975","apply_time":"1453472140","audit_time":"1453336147","update_time":"1453335706","check_status":"9","check_reason":"ok","partner_status":"9","commission_status":"0","client_ip":"117.136.78.172","address":"","qq":"1105810599","user_info_temp":"a:6:{s:8:\\"realname\\";s:9:\\"\\u8042\\u4fee\\u56fd\\";s:5:\\"phone\\";s:11:\\"18854623168\\";s:2:\\"qq\\";s:10:\\"1105810599\\";s:7:\\"pay_way\\";s:6:\\"alipay\\";s:7:\\"account\\";s:11:\\"15351671968\\";s:11:\\"authen_name\\";s:9:\\"\\u8042\\u4fee\\u56fd\\";}"}', '2016-01-26 17:01:59'),
(22, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-27 09:27:19'),
(23, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-27 13:14:38'),
(24, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-27 15:55:23'),
(25, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-28 09:24:16'),
(26, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-28 11:16:09'),
(27, 7, 'wechat_reply', 7, 1, '{"id":"7","type":"text","precision":"0","keyword":"\\u4f60\\u597d","content":"\\u4f60\\u597d\\uff0c\\u6b22\\u8fce\\u52a0\\u5165\\u6d77\\u4fe1\\u5408\\u4f19\\u4eba","create_time":"1453951015","update_time":"1453951015"}', '2016-01-28 11:16:55'),
(28, 3, 'wechat_reply', 7, 2, '{"id":"3","type":"subscribe","precision":"0","keyword":"","content":"\\u6b22\\u8fce\\u52a0\\u5165\\u6d77\\u4fe1\\u5408\\u4f19\\u4eba\\uff0c\\u8fd9\\u662f\\u6d77\\u4fe1\\u4e0e\\u7c89\\u4e1d\\u7684\\u4e92\\u52a8\\u5e73\\u53f0\\uff0c\\u8ba9\\u6211\\u4eec\\u7545\\u6240\\u6b32\\u8a00\\uff0c\\u540c\\u8fdb\\u6b65\\u5171\\u8d62\\u5229\\uff01","create_time":"1452588123","update_time":"1453951069"}', '2016-01-28 11:17:49'),
(29, 3, 'wechat_reply', 7, 2, '{"id":"3","type":"subscribe","precision":"0","keyword":"","content":"\\u6b22\\u8fce\\u52a0\\u5165\\u6d77\\u4fe1\\u5408\\u4f19\\u4eba\\uff0c\\u8fd9\\u662f\\u6d77\\u4fe1\\u4e0e\\u7c89\\u4e1d\\u7684\\u4e92\\u52a8\\u5e73\\u53f0\\uff0c\\u8ba9\\u6211\\u4eec\\u7545\\u6240\\u6b32\\u8a00\\uff0c\\u540c\\u8fdb\\u6b65\\u5171\\u8d62\\u5229\\uff01","create_time":"1452588123","update_time":"1453951097"}', '2016-01-28 11:18:17'),
(30, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-28 13:23:01'),
(31, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-28 17:05:59'),
(32, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 09:42:53'),
(33, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 10:04:08'),
(34, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 11:01:40'),
(35, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 11:15:11'),
(36, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 15:05:17'),
(37, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-01-29 16:07:50'),
(38, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 09:37:51'),
(39, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 10:05:41'),
(40, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 10:06:44'),
(41, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 11:28:12'),
(42, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 13:23:42'),
(43, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 13:48:39'),
(44, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 14:12:42'),
(45, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-01 16:04:29'),
(46, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-02 10:28:32'),
(47, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-03 10:14:41'),
(48, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-03 10:41:41'),
(49, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-03 14:27:01'),
(50, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-04 09:41:13'),
(51, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-15 09:04:01'),
(52, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-15 13:25:11'),
(53, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-15 14:48:49'),
(54, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-15 15:38:57'),
(55, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-02-17 14:04:21'),
(56, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"d13c52be6f9de62f46e2646256659c86","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:11:21'),
(57, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:24:25'),
(58, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:25:06'),
(59, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:26:20'),
(60, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:27:28'),
(61, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:31:44'),
(62, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:34:58'),
(63, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:42:56'),
(64, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:48:56'),
(65, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:49:11'),
(66, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:49:31'),
(67, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 10:57:43'),
(68, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-17 11:49:04'),
(69, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 09:23:41'),
(70, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 10:48:28'),
(71, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 10:56:33'),
(72, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 10:59:52'),
(73, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 11:09:49'),
(74, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 11:55:58'),
(75, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 11:57:07'),
(76, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 11:58:14'),
(77, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 11:59:02'),
(78, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 12:00:03'),
(79, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 12:01:00'),
(80, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 12:01:30'),
(81, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 12:02:57'),
(82, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 12:04:36'),
(83, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 13:40:58'),
(84, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:04:04'),
(85, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:12:14'),
(86, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:16:36'),
(87, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:17:37'),
(88, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:17:50'),
(89, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:20:33'),
(90, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:22:29'),
(91, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 14:29:01'),
(92, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-18 16:59:44'),
(93, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 09:27:45'),
(94, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 10:38:13'),
(95, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 11:32:50'),
(96, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 11:34:42'),
(97, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 13:44:26'),
(98, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 15:47:45'),
(99, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-21 16:24:11'),
(100, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-22 09:33:25'),
(101, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-22 11:24:18'),
(102, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-03-22 13:29:14'),
(103, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-06-16 10:27:51'),
(104, 12, 'attribute', 7, 2, '{"id":"12","type":"commission_spread","title":"\\u63a8\\u5e7f\\u4f63\\u91d1\\u8bbe\\u7f6e","value":"{\\"spread\\":1,\\"withdraw\\":10}","status":"0","sort":"0"}', '2016-06-16 10:56:48'),
(105, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 11:09:52'),
(106, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 11:10:14'),
(107, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 11:10:11'),
(108, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 11:30:17'),
(109, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 11:36:29'),
(110, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 14:24:16'),
(111, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 14:42:48'),
(112, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 14:45:49'),
(113, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 15:16:32'),
(114, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 15:21:12'),
(115, 1, 'mall_good', 7, 1, '{"id":"1","pid":"2","menu_id":"3","group_id":"4","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"1","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"10","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-13 15:56:18'),
(116, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"4","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"1","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"12","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-13 16:48:09'),
(117, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 18:56:12');
INSERT INTO `hx_operate_log` (`id`, `table_id`, `table_name`, `admin_uid`, `type`, `content`, `create_time`) VALUES
(118, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-13 19:36:23'),
(119, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 10:02:20'),
(120, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"4","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"1","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"14","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 10:07:57'),
(121, 1, 'mall_good', 7, 2, '{"id":"1","pid":"6","menu_id":"6","group_id":"4","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"100","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"14","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 10:08:31'),
(122, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 11:08:07'),
(123, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 11:30:15'),
(124, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 14:28:29'),
(125, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 14:41:42'),
(126, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"1","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"100","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 14:43:50'),
(127, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 16:32:12'),
(128, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-14 16:40:06'),
(129, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"1","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"90","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"1","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 16:40:25'),
(130, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"1","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"90","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"1","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 16:48:39'),
(131, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"400","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"90","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"1","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 16:51:15'),
(132, 1, 'mall_good', 7, 2, '{"id":"1","pid":"8","menu_id":"13","group_id":"400","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"90","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"1","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 17:16:58'),
(133, 1, 'mall_good', 7, 2, '{"id":"1","pid":"13","menu_id":"14","group_id":"400","name":"\\u6d77\\u738b\\u7535\\u89c6\\u673a","spec":"42\\u5bf8","promotion":"\\u4e70\\u4e00\\u9001\\u4e00","description":"\\u6781\\u81f4LED\\u4f53\\u9a8c","price":"428800","old_price":"430000","image":"","detail":"&lt;p&gt;\\u5185\\u5bb9\\u6d4b\\u8bd5&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"90","sales_volume":"0","tags":"4","shelves_time":"1468396578","create_time":"1468396578","sort":"1","status":"1","commission":"20000","code_69":"","show_images":"[\\"\\\\\\/uploads\\\\\\/nullnull\\"]","sku_name":"","click":"16","top":"1","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 17:33:24'),
(134, 2, 'mall_good', 7, 1, '{"id":"2","pid":"13","menu_id":"14","group_id":"400","name":"\\u534e\\u4e09\\u5927\\u7535\\u89c6","spec":"43\\u5bf8","promotion":"\\u4e7010\\u90011","description":"\\u98de\\u4e00\\u822c\\u7684\\u4eab\\u53d7","price":"410000","old_price":"420000","image":"","detail":"&lt;p&gt;\\u534e\\u4e09 \\u7535\\u89c6\\u554a&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"100","sales_volume":"0","tags":"4","shelves_time":"1468490810","create_time":"1468490810","sort":"1","status":"1","commission":"1000","code_69":"","show_images":"null","sku_name":"","click":"10","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":"1"}', '2016-07-14 18:06:50'),
(135, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 09:25:25'),
(136, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 09:30:49'),
(137, 3, 'mall_good', 7, 1, '{"id":"3","pid":"13","menu_id":"14","group_id":"400","name":"\\u5927\\u7535\\u89c6","spec":"85\\u5bf8","promotion":"\\u4e7020\\u90011","description":"\\u8d85\\u7ea7\\u5927\\u7535\\u89c6","price":"80000000","old_price":"90000000","image":"","detail":"&lt;p&gt;\\u5927\\u7535\\u89c6&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"200","sales_volume":"0","tags":"4","shelves_time":"1468547188","create_time":"1468547188","sort":"0","status":"1","commission":"20000","code_69":"","show_images":"null","sku_name":"","click":"200","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 09:46:28'),
(138, 4, 'mall_good', 7, 1, '{"id":"4","pid":"15","menu_id":"18","group_id":"3","name":"B142","spec":"4.2\\u5bf8","promotion":"\\u4e701 \\u90010","description":"\\u597d\\u73a9","price":"100000","old_price":"1000000","image":"","detail":"&lt;p&gt;123&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"123","sales_volume":"0","tags":"4","shelves_time":"1468549295","create_time":"1468549295","sort":"0","status":"1","commission":"12300","code_69":"","show_images":"null","sku_name":"","click":"123","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 10:21:35'),
(139, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 11:06:36'),
(140, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 12:08:00'),
(141, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 12:39:47'),
(142, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 14:03:29'),
(143, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 14:17:00'),
(144, 5, 'mall_good', 7, 1, '{"id":"5","pid":"15","menu_id":"18","group_id":"2","name":"\\u534e\\u4e3aC213","spec":"3.2","promotion":"\\u4e70\\u4e00\\u9001\\u4ee5","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","old_price":"10000","image":"20160715\\/578885ace25a2.jpg","detail":"&lt;p&gt;\\u6d4b\\u8bd5\\u600e\\u4e48\\u6837&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"100","sales_volume":"0","tags":"4","shelves_time":"1468564908","create_time":"1468564908","sort":"1","status":"1","commission":"10000","code_69":"","show_images":"null","sku_name":"","click":"100","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 14:41:48'),
(145, 4, 'mall_good', 7, 2, '{"id":"4","pid":"15","menu_id":"18","group_id":"3","name":"B142","spec":"4.2\\u5bf8","promotion":"\\u4e701 \\u90010","description":"\\u597d\\u73a9","price":"100000","old_price":"1000000","image":"20160715\\/57888ba0e50ce.jpg","detail":"&lt;p&gt;123&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"123","sales_volume":"0","tags":"4","shelves_time":"1468549295","create_time":"1468549295","sort":"0","status":"1","commission":"12300","code_69":"","show_images":"null","sku_name":"","click":"123","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 15:07:12'),
(146, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"e10adc3949ba59abbe56e057f20f883e","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 15:55:39'),
(147, 7, 'auth_user', 7, 2, '{"user_id":"7","fid":"0","username":"admin","password":"4e4b792b68432d7035ff8ac86dfa1629","nickname":"gaorenhua","regdate":"1444826229","lastdate":"1449546031","regip":"127.0.0.1","lastip":"172.16.13.184","loginnum":"245","email":"597170962@qq.com","message":"0","islock":"0","vip":"0","overduedate":"0","mobile":"15318776618","role_id":"0"}', '2016-07-15 17:43:08'),
(148, 5, 'mall_good', 7, 2, '{"id":"5","pid":"15","menu_id":"18","group_id":"2","name":"\\u534e\\u4e3aC213","spec":"3.2","promotion":"\\u4e70\\u4e00\\u9001\\u4ee5","description":"\\u8fd9\\u4e2a\\u624b\\u673a\\u8fd8\\u884c","price":"10000","old_price":"10000","image":"20160715\\/578885ace25a2.jpg","detail":"&lt;p&gt;\\u6d4b\\u8bd5\\u600e\\u4e48\\u6837&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"92","sales_volume":"0","tags":"4","shelves_time":"1468564908","create_time":"1468564908","sort":"1","status":"1","commission":"0","code_69":"","show_images":"null","sku_name":"","click":"125","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 17:48:51'),
(149, 6, 'mall_good', 7, 1, '{"id":"6","pid":"13","menu_id":"14","group_id":"0","name":"\\u8d85\\u725b\\u7535\\u89c6","spec":"42\\u5bf8","promotion":"\\u4e7010\\u4e2a\\u90011\\u4e2a","description":"\\u725b\\u725b\\u7684\\u7535\\u89c6","price":"300000","old_price":"300000","image":"20160715\\/5788b204be90d.jpg","detail":"&lt;p&gt;\\u6d4b\\u8bd5\\u5546\\u54c1&lt;\\/p&gt;","sku_id":"","is_ecp":"0","stock":"100","sales_volume":"0","tags":"4","shelves_time":"1468576260","create_time":"1468576260","sort":"1","status":"1","commission":"0","code_69":"","show_images":"null","sku_name":"","click":"100","top":"0","with_invoice":"0","prompt":"","on_time":"0","off_time":"0","ad_ids":""}', '2016-07-15 17:51:00');

-- --------------------------------------------------------

--
-- 表的结构 `hx_reward_task`
--

CREATE TABLE IF NOT EXISTS `hx_reward_task` (
  `id` mediumint(8) unsigned NOT NULL,
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_by` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建者'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_reward_task`
--

INSERT INTO `hx_reward_task` (`id`, `start_time`, `end_time`, `create_time`, `create_by`) VALUES
(1, 1451577600, 1454169600, 1452237850, 7),
(2, 1448899200, 1451577600, 1452568266, 7),
(3, 1438358400, 1440950400, 1453104936, 7);

-- --------------------------------------------------------

--
-- 表的结构 `hx_reward_task_data`
--

CREATE TABLE IF NOT EXISTS `hx_reward_task_data` (
  `id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户uid',
  `task_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '奖励任务id',
  `product_commission` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售佣金',
  `spread_commission` int(10) NOT NULL,
  `fans_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '粉丝数量'
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_reward_task_data`
--

INSERT INTO `hx_reward_task_data` (`id`, `uid`, `task_id`, `product_commission`, `spread_commission`, `fans_num`) VALUES
(1, 15005, 1, 15000, 5000, 1),
(2, 14452, 1, 5000, 0, 0),
(3, 5440, 1, 5000, 0, 0),
(4, 11703, 1, 5000, 0, 0),
(5, 3931, 1, 100, 65000, 13),
(6, 2937, 2, 0, 165000, 25),
(7, 11077, 2, 20000, 155000, 30),
(8, 13587, 2, 0, 70000, 14),
(9, 14788, 2, 0, 70000, 13),
(10, 13440, 2, 0, 65000, 12),
(11, 15032, 2, 0, 50000, 8),
(12, 850, 2, 5000, 45000, 9),
(13, 5794, 2, 5000, 45000, 9),
(14, 526, 2, 0, 40000, 8),
(15, 14452, 2, 0, 30000, 4),
(16, 3003, 2, 200, 30000, 7),
(17, 9371, 2, 0, 25000, 6),
(18, 325, 2, 0, 20000, 3),
(19, 9378, 2, 0, 20000, 3),
(20, 5531, 2, 15000, 20000, 5),
(21, 13628, 2, 0, 20000, 2),
(22, 11313, 2, 0, 20000, 3),
(23, 14326, 2, 0, 20000, 4),
(24, 7276, 2, 0, 15000, 1),
(25, 7679, 2, 0, 15000, 3),
(26, 13812, 2, 0, 15000, 3),
(27, 7817, 2, 0, 15000, 3),
(28, 14605, 2, 0, 15000, 3),
(29, 13029, 2, 15000, 10000, 2),
(30, 14703, 2, 0, 10000, 2),
(31, 13917, 2, 0, 10000, 1),
(32, 9005, 2, 0, 10000, 2),
(33, 15176, 2, 0, 10000, 2),
(34, 841, 2, 0, 10000, 2),
(35, 5012, 2, 0, 10000, 2),
(36, 2533, 2, 0, 10000, 2),
(37, 9262, 2, 0, 10000, 1),
(38, 7983, 2, 0, 10000, 2),
(39, 14942, 2, 0, 10000, 2),
(40, 13773, 2, 0, 5000, 1),
(41, 3330, 2, 0, 5000, 1),
(42, 9886, 2, 0, 5000, 1),
(43, 8064, 2, 0, 5000, 1),
(44, 14065, 2, 0, 5000, 1),
(45, 5297, 2, 0, 5000, 1),
(46, 2916, 2, 5000, 5000, 0),
(47, 4155, 2, 0, 5000, 1),
(48, 13130, 2, 0, 5000, 1),
(49, 14711, 2, 0, 5000, 1),
(50, 1018, 2, 0, 5000, 1),
(51, 10230, 2, 0, 5000, 1),
(52, 8831, 2, 0, 5000, 1),
(53, 14105, 2, 0, 5000, 0),
(54, 5440, 2, 0, 5000, 1),
(55, 13603, 2, 0, 5000, 1),
(56, 15163, 2, 0, 5000, 1),
(57, 11088, 2, 0, 5000, 1),
(58, 9485, 2, 0, 5000, 1),
(59, 14556, 2, 0, 5000, 1),
(60, 7735, 2, 0, 5000, 1),
(61, 4318, 2, 0, 5000, 1),
(62, 13377, 2, 0, 5000, 1),
(63, 14729, 2, 0, 5000, 1),
(64, 1879, 2, 0, 5000, 1),
(65, 10420, 2, 0, 5000, 1),
(66, 14146, 2, 0, 5000, 1),
(67, 9552, 2, 0, 5000, 1),
(68, 14583, 2, 0, 5000, 1),
(69, 13986, 2, 0, 5000, 1),
(70, 10863, 2, 0, 5000, 1),
(71, 13636, 2, 0, 5000, 1),
(72, 15366, 2, 0, 5000, 1),
(73, 3128, 2, 0, 5000, 1),
(74, 12435, 2, 0, 5000, 1),
(75, 846, 2, 100, 5000, 1),
(76, 9642, 2, 0, 5000, 1),
(77, 14022, 2, 0, 5000, 1),
(78, 5295, 2, 0, 5000, 1),
(79, 13573, 2, 0, 5000, 0),
(80, 2732, 2, 20000, 5000, 1),
(81, 11050, 2, 5000, 5000, 1),
(82, 14450, 2, 10000, 5000, 1),
(83, 1352, 3, 0, 0, 0),
(84, 10013, 3, 0, 0, 0),
(85, 4429, 3, 0, 0, 0),
(86, 3273, 3, 0, 0, 0),
(87, 7515, 3, 0, 0, 0),
(88, 12105, 3, 0, 0, 0),
(89, 1882, 3, 0, 0, 0),
(90, 9986, 3, 0, 0, 0),
(91, 4590, 3, 0, 0, 0),
(92, 228, 3, 0, 0, 0),
(93, 11989, 3, 0, 0, 0),
(94, 1820, 3, 0, 0, 0),
(95, 1676, 3, 0, 0, 0),
(96, 11313, 3, 0, 0, 0),
(97, 8153, 3, 0, 0, 0),
(98, 12537, 3, 0, 0, 0),
(99, 13535, 3, 0, 0, 0),
(100, 4228, 3, 0, 0, 0),
(101, 12390, 3, 0, 0, 0),
(102, 11890, 3, 0, 0, 0),
(103, 1203, 3, 0, 0, 0),
(104, 5300, 3, 0, 0, 0),
(105, 11623, 3, 0, 0, 0),
(106, 4838, 3, 0, 0, 0),
(107, 11251, 3, 0, 0, 0),
(108, 9632, 3, 0, 0, 0),
(109, 8553, 3, 0, 0, 0),
(110, 8870, 3, 0, 0, 0),
(111, 2975, 3, 0, 0, 0),
(112, 8005, 3, 0, 0, 0),
(113, 8722, 3, 0, 0, 0),
(114, 5556, 3, 0, 0, 0),
(115, 11684, 3, 0, 0, 0),
(116, 5260, 3, 0, 0, 0),
(117, 3544, 3, 0, 0, 0),
(118, 7654, 3, 0, 0, 0),
(119, 3612, 3, 0, 0, 0),
(120, 12370, 3, 0, 0, 0),
(121, 5806, 3, 0, 0, 0),
(122, 5380, 3, 0, 0, 0),
(123, 1936, 3, 0, 0, 0),
(124, 11618, 3, 0, 0, 0),
(125, 1338, 3, 0, 0, 0),
(126, 5815, 3, 0, 0, 0),
(127, 11548, 3, 0, 0, 0),
(128, 13179, 3, 0, 0, 0),
(129, 11217, 3, 0, 0, 0),
(130, 12176, 3, 0, 0, 0),
(131, 12419, 3, 0, 0, 0),
(132, 2279, 3, 0, 0, 0),
(133, 8814, 3, 0, 0, 0),
(134, 11331, 3, 0, 0, 0),
(135, 7423, 3, 0, 0, 0),
(136, 2219, 3, 0, 0, 0),
(137, 7901, 3, 0, 0, 0),
(138, 2939, 3, 0, 0, 0),
(139, 3046, 3, 0, 0, 0),
(140, 7150, 3, 0, 0, 0),
(141, 11478, 3, 0, 0, 0),
(142, 8237, 3, 0, 0, 0),
(143, 2186, 3, 0, 0, 0),
(144, 10260, 3, 0, 0, 0),
(145, 7374, 3, 0, 0, 0),
(146, 1310, 3, 0, 0, 0),
(147, 6968, 3, 0, 0, 0),
(148, 13054, 3, 0, 0, 0),
(149, 11842, 3, 0, 0, 0),
(150, 12910, 3, 0, 0, 0),
(151, 10820, 3, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `hx_shipping_route`
--

CREATE TABLE IF NOT EXISTS `hx_shipping_route` (
  `id` int(10) NOT NULL,
  `order_id` varchar(32) NOT NULL COMMENT '订单号',
  `order_number` varchar(64) NOT NULL,
  `way_bill_no` varchar(16) NOT NULL COMMENT '运单号',
  `logistics_id` varchar(32) NOT NULL COMMENT '快递名称 顺丰SFExpress',
  `routes` text NOT NULL COMMENT '路由信息',
  `last_route` varchar(2048) NOT NULL COMMENT '最新路由信息',
  `ecp_body` text NOT NULL COMMENT 'ecp推送信息',
  `status` tinyint(1) NOT NULL COMMENT '订单状态，0为进行中，1为结束',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_statistics_datawarehouse`
--

CREATE TABLE IF NOT EXISTS `hx_statistics_datawarehouse` (
  `id` int(11) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '0',
  `month` int(2) NOT NULL DEFAULT '0',
  `day` int(2) NOT NULL DEFAULT '0',
  `week` int(2) NOT NULL DEFAULT '0',
  `week_day` int(1) NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT 'unknow',
  `value` text NOT NULL,
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=212 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_statistics_hot_enter_point`
--

CREATE TABLE IF NOT EXISTS `hx_statistics_hot_enter_point` (
  `id` int(11) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '0',
  `month` int(2) NOT NULL DEFAULT '0',
  `day` int(2) NOT NULL DEFAULT '0',
  `week` int(2) NOT NULL DEFAULT '0',
  `week_day` int(1) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `count_num` int(11) NOT NULL DEFAULT '0',
  `sorts_num` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_statistics_hot_referrer`
--

CREATE TABLE IF NOT EXISTS `hx_statistics_hot_referrer` (
  `id` int(11) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '0',
  `month` int(2) NOT NULL DEFAULT '0',
  `day` int(2) NOT NULL DEFAULT '0',
  `week` int(2) NOT NULL DEFAULT '0',
  `week_day` int(1) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `count_num` int(11) NOT NULL DEFAULT '0',
  `sorts_num` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_statistics_hot_show_good`
--

CREATE TABLE IF NOT EXISTS `hx_statistics_hot_show_good` (
  `id` int(11) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '0',
  `month` int(2) NOT NULL DEFAULT '0',
  `day` int(2) NOT NULL DEFAULT '0',
  `week` int(2) NOT NULL DEFAULT '0',
  `week_day` int(1) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `count_num` int(11) NOT NULL DEFAULT '0',
  `sorts_num` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_statistics_hot_user`
--

CREATE TABLE IF NOT EXISTS `hx_statistics_hot_user` (
  `id` int(11) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '0',
  `month` int(2) NOT NULL DEFAULT '0',
  `day` int(2) NOT NULL DEFAULT '0',
  `week` int(2) NOT NULL DEFAULT '0',
  `week_day` int(1) NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT 'unknow',
  `value` text NOT NULL,
  `count_num` int(11) NOT NULL DEFAULT '0',
  `sorts_num` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=892 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 表的结构 `hx_user`
--

CREATE TABLE IF NOT EXISTS `hx_user` (
  `uid` int(10) unsigned NOT NULL COMMENT '唯一自增id',
  `openid` varchar(40) NOT NULL COMMENT '用户的标识，对当前公众号唯一',
  `nickname` varchar(20) NOT NULL COMMENT '昵称',
  `sex` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别，1男性，2女性，0未知',
  `city` varchar(30) NOT NULL COMMENT '城市',
  `country` varchar(30) NOT NULL COMMENT '国家',
  `province` varchar(30) NOT NULL COMMENT '省',
  `language` varchar(10) NOT NULL COMMENT '语言',
  `headimgurl` varchar(255) NOT NULL COMMENT '头像',
  `subscribe` tinyint(1) unsigned DEFAULT '0' COMMENT '是否关注: 0-未关注, 1-已关注',
  `subscribe_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注时间戳',
  `unionid` varchar(40) NOT NULL COMMENT '公众号绑定到微信开放平台帐号',
  `remark` varchar(255) NOT NULL COMMENT '公众号运营者对粉丝的备注',
  `groupid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户所在的分组ID (微信)',
  `realname` varchar(20) NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) NOT NULL COMMENT '电话',
  `reason` varchar(200) NOT NULL,
  `credit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `balance` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '账户余额,单位:分',
  `award` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合伙人激励佣金, 单位:分, (若下线贡献足够多, 额外的奖励)',
  `invite_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '邀请人',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否顶级合伙人: 0-否, 1-是',
  `qrcode` varchar(255) NOT NULL COMMENT '二维码图片',
  `label_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '标签ID',
  `tag_id` varchar(255) NOT NULL DEFAULT '' COMMENT '标签ids, 代替label_id , 但暂时没删除label_id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '用户分组, 注意与groupid 不同',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `apply_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '申请合伙人时间',
  `audit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '审核时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0',
  `check_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '更新信息审核状态, 0-未申请 1-待审核, 2-已拒绝, 9-审核通过',
  `check_reason` varchar(255) NOT NULL COMMENT '修改信息审核理由',
  `partner_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '合伙人状态: 0-未申请, 1-待审核, 2-拒绝, 9-已通过',
  `commission_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '推广佣金状态: 0-未处理, 1-已处理',
  `commission_ratio` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '佣金比例',
  `client_ip` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `qq` varchar(15) NOT NULL COMMENT 'qq',
  `user_info_temp` varchar(1000) NOT NULL DEFAULT 'a:0:{}' COMMENT '用户申请修改信息暂时存放'
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_user`
--

INSERT INTO `hx_user` (`uid`, `openid`, `nickname`, `sex`, `city`, `country`, `province`, `language`, `headimgurl`, `subscribe`, `subscribe_time`, `unionid`, `remark`, `groupid`, `realname`, `phone`, `reason`, `credit`, `balance`, `award`, `invite_id`, `is_top`, `qrcode`, `label_id`, `tag_id`, `group_id`, `create_time`, `apply_time`, `audit_time`, `update_time`, `check_status`, `check_reason`, `partner_status`, `commission_status`, `commission_ratio`, `client_ip`, `address`, `qq`, `user_info_temp`) VALUES
(1000, 'oWHLsvqAHqeGVfKpVi9cxC_fe5fM', '西昆仑', 1, '青岛', '中国', '山东', 'zh_CN', 'http://wx.qlogo.cn/mmopen/K6mm5pSiaOuvRTiaWKBVuBVIX9Rv2fprH0sATOdzX8glK73EibEvEk7asHqcp9LZkDfmqfyt5hhSfzhRh5cUyKA16IjThNlrjwF/0', 0, 1455618279, '', '', 0, '', '', '', 0, 0, 0, 0, 0, '', 0, '', 0, 1455690280, 0, 0, 0, 0, '', 0, 0, 0, '101.226.125.15', '', '', 'a:0:{}'),
(1001, 'ocJNos4yojjXUg6C0cbvVfDlXRtk', '张焕', 1, '枣庄', '中国', '山东', 'zh_CN', 'http://wx.qlogo.cn/mmopen/K1wMWlXCKHrxWU0ALmI7Je7t1ektJNPPZLxcVjUqTzhvoEmupoIAVQatTiaqIoXRicv7ib4WDibsQibbXiaoDbLcawic7aMLCmIPpq6/0', 0, 1468482235, '', '', 0, '', '', '', 0, 0, 0, 0, 0, '', 0, '', 0, 1468482535, 0, 0, 0, 0, '', 0, 0, 0, '221.215.133.154', '', '', 'a:0:{}'),
(1002, 'ocJNos78dcUlkFGhvKA2aeSgwj4I', '闫怀堂', 1, '青岛', '中国', '山东', 'zh_CN', 'http://wx.qlogo.cn/mmopen/uwicBmyZf4xSCtFNCST5XHSPzyVQ0EWE0pqp3ZLiccy2sOBREmD4ITZHz83y549f2KZKCy77nGE167RWs6ibggKe45aicjbEKgdU/0', 0, 1468482231, '', '', 0, '', '', '', 0, 0, 0, 0, 0, '', 0, '', 0, 1468483310, 0, 0, 0, 0, '', 9, 0, 2, '221.215.133.154', '', '', 'a:0:{}');

-- --------------------------------------------------------

--
-- 表的结构 `hx_user_payment`
--

CREATE TABLE IF NOT EXISTS `hx_user_payment` (
  `id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `pay_way` varchar(20) NOT NULL COMMENT '支付方式, alipay, weixin, ',
  `account` varchar(50) NOT NULL,
  `authen_name` varchar(30) NOT NULL COMMENT '支付认证姓名',
  `bank_name` varchar(50) NOT NULL COMMENT '开户行',
  `bank_outlet` varchar(100) NOT NULL COMMENT '开户行',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 替换视图以便查看 `hx_view_all_fans`
--
CREATE TABLE IF NOT EXISTS `hx_view_all_fans` (
`uid` int(10) unsigned
,`openid` varchar(40)
,`nickname` varchar(20)
,`sex` tinyint(1) unsigned
,`city` varchar(30)
,`country` varchar(30)
,`province` varchar(30)
,`language` varchar(10)
,`headimgurl` varchar(255)
,`subscribe_time` int(10) unsigned
,`unionid` varchar(40)
,`remark` varchar(255)
,`groupid` int(10) unsigned
,`realname` varchar(20)
,`phone` varchar(20)
,`reason` varchar(200)
,`credit` int(10) unsigned
,`balance` int(10) unsigned
,`award` int(10) unsigned
,`invite_id` int(10) unsigned
,`qrcode` varchar(255)
,`label_id` smallint(5) unsigned
,`group_id` smallint(5) unsigned
,`create_time` int(10) unsigned
,`apply_time` int(10) unsigned
,`audit_time` int(10) unsigned
,`update_time` int(10) unsigned
,`check_status` tinyint(1) unsigned
,`check_reason` varchar(255)
,`partner_status` tinyint(1) unsigned
,`commission_status` tinyint(1) unsigned
,`client_ip` varchar(20)
,`address` varchar(100)
,`qq` varchar(15)
);

-- --------------------------------------------------------

--
-- 表的结构 `hx_wechat_reply`
--

CREATE TABLE IF NOT EXISTS `hx_wechat_reply` (
  `id` int(10) unsigned NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'keyword' COMMENT 'subscribe-关注自动回复, keyword-关键字自动回复, image-图文自动回复',
  `precision` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-模糊查找, 1-精确查找',
  `keyword` varchar(100) NOT NULL COMMENT '关键字',
  `content` text NOT NULL COMMENT '回复内容',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间'
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_wechat_reply`
--

INSERT INTO `hx_wechat_reply` (`id`, `type`, `precision`, `keyword`, `content`, `create_time`, `update_time`) VALUES
(2, 'text', 1, '测试', '欢迎来到合伙人商城 /得意  &lt;a href=&quot;http://p1.hehuofa.com/Mall/Index/index&quot;&gt;商城首页&lt;/a&gt;', 1452591522, 1452591522),
(3, 'subscribe', 0, '', '欢迎加入合伙人，这是海信与粉丝的互动平台，让我们畅所欲言，同进步共赢利！', 1452588123, 1453951097),
(7, 'text', 0, '你好', '你好，欢迎加入合伙人', 1453951015, 1453951015);

-- --------------------------------------------------------

--
-- 表的结构 `hx_wxmenu_class`
--

CREATE TABLE IF NOT EXISTS `hx_wxmenu_class` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `keyword` varchar(30) NOT NULL,
  `url` varchar(300) NOT NULL DEFAULT '',
  `is_show` tinyint(1) NOT NULL,
  `sort` tinyint(3) NOT NULL,
  `wxsys` char(40) NOT NULL,
  `text` varchar(500) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `nav` varchar(200) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- 转存表中的数据 `hx_wxmenu_class`
--

INSERT INTO `hx_wxmenu_class` (`id`, `pid`, `title`, `keyword`, `url`, `is_show`, `sort`, `wxsys`, `text`, `tel`, `nav`) VALUES
(24, 0, '商城', '', 'http://jvyoujia.startsrun.com/', 1, 5, '', '', '', ''),
(26, 0, '合伙人', '', '', 1, 3, '扫码带提示', '', '', NULL),
(27, 26, '合伙人介绍＆申请', '', 'http://jvyoujia.startsrun.com/Partner/Index/apply.html', 1, 5, '', '', '', ''),
(28, 26, '专属二维码', '', 'http://jvyoujia.startsrun.com/Partner/Index/qrcode', 1, 4, '', '', '', ''),
(29, 26, '我的合伙人', '', 'http://jvyoujia.startsrun.com/Partner/Index/ucenter', 1, 3, '', '', '', ''),
(30, 26, '常见问题解答', '', 'http://jvyoujia.startsrun.com/Mall/Ucenter/help', 1, 2, '', '', '', ''),
(31, 0, '福利', '', '', 1, 4, '', '', NULL, NULL),
(32, 31, '优惠券', '', 'http://jvyoujia.startsrun.com/Mall/Ucenter/welfare.html', 1, 5, '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- 视图结构 `hx_view_all_fans`
--
DROP TABLE IF EXISTS `hx_view_all_fans`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `hx_view_all_fans` AS select `hx_user`.`uid` AS `uid`,`hx_user`.`openid` AS `openid`,`hx_user`.`nickname` AS `nickname`,`hx_user`.`sex` AS `sex`,`hx_user`.`city` AS `city`,`hx_user`.`country` AS `country`,`hx_user`.`province` AS `province`,`hx_user`.`language` AS `language`,`hx_user`.`headimgurl` AS `headimgurl`,`hx_user`.`subscribe_time` AS `subscribe_time`,`hx_user`.`unionid` AS `unionid`,`hx_user`.`remark` AS `remark`,`hx_user`.`groupid` AS `groupid`,`hx_user`.`realname` AS `realname`,`hx_user`.`phone` AS `phone`,`hx_user`.`reason` AS `reason`,`hx_user`.`credit` AS `credit`,`hx_user`.`balance` AS `balance`,`hx_user`.`award` AS `award`,`hx_user`.`invite_id` AS `invite_id`,`hx_user`.`qrcode` AS `qrcode`,`hx_user`.`label_id` AS `label_id`,`hx_user`.`group_id` AS `group_id`,`hx_user`.`create_time` AS `create_time`,`hx_user`.`apply_time` AS `apply_time`,`hx_user`.`audit_time` AS `audit_time`,`hx_user`.`update_time` AS `update_time`,`hx_user`.`check_status` AS `check_status`,`hx_user`.`check_reason` AS `check_reason`,`hx_user`.`partner_status` AS `partner_status`,`hx_user`.`commission_status` AS `commission_status`,`hx_user`.`client_ip` AS `client_ip`,`hx_user`.`address` AS `address`,`hx_user`.`qq` AS `qq` from `hx_user` where (`hx_user`.`subscribe_time` > 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hx_activity_booking_action`
--
ALTER TABLE `hx_activity_booking_action`
  ADD PRIMARY KEY (`act_id`);

--
-- Indexes for table `hx_activity_booking_bespoke`
--
ALTER TABLE `hx_activity_booking_bespoke`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_activity_group_action`
--
ALTER TABLE `hx_activity_group_action`
  ADD PRIMARY KEY (`act_id`);

--
-- Indexes for table `hx_activity_group_bespoke`
--
ALTER TABLE `hx_activity_group_bespoke`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_activity_menu`
--
ALTER TABLE `hx_activity_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `hx_activity_menu_item`
--
ALTER TABLE `hx_activity_menu_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_activity_seckill_action`
--
ALTER TABLE `hx_activity_seckill_action`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `action_name` (`action_name`);

--
-- Indexes for table `hx_article`
--
ALTER TABLE `hx_article`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_attribute`
--
ALTER TABLE `hx_attribute`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`type`);

--
-- Indexes for table `hx_auth_access`
--
ALTER TABLE `hx_auth_access`
  ADD KEY `groupId` (`role_id`),
  ADD KEY `nodeId` (`node_id`);

--
-- Indexes for table `hx_auth_node`
--
ALTER TABLE `hx_auth_node`
  ADD PRIMARY KEY (`id`),
  ADD KEY `level` (`level`),
  ADD KEY `pid` (`pid`),
  ADD KEY `status` (`status`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `hx_auth_role`
--
ALTER TABLE `hx_auth_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `hx_auth_user`
--
ALTER TABLE `hx_auth_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `email` (`email`(20)),
  ADD KEY `fid` (`fid`);

--
-- Indexes for table `hx_code_telephone`
--
ALTER TABLE `hx_code_telephone`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_commission_file`
--
ALTER TABLE `hx_commission_file`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_commission_log`
--
ALTER TABLE `hx_commission_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `money` (`money`),
  ADD KEY `uid_type_status` (`uid`,`type`,`status`);

--
-- Indexes for table `hx_commission_task`
--
ALTER TABLE `hx_commission_task`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_commission_task_data`
--
ALTER TABLE `hx_commission_task_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `uid_type_status` (`uid`,`type`,`status`),
  ADD KEY `money` (`money`);

--
-- Indexes for table `hx_ecp_base_region`
--
ALTER TABLE `hx_ecp_base_region`
  ADD PRIMARY KEY (`region_id`),
  ADD KEY `warehouse_name` (`warehouse_name`),
  ADD KEY `warehouse_code` (`warehouse_code`);

--
-- Indexes for table `hx_ecp_inventory`
--
ALTER TABLE `hx_ecp_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`,`sku_id`,`warehouse_code`,`warehouse_name`,`created_at`,`updated_at`);

--
-- Indexes for table `hx_ecp_warehouse`
--
ALTER TABLE `hx_ecp_warehouse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `warehouse_name` (`warehouse_name`),
  ADD KEY `warehouse_code` (`warehouse_code`);

--
-- Indexes for table `hx_help`
--
ALTER TABLE `hx_help`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_address`
--
ALTER TABLE `hx_mall_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_advert`
--
ALTER TABLE `hx_mall_advert`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_alipay`
--
ALTER TABLE `hx_mall_alipay`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_banner`
--
ALTER TABLE `hx_mall_banner`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_cart`
--
ALTER TABLE `hx_mall_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_coupon`
--
ALTER TABLE `hx_mall_coupon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_coupon_record`
--
ALTER TABLE `hx_mall_coupon_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_good`
--
ALTER TABLE `hx_mall_good`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_info`
--
ALTER TABLE `hx_mall_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_invoice`
--
ALTER TABLE `hx_mall_invoice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_number`,`serial_no`,`electronic_invoice_no`),
  ADD KEY `sf_order_id` (`anti_fake_code`);

--
-- Indexes for table `hx_mall_mail`
--
ALTER TABLE `hx_mall_mail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_menu`
--
ALTER TABLE `hx_mall_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_notice`
--
ALTER TABLE `hx_mall_notice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `hx_mall_order`
--
ALTER TABLE `hx_mall_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id` (`id`),
  ADD KEY `order_number` (`order_number`);

--
-- Indexes for table `hx_mall_order_shop`
--
ALTER TABLE `hx_mall_order_shop`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_refund`
--
ALTER TABLE `hx_mall_refund`
  ADD PRIMARY KEY (`id`),
  ADD KEY `openid` (`openid`),
  ADD KEY `good_id` (`good_id`);

--
-- Indexes for table `hx_mall_spread`
--
ALTER TABLE `hx_mall_spread`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_tag`
--
ALTER TABLE `hx_mall_tag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_workcard`
--
ALTER TABLE `hx_mall_workcard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_proved` (`is_proved`);

--
-- Indexes for table `hx_mall_wxconfig`
--
ALTER TABLE `hx_mall_wxconfig`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_wxmenu`
--
ALTER TABLE `hx_mall_wxmenu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_mall_wxmessage`
--
ALTER TABLE `hx_mall_wxmessage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_msg_log`
--
ALTER TABLE `hx_msg_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_msg_queue_error`
--
ALTER TABLE `hx_msg_queue_error`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_msg_template`
--
ALTER TABLE `hx_msg_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_msg_wechat_template`
--
ALTER TABLE `hx_msg_wechat_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_msj_operation_log`
--
ALTER TABLE `hx_msj_operation_log`
  ADD PRIMARY KEY (`operation_log`),
  ADD KEY `index_uid_node` (`operation_uid`,`operation_node`,`operation_log`);

--
-- Indexes for table `hx_operate_log`
--
ALTER TABLE `hx_operate_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `table` (`table_id`,`table_name`);

--
-- Indexes for table `hx_reward_task`
--
ALTER TABLE `hx_reward_task`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_reward_task_data`
--
ALTER TABLE `hx_reward_task_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `task_id` (`task_id`);

--
-- Indexes for table `hx_shipping_route`
--
ALTER TABLE `hx_shipping_route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `way_bill_no` (`way_bill_no`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `status` (`status`),
  ADD KEY `courier` (`logistics_id`);

--
-- Indexes for table `hx_statistics_datawarehouse`
--
ALTER TABLE `hx_statistics_datawarehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_statistics_hot_enter_point`
--
ALTER TABLE `hx_statistics_hot_enter_point`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_statistics_hot_referrer`
--
ALTER TABLE `hx_statistics_hot_referrer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_statistics_hot_show_good`
--
ALTER TABLE `hx_statistics_hot_show_good`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_statistics_hot_user`
--
ALTER TABLE `hx_statistics_hot_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hx_user`
--
ALTER TABLE `hx_user`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `openid` (`openid`),
  ADD KEY `invite_id` (`invite_id`);

--
-- Indexes for table `hx_user_payment`
--
ALTER TABLE `hx_user_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `hx_wechat_reply`
--
ALTER TABLE `hx_wechat_reply`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `hx_wxmenu_class`
--
ALTER TABLE `hx_wxmenu_class`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hx_activity_booking_action`
--
ALTER TABLE `hx_activity_booking_action`
  MODIFY `act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '活动id';
--
-- AUTO_INCREMENT for table `hx_activity_booking_bespoke`
--
ALTER TABLE `hx_activity_booking_bespoke`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `hx_activity_group_action`
--
ALTER TABLE `hx_activity_group_action`
  MODIFY `act_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '活动id';
--
-- AUTO_INCREMENT for table `hx_activity_group_bespoke`
--
ALTER TABLE `hx_activity_group_bespoke`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `hx_activity_menu`
--
ALTER TABLE `hx_activity_menu`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `hx_activity_menu_item`
--
ALTER TABLE `hx_activity_menu_item`
  MODIFY `id` int(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `hx_activity_seckill_action`
--
ALTER TABLE `hx_activity_seckill_action`
  MODIFY `action_id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_article`
--
ALTER TABLE `hx_article`
  MODIFY `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章id',AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `hx_attribute`
--
ALTER TABLE `hx_attribute`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `hx_auth_node`
--
ALTER TABLE `hx_auth_node`
  MODIFY `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=115;
--
-- AUTO_INCREMENT for table `hx_auth_role`
--
ALTER TABLE `hx_auth_role`
  MODIFY `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `hx_auth_user`
--
ALTER TABLE `hx_auth_user`
  MODIFY `user_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `hx_code_telephone`
--
ALTER TABLE `hx_code_telephone`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_commission_file`
--
ALTER TABLE `hx_commission_file`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_commission_log`
--
ALTER TABLE `hx_commission_log`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_commission_task`
--
ALTER TABLE `hx_commission_task`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_commission_task_data`
--
ALTER TABLE `hx_commission_task_data`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hx_ecp_base_region`
--
ALTER TABLE `hx_ecp_base_region`
  MODIFY `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '区域管理唯一标识',AUTO_INCREMENT=77294155;
--
-- AUTO_INCREMENT for table `hx_ecp_inventory`
--
ALTER TABLE `hx_ecp_inventory`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=134;
--
-- AUTO_INCREMENT for table `hx_ecp_warehouse`
--
ALTER TABLE `hx_ecp_warehouse`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `hx_help`
--
ALTER TABLE `hx_help`
  MODIFY `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_address`
--
ALTER TABLE `hx_mall_address`
  MODIFY `id` mediumint(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址id',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hx_mall_advert`
--
ALTER TABLE `hx_mall_advert`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_mall_alipay`
--
ALTER TABLE `hx_mall_alipay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_banner`
--
ALTER TABLE `hx_mall_banner`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_cart`
--
ALTER TABLE `hx_mall_cart`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '购物车商品id',AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `hx_mall_coupon`
--
ALTER TABLE `hx_mall_coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_coupon_record`
--
ALTER TABLE `hx_mall_coupon_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_good`
--
ALTER TABLE `hx_mall_good`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id',AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `hx_mall_info`
--
ALTER TABLE `hx_mall_info`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_invoice`
--
ALTER TABLE `hx_mall_invoice`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `hx_mall_mail`
--
ALTER TABLE `hx_mall_mail`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_menu`
--
ALTER TABLE `hx_mall_menu`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `hx_mall_notice`
--
ALTER TABLE `hx_mall_notice`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_mall_order`
--
ALTER TABLE `hx_mall_order`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单id',AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `hx_mall_order_shop`
--
ALTER TABLE `hx_mall_order_shop`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '单独商品订单ID',AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `hx_mall_refund`
--
ALTER TABLE `hx_mall_refund`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_tag`
--
ALTER TABLE `hx_mall_tag`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `hx_mall_workcard`
--
ALTER TABLE `hx_mall_workcard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_mall_wxconfig`
--
ALTER TABLE `hx_mall_wxconfig`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_mall_wxmenu`
--
ALTER TABLE `hx_mall_wxmenu`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `hx_mall_wxmessage`
--
ALTER TABLE `hx_mall_wxmessage`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `hx_msg_log`
--
ALTER TABLE `hx_msg_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_msg_queue_error`
--
ALTER TABLE `hx_msg_queue_error`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_msg_template`
--
ALTER TABLE `hx_msg_template`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `hx_msg_wechat_template`
--
ALTER TABLE `hx_msg_wechat_template`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `hx_msj_operation_log`
--
ALTER TABLE `hx_msj_operation_log`
  MODIFY `operation_log` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '操作记录主键';
--
-- AUTO_INCREMENT for table `hx_operate_log`
--
ALTER TABLE `hx_operate_log`
  MODIFY `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=150;
--
-- AUTO_INCREMENT for table `hx_reward_task`
--
ALTER TABLE `hx_reward_task`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `hx_reward_task_data`
--
ALTER TABLE `hx_reward_task_data`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=152;
--
-- AUTO_INCREMENT for table `hx_shipping_route`
--
ALTER TABLE `hx_shipping_route`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_statistics_datawarehouse`
--
ALTER TABLE `hx_statistics_datawarehouse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=212;
--
-- AUTO_INCREMENT for table `hx_statistics_hot_enter_point`
--
ALTER TABLE `hx_statistics_hot_enter_point`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `hx_statistics_hot_referrer`
--
ALTER TABLE `hx_statistics_hot_referrer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `hx_statistics_hot_show_good`
--
ALTER TABLE `hx_statistics_hot_show_good`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_statistics_hot_user`
--
ALTER TABLE `hx_statistics_hot_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=892;
--
-- AUTO_INCREMENT for table `hx_user`
--
ALTER TABLE `hx_user`
  MODIFY `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增id',AUTO_INCREMENT=1003;
--
-- AUTO_INCREMENT for table `hx_user_payment`
--
ALTER TABLE `hx_user_payment`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hx_wechat_reply`
--
ALTER TABLE `hx_wechat_reply`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `hx_wxmenu_class`
--
ALTER TABLE `hx_wxmenu_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
