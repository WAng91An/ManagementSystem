package com.wrq.manage.service;

import com.wrq.manage.bean.Employee;

import java.util.List;

/**
 * Created by 王乾 on 2018/1/9.
 */
public interface IEmployeeService {

    public List<Employee> getAll();

    public int addEmp(Employee employee);

    boolean checkUser(String empName);

    public Employee getEmp(Integer id);
}
