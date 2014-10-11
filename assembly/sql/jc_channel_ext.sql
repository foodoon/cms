/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : cmstest

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2014-10-11 10:56:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jc_channel_ext`
-- ----------------------------
DROP TABLE IF EXISTS `jc_channel_ext`;
CREATE TABLE `jc_channel_ext` (
  `channel_id` int(11) NOT NULL,
  `channel_name` varchar(100) NOT NULL COMMENT '名称',
  `final_step` tinyint(4) DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) DEFAULT NULL COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_static_channel` char(1) NOT NULL DEFAULT '0' COMMENT '是否栏目静态化',
  `is_static_content` char(1) NOT NULL DEFAULT '0' COMMENT '是否内容静态化',
  `is_access_by_dir` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用目录访问',
  `is_list_child` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用子栏目列表',
  `page_size` int(11) NOT NULL DEFAULT '20' COMMENT '每页多少条记录',
  `channel_rule` varchar(150) DEFAULT NULL COMMENT '栏目页生成规则',
  `content_rule` varchar(150) DEFAULT NULL COMMENT '内容页生成规则',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_channel` varchar(100) DEFAULT NULL COMMENT '栏目页模板',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容页模板',
  `title_img` varchar(100) DEFAULT NULL COMMENT '缩略图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有缩略图',
  `has_content_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内容是否有内容图',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '内容标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '内容内容图高度',
  `comment_control` int(11) NOT NULL DEFAULT '0' COMMENT '评论(0:匿名;1:会员;2:关闭)',
  `allow_updown` tinyint(1) NOT NULL DEFAULT '1' COMMENT '顶踩(true:开放;false:关闭)',
  `is_blank` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否新窗口打开',
  `title` varchar(255) DEFAULT NULL COMMENT 'TITLE',
  `keywords` varchar(255) DEFAULT NULL COMMENT 'KEYWORDS',
  `description` varchar(255) DEFAULT NULL COMMENT 'DESCRIPTION',
  `allow_share` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分享(true:开放;false:关闭)',
  `allow_score` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评分(true:开放;false:关闭)',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_ext_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目内容表';

-- ----------------------------
-- Records of jc_channel_ext
-- ----------------------------
INSERT INTO `jc_channel_ext` VALUES ('69', '新闻', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '新闻', '新闻', '新闻', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('70', '图库', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '图库', '图库', '图库', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('71', '财经', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_finance.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '财经', '财经', '财经', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('72', '下载', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '下载', '下载', '下载', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('73', '教育', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_edu.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '教育', '教育', '教育', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('74', '汽车', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_car.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '汽车', '汽车', '汽车', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('75', '娱乐', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_relax.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '娱乐', '娱乐', '娱乐', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('76', '招聘', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '招聘', '招聘', '招聘', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('77', '视频', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '视频', '视频', '视频', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('78', '文库', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '文库', '文库', '文库', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('79', '时政', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '时政', '时政', '时政', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('80', '国际新闻', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '国际新闻', '国际新闻', '国际新闻', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('81', '国内新闻', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', '国内新闻', '国内新闻', '国内新闻', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('82', '社会', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '社会', '社会', '社会', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('83', '法治', null, null, '0', '0', '0', '0', '10', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '法治', '法治', '法治', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('84', '军事', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '军事', '军事', '军事', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('85', '时尚', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/pic_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '时尚', '时尚', '时尚', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('86', '校园', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/pic_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '校园', '校园', '校园', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('87', '旅游', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/pic_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '旅游', '旅游', '旅游', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('88', '要闻', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '要闻', '要闻', '要闻', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('89', '股票', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '股票', '股票', '股票', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('90', '理财', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '理财', '理财', '理财', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('91', '软件', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '软件', '软件', '软件', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('92', '游戏', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '游戏', '游戏', '游戏', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('93', '工具', null, null, '0', '0', '1', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '工具', '工具', '工具', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('94', '文化', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '文化', '文化', '文化', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('95', '历史', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '历史', '历史', '历史', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('96', '车情', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '车情', '车情', '车情', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('97', '图片', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '图片', '图片', '图片', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('98', '新车', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '新车', '新车', '新车', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('99', '维修', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '维修', '维修', '维修', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('100', '明星', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '明星', '明星', '明星', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('101', '八卦', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '八卦', '八卦', '八卦', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('102', '情感', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/news_sub.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '情感', '情感', '情感', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('103', 'IT', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/html_front/cms/www/two/channel/hire.html', null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', 'IT', 'IT', 'IT', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('104', '通信', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '通信', '通信', '通信', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('105', '家电', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '家电', '家电', '家电', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('106', '电影', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '电影', '电影', '电影', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('107', '综艺', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '综艺', '综艺', '综艺', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('108', '电视', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '电视剧', '电视剧', '电视剧', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('109', '教育', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '教育', '教育', '教育', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('110', '科技', null, null, '0', '0', '0', '0', '20', null, null, null, null, null, null, null, '1', '0', '139', '139', '310', '310', '0', '1', '0', '科技', '科技', '科技', '0', '0');
INSERT INTO `jc_channel_ext` VALUES ('111', '网络调查', null, null, '0', '0', '0', '0', '20', null, null, null, '/WEB-INF/t/cms/www/two/channel/news_net.html', null, null, null, '0', '0', '139', '139', '310', '310', '0', '1', '0', null, null, null, '0', '0');
