package com.wrq.manage.service.Impl;

/**
 * Created by 王乾 on 2018/1/9.
 */

import com.wrq.manage.bean.Department;
import com.wrq.manage.dao.DepartmentMapper;
import com.wrq.manage.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("iDepartmentService")
public class DepartmentServiceImpl implements IDepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 所有部门信息
     * @return
     */
    public List<Department> getDepts(){
        List<Department>  list = departmentMapper.selectByExample(null);
        return list;
    }
}
