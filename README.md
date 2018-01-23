# ManagementSystem
[![](https://img.shields.io/badge/JDK-1.8-brightgreen.svg)]()
[![](https://img.shields.io/hexpm/l/plug.svg)]()
[![](https://img.shields.io/badge/maven-v4.0.0-blue.svg)](http://maven.apache.org/)
[![](https://img.shields.io/badge/springframework-v4.0.0-orange.svg)](http://spring.io/projects)
[![](https://img.shields.io/badge/developer-WAng91An-red.svg)](https://github.com/WAng91An)
### SSM实现的增删改查的方法
分别实现了传统跳转页面的方法，然后演进成了ajax方式
页面：
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/add.png?raw=true)
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/index.png?raw=true)
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/update.png?raw=true)
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/delete.png?raw=true)
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/deleteAll.png?raw=true)
![](https://github.com/WAng91An/ManagementSystem/blob/master/png/结构.png?raw=true)
### 传统页面跳转(list.jsp index-normal.jsp)
### ajax方式渲染(index.jsp)
查询员工：
出现页面请求不合理解决方案(出现-1页)
```
    <!--引入分页插件-->
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--分页合理化-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
    
```


增加员工

1. 不合法数据的提交
2. 前台校验安全性低
3. 前台后台都要校验，后台用JSR303
    -  支持JSR303校验
    -  导入hibernate-validator
    -  bean加入patten注解
    -  BindingResult来获得错误信息
4. 数据库建立唯一索引

更新员工

1. 如果controller 的method = PUT
2. 前端的ajax可以这样，但是controller{empId}和pojo中的属性名对应
```
    $.ajax({
                url:"emp/"+$(this).attr("edit-id"),
                type:"POST",
                //controller里面用的是PUT方式接受的请求，所有加上后面的参数
                data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                success: function (result) {
                }
           })
           
     web.xml:
      <!-- 使用Rest风格的URI,将页面普通的post请求转化为指定的delete或者put请求 -->
       <filter>
         <filter-name>HiddenHttpMethodFilter</filter-name>
         <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
       </filter>
       <filter-mapping>
         <filter-name>HiddenHttpMethodFilter</filter-name>
         <url-pattern>/*</url-pattern>
       </filter-mapping>      
```
3. 如果ajax是这样的(直接使用put请求)报错
```
 $.ajax({
                url:"emp/"+$(this).attr("edit-id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success: function (result) {
                }
           })
   
```
- 问题：
  - 提交的数据只有empId字段，提交的email等都为空，绑定不上Employee
  - 更新语句的时候除了主建都为空，报错
- 原因:
  1. tomcat将请求体中的数据封装成一个map
  2. request.getParameter("email")传统取值
  3. springMvc 封装的pojo对象的时候把pojo每个属性的值，进行request.getParameter()
- 解决：
    - AJAX发送put请求的时候，请求体中的数据利用 request.getParameter()拿不到
    - tomcat一看是put就不会封装请求体中的数据为map，只有POST才会封装请求体
4. 如果想直接用PUT请求，怎么解决呢？ 
```
     <!-- ajax发送PUT请求的时候不报错 -->
      <filter>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
      </filter>
      <filter-mapping>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <url-pattern>/*</url-pattern>
      </filter-mapping>
      
```
- 上面过滤器的作用：把请求体重的数据解析包装成一个map，request被重新包装，request.getParameter()从自己的map取数据.
【注】
    更新要用updateByPrimaryKeySelective，否则传的name是空的报错！
    
- 删除员工
    单个和批量删除，通过传的参数不同来执行不同的数据库操作！
