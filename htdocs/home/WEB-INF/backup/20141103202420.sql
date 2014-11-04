SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS jc_acquisition;
CREATE TABLE `jc_acquisition` (
  `acquisition_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `acq_name` varchar(50) NOT NULL COMMENT '采集名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '停止时间',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '当前状态(0:静止;1:采集;2:暂停)',
  `curr_num` int(11) NOT NULL DEFAULT '0' COMMENT '当前号码',
  `curr_item` int(11) NOT NULL DEFAULT '0' COMMENT '当前条数',
  `total_item` int(11) NOT NULL DEFAULT '0' COMMENT '每页总条数',
  `pause_time` int(11) NOT NULL DEFAULT '0' COMMENT '暂停时间(毫秒)',
  `page_encoding` varchar(20) NOT NULL DEFAULT 'GBK' COMMENT '页面编码',
  `plan_list` longtext COMMENT '采集列表',
  `dynamic_addr` varchar(255) DEFAULT NULL COMMENT '动态地址',
  `dynamic_start` int(11) DEFAULT NULL COMMENT '页码开始',
  `dynamic_end` int(11) DEFAULT NULL COMMENT '页码结束',
  `linkset_start` varchar(255) DEFAULT NULL COMMENT '内容链接区开始',
  `linkset_end` varchar(255) DEFAULT NULL COMMENT '内容链接区结束',
  `link_start` varchar(255) DEFAULT NULL COMMENT '内容链接开始',
  `link_end` varchar(255) DEFAULT NULL COMMENT '内容链接结束',
  `title_start` varchar(255) DEFAULT NULL COMMENT '标题开始',
  `title_end` varchar(255) DEFAULT NULL COMMENT '标题结束',
  `keywords_start` varchar(255) DEFAULT NULL COMMENT '关键字开始',
  `keywords_end` varchar(255) DEFAULT NULL COMMENT '关键字结束',
  `description_start` varchar(255) DEFAULT NULL COMMENT '描述开始',
  `description_end` varchar(255) DEFAULT NULL COMMENT '描述结束',
  `content_start` varchar(255) DEFAULT NULL COMMENT '内容开始',
  `content_end` varchar(255) DEFAULT NULL COMMENT '内容结束',
  `pagination_start` varchar(255) DEFAULT NULL COMMENT '内容分页开始',
  `pagination_end` varchar(255) DEFAULT NULL COMMENT '内容分页结束',
  `queue` int(11) NOT NULL DEFAULT '0' COMMENT '队列',
  `repeat_check_type` varchar(20) NOT NULL DEFAULT 'NONE' COMMENT '重复类型',
  `img_acqu` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否采集图片',
  `content_prefix` varchar(255) DEFAULT NULL COMMENT '内容地址补全url',
  `img_prefix` varchar(255) DEFAULT NULL COMMENT '图片地址补全url',
  `view_start` varchar(255) DEFAULT NULL COMMENT '浏览量开始',
  `view_end` varchar(255) DEFAULT NULL COMMENT '浏览量结束',
  `view_id_start` varchar(255) DEFAULT NULL COMMENT 'id前缀',
  `view_id_end` varchar(255) DEFAULT NULL COMMENT 'id后缀',
  `view_link` varchar(255) DEFAULT NULL COMMENT '浏览量动态访问地址',
  `releaseTime_start` varchar(255) DEFAULT NULL COMMENT '发布时间开始',
  `releaseTime_end` varchar(255) DEFAULT NULL COMMENT '发布时间结束',
  `author_start` varchar(255) DEFAULT NULL COMMENT '作者开始',
  `author_end` varchar(255) DEFAULT NULL COMMENT '作者结束',
  `origin_start` varchar(255) DEFAULT NULL COMMENT '来源开始',
  `origin_end` varchar(255) DEFAULT NULL COMMENT '来源结束',
  `releaseTime_format` varchar(255) DEFAULT NULL COMMENT '发布时间格式',
  PRIMARY KEY (`acquisition_id`),
  KEY `fk_jc_acquisition_channel` (`channel_id`),
  KEY `fk_jc_acquisition_contenttype` (`type_id`),
  KEY `fk_jc_acquisition_site` (`site_id`),
  KEY `fk_jc_acquisition_user` (`user_id`),
  CONSTRAINT `fk_jc_acquisition_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_acquisition_contenttype` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_acquisition_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_acquisition_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS采集表';
DROP TABLE IF EXISTS jc_acquisition_history;
CREATE TABLE `jc_acquisition_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `acquisition_id` int(11) DEFAULT NULL COMMENT '采集源',
  `content_id` int(11) DEFAULT NULL COMMENT '内容',
  PRIMARY KEY (`history_id`),
  KEY `fk_acquisition_history_acquisition` (`acquisition_id`),
  CONSTRAINT `fk_jc_history_acquisition` FOREIGN KEY (`acquisition_id`) REFERENCES `jc_acquisition` (`acquisition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集历史记录表';
DROP TABLE IF EXISTS jc_acquisition_temp;
CREATE TABLE `jc_acquisition_temp` (
  `temp_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `channel_url` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目地址',
  `content_url` varchar(255) NOT NULL DEFAULT '' COMMENT '内容地址',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `finish_percent` int(3) NOT NULL DEFAULT '0' COMMENT '百分比',
  `description` varchar(20) NOT NULL DEFAULT '' COMMENT '描述',
  `seq` int(3) NOT NULL DEFAULT '0' COMMENT '顺序',
  PRIMARY KEY (`temp_id`),
  KEY `fk_jc_temp_site` (`site_id`),
  CONSTRAINT `fk_jc_temp_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采集进度临时表';
DROP TABLE IF EXISTS jc_advertising;
CREATE TABLE `jc_advertising` (
  `advertising_id` int(11) NOT NULL AUTO_INCREMENT,
  `adspace_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '广告名称',
  `category` varchar(50) NOT NULL COMMENT '广告类型',
  `ad_code` longtext COMMENT '广告代码',
  `ad_weight` int(11) NOT NULL DEFAULT '1' COMMENT '广告权重',
  `display_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '展现次数',
  `click_count` bigint(20) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `start_time` date DEFAULT NULL COMMENT '开始时间',
  `end_time` date DEFAULT NULL COMMENT '结束时间',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  PRIMARY KEY (`advertising_id`),
  KEY `fk_jc_advertising_site` (`site_id`),
  KEY `fk_jc_space_advertising` (`adspace_id`),
  CONSTRAINT `fk_jc_advertising_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_space_advertising` FOREIGN KEY (`adspace_id`) REFERENCES `jc_advertising_space` (`adspace_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告表';
DROP TABLE IF EXISTS jc_advertising_attr;
CREATE TABLE `jc_advertising_attr` (
  `advertising_id` int(11) NOT NULL,
  `attr_name` varchar(50) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_params_advertising` (`advertising_id`),
  CONSTRAINT `fk_jc_params_advertising` FOREIGN KEY (`advertising_id`) REFERENCES `jc_advertising` (`advertising_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告属性表';
DROP TABLE IF EXISTS jc_advertising_space;
CREATE TABLE `jc_advertising_space` (
  `adspace_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ad_name` varchar(100) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `is_enabled` char(1) NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`adspace_id`),
  KEY `fk_jc_adspace_site` (`site_id`),
  CONSTRAINT `fk_jc_adspace_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS广告版位表';
DROP TABLE IF EXISTS jc_channel;
CREATE TABLE `jc_channel` (
  `channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `parent_id` int(11) DEFAULT NULL COMMENT '父栏目ID',
  `channel_path` varchar(30) DEFAULT NULL COMMENT '访问路径',
  `lft` int(11) NOT NULL DEFAULT '1' COMMENT '树左边',
  `rgt` int(11) NOT NULL DEFAULT '2' COMMENT '树右边',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `workflow_id` int(11) DEFAULT NULL COMMENT '工作流id',
  PRIMARY KEY (`channel_id`),
  KEY `fk_jc_channel_model` (`model_id`),
  KEY `fk_jc_channel_parent` (`parent_id`),
  KEY `fk_jc_channel_site` (`site_id`),
  CONSTRAINT `fk_jc_channel_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_channel_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_channel_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COMMENT='CMS栏目表';
 INSERT INTO `jc_channel` VALUES(69,1,1,null,'news',1,14,1,1,1,null);
 INSERT INTO `jc_channel` VALUES(70,5,1,null,'pic',15,22,2,1,1,null);
 INSERT INTO `jc_channel` VALUES(71,1,1,null,'money',23,30,3,1,1,null);
 INSERT INTO `jc_channel` VALUES(72,4,1,null,'download',31,38,4,1,1,null);
 INSERT INTO `jc_channel` VALUES(73,1,1,null,'edu',39,44,5,1,1,null);
 INSERT INTO `jc_channel` VALUES(74,1,1,null,'qiche',45,54,7,1,1,null);
 INSERT INTO `jc_channel` VALUES(75,1,1,null,'yule',55,62,8,1,1,null);
 INSERT INTO `jc_channel` VALUES(76,8,1,null,'zhaopin',63,70,9,1,0,null);
 INSERT INTO `jc_channel` VALUES(77,6,1,null,'shipin',71,78,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(78,9,1,null,'wenku2',79,84,11,1,1,null);
 INSERT INTO `jc_channel` VALUES(79,1,1,69,'shizheng',2,7,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(80,1,1,79,'guojixinwen',3,4,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(81,1,1,79,'guoneixinwen',5,6,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(82,1,1,69,'shehui',8,9,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(83,1,1,69,'fazhi',10,11,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(84,1,1,69,'junshi',12,13,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(85,5,1,70,'shishang',16,17,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(86,5,1,70,'xiaoyuan',18,19,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(87,5,1,70,'lvyou',20,21,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(88,1,1,71,'yaowen',24,25,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(89,1,1,71,'gupiao',26,27,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(90,1,1,71,'licai',28,29,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(91,4,1,72,'ruanjian',32,33,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(92,4,1,72,'youxi',34,35,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(93,4,1,72,'gongju',36,37,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(94,1,1,73,'wenhua',40,41,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(95,1,1,73,'shi',42,43,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(96,1,1,74,'cheqing',46,47,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(97,1,1,74,'tupian',48,49,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(98,1,1,74,'xinche',50,51,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(99,1,1,74,'weixiu',52,53,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(100,1,1,75,'mingxing',56,57,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(101,1,1,75,'bagua',58,59,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(102,1,1,75,'qinggan',60,61,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(103,8,1,76,'it',64,65,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(104,8,1,76,'tongxin',66,67,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(105,8,1,76,'jiadian',68,69,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(106,6,1,77,'dianying',72,73,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(107,6,1,77,'zongyi',74,75,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(108,6,1,77,'dianshi',76,77,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(109,9,1,78,'jiaoyu',80,81,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(110,9,1,78,'keji1',82,83,10,1,1,null);
 INSERT INTO `jc_channel` VALUES(111,1,1,null,'onlineSurvey',85,86,6,1,1,null);
 INSERT INTO `jc_channel` VALUES(112,11,1,null,'interview',87,88,13,1,1,null);
 INSERT INTO `jc_channel` VALUES(113,10,1,null,'live',89,90,12,1,1,null);
DROP TABLE IF EXISTS jc_channel_attr;
CREATE TABLE `jc_channel_attr` (
  `channel_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_channel` (`channel_id`),
  CONSTRAINT `fk_jc_attr_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目扩展属性表';
 INSERT INTO `jc_channel_attr` VALUES(112,'userIds','');
DROP TABLE IF EXISTS jc_channel_count;
CREATE TABLE `jc_channel_count` (
  `channel_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目访问量计数表';
 INSERT INTO `jc_channel_count` VALUES(112,4,4,4,4);
 INSERT INTO `jc_channel_count` VALUES(113,0,0,0,0);
DROP TABLE IF EXISTS jc_channel_department;
CREATE TABLE `jc_channel_department` (
  `channel_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`department_id`),
  KEY `fk_jc_channel_department` (`department_id`),
  CONSTRAINT `fk_jc_channel_department` FOREIGN KEY (`department_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目部门关联表';
DROP TABLE IF EXISTS jc_channel_ext;
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
 INSERT INTO `jc_channel_ext` VALUES(69,'新闻',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news.html',null,null,null,1,0,139,139,310,310,0,1,0,'新闻','新闻','新闻',0,0);
 INSERT INTO `jc_channel_ext` VALUES(70,'图库',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/pic.html',null,null,null,0,0,139,139,310,310,0,1,0,'图库','图库','图库',0,0);
 INSERT INTO `jc_channel_ext` VALUES(71,'财经',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_finance.html',null,null,null,1,0,139,139,310,310,0,1,0,'财经','财经','财经',0,0);
 INSERT INTO `jc_channel_ext` VALUES(72,'下载',null,null,'0','0','1','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/download.html',null,null,null,1,0,139,139,310,310,0,1,0,'下载','下载','下载',0,0);
 INSERT INTO `jc_channel_ext` VALUES(73,'教育',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_edu.html',null,null,null,0,0,139,139,310,310,0,1,0,'教育','教育','教育',0,0);
 INSERT INTO `jc_channel_ext` VALUES(74,'汽车',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_car.html',null,null,null,1,0,139,139,310,310,0,1,0,'汽车','汽车','汽车',0,0);
 INSERT INTO `jc_channel_ext` VALUES(75,'娱乐',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_relax.html',null,null,null,0,0,139,139,310,310,0,1,0,'娱乐','娱乐','娱乐',0,0);
 INSERT INTO `jc_channel_ext` VALUES(76,'招聘',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/job.html',null,null,null,0,0,139,139,310,310,0,1,0,'招聘','招聘','招聘',0,0);
 INSERT INTO `jc_channel_ext` VALUES(77,'视频',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/video.html',null,null,null,0,0,139,139,310,310,0,1,0,'视频','视频','视频',0,0);
 INSERT INTO `jc_channel_ext` VALUES(78,'文库',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/doc.html',null,null,null,0,0,139,139,310,310,0,1,0,'文库','文库','文库',0,0);
 INSERT INTO `jc_channel_ext` VALUES(79,'时政',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,0,0,139,139,310,310,0,1,0,'时政','时政','时政',0,0);
 INSERT INTO `jc_channel_ext` VALUES(80,'国际新闻',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,0,0,139,139,310,310,0,1,0,'国际新闻','国际新闻','国际新闻',0,0);
 INSERT INTO `jc_channel_ext` VALUES(81,'国内新闻',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,0,0,139,139,310,310,0,1,0,'国内新闻','国内新闻','国内新闻',0,0);
 INSERT INTO `jc_channel_ext` VALUES(82,'社会',null,null,'0','0','0','0',10,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'社会','社会','社会',0,0);
 INSERT INTO `jc_channel_ext` VALUES(83,'法治',null,null,'0','0','0','0',10,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'法治','法治','法治',0,0);
 INSERT INTO `jc_channel_ext` VALUES(84,'军事',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'军事','军事','军事',0,0);
 INSERT INTO `jc_channel_ext` VALUES(85,'时尚',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/pic_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'时尚','时尚','时尚',0,0);
 INSERT INTO `jc_channel_ext` VALUES(86,'校园',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/pic_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'校园','校园','校园',0,0);
 INSERT INTO `jc_channel_ext` VALUES(87,'旅游',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/pic_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'旅游','旅游','旅游',0,0);
 INSERT INTO `jc_channel_ext` VALUES(88,'要闻',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'要闻','要闻','要闻',0,0);
 INSERT INTO `jc_channel_ext` VALUES(89,'股票',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'股票','股票','股票',0,0);
 INSERT INTO `jc_channel_ext` VALUES(90,'理财',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'理财','理财','理财',0,0);
 INSERT INTO `jc_channel_ext` VALUES(91,'软件',null,null,'0','0','1','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/download_2.html',null,null,null,1,0,139,139,310,310,0,1,0,'软件','软件','软件',0,0);
 INSERT INTO `jc_channel_ext` VALUES(92,'游戏',null,null,'0','0','1','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/download_2.html',null,null,null,1,0,139,139,310,310,0,1,0,'游戏','游戏','游戏',0,0);
 INSERT INTO `jc_channel_ext` VALUES(93,'工具',null,null,'0','0','1','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/download_2.html',null,null,null,1,0,139,139,310,310,0,1,0,'工具','工具','工具',0,0);
 INSERT INTO `jc_channel_ext` VALUES(94,'文化',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'文化','文化','文化',0,0);
 INSERT INTO `jc_channel_ext` VALUES(95,'历史',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'历史','历史','历史',0,0);
 INSERT INTO `jc_channel_ext` VALUES(96,'车情',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'车情','车情','车情',0,0);
 INSERT INTO `jc_channel_ext` VALUES(97,'图片',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'图片','图片','图片',0,0);
 INSERT INTO `jc_channel_ext` VALUES(98,'新车',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'新车','新车','新车',0,0);
 INSERT INTO `jc_channel_ext` VALUES(99,'维修',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'维修','维修','维修',0,0);
 INSERT INTO `jc_channel_ext` VALUES(100,'明星',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'明星','明星','明星',0,0);
 INSERT INTO `jc_channel_ext` VALUES(101,'八卦',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'八卦','八卦','八卦',0,0);
 INSERT INTO `jc_channel_ext` VALUES(102,'情感',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'情感','情感','情感',0,0);
 INSERT INTO `jc_channel_ext` VALUES(103,'IT',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/job.html',null,null,null,1,0,139,139,310,310,0,1,0,'IT','IT','IT',0,0);
 INSERT INTO `jc_channel_ext` VALUES(104,'通信',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/job.html',null,null,null,1,0,139,139,310,310,0,1,0,'通信','通信','通信',0,0);
 INSERT INTO `jc_channel_ext` VALUES(105,'家电',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/job.html',null,null,null,1,0,139,139,310,310,0,1,0,'家电','家电','家电',0,0);
 INSERT INTO `jc_channel_ext` VALUES(106,'电影',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/video.html',null,null,null,1,0,139,139,310,310,0,1,0,'电影','电影','电影',0,0);
 INSERT INTO `jc_channel_ext` VALUES(107,'综艺',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/video_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'综艺','综艺','综艺',0,0);
 INSERT INTO `jc_channel_ext` VALUES(108,'电视',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/video_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'电视剧','电视剧','电视剧',0,0);
 INSERT INTO `jc_channel_ext` VALUES(109,'教育',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/doc_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'教育','教育','教育',0,0);
 INSERT INTO `jc_channel_ext` VALUES(110,'科技',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/doc_sub.html',null,null,null,1,0,139,139,310,310,0,1,0,'科技','科技','科技',0,0);
 INSERT INTO `jc_channel_ext` VALUES(111,'网络调查',null,null,'0','0','0','0',20,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/news_net.html',null,null,null,0,0,139,139,310,310,0,1,0,null,null,null,0,0);
 INSERT INTO `jc_channel_ext` VALUES(112,'访谈',null,null,'0','0','0','0',10,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/interview.html',null,null,null,1,0,139,139,310,310,0,1,0,'访谈','访谈',null,0,0);
 INSERT INTO `jc_channel_ext` VALUES(113,'直播',null,null,'0','0','0','0',10,null,null,null,'/WEB-INF/html_front/cms/www/two/channel/live.html',null,null,null,1,0,139,139,310,310,0,1,0,'直播','直播',null,0,0);
DROP TABLE IF EXISTS jc_channel_model;
CREATE TABLE `jc_channel_model` (
  `channel_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL COMMENT '模型id',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '内容模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`channel_id`,`priority`),
  KEY `fk_jc_model_channel_m` (`model_id`),
  CONSTRAINT `fk_jc_channel_model_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_model_channel_m` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='栏目可选内容模型表';
 INSERT INTO `jc_channel_model` VALUES(69,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(69,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(69,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(69,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(69,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(69,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(69,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(69,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(70,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(70,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(70,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(70,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(70,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(70,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(70,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(70,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(71,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(71,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(71,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(71,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(71,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(71,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(71,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(71,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(72,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(72,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(72,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(72,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(72,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(72,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(72,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(72,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(73,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(73,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(73,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(73,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(73,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(73,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(73,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(73,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(74,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(74,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(74,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(74,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(74,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(74,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(74,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(74,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(75,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(75,3,'',1);
 INSERT INTO `jc_channel_model` VALUES(75,4,'',2);
 INSERT INTO `jc_channel_model` VALUES(75,5,'',3);
 INSERT INTO `jc_channel_model` VALUES(75,6,'',4);
 INSERT INTO `jc_channel_model` VALUES(75,7,'',5);
 INSERT INTO `jc_channel_model` VALUES(75,8,'',6);
 INSERT INTO `jc_channel_model` VALUES(75,9,'',7);
 INSERT INTO `jc_channel_model` VALUES(76,8,'',0);
 INSERT INTO `jc_channel_model` VALUES(77,6,'',0);
 INSERT INTO `jc_channel_model` VALUES(78,9,'',0);
 INSERT INTO `jc_channel_model` VALUES(79,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(79,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(79,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(80,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(80,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(80,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(81,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(81,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(81,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(82,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(82,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(82,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(83,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(83,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(83,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(84,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(84,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(84,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(85,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(85,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(85,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(86,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(86,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(86,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(87,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(87,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(87,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(88,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(89,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(90,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(91,4,'',0);
 INSERT INTO `jc_channel_model` VALUES(92,4,'',0);
 INSERT INTO `jc_channel_model` VALUES(93,4,'',0);
 INSERT INTO `jc_channel_model` VALUES(94,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(94,4,'',1);
 INSERT INTO `jc_channel_model` VALUES(94,5,'',2);
 INSERT INTO `jc_channel_model` VALUES(94,6,'',3);
 INSERT INTO `jc_channel_model` VALUES(94,9,'',4);
 INSERT INTO `jc_channel_model` VALUES(95,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(95,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(95,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(95,9,'',3);
 INSERT INTO `jc_channel_model` VALUES(96,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(96,6,'',1);
 INSERT INTO `jc_channel_model` VALUES(96,9,'',2);
 INSERT INTO `jc_channel_model` VALUES(97,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(97,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(97,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(98,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(98,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(99,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(99,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(99,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(100,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(100,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(100,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(101,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(101,5,'',1);
 INSERT INTO `jc_channel_model` VALUES(101,6,'',2);
 INSERT INTO `jc_channel_model` VALUES(102,1,'',0);
 INSERT INTO `jc_channel_model` VALUES(103,8,'',0);
 INSERT INTO `jc_channel_model` VALUES(104,8,'',0);
 INSERT INTO `jc_channel_model` VALUES(105,8,'',0);
 INSERT INTO `jc_channel_model` VALUES(106,6,'',0);
 INSERT INTO `jc_channel_model` VALUES(107,6,'',0);
 INSERT INTO `jc_channel_model` VALUES(108,6,'',0);
 INSERT INTO `jc_channel_model` VALUES(109,9,'',0);
 INSERT INTO `jc_channel_model` VALUES(110,9,'',0);
 INSERT INTO `jc_channel_model` VALUES(112,11,'/WEB-INF/html_front/cms/www/two/content/interview_content.html',0);
 INSERT INTO `jc_channel_model` VALUES(113,10,'',0);
DROP TABLE IF EXISTS jc_channel_txt;
CREATE TABLE `jc_channel_txt` (
  `channel_id` int(11) NOT NULL,
  `txt` longtext COMMENT '栏目内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`channel_id`),
  CONSTRAINT `fk_jc_txt_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目文本表';
DROP TABLE IF EXISTS jc_channel_user;
CREATE TABLE `jc_channel_user` (
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`user_id`),
  KEY `fk_jc_channel_user` (`user_id`),
  CONSTRAINT `fk_jc_channel_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目用户关联表';
DROP TABLE IF EXISTS jc_chnl_group_contri;
CREATE TABLE `jc_chnl_group_contri` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_c` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_c` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_c` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目投稿会员组关联表';
 INSERT INTO `jc_chnl_group_contri` VALUES(112,1);
 INSERT INTO `jc_chnl_group_contri` VALUES(113,1);
 INSERT INTO `jc_chnl_group_contri` VALUES(112,2);
 INSERT INTO `jc_chnl_group_contri` VALUES(113,2);
 INSERT INTO `jc_chnl_group_contri` VALUES(112,3);
 INSERT INTO `jc_chnl_group_contri` VALUES(113,3);
DROP TABLE IF EXISTS jc_chnl_group_view;
CREATE TABLE `jc_chnl_group_view` (
  `channel_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`group_id`),
  KEY `fk_jc_channel_group_v` (`group_id`),
  CONSTRAINT `fk_jc_channel_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_channel_v` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS栏目浏览会员组关联表';
 INSERT INTO `jc_chnl_group_view` VALUES(1,1);
DROP TABLE IF EXISTS jc_comment;
CREATE TABLE `jc_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_user_id` int(11) DEFAULT NULL COMMENT '评论用户ID',
  `reply_user_id` int(11) DEFAULT NULL COMMENT '回复用户ID',
  `content_id` int(11) NOT NULL COMMENT '内容ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `create_time` datetime NOT NULL COMMENT '评论时间',
  `reply_time` datetime DEFAULT NULL COMMENT '回复时间',
  `ups` smallint(6) NOT NULL DEFAULT '0' COMMENT '支持数',
  `downs` smallint(6) NOT NULL DEFAULT '0' COMMENT '反对数',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `score` int(11) DEFAULT NULL COMMENT '评分',
  PRIMARY KEY (`comment_id`),
  KEY `fk_jc_comment_content` (`content_id`),
  KEY `fk_jc_comment_reply` (`reply_user_id`),
  KEY `fk_jc_comment_site` (`site_id`),
  KEY `fk_jc_comment_user` (`comment_user_id`),
  CONSTRAINT `fk_jc_comment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_comment_reply` FOREIGN KEY (`reply_user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_comment_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_comment_user` FOREIGN KEY (`comment_user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='CMS评论表';
DROP TABLE IF EXISTS jc_comment_ext;
CREATE TABLE `jc_comment_ext` (
  `comment_id` int(11) NOT NULL,
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `text` longtext COMMENT '评论内容',
  `reply` longtext COMMENT '回复内容',
  KEY `fk_jc_ext_comment` (`comment_id`),
  CONSTRAINT `fk_jc_ext_comment` FOREIGN KEY (`comment_id`) REFERENCES `jc_comment` (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS评论扩展表';
DROP TABLE IF EXISTS jc_config;
CREATE TABLE `jc_config` (
  `config_id` int(11) NOT NULL,
  `context_path` varchar(20) DEFAULT '/JeeCms' COMMENT '部署路径',
  `servlet_point` varchar(20) DEFAULT NULL COMMENT 'Servlet挂载点',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `db_file_uri` varchar(50) NOT NULL DEFAULT '/dbfile.svl?n=' COMMENT '数据库附件访问地址',
  `is_upload_to_db` tinyint(1) NOT NULL DEFAULT '0' COMMENT '上传附件至数据库',
  `def_img` varchar(255) NOT NULL DEFAULT '/style/www/default/no_picture.gif' COMMENT '图片不存在时默认图片',
  `login_url` varchar(255) NOT NULL DEFAULT '/login.jspx' COMMENT '登录地址',
  `process_url` varchar(255) DEFAULT NULL COMMENT '登录后处理地址',
  `mark_on` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开启图片水印',
  `mark_width` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小宽度',
  `mark_height` int(11) NOT NULL DEFAULT '120' COMMENT '图片最小高度',
  `mark_image` varchar(100) DEFAULT '/r/cms/www/watermark.png' COMMENT '图片水印',
  `mark_content` varchar(100) NOT NULL DEFAULT 'www.wmtv.cn' COMMENT '文字水印内容',
  `mark_size` int(11) NOT NULL DEFAULT '20' COMMENT '文字水印大小',
  `mark_color` varchar(10) NOT NULL DEFAULT '#FF0000' COMMENT '文字水印颜色',
  `mark_alpha` int(11) NOT NULL DEFAULT '50' COMMENT '水印透明度（0-100）',
  `mark_position` int(11) NOT NULL DEFAULT '1' COMMENT '水印位置(0-5)',
  `mark_offset_x` int(11) NOT NULL DEFAULT '0' COMMENT 'x坐标偏移量',
  `mark_offset_y` int(11) NOT NULL DEFAULT '0' COMMENT 'y坐标偏移量',
  `count_clear_time` date NOT NULL COMMENT '计数器清除时间',
  `count_copy_time` datetime NOT NULL COMMENT '计数器拷贝时间',
  `download_code` varchar(32) NOT NULL DEFAULT 'cms' COMMENT '下载防盗链md5混淆码',
  `download_time` int(11) NOT NULL DEFAULT '12' COMMENT '下载有效时间（小时）',
  `email_host` varchar(50) DEFAULT NULL COMMENT '邮件发送服务器',
  `email_encoding` varchar(20) DEFAULT NULL COMMENT '邮件发送编码',
  `email_username` varchar(100) DEFAULT NULL COMMENT '邮箱用户名',
  `email_password` varchar(100) DEFAULT NULL COMMENT '邮箱密码',
  `email_personal` varchar(100) DEFAULT NULL COMMENT '邮箱发件人',
  `email_validate` tinyint(1) DEFAULT '0' COMMENT '开启邮箱验证',
  `office_home` varchar(255) NOT NULL COMMENT 'openoffice安装目录',
  `office_port` varchar(10) NOT NULL DEFAULT '8810' COMMENT 'openoffice端口',
  `swftools_home` varchar(255) NOT NULL COMMENT 'swftoos安装目录',
  `view_only_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '只有终审才能浏览内容页',
  `inside_site` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内网（通过站点路径区分站点）',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置表';
 INSERT INTO `jc_config` VALUES(1,null,null,80,'/dbfile.svl?n=',0,'/style/www/no_picture.gif','/login.jspx',null,1,120,120,'/style/www/watermark.png','www.wmtv.cn',40,'#FF0000',100,0,0,0,'2014-11-03','2014-11-03 08:57:24.0','cms',12,null,null,null,null,null,1,'D:/Program Files/OpenOffice3','8810','D:/SWFTools/pdf2swf.exe',0,0);
DROP TABLE IF EXISTS jc_config_attr;
CREATE TABLE `jc_config_attr` (
  `config_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_config` (`config_id`),
  CONSTRAINT `fk_jc_attr_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS配置属性表';
DROP TABLE IF EXISTS jc_config_item;
CREATE TABLE `jc_config_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型 "1":"字符串文本","2":"整型文本","3":"浮点型文本","4":"文本区","5":"日期","6":"下拉列表","7":"复选框","8":"单选框"',
  `is_required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必填',
  `category` int(11) NOT NULL DEFAULT '1' COMMENT '模型项目所属分类（1注册模型）',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_config` (`config_id`),
  CONSTRAINT `fk_jc_item_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='CMS配置模型项表';
DROP TABLE IF EXISTS jc_content;
CREATE TABLE `jc_content` (
  `content_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL COMMENT '栏目ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `type_id` int(11) NOT NULL COMMENT '属性ID',
  `model_id` int(11) NOT NULL COMMENT '模型ID',
  `site_id` int(11) NOT NULL COMMENT '站点ID',
  `sort_date` datetime NOT NULL COMMENT '排序日期',
  `top_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '固顶级别',
  `has_title_img` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有标题图',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '状态(0:草稿;1:审核中;2:审核通过;3:回收站；4:投稿)',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_site` (`site_id`),
  KEY `fk_jc_content_type` (`type_id`),
  KEY `fk_jc_content_user` (`user_id`),
  KEY `fk_jc_contentchannel` (`channel_id`),
  KEY `fk_jc_content_model` (`model_id`),
  CONSTRAINT `fk_jc_contentchannel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_jc_content_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`),
  CONSTRAINT `fk_jc_content_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_content_type` FOREIGN KEY (`type_id`) REFERENCES `jc_content_type` (`type_id`),
  CONSTRAINT `fk_jc_content_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=730 DEFAULT CHARSET=utf8 COMMENT='CMS内容表';
 INSERT INTO `jc_content` VALUES(710,80,1,1,1,1,'2014-10-11 22:45:36.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(711,81,1,2,1,1,'2014-10-12 10:03:53.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(712,81,1,2,1,1,'2014-10-12 21:16:38.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(714,82,1,1,1,1,'2014-10-14 17:13:09.0',0,1,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(715,81,1,2,1,1,'2014-10-14 17:23:23.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(716,81,1,1,1,1,'2014-10-14 17:34:38.0',0,0,1,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(718,81,1,4,1,1,'2014-10-15 12:32:36.0',0,0,1,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(719,85,1,2,5,1,'2014-10-15 14:11:04.0',0,1,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(720,80,1,3,1,1,'2014-10-15 14:43:02.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(721,80,1,3,1,1,'2014-10-15 14:44:28.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(722,81,1,3,1,1,'2014-10-15 14:44:55.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(723,82,1,3,1,1,'2014-10-15 14:45:45.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(724,82,1,3,1,1,'2014-10-15 14:48:02.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(725,80,1,1,1,1,'2014-10-15 17:24:01.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(726,81,1,2,1,1,'2014-10-16 22:28:21.0',0,0,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(727,85,1,2,5,1,'2014-11-01 10:13:46.0',0,1,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(728,86,1,3,5,1,'2014-11-01 10:27:55.0',0,1,0,2,0,0,0,0,0);
 INSERT INTO `jc_content` VALUES(729,112,1,1,11,1,'2014-11-03 08:57:13.0',0,0,0,2,1,0,0,0,0);
DROP TABLE IF EXISTS jc_content_attachment;
CREATE TABLE `jc_content_attachment` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `attachment_path` varchar(255) NOT NULL COMMENT '附件路径',
  `attachment_name` varchar(100) NOT NULL COMMENT '附件名称',
  `filename` varchar(100) DEFAULT NULL COMMENT '文件名',
  `download_count` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_jc_attachment_content` (`content_id`),
  CONSTRAINT `fk_jc_attachment_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容附件表';
 INSERT INTO `jc_content_attachment` VALUES(715,0,'/upload/www/201410/141731073a2q.jpg','1.jpg',null,0);
DROP TABLE IF EXISTS jc_content_attr;
CREATE TABLE `jc_content_attr` (
  `content_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_content` (`content_id`),
  CONSTRAINT `fk_jc_attr_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展属性表';
DROP TABLE IF EXISTS jc_content_channel;
CREATE TABLE `jc_content_channel` (
  `channel_id` int(11) NOT NULL,
  `content_id` int(11) NOT NULL,
  PRIMARY KEY (`channel_id`,`content_id`),
  KEY `fk_jc_channel_content` (`content_id`),
  CONSTRAINT `fk_jc_channel_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_content_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容栏目关联表';
 INSERT INTO `jc_content_channel` VALUES(80,710);
 INSERT INTO `jc_content_channel` VALUES(81,711);
 INSERT INTO `jc_content_channel` VALUES(81,712);
 INSERT INTO `jc_content_channel` VALUES(82,714);
 INSERT INTO `jc_content_channel` VALUES(81,715);
 INSERT INTO `jc_content_channel` VALUES(81,716);
 INSERT INTO `jc_content_channel` VALUES(81,718);
 INSERT INTO `jc_content_channel` VALUES(85,719);
 INSERT INTO `jc_content_channel` VALUES(80,720);
 INSERT INTO `jc_content_channel` VALUES(80,721);
 INSERT INTO `jc_content_channel` VALUES(81,722);
 INSERT INTO `jc_content_channel` VALUES(82,723);
 INSERT INTO `jc_content_channel` VALUES(82,724);
 INSERT INTO `jc_content_channel` VALUES(80,725);
 INSERT INTO `jc_content_channel` VALUES(81,726);
 INSERT INTO `jc_content_channel` VALUES(85,727);
 INSERT INTO `jc_content_channel` VALUES(86,728);
 INSERT INTO `jc_content_channel` VALUES(112,729);
DROP TABLE IF EXISTS jc_content_check;
CREATE TABLE `jc_content_check` (
  `content_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核步数',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `is_rejected` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否退回',
  `reviewer` int(11) DEFAULT NULL COMMENT '终审者',
  `check_date` datetime DEFAULT NULL COMMENT '终审时间',
  PRIMARY KEY (`content_id`),
  KEY `fk_jc_content_check_user` (`reviewer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容审核信息表';
 INSERT INTO `jc_content_check` VALUES(710,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(711,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(712,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(714,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(715,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(716,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(718,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(719,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(720,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(721,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(722,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(723,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(724,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(725,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(726,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(727,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(728,3,null,0,null,null);
 INSERT INTO `jc_content_check` VALUES(729,3,null,0,null,null);
DROP TABLE IF EXISTS jc_content_count;
CREATE TABLE `jc_content_count` (
  `content_id` int(11) NOT NULL,
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '总访问数',
  `views_month` int(11) NOT NULL DEFAULT '0' COMMENT '月访问数',
  `views_week` int(11) NOT NULL DEFAULT '0' COMMENT '周访问数',
  `views_day` int(11) NOT NULL DEFAULT '0' COMMENT '日访问数',
  `comments` int(11) NOT NULL DEFAULT '0' COMMENT '总评论数',
  `comments_month` int(11) NOT NULL DEFAULT '0' COMMENT '月评论数',
  `comments_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周评论数',
  `comments_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日评论数',
  `downloads` int(11) NOT NULL DEFAULT '0' COMMENT '总下载数',
  `downloads_month` int(11) NOT NULL DEFAULT '0' COMMENT '月下载数',
  `downloads_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周下载数',
  `downloads_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日下载数',
  `ups` int(11) NOT NULL DEFAULT '0' COMMENT '总顶数',
  `ups_month` int(11) NOT NULL DEFAULT '0' COMMENT '月顶数',
  `ups_week` smallint(6) NOT NULL DEFAULT '0' COMMENT '周顶数',
  `ups_day` smallint(6) NOT NULL DEFAULT '0' COMMENT '日顶数',
  `downs` int(11) NOT NULL DEFAULT '0' COMMENT '总踩数',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容计数表';
 INSERT INTO `jc_content_count` VALUES(710,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(711,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(712,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(714,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(715,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(716,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(718,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(719,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(720,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(721,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(722,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(723,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(724,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(725,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(726,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(727,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
 INSERT INTO `jc_content_count` VALUES(729,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0);
DROP TABLE IF EXISTS jc_content_doc;
CREATE TABLE `jc_content_doc` (
  `content_id` int(11) NOT NULL,
  `doc_path` varchar(255) NOT NULL COMMENT '文档路径',
  `swf_path` varchar(255) DEFAULT NULL COMMENT '转换的swf路径',
  `grain` int(11) NOT NULL DEFAULT '0' COMMENT '财富收益',
  `down_need` int(11) NOT NULL DEFAULT '0' COMMENT '下载需要财富',
  `is_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开放',
  `file_suffix` varchar(10) NOT NULL COMMENT '文档文件格式',
  `avg_score` float(11,1) NOT NULL DEFAULT '0.0' COMMENT '平均得分',
  `swf_num` int(11) NOT NULL DEFAULT '1' COMMENT 'swf文件总量',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文库相关';
DROP TABLE IF EXISTS jc_content_ext;
CREATE TABLE `jc_content_ext` (
  `content_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL COMMENT '标题',
  `short_title` varchar(150) DEFAULT NULL COMMENT '简短标题',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `origin` varchar(100) DEFAULT NULL COMMENT '来源',
  `origin_url` varchar(255) DEFAULT NULL COMMENT '来源链接',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `release_date` datetime NOT NULL COMMENT '发布日期',
  `media_path` varchar(255) DEFAULT NULL COMMENT '媒体路径',
  `media_type` varchar(20) DEFAULT NULL COMMENT '媒体类型',
  `title_color` varchar(10) DEFAULT NULL COMMENT '标题颜色',
  `is_bold` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加粗',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图片',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图片',
  `type_img` varchar(100) DEFAULT NULL COMMENT '类型图片',
  `link` varchar(255) DEFAULT NULL COMMENT '外部链接',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '指定模板',
  `need_regenerate` tinyint(1) NOT NULL DEFAULT '1' COMMENT '需要重新生成静态页',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_ext_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容扩展表';
 INSERT INTO `jc_content_ext` VALUES(710,'测试国际新闻',null,'凤飞飞',null,null,'测试国际新闻','2014-10-11 22:45:36.0',null,null,null,0,null,null,null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(711,'总理访欧微镜头：默克尔的良苦用心',null,null,null,null,null,'2014-10-12 10:03:53.0',null,null,null,0,null,null,'/upload/www/201410/12100300g0cw.jpeg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(712,'总理',null,null,null,null,null,'2014-10-12 21:16:38.0',null,null,null,0,null,null,'/upload/www/201410/12211625vrw3.jpeg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(714,'汉寿一农民抵押土地承包经营权 一纸权证贷款45万元',null,null,'湖南日报',null,'10月11日，汉寿县农民曾宪国通过抵押308亩土地承包经营权，从邮储银行汉寿县支行获得一笔金额45万元、期限2年的贷款。这也是邮储银行湖南省分行在汉寿县试点开办土地承包经营权抵押贷款后，发放的首笔土地流转经营权抵押贷款。','2014-10-14 17:13:09.0',null,null,'#004080',1,'http://news.ums365.com/upload/www/201410/14171143yvxd.jpg?d=1413277783943','/upload/www/201410/14171143yvxd.jpg',null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(715,'脉诊验孕挑战会不了了之？ 比赛委托人称能做成','脉诊验孕','袁野','中新网',null,'中西医大战其实不止一次了。有网友质疑此次争论最终会不了了之，而据阿宝委托人王志安微博透露，报名准备参加诊脉验孕的医生有好几位，并相信这事儿能做成。','2014-10-14 17:23:23.0',null,null,null,0,null,null,null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(716,'电梯安装实时监测系统 救援时间有望提速20%',null,null,null,null,null,'2014-10-14 17:34:38.0',null,null,null,0,null,null,null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(718,'习近平会见韩国新国家党党首 转达对朴槿惠问候',null,null,null,null,null,'2014-10-15 12:32:36.0',null,null,null,0,null,null,null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(719,'测试图库',null,null,null,null,null,'2014-10-15 14:11:04.0',null,null,null,0,'/upload/www/201410/15141226d9j2.jpg','/upload/www/201410/15141055382z.jpg','/upload/www/201410/15141250jn5n.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(720,'测试',null,null,null,null,null,'2014-10-15 14:43:02.0',null,null,null,0,null,null,'/upload/www/201410/15144248elim.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(721,'测试333',null,null,null,null,null,'2014-10-15 14:44:28.0',null,null,null,0,null,null,'/upload/www/201410/15144413o8db.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(722,'测试555',null,null,null,null,null,'2014-10-15 14:44:55.0',null,null,null,0,null,null,'/upload/www/201410/15144445h2lc.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(723,'社会123',null,null,null,null,null,'2014-10-15 14:45:45.0',null,null,null,0,null,null,'/upload/www/201410/1514453651no.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(724,'666',null,null,null,null,null,'2014-10-15 14:48:02.0',null,null,null,0,null,null,'/upload/www/201410/151447534jvy.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(725,'测试国际专题1',null,null,null,null,null,'2014-10-15 17:24:01.0',null,null,null,0,null,null,null,null,null,1);
 INSERT INTO `jc_content_ext` VALUES(726,'习近平：文艺不能当市场奴隶 不要沾满铜臭气',null,null,null,null,null,'2014-10-16 22:28:21.0',null,null,null,0,null,null,'/upload/www/201410/16222718ih3s.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(727,'测试图库123123',null,null,null,null,null,'2014-11-01 10:13:46.0',null,null,null,0,'/upload/www/201411/01101506lka1.jpg','/upload/www/201411/01101323ncmr.jpg','/upload/www/201411/01101302lf0j.jpg',null,null,1);
 INSERT INTO `jc_content_ext` VALUES(728,'阿凡达发达',null,null,null,null,null,'2014-11-01 10:27:55.0',null,null,null,0,'/upload/www/201411/01102826a9zx.jpg',null,'/upload/www/201411/01101639domv.jpg',null,'/WEB-INF/html_front/cms/www/two/content/pic.html',1);
 INSERT INTO `jc_content_ext` VALUES(729,'测试访谈',null,null,null,null,null,'2014-11-03 08:57:13.0','/upload/www/201411/030857059yg1.wmv','WM',null,0,null,null,null,null,'/WEB-INF/html_front/cms/www/two/content/interview_content.html',1);
DROP TABLE IF EXISTS jc_content_group_view;
CREATE TABLE `jc_content_group_view` (
  `content_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`group_id`),
  KEY `fk_jc_content_group_v` (`group_id`),
  CONSTRAINT `fk_jc_content_group_v` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`),
  CONSTRAINT `fk_jc_group_content_v` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容浏览会员组关联表';
DROP TABLE IF EXISTS jc_content_picture;
CREATE TABLE `jc_content_picture` (
  `content_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL COMMENT '排列顺序',
  `img_path` varchar(100) NOT NULL COMMENT '图片地址',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`content_id`,`priority`),
  CONSTRAINT `fk_jc_picture_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容图片表';
 INSERT INTO `jc_content_picture` VALUES(719,0,'/upload/www/201410/15141031ffz3.jpg','');
 INSERT INTO `jc_content_picture` VALUES(719,1,'/upload/www/201410/15141031699d.jpg','');
 INSERT INTO `jc_content_picture` VALUES(719,2,'/upload/www/201410/15141032z3yf.jpg','');
 INSERT INTO `jc_content_picture` VALUES(719,3,'/upload/www/201410/15141033d0xt.jpg','');
 INSERT INTO `jc_content_picture` VALUES(728,0,'/upload/www/201411/01103145iysd.jpg','');
 INSERT INTO `jc_content_picture` VALUES(728,1,'/upload/www/201411/01103156xo4t.jpg','');
DROP TABLE IF EXISTS jc_content_share_check;
CREATE TABLE `jc_content_share_check` (
  `share_check_id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) NOT NULL COMMENT '共享内容',
  `channel_id` int(11) NOT NULL COMMENT '共享栏目',
  `check_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 0待审核 1审核通过 2推送',
  `check_opinion` varchar(255) DEFAULT NULL COMMENT '审核意见',
  `share_valid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '共享有效性',
  PRIMARY KEY (`share_check_id`),
  KEY `fk_channel_jc_content_share` (`channel_id`),
  KEY `fk_check_jc_content_share` (`content_id`),
  CONSTRAINT `fk_channel_jc_content_share` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`),
  CONSTRAINT `fk_check_jc_content_share` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS共享内容审核信息表';
DROP TABLE IF EXISTS jc_content_tag;
CREATE TABLE `jc_content_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(50) NOT NULL COMMENT 'tag名称',
  `ref_counter` int(11) NOT NULL DEFAULT '1' COMMENT '被引用的次数',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `ak_tag_name` (`tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='CMS内容TAG表';
 INSERT INTO `jc_content_tag` VALUES(1,'测试',8);
 INSERT INTO `jc_content_tag` VALUES(2,'国际新闻',1);
 INSERT INTO `jc_content_tag` VALUES(3,'总理',2);
 INSERT INTO `jc_content_tag` VALUES(4,'访',1);
 INSERT INTO `jc_content_tag` VALUES(5,'欧',1);
 INSERT INTO `jc_content_tag` VALUES(6,'微',1);
 INSERT INTO `jc_content_tag` VALUES(7,'镜头',1);
 INSERT INTO `jc_content_tag` VALUES(8,'默克尔',1);
 INSERT INTO `jc_content_tag` VALUES(9,'的',1);
 INSERT INTO `jc_content_tag` VALUES(10,'良苦用心',1);
 INSERT INTO `jc_content_tag` VALUES(20,'汉寿',1);
 INSERT INTO `jc_content_tag` VALUES(21,'一',1);
 INSERT INTO `jc_content_tag` VALUES(22,'农民',1);
 INSERT INTO `jc_content_tag` VALUES(23,'抵押',1);
 INSERT INTO `jc_content_tag` VALUES(24,'土地',1);
 INSERT INTO `jc_content_tag` VALUES(25,'承包',1);
 INSERT INTO `jc_content_tag` VALUES(26,'经营权',1);
 INSERT INTO `jc_content_tag` VALUES(27,'一纸',1);
 INSERT INTO `jc_content_tag` VALUES(28,'权证',1);
 INSERT INTO `jc_content_tag` VALUES(29,'贷款',1);
 INSERT INTO `jc_content_tag` VALUES(30,'45',1);
 INSERT INTO `jc_content_tag` VALUES(31,'万元',1);
 INSERT INTO `jc_content_tag` VALUES(32,'脉诊验孕',1);
 INSERT INTO `jc_content_tag` VALUES(33,'电梯',1);
 INSERT INTO `jc_content_tag` VALUES(34,'安装',1);
 INSERT INTO `jc_content_tag` VALUES(35,'实时',1);
 INSERT INTO `jc_content_tag` VALUES(36,'监测',1);
 INSERT INTO `jc_content_tag` VALUES(37,'系统',1);
 INSERT INTO `jc_content_tag` VALUES(38,'救援',1);
 INSERT INTO `jc_content_tag` VALUES(39,'时间',1);
 INSERT INTO `jc_content_tag` VALUES(41,'习近平',2);
 INSERT INTO `jc_content_tag` VALUES(42,'会见',1);
 INSERT INTO `jc_content_tag` VALUES(43,'韩国',1);
 INSERT INTO `jc_content_tag` VALUES(44,'新',1);
 INSERT INTO `jc_content_tag` VALUES(45,'国家',1);
 INSERT INTO `jc_content_tag` VALUES(46,'党',1);
 INSERT INTO `jc_content_tag` VALUES(47,'党首',1);
 INSERT INTO `jc_content_tag` VALUES(48,'转达',1);
 INSERT INTO `jc_content_tag` VALUES(49,'对',1);
 INSERT INTO `jc_content_tag` VALUES(50,'朴',1);
 INSERT INTO `jc_content_tag` VALUES(51,'槿',1);
 INSERT INTO `jc_content_tag` VALUES(52,'惠',1);
 INSERT INTO `jc_content_tag` VALUES(53,'问候',1);
 INSERT INTO `jc_content_tag` VALUES(54,'图库',2);
 INSERT INTO `jc_content_tag` VALUES(55,'333',1);
 INSERT INTO `jc_content_tag` VALUES(56,'555',1);
 INSERT INTO `jc_content_tag` VALUES(57,'社会',1);
 INSERT INTO `jc_content_tag` VALUES(58,'123',1);
 INSERT INTO `jc_content_tag` VALUES(59,'666',1);
 INSERT INTO `jc_content_tag` VALUES(60,'国际',1);
 INSERT INTO `jc_content_tag` VALUES(61,'专题',1);
 INSERT INTO `jc_content_tag` VALUES(62,'1',1);
 INSERT INTO `jc_content_tag` VALUES(63,'文艺',1);
 INSERT INTO `jc_content_tag` VALUES(64,'不能',1);
 INSERT INTO `jc_content_tag` VALUES(65,'当',1);
 INSERT INTO `jc_content_tag` VALUES(66,'市场',1);
 INSERT INTO `jc_content_tag` VALUES(67,'奴隶',1);
 INSERT INTO `jc_content_tag` VALUES(68,'不要',1);
 INSERT INTO `jc_content_tag` VALUES(69,'沾满',1);
 INSERT INTO `jc_content_tag` VALUES(70,'铜臭气',1);
 INSERT INTO `jc_content_tag` VALUES(71,'123123',1);
 INSERT INTO `jc_content_tag` VALUES(72,'阿',1);
 INSERT INTO `jc_content_tag` VALUES(73,'凡',1);
 INSERT INTO `jc_content_tag` VALUES(74,'达',1);
 INSERT INTO `jc_content_tag` VALUES(75,'发达',1);
 INSERT INTO `jc_content_tag` VALUES(76,'访谈',1);
DROP TABLE IF EXISTS jc_content_topic;
CREATE TABLE `jc_content_topic` (
  `content_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`content_id`,`topic_id`),
  KEY `fk_jc_content_topic` (`topic_id`),
  CONSTRAINT `fk_jc_content_topic` FOREIGN KEY (`topic_id`) REFERENCES `jc_topic` (`topic_id`),
  CONSTRAINT `fk_jc_topic_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS专题内容关联表';
 INSERT INTO `jc_content_topic` VALUES(564,4);
 INSERT INTO `jc_content_topic` VALUES(334,5);
 INSERT INTO `jc_content_topic` VALUES(444,5);
 INSERT INTO `jc_content_topic` VALUES(446,5);
 INSERT INTO `jc_content_topic` VALUES(448,5);
 INSERT INTO `jc_content_topic` VALUES(509,5);
 INSERT INTO `jc_content_topic` VALUES(560,5);
 INSERT INTO `jc_content_topic` VALUES(508,6);
 INSERT INTO `jc_content_topic` VALUES(511,6);
 INSERT INTO `jc_content_topic` VALUES(725,9);
 INSERT INTO `jc_content_topic` VALUES(726,15);
 INSERT INTO `jc_content_topic` VALUES(727,16);
 INSERT INTO `jc_content_topic` VALUES(728,16);
DROP TABLE IF EXISTS jc_content_txt;
CREATE TABLE `jc_content_txt` (
  `content_id` int(11) NOT NULL,
  `txt` longtext COMMENT '文章内容',
  `txt1` longtext COMMENT '扩展内容1',
  `txt2` longtext COMMENT '扩展内容2',
  `txt3` longtext COMMENT '扩展内容3',
  PRIMARY KEY (`content_id`),
  CONSTRAINT `fk_jc_txt_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容文本表';
 INSERT INTO `jc_content_txt` VALUES(710,'<p>测试国际新闻</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(711,'<p>瓷器是中国的名片，欧洲制瓷工业就曾学习和借鉴过中国的制瓷技术。经过不断摸索创新，德国制瓷工业的技术现在已大为提高。皇家瓷器厂、梅森瓷器厂等公司出品的精品瓷器也已成为中国大商场里的畅销货。</p>\r\n<p>正如总理所说：&ldquo;瓷器发源地在中国，但德国等国家的水平大幅提高，有些地方甚至值得中国学习，所以中德之间可以互学互鉴。&rdquo;</p>\r\n<p><strong>【水煮牛肉VS勃兰登堡风味烤鸭】</strong></p>\r\n<p>在皇家瓷器厂的博凯里尼厅里，两国总理一起吃了今天的第二顿饭&mdash;&mdash;正式欢迎宴会之外的小范围晚宴。</p>\r\n<p>宴会是领导人出访日程中不可或缺的安排，但是和谁吃、吃什么、在哪里吃可是有讲究的。默克尔的这个安排既是因为她和总理良好的私人关系，也是为了答谢今年7月她访问中国时受到的热情接待。</p>\r\n<p>既然是小范围，参与的人数必然不多，除了两位总理，只有双方的10位官员。所用的杯盘碟盏就是由皇家瓷器厂制作的纯白色瓷器。皇家瓷器厂的瓷器都是纯手工制作，因为设计精美、工艺精湛而有&ldquo;白色黄金&rdquo;的美誉。</p>\r\n<p align=\"center\"><img align=\"\" alt=\"\" border=\"0\" src=\"http://news.ums365.com/upload/www/201410/14171946a8os.jpg\" /></p>\r\n<p align=\"center\"><img alt=\"\" src=\"/upload/www/201410/14172137ae77.jpg\" style=\"width: 438px; height: 290px;\" /></p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(712,'<p>测试测试测试</p>\r\n<p><img alt=\"\" src=\"/upload/www/201410/12211625vrw3.jpeg\" style=\"width: 640px; height: 420px;\" /></p>\r\n<p>&nbsp;</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(714,'<p>10月11日，汉寿县农民曾宪国通过抵押308亩土地承包经营权，从邮储银行汉寿县支行获得一笔金额45万元、期限2年的贷款。这也是邮储银行湖南省分行在汉寿县试点开办土地承包经营权抵押贷款后，发放的首笔土地流转经营权抵押贷款。</p>\r\n<p>据了解，曾宪国2011年开始经营养殖业，今年从村里承包了308亩鱼池8年的经营权，并且交清了全部租金，县政府对其颁发了农村土地承包经营权证。</p>\r\n<p>&ldquo;以前因为没有银行要求的传统抵押物房产等，只能贷到农户小额贷款3万至5万元。&rdquo;曾宪国介绍，&ldquo;今年新扎了40万只蚌，需要人工及生活费52万元。在一次性付清80万元鱼池租金后，资金周转出现了困难。&rdquo;邮储银行汉寿县支行的信贷员主动上门服务，并为他介绍了邮储银行湖南省分行创新推出的土地承包经营权抵押贷款。通过确权、评估、审查审批等手续后，最终顺利获得了贷款。</p>\r\n<p>没有抵押物难贷款，一直是发展规模化农业的一个瓶颈。邮储银行湖南省分行今年在各类传统涉农贷款的基础上，因地制宜在全省范围内开办了家庭农场贷款，并创新了诸如土地承包经营权抵押等担保方式，贷款金额最高可达500万元，期限最长达5年。(记者胡信松 通讯员晏鄂龙 肖羽含)</p>\r\n<p style=\"text-align: center;\"><img alt=\"\" src=\"http://news.ums365.com/upload/www/201410/14171143yvxd.jpg?d=1413277783943\" style=\"border-width: 0px; border-style: solid;\" /></p>\r\n<p style=\"text-align: right;\">[来源：湖南日报][责编：方路]</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(715,'<p align=\"center\"><img align=\"\" alt=\"脉诊验孕挑战会不了了之？比赛委托人称能做成\" border=\"0\" src=\"http://i3.sinaimg.cn/dy/o/2014-10-14/1413254091_yW7c6N.jpg\" width=\"550\" /></p>\r\n<p>中新网10月14日电(健康频道 袁野) 连日来，一场质疑 &ldquo;脉诊验孕&rdquo;准确率能否超过80%的微博战夺人眼球。北京积水潭烧伤科医师&ldquo;烧伤超人阿宝&rdquo;(以下简称&ldquo;阿宝&rdquo;)率先发起挑战，愿出奖金五万元，随后，北京中医药大学教师杨桢应战，挑战赛奖金也在部分人士赞助下追加到了10万元。成都老中医吕即来看到此消息后决定在成都开展一场更大、更全面的中西医较量，并表示，愿出20万作为奖金挑战多种病症。</p>\r\n<p>中西医大战其实不止一次了。有网友质疑此次争论最终会不了了之，而据阿宝委托人王志安微博透露，报名准备参加诊脉验孕的医生有好几位，并相信这事儿能做成。</p>\r\n<p><strong>阿宝 ：&ldquo;微博约战&rdquo;奖金已达10万元</strong></p>\r\n<p>9月13日，阿宝发了一条微博：《阿宝挑战中医脉诊大师公告》挑战对象：全国三甲医院副高及以上职称中医均可参加。挑战内容：中医脉诊妊娠与否，随机盲法测试。准确率超过80%为胜。奖励：挑战者无论胜负无需付任何代价。若胜利，阿宝将提供奖金五万元并终身不称中医为伪科学。欢迎爱好科学的土豪增加奖金。</p>\r\n<p>10月10日，阿宝表示，由于近期工作比较忙碌，他已将&ldquo;挑战赛&rdquo;事宜全权委托给媒体人王志安。</p>\r\n<p>10月 11日，阿宝通过微博发表对&ldquo;脉诊验孕&rdquo;的声明，称&ldquo;挑战赛&rdquo;的资金问题已解决，同时继续广发&ldquo;英雄帖&rdquo;，希望更多中医参与。目前，&ldquo;挑战赛&rdquo;奖金已在部分网友的赞助下追加到了10万元。</p>\r\n<p>目前，双方在脉诊验孕的医学伦理上产生争议。13日凌晨，阿宝发布置顶微博表示，脉诊并非新的技术，而是临床应用多年的无创技术，该技术没有造成受试者不良后果的可能。同时，这项活动不是临床研究，而是以临床研究的模式组织的挑战赛，以临床研究的法律手续要求本身就是荒唐的。</p>\r\n<p>阿宝在微博中还表示，&ldquo;如果13日晚10点之前杨桢医生依然不作出具体而有意义的回应。只能认为杨桢医生没有参加的诚意，视为弃权。&rdquo;</p>\r\n<p>作为新浪微博名人、科普人士，阿宝拥有32万多名粉丝。此前，他因批中医及发表&ldquo;口服胶原蛋白保健品全是骗人的&rdquo;等观点引发关注。</p>\r\n<p><strong>北京中医药大学方剂学教师杨桢：准确率不可能百分之百</strong></p>\r\n<p>阿宝的微博一出，北京中医药大学教师杨桢转发称，阿宝拉黑了他，无法报名很着急。后来，有网友替他报名应战。</p>\r\n<p>随后，杨桢发表了《有关&ldquo;脉诊验孕&rdquo;项目实施方案的备忘录》长微博，对实验方案进行了详细的解读，参加测试的育龄妇女共有32名，孕妇占到一半。杨桢医生与参试者之间用窗帘遮挡，不得见到对方的面貌、体形和任何其他有关的信息。 仅根据自己的切脉结果来判断参试者怀孕情况。</p>\r\n<p>最终，将通过脉诊准确率与尿检HCG阳性率的对比，评价切脉验孕的准确性是否达到80%。</p>\r\n<p>杨桢认为，脉象的可靠性非常高。接受《西安晚报》采访时杨桢表示，孕脉能够摸出来，应该是中医的基本功，但现在因为有了很多替代的检查方式，所以很多医生都不用这种方法。对于这场在微博中被视为中西医又一次交锋的挑战赛，杨桢希望，这场挑战是他与阿宝两人间的较量，不要升级为中西医之间的斗争。</p>\r\n<p>谈到脉诊验孕的准确性，杨桢坦言，&ldquo;脉诊验孕&rdquo;需要排除假阳性，准确率不可能达到百分之百。</p>\r\n<p>针对脉诊验孕的伦理争议，杨桢10月13日晚间回应称，备忘录里的建议对阿宝没有约束力，并表示比赛继续。&ldquo;阿宝是发起人，如果他认为不需要伦理审查，那就接着进行下去，不必在这上面纠结。&rdquo;</p>\r\n<p>[NextPage][/NextPage]</p>\r\n<p>&nbsp;</p>\r\n<p><strong>阿宝委托人王志安：相信这事儿能做成</strong></p>\r\n<p>接受阿宝委托后，王志安表示，按照项目的运行设置要求，需要至少二三十万元的花费，其中包含项目的管理、统计、生成报告，受试者必要体检、孕检等费用。这笔费用已得到&ldquo;小伙伴&rdquo;的支持和赞助。</p>\r\n<p>关于为何接受成为此次&ldquo;挑战赛&rdquo;的代理人、运作者，王志安坦言，他希望通过科学合理的方案设计，让这场&ldquo;擂台赛&rdquo;不同于微博上&ldquo;各说各话&rdquo;式吵架，而是寻找一个双方能够达成共识的方式，去检验最终的结果。由于双方就&ldquo;伦理&rdquo;等实验中涉及的问题未达成一致，挑战赛尚无时间表。</p>\r\n<p>13日中午，王志安发布微博称：&ldquo;目前报名准备参加诊脉验孕的医生有好几位，好事。我相信这事儿能做成，大家不必急，慢慢看。&rdquo;</p>\r\n<p><strong>老中医吕即来：希望更多人理性看待中西和西医</strong></p>\r\n<p>看到中医验孕的信息后，11日晚，吕即来决定在成都开展一场更大、更全面的中西医较量，并表示得到了众多同行的资金支持。&ldquo;有了他们的支持，加上我自己筹钱，我愿意出20万作为奖金。&rdquo;</p>\r\n<p>10月12日，吕即来通过微博报名参加中医验孕挑战。在微博上，他给阿宝委托人王志安发信息，自称在中医临床工作已22年，目前是中医执业医师。此外，吕即来还说，&ldquo;不但要验孕，还要挑战通过诊脉来判断还有几天来月经&rdquo;。</p>\r\n<p>吕即来通过《华西都市报》表示，每个学科都不是完美的，都有缺点，但不能因为一个缺点就否定一个传承了上千年的学科。他希望通过此次事件，能让更多人能更为理性的看待中医和西医。(中新网健康频道)</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(716,'<p align=\"center\"><img align=\"\" alt=\"\" border=\"0\" src=\"http://news.ums365.com/upload/www/201410/14173209t0h0.jpg\" /></p>\r\n<p>当监管、检验和维保人员增加的速度，远赶不上城市电梯增加的速度，如何有效维护电梯运行安全?质监部门请来&ldquo;科技君&rdquo;帮忙：将来被困电梯需要求助时，除了拨打救援电话96366之外，如果其所乘坐的电梯安装了运行实时监测设备，故障信息还将通过物联网系统自动通知救援单位。专家预测，长沙电梯安全应急处置有了&ldquo;双保险&rdquo;后，救援时间有望提速20%。</p>\r\n<p>随着城市建设规模的扩大以及高层建筑的增加，电梯数量激增。到今年9月底，长沙市注册登记的在用电梯数量为4.59万台。负责电梯监督管理和检验的人员只有135人，人机比矛盾日益突出。</p>\r\n<p>[NextPage][/NextPage]</p>\r\n<p>如何及时解决电梯困人等故障，提高市民出行安全系数?湖南省惟一的96366电梯应急处置救援平台于今年7月份在长沙市试运行。近日，国家质监总局副局长陈钢一行来到长沙市质监局96366应急处置中心，通过摄像头和麦克风，观看了一次应急救援演练，了解到救援人员到达现场平均用时为21分钟，现场实施救援平均用时为6分钟，充分肯定了这一立体平台的高效与及时。看到中心大型电子显示屏上显示的42个网格救援点标志时，他表示，希望能进一步提高救援点的密度，减小救援半径。(记者 周辉霞 实习生陈蕾)</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: right;\">[来源：长沙晚报][责编：苏仁]</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(718,'<p>新华网北京10月14日电 （记者 刘华）中共中央总书记、国家主席习近平14日在人民大会堂会见来华出席中韩政党政策对话首次会议的韩国新国家党党首金武星。</p>\r\n<p>　 　习近平强调，今年7月我对韩国进行了国事访问，同朴槿惠总统就充实和深化中韩战略合作伙伴关系达成一系列重要共识。中方愿同韩方共享发展机遇，共同应对 挑战，全面深化合作，为实现两国繁荣发展、促进地区和平稳定不懈努力。请你转达我对朴槿惠总统的诚挚问候和良好祝愿，我期待在亚太经合组织领导人非正式会 议期间同她会晤。</p>\r\n<p>　　习近平指出，中国共产党与韩国新国家党的交流与合作对促进两国关系发挥着重要作用。双方应该进一步加强高层交往、深化治国理政经验交流、推进青年政治家友好往来，为构筑更加成熟、更高水平的中韩战略合作伙伴关系作出积极贡献。</p>\r\n<p>　　金武星转达了朴槿惠总统对习近平总书记的问候。他表示，自建交以来，特别是在两国元首的亲自引领和推动下，韩中关系获得举世瞩目的发展。韩国新国家党愿通过政党对话同中方加强沟通，分享经验，推动两国关系不断深化，也衷心祝愿中国早日实现伟大的中国梦。</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(725,'<p>测试国际专题1</p>\r\n',null,null,null);
 INSERT INTO `jc_content_txt` VALUES(726,'<p style=\"TEXT-INDENT: 2em\">“文艺是时代前进的号角，最能代表一个时代的风貌，最能引领一个时代的风气。实现“两个一百\r\n年”奋斗目标、实现中华民族伟大复兴的中国梦，文艺的作用不可替代，文艺工作者大有可为。广大文艺工作者要从这样的高度认识文艺的地位和作用，认识自己所\r\n担负的历史使命和责任，坚持以人民为中心的创作导向，努力创作更多无愧于时代的优秀作品，弘扬中国精神、凝聚中国力量，鼓舞全国各族人民朝气蓬勃迈向未\r\n来。”</p><p style=\"TEXT-INDENT: 2em\"><strong>文艺不能在市场经济大潮中迷失方向</strong></p><p style=\"TEXT-INDENT: 2em\">习\r\n近平强调，改革开放以来，我国文艺创作迎来了新的春天，产生了大量脍炙人口的优秀作品。同时，也不能否认，在文艺创作方面，也存在着有数量缺质量、有“高\r\n原”缺“高峰”的现象，存在着抄袭模仿、千篇一律的问题，存在着机械化生产、快餐式消费的问题。文艺不能在市场经济大潮中迷失方向，不能在为什么人的问题\r\n上发生偏差，否则文艺就没有生命力。低俗不是通俗，欲望不代表希望，单纯感官娱乐不等于精神快乐。</p><p style=\"TEXT-INDENT: 2em\"><strong>我国作家艺术家应该成为时代风气的先觉者、先行者、先倡者</strong></p><p style=\"TEXT-INDENT: 2em\">习近平指出，繁荣文艺创作、推动文艺创新，必须有大批德艺双馨的文艺名家。我国作家艺术家应该成为时代风气的先觉者、先行者、先倡者，通过更多有筋骨、有道德、有温度的文艺作品，书写和记录人民的伟大实践、时代的进步要求，彰显信仰之美、崇高之美。</p><p style=\"TEXT-INDENT: 2em\"><strong>文学戏剧电影等要跟上时代发展<br/></strong></p><p style=\"TEXT-INDENT: 2em\">习\r\n近平指出，随着人民生活水平不断提高，人民对包括文艺作品在内的文化产品的质量、品位、风格等的要求也更高了。文学、戏剧、电影、电视、音乐、舞蹈、美\r\n术、摄影、书法、曲艺、杂技以及民间文艺、群众文艺等各领域都要跟上时代发展、把握人民需求，以充沛的激情、生动的笔触、优美的旋律、感人的形象创作生产\r\n出人民喜闻乐见的优秀作品，让人民精神文化生活不断迈上新台阶。</p><p style=\"TEXT-INDENT: 2em\"><img src=\"/upload/www/201410/16222718ih3s.jpg\" height=\"318\" width=\"500\"/></p><p><br/></p>',null,null,null);
DROP TABLE IF EXISTS jc_content_type;
CREATE TABLE `jc_content_type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(20) NOT NULL COMMENT '名称',
  `img_width` int(11) DEFAULT NULL COMMENT '图片宽',
  `img_height` int(11) DEFAULT NULL COMMENT '图片高',
  `has_image` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容类型表';
 INSERT INTO `jc_content_type` VALUES(1,'普通',100,100,0,0);
 INSERT INTO `jc_content_type` VALUES(2,'图文',143,98,1,0);
 INSERT INTO `jc_content_type` VALUES(3,'焦点',280,200,1,0);
 INSERT INTO `jc_content_type` VALUES(4,'头条',0,0,0,0);
DROP TABLE IF EXISTS jc_contenttag;
CREATE TABLE `jc_contenttag` (
  `content_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `priority` int(11) NOT NULL,
  KEY `fk_jc_content_tag` (`tag_id`),
  KEY `fk_jc_tag_content` (`content_id`),
  CONSTRAINT `fk_jc_content_tag` FOREIGN KEY (`tag_id`) REFERENCES `jc_content_tag` (`tag_id`),
  CONSTRAINT `fk_jc_tag_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS内容标签关联表';
 INSERT INTO `jc_contenttag` VALUES(710,1,0);
 INSERT INTO `jc_contenttag` VALUES(710,2,1);
 INSERT INTO `jc_contenttag` VALUES(711,3,0);
 INSERT INTO `jc_contenttag` VALUES(711,4,1);
 INSERT INTO `jc_contenttag` VALUES(711,5,2);
 INSERT INTO `jc_contenttag` VALUES(711,6,3);
 INSERT INTO `jc_contenttag` VALUES(711,7,4);
 INSERT INTO `jc_contenttag` VALUES(711,8,5);
 INSERT INTO `jc_contenttag` VALUES(711,9,6);
 INSERT INTO `jc_contenttag` VALUES(711,10,7);
 INSERT INTO `jc_contenttag` VALUES(712,3,0);
 INSERT INTO `jc_contenttag` VALUES(714,20,0);
 INSERT INTO `jc_contenttag` VALUES(714,21,1);
 INSERT INTO `jc_contenttag` VALUES(714,22,2);
 INSERT INTO `jc_contenttag` VALUES(714,23,3);
 INSERT INTO `jc_contenttag` VALUES(714,24,4);
 INSERT INTO `jc_contenttag` VALUES(714,25,5);
 INSERT INTO `jc_contenttag` VALUES(714,26,6);
 INSERT INTO `jc_contenttag` VALUES(714,27,7);
 INSERT INTO `jc_contenttag` VALUES(714,28,8);
 INSERT INTO `jc_contenttag` VALUES(714,29,9);
 INSERT INTO `jc_contenttag` VALUES(714,30,10);
 INSERT INTO `jc_contenttag` VALUES(714,31,11);
 INSERT INTO `jc_contenttag` VALUES(715,32,0);
 INSERT INTO `jc_contenttag` VALUES(716,33,0);
 INSERT INTO `jc_contenttag` VALUES(716,34,1);
 INSERT INTO `jc_contenttag` VALUES(716,35,2);
 INSERT INTO `jc_contenttag` VALUES(716,36,3);
 INSERT INTO `jc_contenttag` VALUES(716,37,4);
 INSERT INTO `jc_contenttag` VALUES(716,38,5);
 INSERT INTO `jc_contenttag` VALUES(716,39,6);
 INSERT INTO `jc_contenttag` VALUES(718,41,0);
 INSERT INTO `jc_contenttag` VALUES(718,42,1);
 INSERT INTO `jc_contenttag` VALUES(718,43,2);
 INSERT INTO `jc_contenttag` VALUES(718,44,3);
 INSERT INTO `jc_contenttag` VALUES(718,45,4);
 INSERT INTO `jc_contenttag` VALUES(718,46,5);
 INSERT INTO `jc_contenttag` VALUES(718,47,6);
 INSERT INTO `jc_contenttag` VALUES(718,48,7);
 INSERT INTO `jc_contenttag` VALUES(718,49,8);
 INSERT INTO `jc_contenttag` VALUES(718,50,9);
 INSERT INTO `jc_contenttag` VALUES(718,51,10);
 INSERT INTO `jc_contenttag` VALUES(718,52,11);
 INSERT INTO `jc_contenttag` VALUES(718,53,12);
 INSERT INTO `jc_contenttag` VALUES(719,1,0);
 INSERT INTO `jc_contenttag` VALUES(719,54,1);
 INSERT INTO `jc_contenttag` VALUES(720,1,0);
 INSERT INTO `jc_contenttag` VALUES(721,1,0);
 INSERT INTO `jc_contenttag` VALUES(721,55,1);
 INSERT INTO `jc_contenttag` VALUES(722,1,0);
 INSERT INTO `jc_contenttag` VALUES(722,56,1);
 INSERT INTO `jc_contenttag` VALUES(723,57,0);
 INSERT INTO `jc_contenttag` VALUES(723,58,1);
 INSERT INTO `jc_contenttag` VALUES(724,59,0);
 INSERT INTO `jc_contenttag` VALUES(725,1,0);
 INSERT INTO `jc_contenttag` VALUES(725,60,1);
 INSERT INTO `jc_contenttag` VALUES(725,61,2);
 INSERT INTO `jc_contenttag` VALUES(725,62,3);
 INSERT INTO `jc_contenttag` VALUES(726,41,0);
 INSERT INTO `jc_contenttag` VALUES(726,63,1);
 INSERT INTO `jc_contenttag` VALUES(726,64,2);
 INSERT INTO `jc_contenttag` VALUES(726,65,3);
 INSERT INTO `jc_contenttag` VALUES(726,66,4);
 INSERT INTO `jc_contenttag` VALUES(726,67,5);
 INSERT INTO `jc_contenttag` VALUES(726,68,6);
 INSERT INTO `jc_contenttag` VALUES(726,69,7);
 INSERT INTO `jc_contenttag` VALUES(726,70,8);
 INSERT INTO `jc_contenttag` VALUES(727,1,0);
 INSERT INTO `jc_contenttag` VALUES(727,54,1);
 INSERT INTO `jc_contenttag` VALUES(727,71,2);
 INSERT INTO `jc_contenttag` VALUES(728,72,0);
 INSERT INTO `jc_contenttag` VALUES(728,73,1);
 INSERT INTO `jc_contenttag` VALUES(728,74,2);
 INSERT INTO `jc_contenttag` VALUES(728,75,3);
 INSERT INTO `jc_contenttag` VALUES(729,1,0);
 INSERT INTO `jc_contenttag` VALUES(729,76,1);
DROP TABLE IF EXISTS jc_department;
CREATE TABLE `jc_department` (
  `depart_id` int(11) NOT NULL AUTO_INCREMENT,
  `depart_name` varchar(255) NOT NULL DEFAULT '' COMMENT '部门名称',
  `site_id` int(11) DEFAULT '0' COMMENT '站点',
  `priority` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `weights` int(11) NOT NULL DEFAULT '1' COMMENT '权重(值越大，级别越高)',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级部门ID',
  PRIMARY KEY (`depart_id`),
  KEY `fk_jc_department_site` (`site_id`),
  KEY `fk_jc_jc_department_parent` (`parent_id`),
  CONSTRAINT `fk_jc_jc_department_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='部门';
 INSERT INTO `jc_department` VALUES(1,'一级部门',null,1,1,null);
DROP TABLE IF EXISTS jc_dictionary;
CREATE TABLE `jc_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'name',
  `value` varchar(255) NOT NULL COMMENT 'value',
  `type` varchar(255) NOT NULL COMMENT 'type',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='字典表';
 INSERT INTO `jc_dictionary` VALUES(1,'10-20人','10-20人','scale');
 INSERT INTO `jc_dictionary` VALUES(2,'20-50人','20-50人','scale');
 INSERT INTO `jc_dictionary` VALUES(3,'50-10人','50-10人','scale');
 INSERT INTO `jc_dictionary` VALUES(4,'100人以上','100人以上','scale');
 INSERT INTO `jc_dictionary` VALUES(5,'私企','私企','nature');
 INSERT INTO `jc_dictionary` VALUES(6,'股份制','股份制','nature');
 INSERT INTO `jc_dictionary` VALUES(7,'国企','国企','nature');
 INSERT INTO `jc_dictionary` VALUES(8,'互联网','互联网','industry');
 INSERT INTO `jc_dictionary` VALUES(9,'房地产','房地产','industry');
 INSERT INTO `jc_dictionary` VALUES(10,'加工制造','加工制造','industry');
 INSERT INTO `jc_dictionary` VALUES(11,'服务行业','服务行业','industry');
DROP TABLE IF EXISTS jc_directive_tpl;
CREATE TABLE `jc_directive_tpl` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `description` varchar(1000) DEFAULT NULL COMMENT '标签描述',
  `code` text COMMENT '标签代码',
  `user_id` int(11) NOT NULL COMMENT '标签创建者',
  PRIMARY KEY (`tpl_id`),
  KEY `fk_jc_directive_tpl_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COMMENT='FComment';
DROP TABLE IF EXISTS jc_file;
CREATE TABLE `jc_file` (
  `file_path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(255) DEFAULT '' COMMENT '文件名字',
  `file_isvalid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有效',
  `content_id` int(11) DEFAULT NULL COMMENT '内容id',
  PRIMARY KEY (`file_path`),
  KEY `fk_jc_file_content` (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 INSERT INTO `jc_file` VALUES('/upload/www/201410/120957148bj6.jpeg','112263456.jpeg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/12100300g0cw.jpeg','112263456.jpeg',1,711);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/12211625vrw3.jpeg','112263456.jpeg',1,712);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/141707113iq7.jpg','挖掘机.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/14171143yvxd.jpg','3.jpg',1,714);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/141725428ec8.jpg','A6RSD84354A50026.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/141731073a2q.jpg','1.jpg',1,715);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/141731393vki.avi','/upload/www/201410/141731393vki.avi',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15131723qel9.jpg','/upload/www/201410/15131723qel9.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/151410436d9h.jpg','22.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15141055382z.jpg','23.jpg',1,719);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15141147n2rl.jpg','23.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15141226d9j2.jpg','24.jpg',1,719);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15141250jn5n.jpg','26.jpg',1,719);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15144248elim.jpg','24.jpg',1,720);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15144413o8db.jpg','24.jpg',1,721);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15144445h2lc.jpg','26.jpg',1,722);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/1514453651no.jpg','24.jpg',1,723);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15144738xlsg.jpg','22.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/151447534jvy.jpg','24.jpg',1,724);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/151717431apw.jpg','2.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/15171752bxsp.jpg','1.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/16091022be0p.jpg','22.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/16222718ih3s.jpg','112436593.jpg',1,726);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/162252549jkw.jpg','112436593.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201410/16225318gisu.jpg','112436593.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01095330nqbh.jpg','Penguins.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01095650e9si.jpg','Penguins.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01100119wke6.jpg','Tulips.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/0110040613ij.jpg','Desert.jpg',0,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01101302lf0j.jpg','Penguins.jpg',1,727);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01101323ncmr.jpg','Tulips.jpg',1,727);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01101506lka1.jpg','Tulips.jpg',1,727);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01101639domv.jpg','Koala.jpg',1,728);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/01102826a9zx.jpg','Hydrangeas.jpg',1,728);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/020912442izn.jpg','Tulips.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/020913059c24.jpg','Desert.jpg',1,null);
 INSERT INTO `jc_file` VALUES('/upload/www/201411/030857059yg1.wmv','/upload/www/201411/030857059yg1.wmv',1,729);
DROP TABLE IF EXISTS jc_friendlink;
CREATE TABLE `jc_friendlink` (
  `friendlink_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_id` int(11) NOT NULL,
  `site_name` varchar(150) NOT NULL COMMENT '网站名称',
  `domain` varchar(255) NOT NULL COMMENT '网站地址',
  `logo` varchar(150) DEFAULT NULL COMMENT '图标',
  `email` varchar(100) DEFAULT NULL COMMENT '站长邮箱',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `views` int(11) NOT NULL DEFAULT '0' COMMENT '点击次数',
  `is_enabled` char(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlink_id`),
  KEY `fk_jc_ctg_friendlink` (`friendlinkctg_id`),
  KEY `fk_jc_friendlink_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_friendlink` FOREIGN KEY (`friendlinkctg_id`) REFERENCES `jc_friendlink_ctg` (`friendlinkctg_id`),
  CONSTRAINT `fk_jc_friendlink_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接';
 INSERT INTO `jc_friendlink` VALUES(3,1,2,'京东商城','http://www.360buy.com/','/u/cms/www/201112/1910271036lr.gif','','',3,'1',10);
 INSERT INTO `jc_friendlink` VALUES(4,1,2,'当当网','http://www.dangdang.com/','/u/cms/www/201112/191408344rwj.gif','','',1,'1',10);
 INSERT INTO `jc_friendlink` VALUES(5,1,2,'亚马逊','http://www.amazon.cn/','/u/cms/www/201112/19141012lh2q.gif','','',1,'1',10);
 INSERT INTO `jc_friendlink` VALUES(6,1,2,'ihush','http://www.ihush.com/','/u/cms/www/201112/19141255yrfb.gif','','',1,'1',10);
DROP TABLE IF EXISTS jc_friendlink_ctg;
CREATE TABLE `jc_friendlink_ctg` (
  `friendlinkctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `friendlinkctg_name` varchar(50) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  PRIMARY KEY (`friendlinkctg_id`),
  KEY `fk_jc_friendlinkctg_site` (`site_id`),
  CONSTRAINT `fk_jc_friendlinkctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS友情链接类别';
 INSERT INTO `jc_friendlink_ctg` VALUES(1,1,'文字链接',1);
 INSERT INTO `jc_friendlink_ctg` VALUES(2,1,'品牌专区（图片链接）',2);
DROP TABLE IF EXISTS jc_group;
CREATE TABLE `jc_group` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `need_captcha` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要验证码',
  `need_check` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否需要审核',
  `allow_per_day` int(11) NOT NULL DEFAULT '4096' COMMENT '每日允许上传KB',
  `allow_max_file` int(11) NOT NULL DEFAULT '1024' COMMENT '每个文件最大KB',
  `allow_suffix` varchar(255) DEFAULT 'jpg,jpeg,gif,png,bmp' COMMENT '允许上传的后缀',
  `is_reg_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认会员组',
  `allow_file_size` int(11) NOT NULL DEFAULT '4096' COMMENT '每个上传文库的文件大小限制kB',
  `allow_file_total` int(11) NOT NULL DEFAULT '0' COMMENT '上传总数限制(0没有限制)',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='CMS会员组表';
 INSERT INTO `jc_group` VALUES(1,'普通会员',10,1,1,0,0,'',1,4096,0);
 INSERT INTO `jc_group` VALUES(2,'高级组',10,1,1,0,0,'',0,4096,0);
 INSERT INTO `jc_group` VALUES(3,'vip',10,1,1,0,0,'',0,4096,0);
DROP TABLE IF EXISTS jc_guestbook;
CREATE TABLE `jc_guestbook` (
  `guestbook_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `guestbookctg_id` int(11) NOT NULL,
  `member_id` int(11) DEFAULT NULL COMMENT '留言会员',
  `admin_id` int(11) DEFAULT NULL COMMENT '回复管理员',
  `ip` varchar(50) NOT NULL COMMENT '留言IP',
  `create_time` datetime NOT NULL COMMENT '留言时间',
  `replay_time` datetime DEFAULT NULL COMMENT '回复时间',
  `is_checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`guestbook_id`),
  KEY `fk_jc_ctg_guestbook` (`guestbookctg_id`),
  KEY `fk_jc_guestbook_admin` (`admin_id`),
  KEY `fk_jc_guestbook_member` (`member_id`),
  KEY `fk_jc_guestbook_site` (`site_id`),
  CONSTRAINT `fk_jc_ctg_guestbook` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_admin` FOREIGN KEY (`admin_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_member` FOREIGN KEY (`member_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_guestbook_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='CMS留言';
DROP TABLE IF EXISTS jc_guestbook_ctg;
CREATE TABLE `jc_guestbook_ctg` (
  `guestbookctg_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `ctg_name` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`guestbookctg_id`),
  KEY `fk_jc_guestbookctg_site` (`site_id`),
  CONSTRAINT `fk_jc_guestbookctg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS留言类别';
 INSERT INTO `jc_guestbook_ctg` VALUES(1,1,'普通',1,'普通留言');
 INSERT INTO `jc_guestbook_ctg` VALUES(2,1,'投诉',10,'投诉');
DROP TABLE IF EXISTS jc_guestbook_ctg_department;
CREATE TABLE `jc_guestbook_ctg_department` (
  `guestbookctg_id` int(11) NOT NULL,
  `depart_id` int(11) NOT NULL,
  PRIMARY KEY (`guestbookctg_id`,`depart_id`),
  KEY `fk_jc_channel_department` (`depart_id`),
  CONSTRAINT `fk_jc_department_guestbook_ctg` FOREIGN KEY (`guestbookctg_id`) REFERENCES `jc_guestbook_ctg` (`guestbookctg_id`),
  CONSTRAINT `fk_jc_guestbook_ctg_department` FOREIGN KEY (`depart_id`) REFERENCES `jc_department` (`depart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言类别部门关联表';
DROP TABLE IF EXISTS jc_guestbook_ext;
CREATE TABLE `jc_guestbook_ext` (
  `guestbook_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `content` longtext COMMENT '留言内容',
  `reply` longtext COMMENT '回复内容',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `qq` varchar(50) DEFAULT NULL COMMENT 'QQ',
  KEY `fk_jc_ext_guestbook` (`guestbook_id`),
  CONSTRAINT `fk_jc_ext_guestbook` FOREIGN KEY (`guestbook_id`) REFERENCES `jc_guestbook` (`guestbook_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS留言内容';
DROP TABLE IF EXISTS jc_job_apply;
CREATE TABLE `jc_job_apply` (
  `job_apply_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `content_id` int(11) NOT NULL COMMENT '职位id',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`job_apply_id`),
  KEY `fk_jc_job_apply_user` (`user_id`),
  KEY `fk_jc_job_apply_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_content` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_job_apply_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='职位申请表';
DROP TABLE IF EXISTS jc_keyword;
CREATE TABLE `jc_keyword` (
  `keyword_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL COMMENT '站点ID',
  `keyword_name` varchar(100) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '链接',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`keyword_id`),
  KEY `fk_jc_keyword_site` (`site_id`),
  CONSTRAINT `fk_jc_keyword_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS内容关键词表';
 INSERT INTO `jc_keyword` VALUES(1,null,'为民网','<a href=\"http://www.wmtv.cn/\" target=\"_blank\">为民网系统</a>',0);
DROP TABLE IF EXISTS jc_log;
CREATE TABLE `jc_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `category` int(11) NOT NULL COMMENT '日志类型',
  `log_time` datetime NOT NULL COMMENT '日志时间',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP地址',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL地址',
  `title` varchar(255) DEFAULT NULL COMMENT '日志标题',
  `content` varchar(255) DEFAULT NULL COMMENT '日志内容',
  PRIMARY KEY (`log_id`),
  KEY `fk_jc_log_site` (`site_id`),
  KEY `fk_jc_log_user` (`user_id`),
  CONSTRAINT `fk_jc_log_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_log_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8 COMMENT='CMS日志表';
 INSERT INTO `jc_log` VALUES(9,1,null,1,'2014-10-11 15:52:54.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(10,1,null,1,'2014-10-11 16:09:12.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(11,1,null,1,'2014-10-11 17:09:00.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(12,1,null,1,'2014-10-11 22:44:53.0','58.100.4.172','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(13,1,1,3,'2014-10-11 22:45:40.0','58.100.4.172','/s/content/o_save.do','增加文章','id=710;title=测试国际新闻');
 INSERT INTO `jc_log` VALUES(14,1,1,3,'2014-10-11 22:47:53.0','58.100.4.172','/s/site_config/o_base_update.do','站点基本设置',null);
 INSERT INTO `jc_log` VALUES(15,1,1,3,'2014-10-11 22:48:50.0','58.100.4.172','/s/config/o_system_update.do','修改系统设置',null);
 INSERT INTO `jc_log` VALUES(16,1,1,3,'2014-10-11 23:11:36.0','58.100.4.172','/s/channel/o_update.do','修改栏目','id=80;name=国际新闻');
 INSERT INTO `jc_log` VALUES(17,1,1,3,'2014-10-11 23:12:37.0','58.100.4.172','/s/model/o_update.do','修改模型','id=1;name=新闻');
 INSERT INTO `jc_log` VALUES(18,1,1,3,'2014-10-11 23:12:51.0','58.100.4.172','/s/model/o_update.do','修改模型','id=2;name=单页');
 INSERT INTO `jc_log` VALUES(19,1,1,3,'2014-10-11 23:14:08.0','58.100.4.172','/s/model/o_update.do','修改模型','id=3;name=作品');
 INSERT INTO `jc_log` VALUES(20,1,1,3,'2014-10-11 23:14:18.0','58.100.4.172','/s/model/o_update.do','修改模型','id=4;name=下载');
 INSERT INTO `jc_log` VALUES(21,1,1,3,'2014-10-11 23:14:30.0','58.100.4.172','/s/model/o_update.do','修改模型','id=5;name=图库');
 INSERT INTO `jc_log` VALUES(22,1,1,3,'2014-10-11 23:15:07.0','58.100.4.172','/s/model/o_update.do','修改模型','id=6;name=视频');
 INSERT INTO `jc_log` VALUES(23,1,1,3,'2014-10-11 23:15:23.0','58.100.4.172','/s/model/o_update.do','修改模型','id=7;name=产品');
 INSERT INTO `jc_log` VALUES(24,1,1,3,'2014-10-11 23:15:52.0','58.100.4.172','/s/model/o_update.do','修改模型','id=8;name=招聘');
 INSERT INTO `jc_log` VALUES(25,1,1,3,'2014-10-11 23:16:14.0','58.100.4.172','/s/model/o_update.do','修改模型','id=9;name=文库');
 INSERT INTO `jc_log` VALUES(26,1,1,3,'2014-10-11 23:17:54.0','58.100.4.172','/s/model/o_update.do','修改模型','id=8;name=招聘');
 INSERT INTO `jc_log` VALUES(27,1,1,3,'2014-10-11 23:19:46.0','58.100.4.172','/s/model/o_update.do','修改模型','id=2;name=单页');
 INSERT INTO `jc_log` VALUES(28,1,null,1,'2014-10-12 09:53:19.0','58.100.4.172','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(29,1,1,3,'2014-10-12 09:59:27.0','58.100.4.172','/s/config/o_mark_update.do','修改水印设置',null);
 INSERT INTO `jc_log` VALUES(30,1,1,3,'2014-10-12 10:00:40.0','58.100.4.172','/s/config/o_system_update.do','修改系统设置',null);
 INSERT INTO `jc_log` VALUES(31,1,1,3,'2014-10-12 10:03:54.0','58.100.4.172','/s/content/o_save.do','增加文章','id=711;title=总理访欧微镜头：默克尔的良苦用心');
 INSERT INTO `jc_log` VALUES(32,1,null,1,'2014-10-12 21:15:54.0','58.100.4.172','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(33,1,1,3,'2014-10-12 21:16:40.0','58.100.4.172','/s/content/o_save.do','增加文章','id=712;title=总理');
 INSERT INTO `jc_log` VALUES(34,1,1,3,'2014-10-12 21:17:36.0','58.100.4.172','/s/content/o_update.do','修改文章','id=712;title=总理');
 INSERT INTO `jc_log` VALUES(35,1,null,1,'2014-10-13 09:15:30.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(36,null,null,2,'2014-10-13 11:39:01.0','183.129.242.122','/s/login.do','login failure','username=ad');
 INSERT INTO `jc_log` VALUES(37,null,null,2,'2014-10-14 07:52:33.0','58.100.4.172','/s/login.do','login failure','username=a');
 INSERT INTO `jc_log` VALUES(38,1,null,1,'2014-10-14 16:52:51.0','175.10.134.102','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(39,1,null,1,'2014-10-14 16:57:16.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(40,1,null,1,'2014-10-14 16:57:26.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(41,1,null,1,'2014-10-14 17:00:03.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(42,1,null,1,'2014-10-14 17:01:29.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(43,1,null,1,'2014-10-14 17:03:20.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(44,null,null,2,'2014-10-14 17:04:14.0','222.240.202.100','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(45,null,null,2,'2014-10-14 17:04:24.0','222.240.202.100','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(46,1,null,1,'2014-10-14 17:04:33.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(47,1,1,3,'2014-10-14 17:09:33.0','222.240.202.100','/s/content/o_save.do','增加文章','id=713;title=循着刘先生提供的线索，三湘都市报记者');
 INSERT INTO `jc_log` VALUES(48,null,null,2,'2014-10-14 17:12:37.0','222.240.202.100','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(49,1,null,1,'2014-10-14 17:12:59.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(50,1,1,3,'2014-10-14 17:13:11.0','222.240.202.100','/s/content/o_save.do','增加文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(51,1,1,3,'2014-10-14 17:14:25.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(52,1,1,3,'2014-10-14 17:15:31.0','222.240.202.100','/s/content/o_delete.do','删除文章','id=713;title=循着刘先生提供的线索，三湘都市报记者');
 INSERT INTO `jc_log` VALUES(53,1,1,3,'2014-10-14 17:16:45.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(54,1,1,3,'2014-10-14 17:17:00.0','222.240.202.100','/s/content/o_update.do','修改文章','id=710;title=测试国际新闻');
 INSERT INTO `jc_log` VALUES(55,1,1,3,'2014-10-14 17:17:39.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(56,1,1,3,'2014-10-14 17:19:53.0','222.240.202.100','/s/content/o_update.do','修改文章','id=711;title=总理访欧微镜头：默克尔的良苦用心');
 INSERT INTO `jc_log` VALUES(57,1,1,3,'2014-10-14 17:20:50.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(58,1,1,3,'2014-10-14 17:22:28.0','222.240.202.100','/s/content/o_update.do','修改文章','id=711;title=总理访欧微镜头：默克尔的良苦用心');
 INSERT INTO `jc_log` VALUES(59,1,1,3,'2014-10-14 17:23:23.0','222.240.202.100','/s/content/o_save.do','增加文章','id=715;title=脉诊验孕挑战会不了了之？ 比赛委托人称能做成');
 INSERT INTO `jc_log` VALUES(60,1,1,3,'2014-10-14 17:28:08.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(61,1,1,3,'2014-10-14 17:29:43.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(62,1,1,3,'2014-10-14 17:30:35.0','222.240.202.100','/s/content/o_update.do','修改文章','id=714;title=汉寿一农民抵押土地承包经营权 一纸权证贷款45万元');
 INSERT INTO `jc_log` VALUES(63,1,1,3,'2014-10-14 17:32:14.0','222.240.202.100','/s/content/o_update.do','修改文章','id=715;title=脉诊验孕挑战会不了了之？ 比赛委托人称能做成');
 INSERT INTO `jc_log` VALUES(64,1,1,3,'2014-10-14 17:34:38.0','222.240.202.100','/s/content/o_save.do','增加文章','id=716;title=电梯安装实时监测系统 救援时间有望提速20%');
 INSERT INTO `jc_log` VALUES(65,1,null,1,'2014-10-15 09:39:49.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(66,1,null,1,'2014-10-15 12:20:49.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(67,1,1,3,'2014-10-15 12:26:00.0','183.129.242.122','/s/content/o_save.do','增加文章','id=717;title=测试图片');
 INSERT INTO `jc_log` VALUES(68,1,1,3,'2014-10-15 12:28:40.0','183.129.242.122','/s/content/o_update.do','修改文章','id=717;title=测试图片');
 INSERT INTO `jc_log` VALUES(69,1,1,3,'2014-10-15 12:31:38.0','183.129.242.122','/s/content/o_delete.do','删除文章','id=717;title=测试图片');
 INSERT INTO `jc_log` VALUES(70,1,1,3,'2014-10-15 12:32:36.0','183.129.242.122','/s/content/o_save.do','增加文章','id=718;title=习近平会见韩国新国家党党首 转达对朴槿惠问候');
 INSERT INTO `jc_log` VALUES(71,1,1,3,'2014-10-15 14:11:05.0','183.129.242.122','/s/content/o_save.do','增加文章','id=719;title=测试图库');
 INSERT INTO `jc_log` VALUES(72,1,1,3,'2014-10-15 14:13:00.0','183.129.242.122','/s/content/o_update.do','修改文章','id=719;title=测试图库');
 INSERT INTO `jc_log` VALUES(73,1,1,3,'2014-10-15 14:43:02.0','183.129.242.122','/s/content/o_save.do','增加文章','id=720;title=测试');
 INSERT INTO `jc_log` VALUES(74,1,1,3,'2014-10-15 14:44:28.0','183.129.242.122','/s/content/o_save.do','增加文章','id=721;title=测试333');
 INSERT INTO `jc_log` VALUES(75,1,1,3,'2014-10-15 14:44:55.0','183.129.242.122','/s/content/o_save.do','增加文章','id=722;title=测试555');
 INSERT INTO `jc_log` VALUES(76,1,1,3,'2014-10-15 14:45:46.0','183.129.242.122','/s/content/o_save.do','增加文章','id=723;title=社会123');
 INSERT INTO `jc_log` VALUES(77,1,1,3,'2014-10-15 14:48:02.0','183.129.242.122','/s/content/o_save.do','增加文章','id=724;title=666');
 INSERT INTO `jc_log` VALUES(78,1,null,1,'2014-10-15 17:05:48.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(79,1,null,1,'2014-10-15 17:07:40.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(80,1,null,1,'2014-10-15 17:08:19.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(81,1,1,3,'2014-10-15 17:17:55.0','222.240.202.100','/s/topic/o_save.do','增加专题','id=8;name=QQ群');
 INSERT INTO `jc_log` VALUES(82,1,1,3,'2014-10-15 17:22:03.0','222.240.202.100','/s/topic/o_update.do','修改专题','id=8;name=QQ群');
 INSERT INTO `jc_log` VALUES(83,1,1,3,'2014-10-15 17:22:43.0','183.129.242.122','/s/topic/o_save.do','增加专题','id=9;name=专题测试1');
 INSERT INTO `jc_log` VALUES(84,1,1,3,'2014-10-15 17:24:01.0','183.129.242.122','/s/content/o_save.do','增加文章','id=725;title=测试国际专题1');
 INSERT INTO `jc_log` VALUES(85,1,1,3,'2014-10-15 17:58:04.0','183.129.242.122','/s/topic/o_update.do','修改专题','id=9;name=专题测试1');
 INSERT INTO `jc_log` VALUES(86,1,1,3,'2014-10-15 18:01:26.0','183.129.242.122','/s/topic/o_update.do','修改专题','id=8;name=QQ群');
 INSERT INTO `jc_log` VALUES(87,1,1,3,'2014-10-15 18:01:32.0','183.129.242.122','/s/topic/o_update.do','修改专题','id=9;name=专题测试1');
 INSERT INTO `jc_log` VALUES(88,1,null,1,'2014-10-15 23:19:33.0','58.100.4.172','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(89,1,1,3,'2014-10-15 23:19:53.0','58.100.4.172','/s/content/o_update.do','修改文章','id=718;title=习近平会见韩国新国家党党首 转达对朴槿惠问候');
 INSERT INTO `jc_log` VALUES(90,1,1,3,'2014-10-15 23:20:07.0','58.100.4.172','/s/content/o_update.do','修改文章','id=716;title=电梯安装实时监测系统 救援时间有望提速20%');
 INSERT INTO `jc_log` VALUES(91,1,1,3,'2014-10-15 23:21:04.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=10;name=专题2');
 INSERT INTO `jc_log` VALUES(92,1,1,3,'2014-10-15 23:21:14.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=11;name=专题3');
 INSERT INTO `jc_log` VALUES(93,1,1,3,'2014-10-15 23:21:22.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=12;name=专题4');
 INSERT INTO `jc_log` VALUES(94,1,1,3,'2014-10-15 23:21:30.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=13;name=专题5');
 INSERT INTO `jc_log` VALUES(95,1,1,3,'2014-10-15 23:21:38.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=14;name=专题6');
 INSERT INTO `jc_log` VALUES(96,1,1,3,'2014-10-15 23:21:47.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=15;name=专题7');
 INSERT INTO `jc_log` VALUES(97,1,1,3,'2014-10-15 23:24:34.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=15;name=专题7');
 INSERT INTO `jc_log` VALUES(98,1,1,3,'2014-10-15 23:24:48.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=14;name=专题6');
 INSERT INTO `jc_log` VALUES(99,1,1,3,'2014-10-15 23:24:59.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=13;name=专题5');
 INSERT INTO `jc_log` VALUES(100,1,1,3,'2014-10-15 23:25:18.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=12;name=专题4');
 INSERT INTO `jc_log` VALUES(101,1,1,3,'2014-10-15 23:25:28.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=10;name=专题2');
 INSERT INTO `jc_log` VALUES(102,1,1,3,'2014-10-15 23:25:40.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=11;name=专题3');
 INSERT INTO `jc_log` VALUES(103,1,1,3,'2014-10-15 23:25:54.0','58.100.4.172','/s/topic/o_update.do','修改专题','id=9;name=专题测试1');
 INSERT INTO `jc_log` VALUES(104,1,null,1,'2014-10-16 09:03:49.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(105,1,1,3,'2014-10-16 09:07:52.0','183.129.242.122','/s/config/o_mark_update.do','修改水印设置',null);
 INSERT INTO `jc_log` VALUES(106,1,null,1,'2014-10-16 12:30:00.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(107,null,null,2,'2014-10-16 13:24:47.0','183.129.242.122','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(108,1,null,1,'2014-10-16 13:24:54.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(109,1,null,1,'2014-10-16 15:23:14.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(110,1,null,1,'2014-10-16 19:40:41.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(111,1,null,1,'2014-10-16 22:25:55.0','58.100.4.172','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(112,1,1,3,'2014-10-16 22:28:25.0','58.100.4.172','/s/content/o_save.do','增加文章','id=726;title=习近平：文艺不能当市场奴隶 不要沾满铜臭气');
 INSERT INTO `jc_log` VALUES(113,1,1,3,'2014-10-16 22:53:41.0','58.100.4.172','/s/topic/o_save.do','增加专题','id=16;name=习近平座谈会');
 INSERT INTO `jc_log` VALUES(114,1,1,3,'2014-10-16 23:35:51.0','58.100.4.172','/s/channel/o_update.do','修改栏目','id=69;name=新闻');
 INSERT INTO `jc_log` VALUES(115,1,null,1,'2014-10-17 11:40:08.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(116,1,null,1,'2014-10-17 17:23:01.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(117,1,null,1,'2014-10-18 15:11:23.0','123.157.216.202','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(118,1,null,1,'2014-10-20 15:49:41.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(119,1,null,1,'2014-10-20 18:09:15.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(120,1,1,3,'2014-10-20 18:12:30.0','183.129.242.122','/s/template/o_save.do','增加模板','filename=test');
 INSERT INTO `jc_log` VALUES(121,1,1,3,'2014-10-20 18:13:22.0','183.129.242.122','/s/template/o_delete_single.do','删除模板','filename=/WEB-INF/html_front/cms/www/test.html');
 INSERT INTO `jc_log` VALUES(122,1,null,1,'2014-10-30 15:47:49.0','222.240.202.100','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(123,1,null,1,'2014-10-31 21:16:17.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(124,1,null,1,'2014-11-01 09:52:46.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(125,null,null,2,'2014-11-01 10:03:41.0','58.100.6.247','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(126,1,null,1,'2014-11-01 10:03:47.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(127,1,1,3,'2014-11-01 10:13:50.0','58.100.6.247','/s/content/o_save.do','增加文章','id=727;title=测试图库');
 INSERT INTO `jc_log` VALUES(128,1,1,3,'2014-11-01 10:15:20.0','58.100.6.247','/s/content/o_update.do','修改文章','id=727;title=测试图库123123');
 INSERT INTO `jc_log` VALUES(129,1,1,3,'2014-11-01 10:27:55.0','58.100.6.247','/s/content/o_save.do','增加文章','id=728;title=阿凡达发达');
 INSERT INTO `jc_log` VALUES(130,1,1,3,'2014-11-01 10:28:41.0','58.100.6.247','/s/content/o_update.do','修改文章','id=728;title=阿凡达发达');
 INSERT INTO `jc_log` VALUES(131,1,1,3,'2014-11-01 10:30:47.0','58.100.6.247','/s/content/o_update.do','修改文章','id=728;title=阿凡达发达');
 INSERT INTO `jc_log` VALUES(132,1,1,3,'2014-11-01 10:32:00.0','58.100.6.247','/s/content/o_update.do','修改文章','id=728;title=阿凡达发达');
 INSERT INTO `jc_log` VALUES(133,1,null,1,'2014-11-01 14:08:32.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(134,1,null,1,'2014-11-01 19:17:04.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(135,null,null,2,'2014-11-02 09:11:55.0','58.100.6.247','/s/login.do','login failure','username=admin');
 INSERT INTO `jc_log` VALUES(136,1,null,1,'2014-11-02 09:12:00.0','58.100.6.247','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(137,1,1,3,'2014-11-02 09:13:22.0','58.100.6.247','/s/topic/o_save.do','增加专题','id=17;name=abc专题');
 INSERT INTO `jc_log` VALUES(138,1,1,3,'2014-11-02 09:15:28.0','58.100.6.247','/s/topic/o_update.do','修改专题','id=17;name=abc专题');
 INSERT INTO `jc_log` VALUES(139,1,1,3,'2014-11-02 20:03:38.0','58.100.6.247','/s/model/o_save.do','增加模型','id=10;name=直播');
 INSERT INTO `jc_log` VALUES(140,1,1,3,'2014-11-02 20:04:34.0','58.100.6.247','/s/model/o_save.do','增加模型','id=11;name=访谈');
 INSERT INTO `jc_log` VALUES(141,1,null,1,'2014-11-02 20:20:35.0','127.0.0.1','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(142,1,1,3,'2014-11-02 20:25:16.0','127.0.0.1','/s/channel/o_save.do','增加栏目','id=112;title=null');
 INSERT INTO `jc_log` VALUES(143,1,1,3,'2014-11-02 20:26:27.0','127.0.0.1','/s/channel/o_save.do','增加栏目','id=113;title=null');
 INSERT INTO `jc_log` VALUES(144,1,1,3,'2014-11-02 20:27:20.0','127.0.0.1','/s/channel/o_update.do','修改栏目','id=76;name=招聘');
 INSERT INTO `jc_log` VALUES(145,1,1,3,'2014-11-02 20:28:28.0','127.0.0.1','/s/channel/o_update.do','修改栏目','id=112;name=访谈');
 INSERT INTO `jc_log` VALUES(146,1,1,3,'2014-11-02 20:28:41.0','127.0.0.1','/s/channel/o_update.do','修改栏目','id=113;name=直播');
 INSERT INTO `jc_log` VALUES(147,1,null,1,'2014-11-02 21:24:31.0','127.0.0.1','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(148,1,null,1,'2014-11-03 08:54:28.0','183.129.242.122','/s/login.do','login success',null);
 INSERT INTO `jc_log` VALUES(149,1,1,3,'2014-11-03 08:57:14.0','183.129.242.122','/s/content/o_save.do','增加文章','id=729;title=测试访谈');
 INSERT INTO `jc_log` VALUES(150,1,1,3,'2014-11-03 09:04:20.0','183.129.242.122','/s/channel/o_update.do','修改栏目','id=113;name=直播');
 INSERT INTO `jc_log` VALUES(151,1,1,3,'2014-11-03 09:04:34.0','183.129.242.122','/s/channel/o_update.do','修改栏目','id=112;name=访谈');
 INSERT INTO `jc_log` VALUES(152,1,1,3,'2014-11-03 18:32:11.0','183.129.242.122','/s/channel/o_update.do','修改栏目','id=113;name=直播');
 INSERT INTO `jc_log` VALUES(153,1,1,3,'2014-11-03 18:33:04.0','183.129.242.122','/s/channel/o_update.do','修改栏目','id=112;name=访谈');
 INSERT INTO `jc_log` VALUES(154,1,null,1,'2014-11-03 20:22:10.0','58.100.6.247','/s/login.do','login success',null);
DROP TABLE IF EXISTS jc_message;
CREATE TABLE `jc_message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  PRIMARY KEY (`msg_id`),
  KEY `fk_jc_message_user_send` (`msg_send_user`),
  KEY `fk_jc_message_user_receiver` (`msg_receiver_user`),
  KEY `fk_jc_message_site` (`site_id`),
  CONSTRAINT `fk_jc_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站内信';
DROP TABLE IF EXISTS jc_model;
CREATE TABLE `jc_model` (
  `model_id` int(11) NOT NULL,
  `model_name` varchar(100) NOT NULL COMMENT '名称',
  `model_path` varchar(100) NOT NULL COMMENT '路径',
  `tpl_channel_prefix` varchar(20) DEFAULT NULL COMMENT '栏目模板前缀',
  `tpl_content_prefix` varchar(20) DEFAULT NULL COMMENT '内容模板前缀',
  `title_img_width` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图宽度',
  `title_img_height` int(11) NOT NULL DEFAULT '139' COMMENT '栏目标题图高度',
  `content_img_width` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图宽度',
  `content_img_height` int(11) NOT NULL DEFAULT '310' COMMENT '栏目内容图高度',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `has_content` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有内容',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认模型',
  PRIMARY KEY (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS模型表';
 INSERT INTO `jc_model` VALUES(1,'新闻','1','news','news',139,139,310,310,1,1,0,1);
 INSERT INTO `jc_model` VALUES(2,'单页','2','alone','',139,139,310,310,2,0,0,0);
 INSERT INTO `jc_model` VALUES(3,'作品','3','works','works',139,139,310,310,3,1,0,0);
 INSERT INTO `jc_model` VALUES(4,'下载','4','download','download',139,139,310,310,4,1,0,0);
 INSERT INTO `jc_model` VALUES(5,'图库','5','pic','pic',139,139,310,310,5,1,0,0);
 INSERT INTO `jc_model` VALUES(6,'视频','6','vedio','vedio',139,139,310,310,10,1,0,0);
 INSERT INTO `jc_model` VALUES(7,'产品','7','prod','prod',139,139,310,310,10,1,0,0);
 INSERT INTO `jc_model` VALUES(8,'招聘','job','job','job',139,139,310,310,10,1,0,0);
 INSERT INTO `jc_model` VALUES(9,'文库','wenku','doc','doc',139,139,310,310,10,1,0,0);
 INSERT INTO `jc_model` VALUES(10,'直播','live','live','live',139,139,310,310,10,1,0,0);
 INSERT INTO `jc_model` VALUES(11,'访谈','interview','interview','interview',139,139,310,310,10,1,0,0);
DROP TABLE IF EXISTS jc_model_item;
CREATE TABLE `jc_model_item` (
  `modelitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) NOT NULL,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `item_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '70' COMMENT '排列顺序',
  `def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `opt_value` varchar(255) DEFAULT NULL COMMENT '可选项',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) NOT NULL DEFAULT '1' COMMENT '数据类型',
  `is_single` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否独占一行',
  `is_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否栏目模型项',
  `is_custom` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否自定义',
  `is_display` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  PRIMARY KEY (`modelitem_id`),
  KEY `fk_jc_item_model` (`model_id`),
  CONSTRAINT `fk_jc_item_model` FOREIGN KEY (`model_id`) REFERENCES `jc_model` (`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8 COMMENT='CMS模型项表';
 INSERT INTO `jc_model_item` VALUES(1,1,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(2,1,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(3,1,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(4,1,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(5,1,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(6,1,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(7,1,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(8,1,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(9,1,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(10,1,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(11,1,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(12,1,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(13,1,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(14,1,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(15,1,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(16,1,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(17,1,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(18,1,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(19,1,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(20,1,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(21,1,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(23,1,'title','标题',9,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(24,1,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(25,1,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(26,1,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(27,1,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(28,1,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(29,1,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(30,1,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(31,1,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(32,1,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(33,1,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(34,1,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(35,1,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(36,1,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(37,1,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(38,1,'attachments','附件',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(39,1,'media','多媒体',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(40,1,'txt','内容',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(42,2,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(43,2,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(44,2,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(45,2,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(46,2,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(47,2,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(48,2,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(49,2,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(50,2,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(51,2,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(52,2,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(53,2,'txt','内容',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(54,3,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(55,3,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(56,3,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(57,3,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(58,3,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(59,3,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(60,3,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(61,3,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(62,3,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(63,3,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(64,3,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(65,3,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(66,3,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(67,3,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(68,3,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(69,3,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(70,3,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(73,3,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(74,3,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(75,3,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(76,3,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(77,3,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(78,3,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(79,3,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(80,3,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(81,3,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(82,3,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(83,3,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(84,3,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(85,3,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(86,3,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(87,3,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(88,3,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(89,3,'attachments','附件',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(90,3,'media','多媒体',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(91,3,'txt','内容',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(92,3,'pictures','图片集',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(93,4,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(94,4,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(95,4,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(96,4,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(97,4,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(98,4,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(99,4,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(100,4,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(101,4,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(102,4,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(103,4,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(104,4,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(105,4,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(106,4,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(107,4,'channelId','栏目',1,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(108,4,'title','软件名称',2,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(109,4,'shortTitle','软件版本',3,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(110,4,'titleColor','标题颜色',4,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(111,4,'description','摘要',5,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(112,4,'author','发布人',6,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(113,4,'viewGroupIds','浏览权限',7,null,null,null,null,null,null,null,7,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(114,4,'topLevel','固顶级别',8,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(115,4,'releaseDate','发布时间',9,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(116,4,'typeId','内容类型',21,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(117,4,'tplContent','指定模板',22,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(118,4,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(119,4,'attachments','资源上传',11,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(120,4,'txt','软件介绍',20,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(121,4,'softType','软件类型',12,'国产软件','国产软件,国外软件','100','3','30',null,null,6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(122,4,'warrant','软件授权',13,'免费版','免费版,共享版','','3','30','','',6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(123,4,'relatedLink','相关链接',14,'http://','','50','3','30','','',1,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(124,4,'demoUrl','演示地址',15,'http://',null,'60','3','30',null,null,1,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(125,5,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(126,5,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(127,5,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(128,5,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(129,5,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(130,5,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(131,5,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(132,5,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(133,5,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(134,5,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(135,5,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(136,5,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(137,5,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(138,5,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(139,5,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(140,5,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(141,5,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(142,5,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(143,5,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(144,5,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(145,5,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(146,5,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(147,5,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(148,5,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(149,5,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(150,5,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(151,5,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(152,5,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(153,5,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(154,5,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(155,5,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(156,5,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(157,5,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(158,5,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(159,5,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(160,5,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(161,5,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(162,5,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(163,5,'pictures','图片集',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(164,6,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(165,6,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(166,6,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(167,6,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(168,6,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(169,6,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(170,6,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(171,6,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(172,6,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(173,6,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(174,6,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(175,6,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(176,6,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(177,6,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(178,6,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(179,6,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(180,6,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(181,6,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(182,6,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(183,6,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(184,6,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(186,6,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(187,6,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(188,6,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(189,6,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(190,6,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(191,6,'description','内容简介',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(192,6,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,0);
 INSERT INTO `jc_model_item` VALUES(193,6,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,0);
 INSERT INTO `jc_model_item` VALUES(194,6,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(195,6,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(196,6,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(197,6,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(198,6,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(199,6,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(200,6,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(201,6,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(202,6,'attachments','附件',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(203,6,'media','多媒体',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(204,7,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(205,7,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(206,7,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(207,7,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(208,7,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(209,7,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(210,7,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(211,7,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(212,7,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(213,7,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(214,7,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(215,7,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(216,7,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(217,7,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(218,7,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(219,7,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(220,7,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(221,7,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(222,7,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(223,7,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(224,7,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(225,7,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(226,7,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(227,7,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(228,7,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(229,7,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(230,7,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(231,7,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(232,7,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(233,7,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(234,7,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(235,7,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(236,7,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(237,7,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(238,7,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(239,7,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(240,7,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(241,7,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(242,7,'txt','内容',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(243,7,'marketprice','市场价',10,null,null,null,'3','30',null,null,3,1,0,1,1);
 INSERT INTO `jc_model_item` VALUES(244,7,'price','价格',10,null,null,null,'3','30',null,null,3,1,0,1,1);
 INSERT INTO `jc_model_item` VALUES(246,4,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(247,1,'pictures','图片集',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(249,8,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(250,8,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(251,8,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(252,8,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(253,8,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(254,8,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(255,8,'tplContent','选择模型模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(256,8,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(257,8,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(258,8,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(259,8,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(260,8,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(261,8,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(262,8,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(263,8,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(264,8,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(265,8,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(266,8,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(267,8,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(268,8,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(269,8,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(270,8,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(271,8,'channelId','栏目',1,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(272,8,'title','岗位名称',1,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(275,8,'tagStr','Tag标签',7,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(279,8,'viewGroupIds','浏览权限',8,null,null,null,null,null,null,null,7,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(280,8,'topLevel','固顶级别',7,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(281,8,'releaseDate','发布时间',2,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(282,8,'typeId','内容类型',7,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(283,8,'tplContent','指定模板',8,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(289,8,'txt','职位描述',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(290,8,'deadline','截止日期',2,null,null,null,'3','30','留空永久有效',null,5,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(291,8,'experience','工作经验',3,null,'1年以内,1年以上,2年以上,3年以上,4年以上,5年以上,不限',null,'3','30',null,null,6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(292,8,'education','最低学历',3,'','专科,本科,硕士,不限','','3','30','','',6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(293,8,'salary','职位月薪',4,null,'2000-3000,3000-5000,4000-6000,5000-7000,6000-8000,8000+,面议',null,'3','30',null,null,6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(294,8,'workplace','工作地点',4,'','北京,上海,深圳,广州,重庆,南京,杭州,西安,南昌','','3','30','','',7,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(295,8,'nature','工作性质',5,'','全职,兼职','','3','30','','',8,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(296,8,'hasmanage','管理经验',5,'','要求,不要求','','3','30','','',8,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(297,8,'nums','招聘人数',6,'','1-3人,3-5人,5-10人,若干','','3','30','','',6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(298,8,'category','职位类别',6,null,'项目主管,java高级工程师,java工程师,网页设计师,测试人员,技术支持',null,'3','30',null,null,6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(299,9,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(300,9,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(301,9,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(302,9,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(303,9,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(304,9,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(305,9,'tplContent','内容模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(306,9,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(307,9,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(308,9,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(309,9,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(310,9,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(311,9,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(312,9,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(313,9,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(314,9,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(315,9,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(316,9,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(317,9,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(318,9,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(319,9,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(320,9,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(321,9,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(322,9,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(323,9,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(324,9,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(325,9,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(326,9,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(327,9,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(328,9,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(329,9,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(330,9,'docPath','文档',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(333,9,'downNeed','下载需要财富',10,null,null,null,null,null,null,null,2,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(334,9,'isOpen','是否开放',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(335,1,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(336,2,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(337,3,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(338,4,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(339,5,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(340,6,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(341,7,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(342,8,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(343,9,'workflowId','工作流',10,null,null,null,null,null,'留空则继承上级栏目设置，顶层为空无需审核',null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(344,1,'channelId','栏目',8,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(403,6,'Director','导演',10,'','','','1','2','','',1,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(404,6,'Starring','主演',10,'','','','1','30','','',1,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(405,6,'VideoType','视频类型',10,null,'历史,古装,都市,喜剧,悬疑,动作,谍战,伦理,战争,惊悚',null,'3','30',null,null,7,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(406,6,'Video','影片信息',10,'','正片,预告片','','3','30','','',6,0,0,1,1);
 INSERT INTO `jc_model_item` VALUES(407,123,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(408,123,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(409,123,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(410,123,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(411,123,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(412,123,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(413,123,'tplContent','内容模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(414,123,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(415,123,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(416,123,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(417,123,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(418,123,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(419,123,'finalStep','终审级别',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(420,123,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(421,123,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(422,123,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(423,123,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(424,123,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(425,123,'userIds','管理权限',10,null,null,null,null,null,null,null,7,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(426,123,'workflowId','工作流',10,null,null,null,null,null,null,null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(427,123,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(428,123,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(429,123,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(430,123,'txt','内容',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(431,123,'txt1','内容1',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(432,123,'txt2','内容2',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(433,123,'txt3','内容3',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(434,5,'titleImg','标题图',10,null,null,null,'3','30',null,null,1,1,1,1,1);
 INSERT INTO `jc_model_item` VALUES(435,11,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(436,11,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(437,11,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(438,11,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(439,11,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(440,11,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(441,11,'tplContent','内容模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(442,11,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(443,11,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(444,11,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(445,11,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(446,11,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(447,11,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(448,11,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(449,11,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(452,11,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(453,11,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(454,11,'workflowId','工作流',10,null,null,null,null,null,null,null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(455,11,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(456,11,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(462,10,'name','栏目名称',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(463,10,'path','访问路径',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(464,10,'title','meta标题',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(465,10,'keywords','meta关键字',10,null,null,null,null,null,null,null,1,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(466,10,'description','meta描述',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(467,10,'tplChannel','栏目模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(468,10,'tplContent','内容模板',10,null,null,null,null,null,null,null,6,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(469,10,'channelStatic','栏目静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(470,10,'contentStatic','内容静态化',10,null,null,null,null,null,null,null,4,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(471,10,'priority','排列顺序',10,null,null,null,null,null,null,null,2,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(472,10,'display','显示',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(473,10,'docImg','文档图片',10,null,null,null,null,null,null,null,8,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(474,10,'afterCheck','审核后',10,null,null,null,null,null,null,null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(475,10,'commentControl','评论',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(476,10,'allowUpdown','顶踩',10,null,null,null,null,null,null,null,8,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(479,10,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(480,10,'contriGroupIds','投稿权限',10,null,null,null,null,null,null,null,7,0,1,0,1);
 INSERT INTO `jc_model_item` VALUES(481,10,'workflowId','工作流',10,null,null,null,null,null,null,null,6,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(482,10,'link','外部链接',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(483,10,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,1,0,1);
 INSERT INTO `jc_model_item` VALUES(489,11,'userIds','管理权限',70,'','','','3','30','','',7,1,1,1,1);
 INSERT INTO `jc_model_item` VALUES(490,11,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(491,11,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(492,11,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(493,11,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(494,11,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(495,11,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(496,11,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(497,11,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(498,11,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(499,11,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(500,11,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(501,11,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(502,11,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(503,11,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(504,11,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(505,11,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(506,11,'attachments','附件',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(507,11,'media','多媒体',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(516,10,'channelId','栏目',10,null,null,null,null,null,null,null,6,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(517,10,'title','标题',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(518,10,'shortTitle','简短标题',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(519,10,'titleColor','标题颜色',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(520,10,'tagStr','Tag标签',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(521,10,'description','摘要',10,null,null,null,null,null,null,null,4,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(522,10,'author','作者',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(523,10,'origin','来源',10,null,null,null,null,null,null,null,1,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(524,10,'viewGroupIds','浏览权限',10,null,null,null,null,null,null,null,7,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(525,10,'topLevel','固顶级别',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(526,10,'releaseDate','发布时间',10,null,null,null,null,null,null,null,5,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(527,10,'typeId','内容类型',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(528,10,'tplContent','指定模板',10,null,null,null,null,null,null,null,6,0,0,0,1);
 INSERT INTO `jc_model_item` VALUES(529,10,'typeImg','类型图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(530,10,'titleImg','标题图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(531,10,'contentImg','内容图',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(532,10,'attachments','附件',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(533,10,'media','多媒体',10,null,null,null,null,null,null,null,1,1,0,0,1);
 INSERT INTO `jc_model_item` VALUES(542,10,'serverUrl','直播服务器地址',70,'','','','3','30','','',1,1,0,1,1);
 INSERT INTO `jc_model_item` VALUES(543,10,'serverPath','直播服务器路径',70,'','','','3','30','','',1,1,0,1,1);
DROP TABLE IF EXISTS jc_origin;
CREATE TABLE `jc_origin` (
  `origin_id` int(11) NOT NULL AUTO_INCREMENT,
  `origin_name` varchar(255) NOT NULL COMMENT '来源名称',
  `ref_count` int(11) NOT NULL DEFAULT '0' COMMENT '来源文章总数',
  PRIMARY KEY (`origin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='来源';
 INSERT INTO `jc_origin` VALUES(1,'新浪微博',0);
 INSERT INTO `jc_origin` VALUES(2,'百度',0);
 INSERT INTO `jc_origin` VALUES(3,'百度论坛',0);
 INSERT INTO `jc_origin` VALUES(4,'百度贴吧',0);
 INSERT INTO `jc_origin` VALUES(5,'新浪新闻',0);
 INSERT INTO `jc_origin` VALUES(6,'腾讯新闻',0);
DROP TABLE IF EXISTS jc_plug;
CREATE TABLE `jc_plug` (
  `plug_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '插件名称',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '文件路径',
  `description` varchar(2000) DEFAULT NULL COMMENT '描述',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `upload_time` datetime NOT NULL COMMENT '上传时间',
  `install_time` datetime DEFAULT NULL COMMENT '安装时间',
  `uninstall_time` datetime DEFAULT NULL COMMENT '卸载时间',
  `file_conflict` tinyint(1) NOT NULL DEFAULT '0' COMMENT '包含文件是否冲突',
  `is_used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '使用状态(0未使用,1使用中)',
  `plug_perms` varchar(255) DEFAULT '' COMMENT '插件权限（,分隔各个权限配置）',
  PRIMARY KEY (`plug_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='插件';
DROP TABLE IF EXISTS jc_receiver_message;
CREATE TABLE `jc_receiver_message` (
  `msg_re_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `msg_title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `msg_content` longtext COMMENT '站内信息内容',
  `send_time` timestamp NULL DEFAULT NULL COMMENT '发送时间',
  `msg_send_user` int(11) NOT NULL DEFAULT '1' COMMENT '发信息人',
  `msg_receiver_user` int(11) NOT NULL DEFAULT '0' COMMENT '接收人',
  `site_id` int(11) NOT NULL DEFAULT '1' COMMENT '站点',
  `msg_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '消息状态0未读，1已读',
  `msg_box` int(2) NOT NULL DEFAULT '1' COMMENT '消息信箱 0收件箱 1发件箱 2草稿箱 3垃圾箱',
  `msg_id` int(11) DEFAULT NULL COMMENT '发信的信件id',
  PRIMARY KEY (`msg_re_id`),
  KEY `jc_receiver_message_user_send` (`msg_send_user`),
  KEY `jc_receiver_message_user_receiver` (`msg_receiver_user`),
  KEY `jc_receiver_message_site` (`site_id`),
  KEY `jc_receiver_message_message` (`msg_re_id`),
  KEY `fk_jc_receiver_message_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_message` FOREIGN KEY (`msg_id`) REFERENCES `jc_message` (`msg_id`),
  CONSTRAINT `fk_jc_receiver_message_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_receiver_message_user_receiver` FOREIGN KEY (`msg_receiver_user`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_receiver_message_user_send` FOREIGN KEY (`msg_send_user`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='站内信收信表';
DROP TABLE IF EXISTS jc_role;
CREATE TABLE `jc_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `role_name` varchar(100) NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_super` char(1) NOT NULL DEFAULT '0' COMMENT '拥有所有权限',
  PRIMARY KEY (`role_id`),
  KEY `fk_jc_role_site` (`site_id`),
  CONSTRAINT `fk_jc_role_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS角色表';
 INSERT INTO `jc_role` VALUES(1,null,'管理员',10,'1');
DROP TABLE IF EXISTS jc_role_permission;
CREATE TABLE `jc_role_permission` (
  `role_id` int(11) NOT NULL,
  `uri` varchar(100) NOT NULL,
  KEY `fk_jc_permission_role` (`role_id`),
  CONSTRAINT `fk_jc_permission_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS角色授权表';
 INSERT INTO `jc_role_permission` VALUES(1,'/top.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/right.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/main.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/left.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/index.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/message/v_countUnreadMsg.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/content/o_generateTags.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/map.do');
 INSERT INTO `jc_role_permission` VALUES(1,'/statistic_member/v_list.do');
 INSERT INTO `jc_role_permission` VALUES(1,'admin_global:v_list:*');
 INSERT INTO `jc_role_permission` VALUES(1,'admin_local:v_list:*');
 INSERT INTO `jc_role_permission` VALUES(1,'/admin_local/v_edit/2');
 INSERT INTO `jc_role_permission` VALUES(1,'admin_local:v_list');
DROP TABLE IF EXISTS jc_score_group;
CREATE TABLE `jc_score_group` (
  `score_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '分组名',
  `description` varchar(1000) DEFAULT NULL COMMENT '描述',
  `enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `def` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否默认',
  `site_id` int(11) NOT NULL COMMENT '站点',
  PRIMARY KEY (`score_group_id`),
  KEY `fk_jc_score_group_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='FComment';
 INSERT INTO `jc_score_group` VALUES(1,'心情组','心情组',0,0,1);
 INSERT INTO `jc_score_group` VALUES(2,'星级评分','星级评分',1,1,1);
DROP TABLE IF EXISTS jc_score_item;
CREATE TABLE `jc_score_item` (
  `score_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_group_id` int(11) NOT NULL COMMENT '评分组',
  `name` varchar(255) NOT NULL COMMENT '评分名',
  `score` int(11) NOT NULL COMMENT '分值',
  `image_path` varchar(255) DEFAULT NULL COMMENT '评分图标路径',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`score_item_id`),
  KEY `fk_jc_score_item_group` (`score_group_id`),
  CONSTRAINT `fk_jc_score_item_group` FOREIGN KEY (`score_group_id`) REFERENCES `jc_score_group` (`score_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='评分项';
 INSERT INTO `jc_score_item` VALUES(1,1,'开心',1,'/style/smilies/m1.gif',1);
 INSERT INTO `jc_score_item` VALUES(2,1,'板砖',1,'/style/smilies/m2.gif',2);
 INSERT INTO `jc_score_item` VALUES(3,1,'感动',1,'/style/smilies/m3.gif',3);
 INSERT INTO `jc_score_item` VALUES(4,1,'有用',1,'/style/smilies/m4.gif',4);
 INSERT INTO `jc_score_item` VALUES(5,1,'疑问',1,'/style/smilies/m5.gif',5);
 INSERT INTO `jc_score_item` VALUES(6,1,'难过',1,'/style/smilies/m6.gif',6);
 INSERT INTO `jc_score_item` VALUES(7,1,'无聊',1,'/style/smilies/m7.gif',7);
 INSERT INTO `jc_score_item` VALUES(8,1,'震惊',1,'/style/smilies/m8.gif',8);
 INSERT INTO `jc_score_item` VALUES(9,2,'非常差',1,'',1);
 INSERT INTO `jc_score_item` VALUES(10,2,'差',2,'',2);
 INSERT INTO `jc_score_item` VALUES(11,2,'一般',3,'',3);
 INSERT INTO `jc_score_item` VALUES(12,2,'好',4,'',4);
 INSERT INTO `jc_score_item` VALUES(13,2,'非常好',5,'',5);
DROP TABLE IF EXISTS jc_score_record;
CREATE TABLE `jc_score_record` (
  `score_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `score_item_id` int(11) NOT NULL COMMENT '评分项',
  `content_id` int(11) NOT NULL COMMENT '内容',
  `score_count` int(11) NOT NULL COMMENT '评分次数',
  PRIMARY KEY (`score_record_id`),
  KEY `fk_jc_record_score_item` (`score_item_id`),
  KEY `index_score_record_content` (`content_id`),
  CONSTRAINT `fk_jc_record_score_item` FOREIGN KEY (`score_item_id`) REFERENCES `jc_score_item` (`score_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='评分纪录';
 INSERT INTO `jc_score_record` VALUES(3,8,560,1);
 INSERT INTO `jc_score_record` VALUES(4,7,560,1);
 INSERT INTO `jc_score_record` VALUES(5,12,559,1);
 INSERT INTO `jc_score_record` VALUES(6,11,447,1);
 INSERT INTO `jc_score_record` VALUES(7,12,447,1);
 INSERT INTO `jc_score_record` VALUES(8,13,447,1);
 INSERT INTO `jc_score_record` VALUES(9,9,447,1);
 INSERT INTO `jc_score_record` VALUES(10,12,509,1);
 INSERT INTO `jc_score_record` VALUES(11,9,509,4);
 INSERT INTO `jc_score_record` VALUES(12,10,509,1);
 INSERT INTO `jc_score_record` VALUES(13,13,509,1);
 INSERT INTO `jc_score_record` VALUES(14,11,559,1);
 INSERT INTO `jc_score_record` VALUES(15,11,446,1);
 INSERT INTO `jc_score_record` VALUES(16,12,444,1);
 INSERT INTO `jc_score_record` VALUES(17,10,444,1);
DROP TABLE IF EXISTS jc_search_words;
CREATE TABLE `jc_search_words` (
  `word_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '搜索词汇',
  `hit_count` int(11) NOT NULL DEFAULT '0' COMMENT '搜索次数',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '优先级',
  `name_initial` varchar(500) NOT NULL DEFAULT '' COMMENT '拼音首字母',
  PRIMARY KEY (`word_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='搜索热词';
 INSERT INTO `jc_search_words` VALUES(1,'国内新闻',0,2,'gnxw');
 INSERT INTO `jc_search_words` VALUES(5,'中国建设',59,2,'zgjs');
 INSERT INTO `jc_search_words` VALUES(6,'中国农业银行',0,2,'zgnyyx');
 INSERT INTO `jc_search_words` VALUES(7,'中国建设银行',10,10,'zgjsyx');
 INSERT INTO `jc_search_words` VALUES(8,'江西',1,10,'jx');
 INSERT INTO `jc_search_words` VALUES(9,'南昌',22,10,'nc');
 INSERT INTO `jc_search_words` VALUES(10,'新闻',9,10,'xw');
 INSERT INTO `jc_search_words` VALUES(13,'毛泽东',8,10,'mzd');
 INSERT INTO `jc_search_words` VALUES(14,'刘晓庆',10,10,'lxq');
 INSERT INTO `jc_search_words` VALUES(15,'广西 ',1,10,'gx');
 INSERT INTO `jc_search_words` VALUES(17,'国内',16,10,'gn');
 INSERT INTO `jc_search_words` VALUES(18,'巴基斯坦',1,10,'bjst');
 INSERT INTO `jc_search_words` VALUES(19,'dd',1,10,'dd');
 INSERT INTO `jc_search_words` VALUES(20,'总理',1,10,'zl');
 INSERT INTO `jc_search_words` VALUES(21,'你是猪',1,10,'nsz');
 INSERT INTO `jc_search_words` VALUES(22,'默克尔',1,10,'mke');
DROP TABLE IF EXISTS jc_sensitivity;
CREATE TABLE `jc_sensitivity` (
  `sensitivity_id` int(11) NOT NULL AUTO_INCREMENT,
  `search` varchar(255) NOT NULL COMMENT '敏感词',
  `replacement` varchar(255) NOT NULL COMMENT '替换词',
  PRIMARY KEY (`sensitivity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS敏感词表';
 INSERT INTO `jc_sensitivity` VALUES(1,'法论功','***');
DROP TABLE IF EXISTS jc_site;
CREATE TABLE `jc_site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL COMMENT '配置ID',
  `ftp_upload_id` int(11) DEFAULT NULL COMMENT '上传ftp',
  `domain` varchar(50) NOT NULL COMMENT '域名',
  `site_path` varchar(20) NOT NULL COMMENT '路径',
  `site_name` varchar(100) NOT NULL COMMENT '网站名称',
  `short_name` varchar(100) NOT NULL COMMENT '简短名称',
  `protocol` varchar(20) NOT NULL DEFAULT 'http://' COMMENT '协议',
  `dynamic_suffix` varchar(10) NOT NULL DEFAULT '.jhtml' COMMENT '动态页后缀',
  `static_suffix` varchar(10) NOT NULL DEFAULT '.html' COMMENT '静态页后缀',
  `static_dir` varchar(50) DEFAULT NULL COMMENT '静态页存放目录',
  `is_index_to_root` char(1) NOT NULL DEFAULT '0' COMMENT '是否使用将首页放在根目录下',
  `is_static_index` char(1) NOT NULL DEFAULT '0' COMMENT '是否静态化首页',
  `locale_admin` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '后台本地化',
  `locale_front` varchar(10) NOT NULL DEFAULT 'zh_CN' COMMENT '前台本地化',
  `tpl_solution` varchar(50) NOT NULL DEFAULT 'default' COMMENT '模板方案',
  `final_step` tinyint(4) NOT NULL DEFAULT '2' COMMENT '终审级别',
  `after_check` tinyint(4) NOT NULL DEFAULT '2' COMMENT '审核后(1:不能修改删除;2:修改后退回;3:修改后不变)',
  `is_relative_path` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用相对路径',
  `is_recycle_on` char(1) NOT NULL DEFAULT '1' COMMENT '是否开启回收站',
  `domain_alias` varchar(255) DEFAULT NULL COMMENT '域名别名',
  `domain_redirect` varchar(255) DEFAULT NULL COMMENT '域名重定向',
  `is_master` tinyint(1) DEFAULT '0' COMMENT '是否主站',
  `parent_id` int(11) DEFAULT NULL COMMENT '父站点id',
  `tpl_index` varchar(255) DEFAULT NULL COMMENT '首页模板',
  `access_path` varchar(50) DEFAULT NULL COMMENT '访问路径',
  `keywords` varchar(255) DEFAULT NULL COMMENT '站点关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '站点描述',
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `ak_domain_path` (`domain`,`access_path`),
  KEY `fk_jc_site_config` (`config_id`),
  KEY `fk_jc_site_upload_ftp` (`ftp_upload_id`),
  KEY `fk_jc_site_parent` (`parent_id`),
  CONSTRAINT `fk_jc_site_config` FOREIGN KEY (`config_id`) REFERENCES `jc_config` (`config_id`),
  CONSTRAINT `fk_jc_site_parent` FOREIGN KEY (`parent_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_site_upload_ftp` FOREIGN KEY (`ftp_upload_id`) REFERENCES `jo_ftp` (`ftp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='CMS站点表';
 INSERT INTO `jc_site` VALUES(1,1,null,'news.ums365.com','www','为民网','为民网','http://','.jhtml','.html','/jx','0','0','zh_CN','zh_CN','two',3,3,'0','0','news.ums365.com','',1,null,'','jx','为民网','为民网');
DROP TABLE IF EXISTS jc_site_access;
CREATE TABLE `jc_site_access` (
  `access_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(32) NOT NULL DEFAULT '',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `access_time` time NOT NULL COMMENT '访问时间',
  `access_date` date NOT NULL COMMENT '访问日期',
  `ip` varchar(50) NOT NULL DEFAULT '',
  `area` varchar(50) DEFAULT NULL COMMENT '访问地区',
  `access_source` varchar(255) DEFAULT NULL COMMENT '访问来源',
  `external_link` varchar(255) DEFAULT NULL COMMENT '外部链接网址',
  `engine` varchar(50) DEFAULT NULL COMMENT '搜索引擎',
  `entry_page` varchar(255) DEFAULT NULL COMMENT '入口页面',
  `last_stop_page` varchar(255) DEFAULT NULL COMMENT '最后停留页面',
  `visit_second` int(11) DEFAULT NULL COMMENT '访问时长(秒)',
  `visit_page_count` int(11) DEFAULT NULL COMMENT '访问页面数',
  `operating_system` varchar(50) DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(50) DEFAULT NULL COMMENT '浏览器',
  `keyword` varchar(255) DEFAULT NULL COMMENT '来访关键字',
  PRIMARY KEY (`access_id`),
  KEY `fk_jc_access_site` (`site_id`),
  CONSTRAINT `fk_jc_access_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='站点访问表';
 INSERT INTO `jc_site_access` VALUES(62,'BD30A7B340EF3066066CC0EDB1B87A9E',1,'08:53:47','2014-11-03','183.129.242.122','浙江省','',null,null,'http://news.ums365.com/','http://news.ums365.com/interview/index.jhtml',1391223594,8,'Win 7','firefox 32','');
 INSERT INTO `jc_site_access` VALUES(63,'A0A3C168D67DC592C6E939705ADFE86D',1,'08:57:43','2014-11-03','183.129.242.122','浙江省','',null,null,'http://news.ums365.com/interview/729.jhtml','http://news.ums365.com/interview/729.jhtml',0,1,'Win 7','chrome 35','');
 INSERT INTO `jc_site_access` VALUES(64,'CD0157C6765448BB7DB715F9E9214F59',1,'08:58:51','2014-11-03','183.129.242.122','浙江省','',null,null,'http://news.ums365.com/interview/729.jhtml','http://news.ums365.com/interview/729.jhtml',1391212819,2,'Win 7','ie 11','');
 INSERT INTO `jc_site_access` VALUES(65,'22D2A4F850EC69455151C648978B212D',1,'08:58:05','2014-11-03','183.129.242.122','浙江省','',null,null,'http://news.ums365.com/interview/729.jhtml','http://news.ums365.com/interview/729.jhtml',0,1,'Win 7','chrome 38','');
DROP TABLE IF EXISTS jc_site_access_count;
CREATE TABLE `jc_site_access_count` (
  `access_count` int(11) NOT NULL AUTO_INCREMENT,
  `page_count` int(11) NOT NULL DEFAULT '1' COMMENT '访问页数',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '用户数',
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `site_id` int(11) NOT NULL COMMENT '统计站点',
  PRIMARY KEY (`access_count`),
  KEY `fk_jc_access_count_site` (`site_id`),
  CONSTRAINT `fk_jc_access_count_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='每日统计页数访问情况';
 INSERT INTO `jc_site_access_count` VALUES(1,1,1,'2014-10-11',1);
 INSERT INTO `jc_site_access_count` VALUES(2,3,1,'2014-10-11',1);
 INSERT INTO `jc_site_access_count` VALUES(3,4,1,'2014-10-11',1);
 INSERT INTO `jc_site_access_count` VALUES(4,1,1,'2014-10-12',1);
 INSERT INTO `jc_site_access_count` VALUES(5,2,1,'2014-10-12',1);
 INSERT INTO `jc_site_access_count` VALUES(6,3,1,'2014-10-12',1);
 INSERT INTO `jc_site_access_count` VALUES(7,5,1,'2014-10-12',1);
 INSERT INTO `jc_site_access_count` VALUES(8,1,3,'2014-10-13',1);
 INSERT INTO `jc_site_access_count` VALUES(9,3,1,'2014-10-13',1);
 INSERT INTO `jc_site_access_count` VALUES(10,1,6,'2014-10-14',1);
 INSERT INTO `jc_site_access_count` VALUES(11,10,1,'2014-10-14',1);
 INSERT INTO `jc_site_access_count` VALUES(12,11,1,'2014-10-14',1);
 INSERT INTO `jc_site_access_count` VALUES(13,12,1,'2014-10-14',1);
 INSERT INTO `jc_site_access_count` VALUES(14,13,1,'2014-10-14',1);
 INSERT INTO `jc_site_access_count` VALUES(15,1,2,'2014-10-15',1);
 INSERT INTO `jc_site_access_count` VALUES(16,2,1,'2014-10-15',1);
 INSERT INTO `jc_site_access_count` VALUES(17,15,1,'2014-10-15',1);
 INSERT INTO `jc_site_access_count` VALUES(18,43,1,'2014-10-15',1);
 INSERT INTO `jc_site_access_count` VALUES(19,1,2,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(20,3,1,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(21,6,1,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(22,8,1,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(23,22,1,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(24,2,1,'2014-10-16',1);
 INSERT INTO `jc_site_access_count` VALUES(25,1,3,'2014-10-17',1);
 INSERT INTO `jc_site_access_count` VALUES(26,4,1,'2014-10-17',1);
 INSERT INTO `jc_site_access_count` VALUES(27,1,3,'2014-10-20',1);
 INSERT INTO `jc_site_access_count` VALUES(28,2,1,'2014-10-20',1);
 INSERT INTO `jc_site_access_count` VALUES(29,1,1,'2014-10-21',1);
 INSERT INTO `jc_site_access_count` VALUES(30,2,1,'2014-10-21',1);
 INSERT INTO `jc_site_access_count` VALUES(31,2,1,'2014-10-22',1);
 INSERT INTO `jc_site_access_count` VALUES(32,2,2,'2014-10-23',1);
 INSERT INTO `jc_site_access_count` VALUES(33,1,1,'2014-10-24',1);
 INSERT INTO `jc_site_access_count` VALUES(34,1,1,'2014-10-25',1);
 INSERT INTO `jc_site_access_count` VALUES(35,2,1,'2014-10-25',1);
 INSERT INTO `jc_site_access_count` VALUES(36,1,1,'2014-10-27',1);
 INSERT INTO `jc_site_access_count` VALUES(37,3,1,'2014-10-28',1);
 INSERT INTO `jc_site_access_count` VALUES(38,1,1,'2014-10-30',1);
 INSERT INTO `jc_site_access_count` VALUES(39,2,1,'2014-10-30',1);
 INSERT INTO `jc_site_access_count` VALUES(40,1,1,'2014-10-31',1);
 INSERT INTO `jc_site_access_count` VALUES(41,1,2,'2014-11-01',1);
 INSERT INTO `jc_site_access_count` VALUES(42,15,1,'2014-11-01',1);
 INSERT INTO `jc_site_access_count` VALUES(43,13,1,'2014-11-01',1);
 INSERT INTO `jc_site_access_count` VALUES(44,12,1,'2014-11-02',1);
 INSERT INTO `jc_site_access_count` VALUES(45,6,1,'2014-11-02',1);
 INSERT INTO `jc_site_access_count` VALUES(46,9,1,'2014-11-02',1);
DROP TABLE IF EXISTS jc_site_access_pages;
CREATE TABLE `jc_site_access_pages` (
  `access_pages_id` int(11) NOT NULL AUTO_INCREMENT,
  `access_page` varchar(255) NOT NULL COMMENT '访问页面',
  `session_id` varchar(32) NOT NULL,
  `access_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '访问日期',
  `access_time` time NOT NULL COMMENT '访问时间',
  `visit_second` int(11) NOT NULL DEFAULT '0' COMMENT '停留时长（秒）',
  `page_index` int(11) NOT NULL DEFAULT '0' COMMENT '用户访问页面的索引',
  `site_id` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`access_pages_id`),
  KEY `fk_jc_access_pages_access` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8 COMMENT='访问详细页面表';
 INSERT INTO `jc_site_access_pages` VALUES(179,'http://news.ums365.com/','BD30A7B340EF3066066CC0EDB1B87A9E','2014-11-03','08:57:19',1391212802,4,1);
 INSERT INTO `jc_site_access_pages` VALUES(180,'http://news.ums365.com/interview/729.jhtml','CD0157C6765448BB7DB715F9E9214F59','2014-11-03','08:58:51',0,1,1);
 INSERT INTO `jc_site_access_pages` VALUES(181,'http://news.ums365.com/interview/729.jhtml','A0A3C168D67DC592C6E939705ADFE86D','2014-11-03','08:57:43',0,1,1);
 INSERT INTO `jc_site_access_pages` VALUES(182,'http://news.ums365.com/interview/index.jhtml','BD30A7B340EF3066066CC0EDB1B87A9E','2014-11-03','08:57:21',2,5,1);
 INSERT INTO `jc_site_access_pages` VALUES(183,'http://news.ums365.com/interview/729.jhtml','22D2A4F850EC69455151C648978B212D','2014-11-03','08:58:05',0,1,1);
 INSERT INTO `jc_site_access_pages` VALUES(184,'http://news.ums365.com/interview/729.jhtml','BD30A7B340EF3066066CC0EDB1B87A9E','2014-11-03','08:57:24',1391223375,6,1);
DROP TABLE IF EXISTS jc_site_access_statistic;
CREATE TABLE `jc_site_access_statistic` (
  `access_statistic_id` int(11) NOT NULL AUTO_INCREMENT,
  `statistic_date` date NOT NULL COMMENT '统计日期',
  `pv` int(11) NOT NULL DEFAULT '0' COMMENT 'pv量',
  `ip` int(11) NOT NULL DEFAULT '0' COMMENT 'ip量',
  `visitors` int(11) NOT NULL DEFAULT '0' COMMENT '访客数量',
  `pages_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均浏览次数',
  `visit_second_aver` int(11) NOT NULL DEFAULT '0' COMMENT '人均访问时长（秒）',
  `site_id` int(11) NOT NULL COMMENT '站点id',
  `statisitc_type` varchar(255) NOT NULL DEFAULT 'all' COMMENT '统计分类（all代表当天所有访问量的统计）',
  `statistic_column_value` varchar(255) DEFAULT '' COMMENT '统计列值',
  PRIMARY KEY (`access_statistic_id`),
  KEY `fk_jc_access_statistic_site` (`site_id`),
  CONSTRAINT `fk_jc_access_statistic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='访问统计表';
 INSERT INTO `jc_site_access_statistic` VALUES(1,'2014-10-11',8,3,3,2,298,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(2,'2014-10-11',1,1,1,1,0,1,'area','北京市');
 INSERT INTO `jc_site_access_statistic` VALUES(3,'2014-10-11',7,2,2,3,448,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(4,'2014-10-11',8,3,3,2,298,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(5,'2014-10-12',11,1,4,2,-30332134,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(6,'2014-10-12',11,1,4,2,-30332134,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(7,'2014-10-12',9,1,3,3,-504180447,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(8,'2014-10-12',2,1,1,2,1391212804,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(9,'2014-10-13',6,1,4,1,347803201,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(10,'2014-10-13',6,1,4,1,347803201,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(11,'2014-10-13',5,1,3,1,463737601,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(12,'2014-10-13',1,1,1,1,0,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(13,'2014-10-14',52,6,10,5,126988856,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(14,'2014-10-14',4,4,4,1,0,1,'area','上海市');
 INSERT INTO `jc_site_access_statistic` VALUES(15,'2014-10-14',1,1,1,1,0,1,'area','北京市');
 INSERT INTO `jc_site_access_statistic` VALUES(16,'2014-10-14',47,1,5,9,253977712,1,'area','湖南省');
 INSERT INTO `jc_site_access_statistic` VALUES(17,'2014-10-14',1,1,1,1,0,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(18,'2014-10-14',51,5,9,5,141098729,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(19,'2014-10-15',62,2,5,12,-24261370,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(20,'2014-10-15',62,2,5,12,-24261370,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(21,'2014-10-15',62,2,5,12,-24261370,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(22,'2014-10-16',43,2,7,6,-233409318,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(23,'2014-10-16',43,2,7,6,-233409318,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(24,'2014-10-16',29,2,5,5,-24264756,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(25,'2014-10-16',14,1,2,7,-756270724,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(26,'2014-10-17',7,1,4,1,347803446,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(27,'2014-10-17',7,1,4,1,347803446,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(28,'2014-10-17',7,1,4,1,347803446,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(29,'2014-10-20',5,2,4,1,347803386,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(30,'2014-10-20',5,2,4,1,347803386,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(31,'2014-10-20',5,2,4,1,347803386,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(32,'2014-10-21',3,1,2,1,695606403,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(33,'2014-10-21',3,1,2,1,695606403,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(34,'2014-10-21',3,1,2,1,695606403,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(35,'2014-10-22',2,1,1,2,1391212801,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(36,'2014-10-22',2,1,1,2,1391212801,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(37,'2014-10-22',2,1,1,2,1391212801,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(38,'2014-10-23',4,2,2,2,-756270666,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(39,'2014-10-23',4,2,2,2,-756270666,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(40,'2014-10-23',4,2,2,2,-756270666,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(41,'2014-10-24',1,1,1,1,0,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(42,'2014-10-24',1,1,1,1,0,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(43,'2014-10-24',1,1,1,1,0,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(44,'2014-10-25',3,1,2,1,695606993,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(45,'2014-10-25',3,1,2,1,695606993,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(46,'2014-10-25',2,1,1,2,1391213987,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(47,'2014-10-25',1,1,1,1,0,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(48,'2014-10-27',1,1,1,1,0,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(49,'2014-10-27',1,1,1,1,0,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(50,'2014-10-27',1,1,1,1,0,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(51,'2014-10-28',3,1,1,3,1391212884,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(52,'2014-10-28',3,1,1,3,1391212884,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(53,'2014-10-28',3,1,1,3,1391212884,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(54,'2014-10-30',3,2,2,1,695606480,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(55,'2014-10-30',1,1,1,1,0,1,'area','上海市');
 INSERT INTO `jc_site_access_statistic` VALUES(56,'2014-10-30',2,1,1,2,1391212960,1,'area','湖南省');
 INSERT INTO `jc_site_access_statistic` VALUES(57,'2014-10-30',3,2,2,1,695606480,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(58,'2014-10-31',1,1,1,1,0,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(59,'2014-10-31',1,1,1,1,0,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(60,'2014-10-31',1,1,1,1,0,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(61,'2014-11-01',30,1,4,7,-378134807,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(62,'2014-11-01',30,1,4,7,-378134807,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(63,'2014-11-01',1,1,1,1,0,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(64,'2014-11-01',16,1,2,8,695607083,1,'source','外部链接');
 INSERT INTO `jc_site_access_statistic` VALUES(65,'2014-11-01',13,1,1,13,1391213900,1,'source','直接访问');
 INSERT INTO `jc_site_access_statistic` VALUES(66,'2014-11-01',16,1,2,8,695607083,1,'link','http://localhost:8080');
 INSERT INTO `jc_site_access_statistic` VALUES(67,'2014-11-02',27,2,3,9,-40428674,1,'all','');
 INSERT INTO `jc_site_access_statistic` VALUES(68,'2014-11-02',18,1,2,9,-756251141,1,'area','浙江省');
 INSERT INTO `jc_site_access_statistic` VALUES(69,'2014-11-02',21,2,2,10,-756249412,1,'source','');
 INSERT INTO `jc_site_access_statistic` VALUES(70,'2014-11-02',6,1,1,6,1391212802,1,'source','直接访问');
DROP TABLE IF EXISTS jc_site_attr;
CREATE TABLE `jc_site_attr` (
  `site_id` int(11) NOT NULL,
  `attr_name` varchar(30) NOT NULL COMMENT '名称',
  `attr_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_attr_site` (`site_id`),
  CONSTRAINT `fk_jc_attr_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点属性表';
 INSERT INTO `jc_site_attr` VALUES(1,'pvTotal','226');
 INSERT INTO `jc_site_attr` VALUES(1,'visitors','79');
DROP TABLE IF EXISTS jc_site_cfg;
CREATE TABLE `jc_site_cfg` (
  `site_id` int(11) NOT NULL,
  `cfg_name` varchar(30) NOT NULL COMMENT '名称',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '值',
  KEY `fk_jc_cfg_site` (`site_id`),
  CONSTRAINT `fk_jc_cfg_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点配置表';
DROP TABLE IF EXISTS jc_site_company;
CREATE TABLE `jc_site_company` (
  `site_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '公司名称',
  `scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `nature` varchar(255) DEFAULT NULL COMMENT '公司性质',
  `industry` varchar(1000) DEFAULT NULL COMMENT '公司行业',
  `contact` varchar(500) DEFAULT NULL COMMENT '联系方式',
  `description` text COMMENT '公司简介',
  `address` varchar(500) DEFAULT NULL COMMENT '公司地址',
  `longitude` float(5,2) DEFAULT NULL COMMENT '经度',
  `latitude` float(4,2) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`site_id`),
  CONSTRAINT `fk_jc_company_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司信息';
 INSERT INTO `jc_site_company` VALUES(1,'为民网','10-20人','私企','互联网','','','',null,null);
DROP TABLE IF EXISTS jc_site_model;
CREATE TABLE `jc_site_model` (
  `model_id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(50) NOT NULL COMMENT '字段',
  `model_label` varchar(100) NOT NULL COMMENT '名称',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `upload_path` varchar(100) DEFAULT NULL COMMENT '上传路径',
  `text_size` varchar(20) DEFAULT NULL COMMENT '长度',
  `area_rows` varchar(3) DEFAULT NULL COMMENT '文本行数',
  `area_cols` varchar(3) DEFAULT NULL COMMENT '文本列数',
  `help` varchar(255) DEFAULT NULL COMMENT '帮助信息',
  `help_position` varchar(1) DEFAULT NULL COMMENT '帮助位置',
  `data_type` int(11) DEFAULT '1' COMMENT '0:编辑器;1:文本框;2:文本区;3:图片;4:附件',
  `is_single` tinyint(1) DEFAULT '1' COMMENT '是否独占一行',
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `ak_field` (`field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点信息模型表';
DROP TABLE IF EXISTS jc_site_refer;
CREATE TABLE `jc_site_refer` (
  `site_id` int(11) NOT NULL,
  `from_site_id` int(11) NOT NULL,
  PRIMARY KEY (`from_site_id`,`site_id`),
  KEY `fk_jc_site_to` (`site_id`),
  CONSTRAINT `fk_jc_site_from` FOREIGN KEY (`from_site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_site_to` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='站点转载权限';
 INSERT INTO `jc_site_refer` VALUES(1,1);
DROP TABLE IF EXISTS jc_site_txt;
CREATE TABLE `jc_site_txt` (
  `site_id` int(11) NOT NULL,
  `txt_name` varchar(30) NOT NULL COMMENT '名称',
  `txt_value` longtext COMMENT '值',
  KEY `fk_jc_txt_site` (`site_id`),
  CONSTRAINT `fk_jc_txt_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS站点文本表';
DROP TABLE IF EXISTS jc_task;
CREATE TABLE `jc_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_code` varchar(255) DEFAULT NULL COMMENT '任务执行代码',
  `task_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '任务类型(1首页静态化、2栏目页静态化、3内容页静态化、4采集、5分发)',
  `task_name` varchar(255) NOT NULL COMMENT '任务名称',
  `job_class` varchar(255) NOT NULL COMMENT '任务类',
  `execycle` tinyint(1) NOT NULL DEFAULT '1' COMMENT '执行周期分类(1非表达式 2 cron表达式)',
  `day_of_month` int(11) DEFAULT NULL COMMENT '每月的哪天',
  `day_of_week` tinyint(1) DEFAULT NULL COMMENT '周几',
  `hour` int(11) DEFAULT NULL COMMENT '小时',
  `minute` int(11) DEFAULT NULL COMMENT '分钟',
  `interval_hour` int(11) DEFAULT NULL COMMENT '间隔小时',
  `interval_minute` int(11) DEFAULT NULL COMMENT '间隔分钟',
  `task_interval_unit` tinyint(1) DEFAULT NULL COMMENT '1分钟、2小时、3日、4周、5月',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT '规则表达式',
  `is_enable` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `task_remark` varchar(255) DEFAULT NULL COMMENT '任务说明',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `user_id` int(11) NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`task_id`),
  KEY `fk_jc_task_site` (`site_id`),
  CONSTRAINT `fk_jc_task_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';
DROP TABLE IF EXISTS jc_task_attr;
CREATE TABLE `jc_task_attr` (
  `task_id` int(11) NOT NULL,
  `param_name` varchar(30) NOT NULL COMMENT '参数名称',
  `param_value` varchar(255) DEFAULT NULL COMMENT '参数值',
  KEY `fk_jc_attr_task` (`task_id`),
  CONSTRAINT `fk_jc_attr_task` FOREIGN KEY (`task_id`) REFERENCES `jc_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参数表';
DROP TABLE IF EXISTS jc_test;
CREATE TABLE `jc_test` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT,
  `test_title` varchar(255) DEFAULT NULL,
  `test_description` varchar(255) DEFAULT NULL,
  `site_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  KEY `fk_jc_test_user` (`user_id`),
  KEY `fk_jc_test_site` (`site_id`),
  CONSTRAINT `fk_jc_test_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_test_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='测试表';
DROP TABLE IF EXISTS jc_third_account;
CREATE TABLE `jc_third_account` (
  `account_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_key` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方账号key',
  `username` varchar(100) NOT NULL DEFAULT '0' COMMENT '关联用户名',
  `source` varchar(10) NOT NULL DEFAULT '' COMMENT '第三方账号平台(QQ、新浪微博等)',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='第三方登录平台账号';
DROP TABLE IF EXISTS jc_topic;
CREATE TABLE `jc_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) DEFAULT NULL,
  `topic_name` varchar(150) NOT NULL COMMENT '名称',
  `short_name` varchar(150) DEFAULT NULL COMMENT '简称',
  `keywords` varchar(255) DEFAULT NULL COMMENT '关键字',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `title_img` varchar(100) DEFAULT NULL COMMENT '标题图',
  `content_img` varchar(100) DEFAULT NULL COMMENT '内容图',
  `tpl_content` varchar(100) DEFAULT NULL COMMENT '专题模板',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否推??',
  PRIMARY KEY (`topic_id`),
  KEY `fk_jc_topic_channel` (`channel_id`),
  CONSTRAINT `fk_jc_topic_channel` FOREIGN KEY (`channel_id`) REFERENCES `jc_channel` (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='CMS专题表';
 INSERT INTO `jc_topic` VALUES(8,82,'QQ群',null,'','','/upload/www/201410/151717431apw.jpg','/upload/www/201410/15171752bxsp.jpg','',10,1);
 INSERT INTO `jc_topic` VALUES(9,82,'专题测试1',null,'','大同是山西第二大城市，历史文化名城，这给擅长挖掘文化遗产商业价值的耿彦波及丰立祥二人提供了一个大舞台，随后“十几年拆不掉的‘老大难’哗啦啦都拆了”。2013年2月，耿彦波转任太原市委副书记、代市长，去年4月“代转正” 。',null,null,'',10,1);
 INSERT INTO `jc_topic` VALUES(10,null,'专题2','专题2','','2010年7月，丰立祥受访时曾指出，时任山西省委书记袁纯清到大同调研时，曾为该市定位了八个大字“塞上古都大佛名城”，并称“大同的建设标准要向北京、天津看齐，依托塞外古都、大佛名城的底蕴建设现代化城市”。丰立祥强调，“这就是我们转型跨越发展的新思路”。',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(11,null,'专题3','专题3','','在这样的理念下，丰立祥与从2008年01月起任大同代市长（2008年7月“代转正”）的耿彦波搭档，在大同市开展了前所未有的“城建风暴”（当地称其为具有“大同的特色”的“两都”（煤都和古都）建设），一时间成了大同百姓街头巷尾谈论的焦点。',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(12,null,'专题4','专题4','','【丰立祥最近公开报道：反腐败大同不能掉队】大同日报报道，10月11日，丰立祥主持市委常委会(扩大)会议，传达学习省委书记王儒林的讲话精神及省纪委常委会的部署要求，研究大同市贯彻落实意见。会议强调，要进一步加大查办案件力度,大同不能掉队，坚持“老虎”、“苍蝇”一起打。 ',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(13,null,'专题5','专题5','','习近平强调，文艺是时代前进的号角，最能代表一个时代的风貌，最能引领一个时代的风气。实现“两个一百年”奋斗目标、实现中华民族伟大复兴的中国梦，文艺的作用不可替代，文艺工作者大有可为。广大文艺工作者要从这样的高度认识文艺的地位和作用，认识自己所担负的历史使命和责任，坚持以人民为中心的创作导向，努力创作更多无愧于时代的优秀作品，弘扬中国精神、凝聚中国力量，鼓舞全国各族人民朝气蓬勃迈向未',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(14,null,'专题6','专题6','','习近平强调，一部好的作品，应该是把社会效益放在首位，同时也应该是社会效益和经济效益相统一的作品。文艺不能当市场的奴隶，不要沾染了铜臭气。优秀的文艺作品，最好是既能在思想上、艺术上取得成功，又能在市场上受到欢迎。',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(15,null,'专题7','专题7','','新华网北京10月15日电 据新华社“新华视点”微博报道，习近平15日上午在京主持召开文艺工作座谈会并发表重要讲话。习近平强调，文艺不能在市场经济大潮中迷失方向，不能在为什么人的问题上发生偏差，否则文艺就没有生命力。低俗不是通俗，欲望不代表希望，单纯感官娱乐不等于精神快乐。 ',null,null,'',10,0);
 INSERT INTO `jc_topic` VALUES(16,null,'习近平座谈会','习近平座谈会','','','/upload/www/201410/162252549jkw.jpg','/upload/www/201410/16225318gisu.jpg','',10,0);
 INSERT INTO `jc_topic` VALUES(17,null,'abc专题',null,'','','/upload/www/201411/020912442izn.jpg','/upload/www/201411/020913059c24.jpg','',10,1);
DROP TABLE IF EXISTS jc_user;
CREATE TABLE `jc_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `depart_id` int(11) DEFAULT NULL COMMENT '部门',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `rank` int(11) NOT NULL DEFAULT '0' COMMENT '管理员级别',
  `upload_total` bigint(20) NOT NULL DEFAULT '0' COMMENT '上传总大小',
  `upload_size` int(11) NOT NULL DEFAULT '0' COMMENT '上传大小',
  `upload_date` date DEFAULT NULL COMMENT '上传日期',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否管理员',
  `is_viewonly_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只读管理员',
  `is_self_admin` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否只管理自己的数据',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `file_total` int(11) NOT NULL DEFAULT '0' COMMENT '上传文库文档个数',
  `grain` int(11) NOT NULL DEFAULT '0' COMMENT '文库财富值',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`),
  KEY `fk_jc_user_group` (`group_id`),
  KEY `fk_jc_user_depart` (`depart_id`),
  CONSTRAINT `fk_jc_user_depart` FOREIGN KEY (`depart_id`) REFERENCES `jc_department` (`depart_id`),
  CONSTRAINT `fk_jc_user_group` FOREIGN KEY (`group_id`) REFERENCES `jc_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户表';
 INSERT INTO `jc_user` VALUES(1,1,1,'admin','','2011-01-03 00:00:00.0','127.0.0.1','2014-11-03 20:22:10.0','58.100.6.247',1088,9,991441,25630,'2014-11-03',1,0,0,0,0,103);
DROP TABLE IF EXISTS jc_user_attr;
CREATE TABLE `jc_user_attr` (
  `user_id` int(11) NOT NULL,
  `attr_name` varchar(255) NOT NULL,
  `attr_value` varchar(255) DEFAULT NULL,
  KEY `fk_jc_attr_user` (`user_id`),
  CONSTRAINT `fk_jc_attr_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户属性表';
DROP TABLE IF EXISTS jc_user_collection;
CREATE TABLE `jc_user_collection` (
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `content_id` int(11) NOT NULL DEFAULT '0' COMMENT '内容id',
  PRIMARY KEY (`user_id`,`content_id`),
  KEY `fk_jc_user_collection_con` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_con` FOREIGN KEY (`content_id`) REFERENCES `jc_content` (`content_id`),
  CONSTRAINT `fk_jc_user_collection_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏关联表';
DROP TABLE IF EXISTS jc_user_ext;
CREATE TABLE `jc_user_ext` (
  `user_id` int(11) NOT NULL,
  `realname` varchar(100) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别',
  `birthday` datetime DEFAULT NULL COMMENT '出生日期',
  `intro` varchar(255) DEFAULT NULL COMMENT '个人介绍',
  `comefrom` varchar(150) DEFAULT NULL COMMENT '来自',
  `qq` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `msn` varchar(100) DEFAULT NULL COMMENT 'MSN',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `user_img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `user_signature` varchar(255) DEFAULT NULL COMMENT '用户个性签名',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_ext_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户扩展信息表';
 INSERT INTO `jc_user_ext` VALUES(1,'大师',null,null,null,'南昌',null,null,'1110','110','','');
DROP TABLE IF EXISTS jc_user_menu;
CREATE TABLE `jc_user_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) NOT NULL COMMENT '菜单名称',
  `menu_url` varchar(255) NOT NULL COMMENT '菜单地址',
  `priority` int(11) NOT NULL DEFAULT '10',
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `fk_jc_menu_user` (`user_id`),
  CONSTRAINT `fk_jc_menu_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='用户常用菜单';
DROP TABLE IF EXISTS jc_user_resume;
CREATE TABLE `jc_user_resume` (
  `user_id` int(11) NOT NULL,
  `resume_name` varchar(255) NOT NULL COMMENT '简历名称',
  `target_worknature` varchar(255) DEFAULT NULL COMMENT '期望工作性质',
  `target_workplace` varchar(255) DEFAULT NULL COMMENT '期望工作地点',
  `target_category` varchar(255) DEFAULT NULL COMMENT '期望职位类别',
  `target_salary` varchar(255) DEFAULT NULL COMMENT '期望月薪',
  `edu_school` varchar(255) DEFAULT NULL COMMENT '毕业学校',
  `edu_graduation` datetime DEFAULT NULL COMMENT '毕业时间',
  `edu_back` varchar(255) DEFAULT NULL COMMENT '学历',
  `edu_discipline` varchar(255) DEFAULT NULL COMMENT '专业',
  `recent_company` varchar(500) DEFAULT NULL COMMENT '最近工作公司名称',
  `company_industry` varchar(255) DEFAULT NULL COMMENT '最近公司所属行业',
  `company_scale` varchar(255) DEFAULT NULL COMMENT '公司规模',
  `job_name` varchar(255) DEFAULT NULL COMMENT '职位名称',
  `job_category` varchar(255) DEFAULT NULL COMMENT '职位类别',
  `job_start` datetime DEFAULT NULL COMMENT '工作起始时间',
  `subordinates` varchar(255) DEFAULT NULL COMMENT '下属人数',
  `job_description` text COMMENT '工作描述',
  `self_evaluation` varchar(2000) DEFAULT NULL COMMENT '自我评价',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_jc_resume_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户简历';
 INSERT INTO `jc_user_resume` VALUES(1,'程序员','全职','上海','java工程师','','家里蹲大学',null,'本科','吃饭','<img src=/jeeadmin/jeecms/admin_global/o_update.do?password=111&groupId=1&rank=9&roleIds=1&siteIds=1&steps=2&allChannels=true&id=1＞',null,null,'11',null,null,null,'111','111');
DROP TABLE IF EXISTS jc_user_role;
CREATE TABLE `jc_user_role` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `fk_jc_role_user` (`user_id`),
  CONSTRAINT `fk_jc_role_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS用户角色关联表';
 INSERT INTO `jc_user_role` VALUES(1,1);
DROP TABLE IF EXISTS jc_user_site;
CREATE TABLE `jc_user_site` (
  `usersite_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `check_step` tinyint(4) NOT NULL DEFAULT '1' COMMENT '审核级别',
  `is_all_channel` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有栏目的权限',
  PRIMARY KEY (`usersite_id`),
  KEY `fk_jc_site_user` (`user_id`),
  KEY `fk_jc_user_site` (`site_id`),
  CONSTRAINT `fk_jc_site_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_user_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS管理员站点表';
 INSERT INTO `jc_user_site` VALUES(2,1,1,3,1);
DROP TABLE IF EXISTS jc_vote_item;
CREATE TABLE `jc_vote_item` (
  `voteitem_id` int(11) NOT NULL AUTO_INCREMENT,
  `votetopic_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `vote_count` int(11) NOT NULL DEFAULT '0' COMMENT '投票数量',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排列顺序',
  `subtopic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`voteitem_id`),
  KEY `fk_jc_vote_item_topic` (`votetopic_id`),
  KEY `FK_jc_vote_item_subtopic` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_item_subtopic` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`),
  CONSTRAINT `fk_jc_vote_item_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='CMS投票项';
 INSERT INTO `jc_vote_item` VALUES(1,2,'不喜欢',0,3,12);
 INSERT INTO `jc_vote_item` VALUES(2,2,'喜欢',0,2,12);
 INSERT INTO `jc_vote_item` VALUES(3,2,'很喜欢',1,1,12);
 INSERT INTO `jc_vote_item` VALUES(4,2,'没有改进',0,7,11);
 INSERT INTO `jc_vote_item` VALUES(5,2,'有改进',0,5,11);
 INSERT INTO `jc_vote_item` VALUES(6,2,'改进很大',1,4,11);
 INSERT INTO `jc_vote_item` VALUES(7,2,'差不多',0,6,11);
 INSERT INTO `jc_vote_item` VALUES(8,2,'下载',1,11,9);
 INSERT INTO `jc_vote_item` VALUES(9,2,'新闻',1,8,9);
 INSERT INTO `jc_vote_item` VALUES(10,2,'图库',1,9,9);
 INSERT INTO `jc_vote_item` VALUES(11,2,'视频',1,10,9);
DROP TABLE IF EXISTS jc_vote_record;
CREATE TABLE `jc_vote_record` (
  `voterecored_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `votetopic_id` int(11) NOT NULL,
  `vote_time` datetime NOT NULL COMMENT '投票时间',
  `vote_ip` varchar(50) NOT NULL COMMENT '投票IP',
  `vote_cookie` varchar(32) NOT NULL COMMENT '投票COOKIE',
  PRIMARY KEY (`voterecored_id`),
  KEY `fk_jc_vote_record_topic` (`votetopic_id`),
  KEY `fk_jc_voterecord_user` (`user_id`),
  CONSTRAINT `fk_jc_voterecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`),
  CONSTRAINT `fk_jc_vote_record_topic` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS投票记录';
DROP TABLE IF EXISTS jc_vote_reply;
CREATE TABLE `jc_vote_reply` (
  `votereply_id` int(11) NOT NULL AUTO_INCREMENT,
  `reply` text COMMENT '回复内容',
  `subtopic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`votereply_id`),
  KEY `FK_jc_vote_reply_sub` (`subtopic_id`),
  CONSTRAINT `FK_jc_vote_reply_sub` FOREIGN KEY (`subtopic_id`) REFERENCES `jc_vote_subtopic` (`subtopic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投票文本题目回复表';
DROP TABLE IF EXISTS jc_vote_subtopic;
CREATE TABLE `jc_vote_subtopic` (
  `subtopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `votetopic_id` int(11) NOT NULL DEFAULT '0' COMMENT '投票（调查）',
  `subtopic_type` int(2) NOT NULL DEFAULT '1' COMMENT '类型（1单选，2多选，3文本）',
  `priority` int(11) DEFAULT NULL,
  PRIMARY KEY (`subtopic_id`),
  KEY `FK_jc_vote_subtopic_vote` (`votetopic_id`),
  CONSTRAINT `FK_jc_vote_subtopic_vote` FOREIGN KEY (`votetopic_id`) REFERENCES `jc_vote_topic` (`votetopic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='投票子题目';
 INSERT INTO `jc_vote_subtopic` VALUES(9,'您觉得哪些模块做的比较好',2,2,4);
 INSERT INTO `jc_vote_subtopic` VALUES(10,'我觉得这里完善一下：',2,3,3);
 INSERT INTO `jc_vote_subtopic` VALUES(11,'设计风格有改进吗？',2,1,2);
 INSERT INTO `jc_vote_subtopic` VALUES(12,'设计风格您喜欢吗？',2,1,1);
DROP TABLE IF EXISTS jc_vote_topic;
CREATE TABLE `jc_vote_topic` (
  `votetopic_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `repeate_hour` int(11) DEFAULT NULL COMMENT '重复投票限制时间，单位小时，为空不允许重复投票',
  `total_count` int(11) NOT NULL DEFAULT '0' COMMENT '总投票数',
  `multi_select` int(11) NOT NULL DEFAULT '1' COMMENT '最多可以选择几项',
  `is_restrict_member` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制会员',
  `is_restrict_ip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制IP',
  `is_restrict_cookie` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否限制COOKIE',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `is_def` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否默认主题',
  PRIMARY KEY (`votetopic_id`),
  KEY `fk_jc_votetopic_site` (`site_id`),
  CONSTRAINT `fk_jc_votetopic_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='CMS投票主题';
 INSERT INTO `jc_vote_topic` VALUES(2,1,'用户问卷调查','希望大家能提出宝贵的意见，我们一定认真改进，谢谢大家的支持！',null,null,null,1,1,0,0,0,0,1);
DROP TABLE IF EXISTS jc_workflow;
CREATE TABLE `jc_workflow` (
  `workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL COMMENT '站点',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`workflow_id`),
  KEY `fk_jc_workflow_site` (`site_id`),
  CONSTRAINT `fk_jc_workflow_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流';
DROP TABLE IF EXISTS jc_workflow_event;
CREATE TABLE `jc_workflow_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `workflow_id` int(11) NOT NULL COMMENT '工作流',
  `date_id` int(11) NOT NULL COMMENT '数据标识',
  `user_id` int(11) NOT NULL COMMENT '发起人',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `next_step` int(11) NOT NULL DEFAULT '0' COMMENT '下个步骤',
  `date_type` int(11) NOT NULL DEFAULT '0' COMMENT '数据类型(0默认内容)',
  `is_finish` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否结束',
  `pass_num` int(11) DEFAULT NULL COMMENT '会签本节点通过人数',
  PRIMARY KEY (`event_id`),
  KEY `fk_event_workflow` (`workflow_id`),
  KEY `fk_workflow_event_user` (`user_id`),
  CONSTRAINT `fk_event_flow` FOREIGN KEY (`workflow_id`) REFERENCES `jc_workflow` (`workflow_id`),
  CONSTRAINT `fk_workflow_event_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流轨迹';
DROP TABLE IF EXISTS jc_workflow_event_user;
CREATE TABLE `jc_workflow_event_user` (
  `event_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL COMMENT '工作流转id',
  `user_id` int(11) NOT NULL COMMENT '流转用户',
  PRIMARY KEY (`event_user_id`),
  KEY `fk_jc_we_user` (`user_id`),
  KEY `fk_jc_we_event` (`event_id`),
  CONSTRAINT `fk_jc_we_event` FOREIGN KEY (`event_id`) REFERENCES `jc_workflow_event` (`event_id`),
  CONSTRAINT `fk_jc_we_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流轨迹用户表';
DROP TABLE IF EXISTS jc_workflow_node;
CREATE TABLE `jc_workflow_node` (
  `workflow_id` int(11) NOT NULL COMMENT '工作流',
  `role_id` int(11) NOT NULL COMMENT '角色',
  `priority` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `is_countersign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 会签 0普通流转',
  PRIMARY KEY (`workflow_id`,`priority`),
  KEY `fk_jc_node_workflow` (`workflow_id`),
  KEY `fk_jc_workflow_node_role` (`role_id`),
  CONSTRAINT `fk_jc_node_workflow` FOREIGN KEY (`workflow_id`) REFERENCES `jc_workflow` (`workflow_id`),
  CONSTRAINT `fk_jc_workflow_node_role` FOREIGN KEY (`role_id`) REFERENCES `jc_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流节点';
DROP TABLE IF EXISTS jc_workflow_record;
CREATE TABLE `jc_workflow_record` (
  `record_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '操作人',
  `site_id` int(11) NOT NULL COMMENT '站点',
  `event_id` int(11) NOT NULL DEFAULT '0' COMMENT '轨迹',
  `record_time` datetime NOT NULL COMMENT '创建时间',
  `opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型(1:通过  2退回 3保持)',
  PRIMARY KEY (`record_id`),
  KEY `fk_jc_workflowrecord_user` (`user_id`),
  KEY `fk_jc_workflowrecord_site` (`site_id`),
  KEY `fk_jc_workflowrecord_event` (`event_id`),
  CONSTRAINT `fk_jc_workflowrecord_event` FOREIGN KEY (`event_id`) REFERENCES `jc_workflow_event` (`event_id`),
  CONSTRAINT `fk_jc_workflowrecord_site` FOREIGN KEY (`site_id`) REFERENCES `jc_site` (`site_id`),
  CONSTRAINT `fk_jc_workflowrecord_user` FOREIGN KEY (`user_id`) REFERENCES `jc_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作流日志记录';
DROP TABLE IF EXISTS jo_authentication;
CREATE TABLE `jo_authentication` (
  `authentication_id` char(32) NOT NULL COMMENT '认证ID',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  `login_ip` varchar(50) NOT NULL COMMENT '登录ip',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`authentication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='认证信息表';
DROP TABLE IF EXISTS jo_config;
CREATE TABLE `jo_config` (
  `cfg_key` varchar(50) NOT NULL COMMENT '配置KEY',
  `cfg_value` varchar(255) DEFAULT NULL COMMENT '配置VALUE',
  PRIMARY KEY (`cfg_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';
 INSERT INTO `jo_config` VALUES('email_encoding','');
 INSERT INTO `jo_config` VALUES('email_host','smtp.163.com');
 INSERT INTO `jo_config` VALUES('email_password','gang1217');
 INSERT INTO `jo_config` VALUES('email_personal','');
 INSERT INTO `jo_config` VALUES('email_port',null);
 INSERT INTO `jo_config` VALUES('email_username','gang0119@163.com');
 INSERT INTO `jo_config` VALUES('login_error_interval','30');
 INSERT INTO `jo_config` VALUES('login_error_times','3');
 INSERT INTO `jo_config` VALUES('message_forgotpassword_subject','找回密码');
 INSERT INTO `jo_config` VALUES('message_forgotpassword_text','感谢您使用会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://www.wmtv.cn/member/password_reset.jspx?uid=${uid}&key=${resetKey}');
 INSERT INTO `jo_config` VALUES('message_register_subject','欢迎您注册为民网');
 INSERT INTO `jo_config` VALUES('message_register_text','${username}您好：\r\n欢迎您注册为民网\r\n请点击以下链接进行激活\r\nhttp://www.wmtv.cn/active.jspx?username=${username}&key=${activationCode}');
 INSERT INTO `jo_config` VALUES('message_subject','会员密码找回信息');
 INSERT INTO `jo_config` VALUES('message_text','感谢您使用会员密码找回功能，请记住以下找回信息：\r\n用户ID：${uid}\r\n用户名：${username}\r\n您的新密码为：${resetPwd}\r\n请访问如下链接新密码才能生效：\r\nhttp://localhost/member/password_reset.jspx?uid=${uid}&key=${resetKey}\r\n');
DROP TABLE IF EXISTS jo_ftp;
CREATE TABLE `jo_ftp` (
  `ftp_id` int(11) NOT NULL AUTO_INCREMENT,
  `ftp_name` varchar(100) NOT NULL COMMENT '名称',
  `ip` varchar(50) NOT NULL COMMENT 'IP',
  `port` int(11) NOT NULL DEFAULT '21' COMMENT '端口号',
  `username` varchar(100) DEFAULT NULL COMMENT '登录名',
  `password` varchar(100) DEFAULT NULL COMMENT '登陆密码',
  `encoding` varchar(20) NOT NULL DEFAULT 'UTF-8' COMMENT '编码',
  `timeout` int(11) DEFAULT NULL COMMENT '超时时间',
  `ftp_path` varchar(255) DEFAULT NULL COMMENT '路径',
  `url` varchar(255) NOT NULL COMMENT '访问URL',
  PRIMARY KEY (`ftp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='FTP表';
DROP TABLE IF EXISTS jo_template;
CREATE TABLE `jo_template` (
  `tpl_name` varchar(150) NOT NULL COMMENT '模板名称',
  `tpl_source` longtext COMMENT '模板内容',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `is_directory` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否目录',
  PRIMARY KEY (`tpl_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模板表';
DROP TABLE IF EXISTS jo_upload;
CREATE TABLE `jo_upload` (
  `filename` varchar(150) NOT NULL COMMENT '文件名',
  `length` int(11) NOT NULL COMMENT '文件大小(字节)',
  `last_modified` bigint(20) NOT NULL COMMENT '最后修改时间',
  `content` longblob NOT NULL COMMENT '内容',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上传附件表';
DROP TABLE IF EXISTS jo_user;
CREATE TABLE `jo_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `register_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '注册IP',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) NOT NULL DEFAULT '127.0.0.1' COMMENT '最后登录IP',
  `login_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reset_key` char(32) DEFAULT NULL COMMENT '重置密码KEY',
  `reset_pwd` varchar(10) DEFAULT NULL COMMENT '重置密码VALUE',
  `error_time` datetime DEFAULT NULL COMMENT '登录错误时间',
  `error_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录错误次数',
  `error_ip` varchar(50) DEFAULT NULL COMMENT '登录错误IP',
  `activation` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态',
  `activation_code` char(32) DEFAULT NULL COMMENT '激活码',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `ak_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
 INSERT INTO `jo_user` VALUES(1,'admin',null,'5f4dcc3b5aa765d61d8327deb882cf99','2011-01-03 00:00:00.0','127.0.0.1','2013-11-06 15:09:12.0','127.0.0.1',131,null,null,'2013-12-24 17:01:46.0',1,'127.0.0.1',1,null);
SET FOREIGN_KEY_CHECKS = 1;
