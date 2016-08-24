数组相关查询
======================

查询Array中包含指定元素的方法
--------------------------------------------
http://stackoverflow.com/questions/18148166/find-document-with-array-that-contains-a-specific-value

官方文档
https://docs.mongodb.com/manual/tutorial/query-documents/#match-an-array-element

Match an Array Element

Equality matches can specify a single element in the array to match. These specifications match if the array contains at least one element with the specified value.

The following example queries for all documents where badges is an array that contains "black" as one of its elements:

```
db.users.find( { badges: "black" } )
```
