# ManagementSystem

### 传统页面跳转(list.jsp index-normal.jsp)
### ajax方式渲染(index.jsp)

增加员工

1. 不合法数据的提交
2. 前台校验安全性低
3. 前台后台都要校验，后台用JSR303
    -  支持JSR303校验
    -  导入hibernate-validator
    -  bean加入patten注解
    -  BindingResult来获得错误信息
4. 数据库建立唯一索引