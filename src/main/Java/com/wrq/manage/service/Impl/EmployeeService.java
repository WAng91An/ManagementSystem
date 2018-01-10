package com.wrq.manage.service.Impl;

import com.wrq.manage.bean.Employee;
import com.wrq.manage.bean.EmployeeExample;
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

    /**
     * 查询所有的员工信息
     * @return
     */
    public List<Employee> getAll(){
        return  employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 根据id查员工信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id){

        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 员工添加
     * @param employee
     * @return result
     */
    public int addEmp(Employee employee){
        int result = employeeMapper.insertSelective(employee);
        return  result;
    }

    /**
     * 员工名是否可用
     * @param empName
     * @return true,代表当前姓名可用，false不可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

}
