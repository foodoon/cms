DROP DATABASE IF EXISTS `cms`;
CREATE DATABASE `cms`;
use `cms`;


delete from mysql.user where User = 'demo_user';
grant select,update,delete,insert on `cms`.* to 'cms_user'@'%' identified by 'cms_pwd';
grant select,update,delete,insert on `cms`.* to 'cms_user'@'localhost' identified by 'cms_pwd';
flush privileges;