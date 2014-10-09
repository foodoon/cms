DROP DATABASE IF EXISTS `demo`;
CREATE DATABASE `demo`;
use `demo`;


delete from mysql.user where User = 'demo_user';
grant select,update,delete,insert on `demo`.* to 'demo_user'@'%' identified by 'demo_pwd';
grant select,update,delete,insert on `demo`.* to 'demo_user'@'localhost' identified by 'demo_pwd';
flush privileges;