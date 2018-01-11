package com.wrq.manage.service;

import com.wrq.manage.bean.Employee;

import java.util.List;

/**
 * Created by 王乾 on 2018/1/9.
 */
public interface IEmployeeService {

     List<Employee> getAll();

     int addEmp(Employee employee);

    boolean checkUser(String empName);

     Employee getEmp(Integer id);

     void updateEmp(Employee employee);

     void deleteEmp(Integer id);

     void deleteBatch(List<Integer> ids);
}
