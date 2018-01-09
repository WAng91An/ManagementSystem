package com.wrq.manage.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wrq.manage.bean.Employee;
import com.wrq.manage.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

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
     * 查询员工数据，分页
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //1.引入pageHelper
        //2.mybatis-config注册
        //3.查询之前只需要调用,传入页码，每页的大小
        PageHelper.startPage(pn,5);
        //4.startPage后面紧跟的查询是一个分页查询
        List<Employee> employeeList = iEmployeeService.getAll();
        //5.使用pageInfo包装查询后的结果
        PageInfo pageInfo = new PageInfo(employeeList);
        return "list";
    }
}
