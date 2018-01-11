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
<!-- 修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓 名:</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" name="empName" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮 箱:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="请输入邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">性 别:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">部门名:</label>
                        <div class="col-sm-3">
                            <!-- 部门动态添加 -->
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 增加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓 名:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="输入姓名">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">邮 箱:</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="请输入邮箱">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">性 别:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">部门名:</label>
                        <div class="col-sm-3">
                            <!-- 部门动态添加 -->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!--信息展示-->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>
                信息管理
            </h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-sm btn-info pull-right" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-sm btn-danger pull-right" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
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
        <!--分页详情-->
        <div class="col-md-6 pageMessage" id="page_info_area">
        </div>
        <!--分页组件-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentPage;
    //1.页面加载完成后直接去发ajax请求
    $(function(pn){
        to_page(1);
    });

    //检查当前是不是全选装填
    function  checkAllOrNot(){
        var flag = ($(".check_item:checked").length == $(".check_item").length);
        $("#check_all").prop("checked",flag);
    }
    //跳到指定页面
    function to_page(pn){
        $.ajax({
            url:"emps",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                //1.解析显示员工信息
                build_emps_table(result);
                //2. 解析显示分页信息
                build_page_info(result);
                //3. 解析显示分页条
                build_page_nav(result);
                //4. 查看当前有没有选中的按钮
                checkAllOrNot();
            }
        });
    }
    //解析表
    function build_emps_table(result){
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.data.pageInfo.list;
        $.each(emps,function(index,item){
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>")
            var empIdTd    = $("<td></td>").append(item.empId);
            var empNameTd  = $("<td></td>").append(item.empName);
            var genderTd   = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd    = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-info btn-xs edit_btn")
                         .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" ");
            editBtn.attr("edit-id",item.empId);
            var delBtn  = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
                         .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" ");
            delBtn.attr("del-id",item.empId);
            var btnTd   = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+
                result.data.pageInfo.pageNum+"页,总共"+
                result.data.pageInfo.pages+"页，总共"+
                result.data.pageInfo.total+"条记录");
        totalRecord = result.data.pageInfo.total;
        currentPage = result.data.pageInfo.pageNum;
    }
    //解析显示分页条,点击事件
    function build_page_nav(result){
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi    = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(!result.data.pageInfo.hasPreviousPage){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //首页上一页添加事件
            firstPageLi.click(function(){
                to_page(1);
            });
            prePageLi.click(function(){
                to_page(result.data.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi    = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi  = $("<li></li>").append($("<a></a>").append("尾页"));
        if(!result.data.pageInfo.hasNextPage){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            //尾页下一页添加事件
            nextPageLi.click(function () {
                to_page(result.data.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.data.pageInfo.pages);
            });
        }


        // 首页前一页
        ul.append(firstPageLi).append(prePageLi);
        // 遍历得到页码
        $.each(result.data.pageInfo.navigatepageNums,function(index,item){
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.data.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            //点击重新请求
            numLi.click(function(){
                to_page(item);
            });
            ul.append(numLi);
        });
        // 下一页末页
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //重置表单
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }
    //点击新增按钮调用模态框
    $("#emp_add_modal_btn").click(function(){
        //表单重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    //查出部门信息
    function getDepts(ele){
        $(ele).empty();
        $.ajax({
            url:"depts",
            type:"GET",
            success:function(result) {
                $.each(result.data.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        })
    }
    //校验表单数据
    function validate_add_form(){
        var empName = $("#empName_add_input").val();
        var regName =  /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            show_validate_msg("#empName_add_input","error","请输入2-5中文或者6-16的英文");
            return false;
        }else {
            show_validate_msg("#empName_add_input","success","");
        }
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input","success","");
        }
        return true;
    }
    //显示检验的信息
    function show_validate_msg(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else  if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
    //员工姓名异步验证
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.data.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        })
    });
    //点击保存员工按钮
    $("#emp_save_btn").click(function(){
        //1. 模态框表单数据提交给服务器进行保存
        //2. 数据格式正确性
        if(!validate_add_form()){
            return false;
        }
        //3. 用户存在,ajax-va
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //4. ajax请求保存
        $.ajax({
            url:"emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success: function (result) {
                if(result.code == 100){
                    //保存成功
                    //1. 关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来最后一页
                    to_page(result.data.pageInfo.pages);
                }else {
                    //显示失败信息
                    if(undefined != result.data.errorFields.email){
                         //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.data.errorFields.email);
                    }
                    if(undefined != result.data.errorFields.empName){
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input","error",result.data.errorFields.empName);
                    }
                }

            }
        });
        to_page(totalRecord);
    });
    //点击删除按钮
    $(document).on("click",".delete_btn",function(){
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId   = $(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗？")){
            //确认后ajax
            $.ajax({
                url:"emp/"+empId,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
    //点击编辑
    $(document).on("click",".edit_btn",function(){
        //信息回填
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));
        //员工id传递给模态框更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    })
    //查询员工
    function getEmp(id){
        $.ajax({
            url:"emp/"+id,
            type:"GET",
            success:function(result){
                var empDate = result.data.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                //放在[]的选中
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        })
    }
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }
        //发送ajax请求，更新数据
        $.ajax({
            url:"emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success: function () {
                $("#empUpdateModal").modal('hide');
                to_page(currentPage);
            }
        })
    });
    //全选全不选
    $("#check_all").click(function(){
        //attr获取自定义属性
        //prop修改和读取dom原生的属性
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //每个checkitem单击事件
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        checkAllOrNot();
    });
    //批量删除
    $("#emp_delete_all_btn").click(function(){
        if($(".check_item:checked").length <= 0){
            alert("请勾选需要删除的人员信息!");
        }else {
            var empNames = "";
            var del_ids = "";
            $.each($(".check_item:checked"),function(){
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                del_ids  +=  $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            //最后的逗号,"-"处理
            empNames.substring(0,empNames.length-1);
            del_ids.substring(0,del_ids.length-1);
            if(confirm("确认删除["+empNames+"]吗?")){
                $.ajax({
                    url:"emp/"+del_ids,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
        }
    });
</script>
</body>
</html>

