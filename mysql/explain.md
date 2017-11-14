EXPLAIN
---------------------------------------------

EXPLAIN 命令是察看查询优化器如何决定执行查询的主要方法。

EXPLAIN EXTENDED
EXPLAIN PARTITIONS

认为EXPLAIN不会执行查询，这是一个常见错误。实际上，如果查询在FROM子句中包括子查询，那么MySQL实际上会执行子查询，
将其结果放在一个临时表中，然后完成外层查询优化。

要意识到EXPLAIN只是个近似结果。

EXPLAIN不会告诉你触发器、存储过程或UDF会如何影响查询。

# 字段
## select_type

这一列显示了对应行是简单还是复杂SELECT

SIMPLE值意味着查询不包括子查询和UNION

SIMPLE, PRIMARY, SUBQUERY-DERIVED, UNION, UNION RESULT

## type列
关联类型／访问类型－－换言之就是MySQL决定如何查找表中的行。

ALL (全表扫描)

index
如果在Extralie中看到 Using index， 说明MySQL正在使用覆盖索引。

range


