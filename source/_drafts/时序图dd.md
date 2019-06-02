---
title: 时序图dd
date: 2019-06-02 01:12:21+0800 
updated: 2019-06-02 01:12:21+0800 
comments: true
---
```puml
title 练习uml设计图
center header
总结整理vim自动补齐脚本，提高博客编写效率
主要练习提炼uml设计图的使用习惯，快速便捷书写uml脚本
endheader
autonumber 0
'actor,boundary,control,entity,database
actor 巡查人 as patrol
actor 管理员 as admin
===发送消息==
patrol --> admin:提交任务
activate patrol
patrol <-- admin:处理完毕
deactivate patrol
```
## 用例

```puml
left to right direction
(列表) as (list)
:admin: --> list
:patrol: --> list
admin --|>patrol
note left of admin
管理所有用户的权限
end note

```
