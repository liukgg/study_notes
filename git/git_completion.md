Git命令自动补全
======================

如果你用的是 Bash shell，可以使用 Git 提供的自动补全脚本。
下载 Git 的源代码，进入 contrib/completion 目录，会看到一个 git-completion.bash 文件。
将此文件复制到你自己的用户主目录中并且改名加上点：
（或者也可以直接复制该文件内容： ）

```shell
cp git-completion.bash ~/.git-completion.bash，
```

并把下面一行内容添加到你的 .bashrc 文件中：

```shell
source ~/.git-completion.bash
```

在输入 Git 命令的时候可以敲两次跳格键（Tab），就会看到列出所有匹配的可用命令建议：

```shell
$ git co<tab><tab>
commit config
```

此例中，键入 git co 然后连按两次 Tab 键，会看到两个相关的建议（命令） commit 和 config。
继而输入 m<tab> 会自动完成 git commit 命令的输入。

命令的选项也可以用这种方式自动完成，其实这种情况更实用些。
比如运行 git log 的时候忘了相关选项的名字，可以输入开头的几个字母，然后敲 Tab 键看看有哪些匹配的：

```shell
$ git log --s<tab>
--shortstat  --since=  --src-prefix=  --stat   --summary
```
