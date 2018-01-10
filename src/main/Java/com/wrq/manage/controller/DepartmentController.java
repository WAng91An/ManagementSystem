package com.wrq.manage.controller;

import com.wrq.manage.bean.Department;
import com.wrq.manage.common.Msg;
import com.wrq.manage.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by 王乾 on 2018/1/9.
 */
@Controller
public class DepartmentController {

    @Autowired
    private IDepartmentService iDepartmentService;

    /**
     * 返回部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = iDepartmentService.getDepts();
        return Msg.success().add("depts",list);
    }

}
