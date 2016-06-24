
mongodb创建索引时指定1或-1的作用（ascending and desending）
===============================================================

概要
------------------------------------------

- 对于单列索引，1和－1是等效的，没有影响。

- 对于复合索引，1和-1会决定，到底哪些排序会能用到索引。

举例说明
----------------------------------------------
http://stackoverflow.com/questions/10329104/why-does-direction-of-index-matter-in-mongodb

参考：
---------------------------------------------

http://stackoverflow.com/questions/10329104/why-does-direction-of-index-matter-in-mongodb

https://docs.mongodb.com/manual/core/index-compound/#index-ascending-and-descending
