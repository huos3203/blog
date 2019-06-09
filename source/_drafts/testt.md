---
title: 练习uml分解需求用例的方法
date: 2019-06-09 07:00:47+0800 
updated: 2019-06-09 07:00:47+0800 
comments: true
---

<!-- TOC GFM -->

* [甘特图](#甘特图)
* [用例图](#用例图)
* [类图](#类图)

<!-- /TOC -->
### 甘特图
```puml
title 甘特图合理安排时间
center header
合理安排时间
endheader
project starts 2019-06-09 
Sunday are closed
Saturday are closed
[整理个人资产] as [money] lasts 5 days
[账户] as [me] lasts 1 days
[投资] as [tz] lasts 2 days
[股市] as [gsh] lasts 2 days
[学习swift] as [swift] lasts 3 days
[swiftUI] as [UI] lasts 1 days
[playground] as [play] lasts 1 days
[xcode11] as [11] lasts 1 days
[设计模式] as [design] lasts 2 days
[money] -> [swift]
[me] -> [tz]
[tz] -> [gsh]
[理财] happens at [gsh]'s end
[swift] -> [design]
[gsh] -> [UI]
[UI] -> [play]
[play] -> [11]
[里程碑] happens at [swift]'s end 
```
### 用例图
分解任务，封装复用功能组件
```puml
title 功能组件分解封装
center header
描述
endheader
:小明: as ren
(公园) as gy
(🐶) as dog
(时间) as time
ren --> gy:晚上散步
gy --> dog:公园遛狗
```

### 类图
```puml
title 开发阶段类图实现
center header
类图功能
endheader
class "xxxUsers" as user{
    --属性组 --
    + var name:String=""	
    __ 函数组__
    + func 遛狗(time:Date,小狗:dog)
}
class "狗类" as dog {
    --属性组 --
    + var name:String="小狗"	
    __ 函数组__
    + func 跑(time:Date,place:String)
}
user -> dog
note right of dog
 在晚上喜欢夜跑的dog
end note
```
