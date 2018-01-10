package com.wrq.manage.service.Impl;

import com.wrq.manage.bean.Employee;
import com.wrq.manage.dao.EmployeeMapper;
import com.wrq.manage.service.IEmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 王乾 on 2018/1/9.
 */
@Service("iEmployeeService")
public class EmployeeService implements IEmployeeService {
        @Autowired
        private EmployeeMapper employeeMapper;

        public List<Employee> getAll(){
            return  employeeMapper.selectByExampleWithDept(null);
        }

        public int addEmp(Employee employee){
            int result = employeeMapper.insertSelective(employee);
            return  result;
        }

}
