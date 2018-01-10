# ManagementSystem
### SSM实现的增删改查的方法
分别实现了传统跳转页面的方法，然后演进成了ajax方式
页面：

![index.png](.\png\index.png)

![add.png](.\png\add.png)

![update.png](.\png\update.png)

![结构.png](.\png\结构.png)


### 传统页面跳转(list.jsp index-normal.jsp)
### ajax方式渲染(index.jsp)
代码结构：


增加员工

1. 不合法数据的提交
2. 前台校验安全性低
3. 前台后台都要校验，后台用JSR303
    -  支持JSR303校验
    -  导入hibernate-validator
    -  bean加入patten注解
    -  BindingResult来获得错误信息
4. 数据库建立唯一索引