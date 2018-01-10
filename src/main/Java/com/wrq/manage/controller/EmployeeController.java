package com.wrq.manage.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wrq.manage.bean.Employee;
import com.wrq.manage.common.Msg;
import com.wrq.manage.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 王乾 on 2018/1/9.
 */

/**
 * 处理增删改查
 */
@Controller
public class EmployeeController {

    @Autowired
    private IEmployeeService iEmployeeService;

    /**
     * ajax请求方式
     * 导入jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){

        //1.引入pageHelper

        //2.mybatis-config注册

        //3.查询之前只需要调用,传入页码，每页的大小

        PageHelper.startPage(pn,5);

        //4.startPage后面紧跟的查询是一个分页查询

        List<Employee> employeeList = iEmployeeService.getAll();

        //5.使用pageInfo包装查询后的结果，传入连续显示的页数

        PageInfo pageInfo = new PageInfo(employeeList,5);

        //6.把pageInfo交给页面

        //7.分装了详细的分页信息，包括查询出来的信息

        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 添加员工
     *1. 支持JSR303校验
     *2. 导入hibernate-validator
     *3. bean加入patten注解
     *4. BindingResult来获得错误信息
     * @param employee
     * @return
     */
    @RequestMapping("/emp")
    @ResponseBody
    public Msg addEmp(@Valid Employee employee, BindingResult bindingResult){
        if(bindingResult.hasErrors()) {
            //校验失败返回错误信息
            Map<String ,Object> map = new HashMap<String, Object>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for(FieldError error : fieldErrors){
                System.out.println("错误的字段名"+error.getField());
                System.out.println("错误的信息"+error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            int result = iEmployeeService.addEmp(employee);
            if(result != 0){
                return this.getEmpsWithJson(1);
            }else{
                return Msg.fail().add("errMsg","新增信息失败");
            }
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //合法性
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是2-5位中文6-16位数字或者字母");
        }
        boolean b = iEmployeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名已经存在");
        }
    }

    /**
     * 传统方式
     * 查询员工数据，分页
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //1.引入pageHelper

        //2.mybatis-config注册

        //3.查询之前只需要调用,传入页码，每页的大小

        PageHelper.startPage(pn,5);

        //4.startPage后面紧跟的查询是一个分页查询

        List<Employee> employeeList = iEmployeeService.getAll();

        //5.使用pageInfo包装查询后的结果，传入连续显示的页数

        PageInfo pageInfo = new PageInfo(employeeList,5);

        //6.把pageInfo交给页面

        //7.分装了详细的分页信息，包括查询出来的信息

        model.addAttribute("pageInfo",pageInfo);

        return "list";
    }
}
