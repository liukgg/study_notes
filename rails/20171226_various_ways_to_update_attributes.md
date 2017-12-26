Rails中更新对象属性的各个方法对比
------------------------------------------

# save(options = {})
尝试保存记录并在保存成功的情况下清除掉改变的属性。
可以通过传入参数 validate: false 来跳过校验。
返回值：true 或 false

示例：
```ruby
user = User.first
user.name         # => "kun"
user.name = "tom" # => "tom"
user.changes      # => {"name"=>["kun", "tom"]}
user.save         # => true
user.changes      # => {}
```

# save!(options = {})
行为类似save，但是当记录无效时，会抛出一个 ActiveRecord::RecordInvalid 异常而不是返回false。

# update(attributes)
按照传入的哈希来更新对象的属性并且保存该记录，所有操作包在一个事务中。
如果该对象无效（校验不通过），那么保存会失败并返回false。
该方法有别名方法： update_attributes

示例：
```ruby
user = User.first
user.update name: "peter" # => true
```

# update!(attributes)
类似update方法，但是调用的事save!而不是save方法，所以当记录无效时会抛出异常。
该方法有别名方法： update_attributes!

# update_all(updates)
更新给定条件下的所有记录。该方法构造一个SQL UPDATE语句，然后直接发送给数据库。
该方法不会将相关的models进行实例化，也不会触发Active Record的callbacks（回调方法）以及validations（校验方法）。
但是，传给update_all方法的值仍然会通过Active Record正常的类型转换和序列化。

示例：
```ruby
# Update all customers with the given attributes
Customer.update_all wants_email: true

# Update all books with 'Rails' in their title
Book.where('title LIKE ?', '%Rails%').update_all(author: 'David')

# Update all books that match conditions, but limit it to 5 ordered by date
Book.where('title LIKE ?', '%Rails%').order(:created_at).limit(5).update_all(author: 'David')

# Update all invoices and set the number column to its id value.
Invoice.update_all('number = id')
```

# update_attribute(name, value)
更新单个属性并保存记录。这对于已经存在的记录上的布尔值更新尤其有用。

对于该方法，需要注意以下特性：
- 跳过了校验（validation）
- 会执行回调（callbacks）
- 会更新updated_at或者updated_on字段（在该字段存在的情况下）
- 会更新这个对象上所有的脏(dirty)属性（发生了变化的属性）

备注：关于dirty的详细了解可以参考 http://api.rubyonrails.org/ 中的相关module
ActiveModel::Dirty (activemodel/lib/active_model/dirty.rb)

示例：
```ruby
user = User.first
user.update_attribute :name, "peter" # => true 
```

# update_attributes(attributes)
update方法的别名，和update方法完全等价，参考update方法用法

# update_attributes!(attributes)
update! 方法的别名，和 update! 方法完全等价，参考 update! 方法用法

# update_column(name, value)
等价于 update_columns(name => value)

# update_columns(attributes)
直接通过UPDATE SQL语句在数据库中更新给定的属性并在接受者（对象）上设置这些属性：
示例：
```ruby
user.update_columns(last_request_at: Time.current)
```

这是更新属性最快捷的方法，因为该方法直接操作数据库，但是与此同时需要注意的是，规律性的update过程完全被跳过了。
注意以下特性：
- 校验被跳过
- 回调被跳过
- 不更新updated_at及updated_on字段
- 但是，属性还是会被序列化，规则同 ActiveRecord::Relation#update_all

当在新对象上被调用时或者至少有一个属性被标记为只读（readonly）时，该方法会抛出一个 ActiveRecord::ActiveRecordError 异常。

# 参考资料：
http://api.rubyonrails.org/
