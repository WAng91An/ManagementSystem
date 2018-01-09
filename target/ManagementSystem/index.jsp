<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    pageContext.setAttribute("path", path);
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
    <base href="basePath">
    <meta charset="utf-8">
    <title>员工信息</title>
    <script type="text/javascript" src="static/js/jquery/jquery.min.js"></script>
    <!--引入样式-->
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap/js/bootstrap.min.js"></script>
    <style>
        .pageMessage{
            width: 50%;
            height: 70px;
            line-height: 70px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>
                信息管理
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary pull-right">新赠</button>
            <button class="btn btn-danger pull-right">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>


                </tbody>

            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 pageMessage">
            当前第 页，总共 页，共 条记录
        </div>
        <div class="col-md-6">

        </div>
    </div>
</div>
<script type="text/javascript">
//1.页面加载完成后直接去发ajax请求
$(function(){
    $.ajax({
        url:"emps",
        data:"pn=1",
        type:"GET",
        success:function(result){
            //1.解析显示员工信息
            build_emps_table(result);
            //2.解析显示分页信息
        }
    });

    function build_emps_table(result){
        var emps = result.data.pageInfo.list;
        $.each(emps,function(index,item){
            var empIdTd    = $("<td></td>").append(item.empId);
            var empNameTd  = $("<td></td>").append(item.empName);
            var genderTd   = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd    = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-xs")
                         .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var delBtn  = $("<button></button>").addClass("btn btn-danger btn-xs")
                         .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnTd   = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
        });
    }

    function build_page_nav(result){

    }
})
</script>
</body>
</html>

