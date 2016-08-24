主从库
======================

### 全局配置
mongoid.yml 中，使用 mode: :primary 可以保证强一致性；
切换为 :sedondary 时无法保证一致性。

### 在特定的查询中指定使用从库
 UserRelation.where(id: 1).read(mode: :secondary)

