Rails + Mysql 存储表情符号
==================================

参考
-----------------------------------------------

rails存储表情符号：  http://blog.arkency.com/2015/05/how-to-store-emoji-in-a-rails-app-with-a-mysql-database/


命令：
-------------------------------------------------

```shell
 USE INFORMATION_SCHEMA;

 SELECT  CONCAT("ALTER TABLE `", TABLE_SCHEMA,"`.`", TABLE_NAME, "` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;")  AS MySQLCMD FROM TABLES  WHERE TABLE_SCHEMA = "your_database_name";

 # 然后依次执行上面列出的命令；
 # 初步调研发现mysql无法一个命令同时改动某个数据库的所有的表。
```
