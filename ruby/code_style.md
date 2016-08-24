# ruby代码规范

作者：罗昕

## The Ruby Style Guide

> Hey jude, don't make it bad.
> Take a sad song and make it better.
> Remember to let her into your heart,
> Then you can start to make it better.

* [github Ruby style guide](https://github.com/styleguide/ruby)
* [community-driven Ruby style guide](https://github.com/bbatsov/ruby-style-guide)
* [Ruby on Rails 3 Style Guide](https://github.com/bbatsov/rails-style-guide)
* [代码大全](http://book.douban.com/subject/1477390/)
* [代码整洁之道](http://book.douban.com/subject/4199741/)
* [重构](http://book.douban.com/subject/1229923/)

## 排版

* 使用`UTF-8`编码

    ```VimL
    set encoding=utf-8
    set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1 " 如果你要打开的文件编码不在此列，那就添加进去
    set termencoding=utf-8
    ```

* 使用等宽字体

    ```VimL
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
    ```

* 使用两个空格作为缩进

    ```Ruby
    # good
    def some_method
      do_something
    end

    # bad - four spaces
    def some_method
        do_something
    end
    ```

* 不要在缩进中留下制表符(Tab)。设置编辑器，自动将制表符展开为两个空格

    ```VimL
    " 示例1：全局设置
    set autoindent
    set expandtab
    set tabstop=2 shiftwidth=2 softtabstop=2
    ```

    ```VimL
    " 示例2：每语言单独设置
    autocmd FileType ruby,eruby,yaml set ai ts=2 sw=2 sts=2 et
    ```

* 正确拼写英文单词

    ```Ruby
    # bad
    def has_joind?(talbe_name)
      return false unless scoped.respond_to?(:joins_values)
      scoped.joins_values.any?{|joins| joins =~ /inner\s+join\s+#{talbe_name}/i }
    end

    # good
    def has_joined?(table_name)
      return false unless scoped.respond_to?(:joins_values)
      scoped.joins_values.any? { |joins| joins =~ /inner\s+join\s+#{table_name}/i }
    end
    ```

* 尽量将行的长度控制在80个字符以下

    ```Ruby
    # bad
    def some_method
      a_long_long_long_long_long_long_long_method_call if condition1 && condition2 && condition3
      a_long_long_long_long_long_long_long_operation1 && a_long_long_long_long_long_long_long_operation2 && a_long_long_long_long_long_long_long_operation3
    end

    # good, 但更好的做法是考虑重命名方法或将相应逻辑抽取成子方法
    def some_method
      if condition1 && condition2 && condition3
        a_long_long_long_long_long_long_long_method_call
      end

      a_long_long_long_long_long_long_long_operation1 &&
        a_long_long_long_long_long_long_long_operation2 &&
        a_long_long_long_long_long_long_long_operation3
    end
    ```

* 不要在行尾留下空白字符

    ```VimL
    set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
    ```

* 在以下位置加上空格：操作符前后, 逗号、冒号、分号后，'{'前后， '}'前

    ```Ruby
    sum = 1 + 2
    result = 10 / (1 + 2)
    a, b = 1, 2
    1 > 2 ? some_operation : other_operation
    [1, 2, 3].each { |e| puts e }
    hash = { key1: 'luo', key2: 'xin' }

    def find(name, options = {})
      result
    end
    ```

    唯一的例外是指数操作符

    ```Ruby
    # bad
    e = M * c ** 2

    # good
    e = M * c**2
    ```

* 以下位置没有空格：'(', '['后和']', ')'前

    ```Ruby
    some(arg).other
    [1, 2, 3].length
    ```

* 保证`when`和`case`的缩进层次相同

    ```Ruby
    case
    when song.name == 'Misty'
      puts 'Not again!'
    when song.duration > 120
      puts 'Too long!'
    when Time.now.hour > 21
      puts "It's too late"
    else
      song.play
    end

    kind = case year
           when 1850..1889 then 'Blues'
           when 1890..1909 then 'Ragtime'
           when 1910..1929 then 'New Orleans Jazz'
           when 1930..1939 then 'Swing'
           when 1940..1950 then 'Bebop'
           else 'Jazz'
           end
    ```

* 使用空行分隔不同方法及同一方法的不同逻辑段

    ```Ruby
    def some_method
      data = initialize(options)

      first_method_call_with(data)
      second_method_call_with(data)
      third_method_call_with(data)

      data.result
    end

    def other_method
      result
    end
    ```

* 如果使用表达式赋值，表达式的缩进要保持一致

    ```Ruby
    # bad
    result = if index > 10
      do_something
    elsif index > 5
      do_other_thing
    else
      puts 'I can not bear it.'
    end

    # good
    result = if index > 10
               do_something
             elsif index > 5
               do_other_thing
             else
               puts 'I can not bear it.'
             end
    ```

* 多行赋值时，为保持美观，尽量将等号对齐

    ```Ruby
    # ok
    var1 = 1
    var12 = 12
    var12345 = 12345
    var123 = 123

    # good
    var1     = 1
    var12    = 12
    var12345 = 12345
    var123   = 123
    ```

* 使用哈希赋值时，如果哈希长度过长，应该用多行表示，且尽量保持对齐

    ```Ruby
    # very bad
    result = {:key1=>:value1,:key2=>:value2}
    # bad
    result = { :this_is_the_first_key => :this_is_the_first_value, :this_is_another_key => :this_is_another_value, :this_is_the_last_key => :this_is_the_last_value }

    # good for ruby 1.8
    result = { :key1 => :value1, :key2 => :value2 }
    result = { :this_is_the_first_key => :this_is_the_first_value,
               :this_is_another_key   => :this_is_another_value,
               :this_is_the_last_key  => :this_is_the_last_value }

    # good for ruby 1.9
    result = { key1: :value1, key2: :value2 }
    result = { this_is_the_first_key: :this_is_the_first_value,
               this_is_another_key:   :this_is_another_value,
               this_is_the_last_key:  :this_is_the_last_value }
    ```

## 语法

* 定义方法时，如果带参要加上括号，否则不要加括号

    ```Ruby
     def some_method
       # body omitted
     end

     def some_method_with_arguments(arg1, arg2)
       # body omitted
     end
    ```

* 使用迭代器，而不要使用for语句

    ```Ruby
    # bad
    for elem in arr do
      puts elem
    end

    # good
    arr.each { |elem| puts elem }
    ```

* 不要在多行的if/unless语句中使用then

    ```Ruby
    # bad
    if some_condition then
      # body omitted
    end

    # good
    if some_condition
      # body omitted
    end
    ```

* 不要使用冗长的三元表达式(?:)。但在逻辑较简单，能用一行表达的情况下，使用三元表达式而不是if/then/else/end语句

    ```Ruby
    # bad
    result = if some_condition then something else something_else end

    # good
    result = some_condition ? something : something_else
    ```

* 三元表达式中不要出现逻辑分支。在这种情况下应该使用if/else语句

    ```Ruby
    # bad
    some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

    # good
    if some_condition
      nested_condition ? nested_something : nested_something_else
    else
      something_else
    end
    ```

* 不要使用and和or. 总是使用&&和||

    ```Ruby
    # bad. 注意操作符的优先级
    # 等价于(result = find_by_name(name)) or find_by_code(code) or fail 'wow!'
    result = find_by_name(name) or find_by_code(code) or fail 'wow!'

    # good
    result = find_by_name(name) || find_by_code(code) || fail('wow!')
    ```

* 不要跨行使用三元表达式, 使用if/unless语句

* 在语句非常简短的情况下使用单行后置if/unless语句

    ```Ruby
    # bad
    if some_condition
      do_something
    end

    # good
    do_something if some_condition
    ```

* 不要使用unless/else语句，将它改写为if/else语句

    ```Ruby
    # bad
    unless success?
      puts 'failure'
    else
      puts 'success'
    end

    # good
    if success?
      puts 'success'
    else
      puts 'failure'
    end
    ```

* 不要对if/unless/while语句的中的单个条件使用括号

    ```Ruby
    # bad
    if (x > 10)
      # body omitted
    end

    # good
    if x > 10
      # body omitted
    end

    # good, 不用括号语义会改变。即使用括号也不要用or
    if (x = something) && y
      # body omitted
    end
    ```

* 单行block使用花括号{...}. 多行block使用do...end. 不要使用do...end进行链式调用

    ```Ruby
    names = %w(Bozhidar Steve Sarah)

    # good
    names.each { |name| puts name }

    # bad
    names.each do |name|
      puts name
    end

    # good
    names.select { |name| name.start_with?('S') }.map { |name| name.upcase }

    # bad
    names.select do |name|
      name.start_with?("S")
    end.map { |name| name.upcase }

    # ok, 但更佳的方式是把复杂逻辑包装成方法调用
    names.select { |name| name.start_with?('S') && name.end_with?('e') }.
             map { |name| name.upcase }
    ```

* 不要在不必要的情况下使用return

    ```Ruby
    # bad
    def some_method(some_arr)
      return some_arr.size
    end

    # good
    def some_method(some_arr)
      some_arr.size
    end
    ```

* 方法定义时，在定义有默认值的参数时，等号的前后要加上空格

    ```Ruby
    # bad
    def some_method(arg1=:default, arg2=nil, arg3=[])
      # do something...
    end

    # good
    def some_method(arg1 = :default, arg2 = nil, arg3 = [])
      # do something...
    end
    ```

* 可以使用赋值语句(=)的返回值，但要注意优先级，需要时以括号环绕

    ```Ruby
    # ok
    if (v = array.grep(/foo/))
      # do something...
    end

    # good
    if v = array.grep(/foo/)
      # do something...
    end

    # also good - 用括号保证操作符优先级正确
    if (v = self.next_value) == "hello"
      # do something...
    end
    ```

* 可以使用||=给变量赋初值，但不要使用||=给布尔类型变量赋初值（因为原始值可能为false）

    ```Ruby
    # set name to Bozhidar, only if it's nil or false
    name ||= 'Bozhidar'

    # bad - would set enabled to true even if it was false
    enabled ||= true

    # good
    enabled = true if enabled.nil?
    ```

* 在用实例变量实现memoize模式的方法中，使用defined?而不是||=

    ```Ruby
    # bad, 当do_something的返回值为nil或false时，没有起到memoize的效果
    def some_method
      @result ||= do_something
    end

    # good
    def some_method
      defined?(@result) ? @result : @result = do_something
    end
    ```

* 不要在方法名和括号中间加空格

    ```Ruby
    # bad
    f (3 + 2) + 1

    # bad
    def fun (a)
      a * 2
    end

    # good
    f(3 + 2) + 1

    # good
    def fun(a)
      a * 2
    end
    ```

* 用下划线取代未使用的block参数

    ```Ruby
    # bad
    result = hash.map { |k, v| v + 1 }

    # good
    result = hash.map { |_, v| v + 1 }
    ```

## 命名规则

* 方法和变量使用snake_case

    ```Ruby
    # bad
    def someMethod
      myName = 'luoxin'
    end

    # good
    def some_method
      my_name = 'luoxin'
    end
    ```

* 类和模块的定义使用CamelCase. 注意保持首字母缩写词的原有形式，如HTTP, RFC, XML等

    ```Ruby
    # bad
    module HttpServer
      # ...
    end

    # good
    module HTTPServer
      # ...
    end
    ```

* 常量的定义使用SCREAMING_SNAKE_CASE

    ```Ruby
    # bad
    class Week
      Days_In_A_Week = 7
    end

    # good
    class Week
      DAYS_IN_A_WEEK = 7
    end
    ```

* 配置相关信息不要使用常量

    ```Ruby
    # bad
    class JavaService
      JAVA_SERVICE_URL = '192.168.8.81'
    end

    # good
    class JavaService
      cattr_accessor :url, instance_write: false
      self.url = '192.168.8.81'
    end
    ```

* 逻辑判断的方法(返回值为布尔型)应该使用形容词或动词完成时态，并以问号结尾。不要使用is_前缀

    ```Ruby
    # bad
    def empty
      something.count > 0
    end

    # bad
    def is_empty?
      something.count > 0
    end

    # good
    def empty?
      something.count > 0
    end
    ```

* 使用具有描述性的方法名和变量名

    ```Ruby
    # bad
    def gen_ymdhms
      # ...
    end

    # good
    def generate_timestamp
      # ...
    end

    # bad
    all = deals.map { |x| x.id }

    # good
    deal_ids = deals.map { |deal| deal.id }
    ```

## 集合

* 当声明全由字符串组成的数组时，使用%w()

    ```Ruby
    # bad
    STATES = ['draft', 'open', 'closed']

    # good
    STATES = %w(draft open closed)
    ```

* 如果集合中的元素皆为唯一，使用Set而不是Array

    ```Ruby
    s = Set.new
    s << 1 << 2 << 3 << 2 << 1 # <Set: {1, 2, 3}>
    ```

* 尽量使用symbol而不是string作为哈希的键

    ```Ruby
    # bad
    hash = { 'one' => 1, 'two' => 2, 'three' => 3 }

    # good for ruby 1.8
    hash = { :one => 1, :two => 2, :three => 3 }

    # good for ruby 1.9
    hash = { one: 1, two: 2, three: 3 }
    ```

## 字符串

* 使用字符串插入(interpolation)，不要使用字符串加法

    ```Ruby
    # bad
    email_with_name = user.name + ' <' + user.email + '>'

    # good
    email_with_name = "#{user.name} <#{user.email}>"
    ```

* 当不需要字符串插入或者处理\t, \n等特殊字符时，使用单引号

    ```Ruby
    # bad
    require "active_support"
    name = "Bozhidar"

    # good
    require 'active_support'
    name = 'Bozhidar'
    ```

* 构造字符串时不要使用字符串加法, 要使用字符串连接操作符

    ```Ruby
    # good and also fast
    html = ''
    html << '<h1>Page title</h1>'
    paragraphs.each { |paragraph| html << "<p>#{paragraph}</p>" }
    ```

## 特殊构造符

* 使用%w构造字符串数组

    ```Ruby
    STATES = %w(draft open closed)
    ```

* 使用%()构造单行的、包含双引号和插入的字符串

    ```Ruby
    # bad (no interpolation needed)
    %(<div class="text">Some text</div>)
    # should be '<div class="text">Some text</div>'

    # bad (no double-quotes)
    %(This is #{quality} style)
    # should be "This is #{quality} style"

    # bad (multiple lines)
    %(<div>\n<span class="big">#{exclamation}</span>\n</div>)
    # should be a heredoc

    # bad (no double-quotes)
    %(<tr><td class='name'>#{name}</td>)
    # should be "<tr><td class='name'>#{name}</td>"

    # good (requires interpolation, has double quotes, single line)
    %(<tr><td class="name">#{name}</td>)
    ```

* 对多行的字符串使用heredoc

    ```Ruby
    # bad (multiple lines)
    %(<div>\n<span class="big">#{exclamation}</span>\n</div>)
    # should be a heredoc

    # good
    <<-HTML
      <div>
        <span class="big">#{exclamation}</span>
      </div>
    HTML
    ```

* 在正则表达式中包含多个'/'时使用%r

    ```Ruby
    # bad
    %r(\s+)

    # still bad
    %r(^/(.*)$)
    # should be /^\/(.*)$/

    # good
    %r(^/blog/2011/(.*)$)
    ```

* 不要使用%q, %Q, %x, %s, and %W. 使用%构造符时，首选()作为分割符

    ```Ruby
    # bad
    name = %q(I'm luoxin)
    # should be "I'm luoxin" or 'I\'m luoxin'

    # bad
    div = %Q(<div id="#@div_id" name="#@div_name"></div>)
    # should be %(<div id="#@div_id" name="#@div_name"></div>)

    # bad
    div = %Q[div id="#@div_id" name="#@div_name"></div>]
    # should be %(<div id="#@div_id" name="#@div_name"></div>)

    # good
    js = %[alert("Hi, #@user_name");]
    ```

## 其他

* 代码中嵌入SQL语句时，SQL关键字大写，其他字符小写

    ```Ruby
    # bad
    User.find_by_sql('select id, name from users where id < 5')

    # good
    User.find_by_sql('SELECT id, name FROM users WHERE id < 5')
    ```

* 如果代码中嵌入的SQL语句过长，使用换行来划分逻辑

    ```Ruby
    # bad, too long
    ActiveRecord::Base.connection.execute('INSERT INTO hui800.deals VALUES (id, code, title, start_time, end_time) SELECT id, code, name, start_date, end_date FROM coupons.deal')

    # good
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO hui800.deals
      VALUES (id, code, title, start_time, end_time)
      SELECT  id, code, name,  start_date, end_date
      FROM coupons.deal
    SQL
    ```

* 不要出现N+1查询

    ```Ruby
    # bad, N+1
    users = User.where('id < 100')
    users.each { |u| puts u.school }

    # good
    users = User.where('id < 100').includes(:school)
    users.each { |u| puts u.school }
    ```

* 方法参数的个数尽量不超过两个，最多不超过三个(*args除外)。如果有多选项，一般通过最末的哈希参数来传递

    ```Ruby
    # bad
    def my_cache(key, city_id = nil, page = nil, per_page = nil, order_by = nil)
    end

    # good
    def my_cache(key, options = {})
    end
    ```

* 在Ruby 1.9中使用新的哈希语法

    ```Ruby
    # bad for Ruby 1.9
    hash = { :a => 1, :b => 2, :c => 3 }

    # good for Ruby 1.9
    hash = { a: 1, b: 2, c: 3 }
    ```

* 在Ruby 1.9中使用新的lambda语法

    ```Ruby
    # bad for Ruby 1.9
    my_lambda = lambda { |x| puts x }
    my_lambda.call(3)

    # good for Ruby 1.9
    my_lambda = ->(x) { puts x }
    my_lambda.(3)
    ```

* 在不期望修改的对象上调用freeze方法

    ```Ruby
    # bad
    configuration = { database: 'tuan800', adapter: 'mysql2' }

    # good
    configuration = { database: 'tuan800', adapter: 'mysql2' }.freeze
    ```

* 熟练使用一种编辑器。推荐使用Vim或Emacs

## 原则

1. Consistency(一致性)
2. KISS(简洁性)
3. Common sense
4. Follow your heart

> 思想、语言、文字，是一体的，假如念起来乱糟糟，意思也不
> 会好——这是最简单的真理，但假如没有前辈来告诉我，我怎么
> 会知道啊。有时我也写点不负责任的粗糙文字，以后重读时，
> 惭愧得无地自容，真想自己脱了裤子请道乾先生打我两棍。孟
> 子曾说，无耻之耻，无耻矣。现在我在文学上是个有廉耻的人，
> 都是多亏了这些先生的教诲。对我来说，他们的作品是比鞭子
> 还有力量的鞭策。
> 我一直想承认我的文学师承是这样一条鲜为人知的线索。这是
> 给我脸上贴金。我最终写出了这些，不是因为我的书已经写得
> 好了，而是因为，不把这个秘密说出来，对现在的年轻人是不
> 公道的。没有人告诉他们这些，只按名声来理解文学，就会不
> 知道什么是坏，什么是好。
>                         --王小波《我的师承》