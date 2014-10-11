DROP DATABASE IF EXISTS `cmstest`;
CREATE DATABASE `cmstest` default charset=utf8 ;
use `cmstest`;


delete from mysql.user where User = 'cmstest_user';
grant select,update,delete,insert on `cmstest`.* to 'cmstest_user'@'%' identified by 'cms_pwd';
grant select,update,delete,insert on `cmstest`.* to 'cmstest_user'@'localhost' identified by 'cms_pwd';
flush privileges;