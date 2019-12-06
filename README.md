# SSM三大框架整合

> 本项目是针对Java EE互联网轻量级框架整合,目前没有过多的功能,只实现用户模块的增删改查权限验证等功能(其他模块都一样),

因为目的不在如何写业务逻辑,而是整合框架.

## 技术

### 技术点

1. java   
2. spring   
3. springMVC 
4. mybatis
5. maven
6. mysql
7. druid
8. redis 
9. layui


## 功能

从 Spring核心IoC(Bean装配), Spring核心AOP(封装日志,封装数据库主从切换), 

监听器(redis频道监听,redis过期事件监听)(redis采用的哨兵模式)到Web层的拦截器(登录以及权限拦截),

再到DAO层的Mybatis常规的配置以及用法. test中包含了各层的测试,以及redis

常用技术的测试等等. 可用于真正开发时技术参考.



## 演示

> 导入数据库,账号/密码 abc123/123456

## 效果图如下:

![Image 1](https://github.com/pzhen/jbctrl/blob/master/src/main/resources/jbctrl01.png)

![Image 2](https://github.com/pzhen/jbctrl/blob/master/src/main/resources/jbctrl02.png)

![Image 3](https://github.com/pzhen/jbctrl/blob/master/src/main/resources/jbctrl03.png)


