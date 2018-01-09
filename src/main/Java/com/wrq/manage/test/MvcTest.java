package com.wrq.manage.test;

import com.github.pagehelper.PageInfo;
import com.wrq.manage.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试请求的正确性
 * Spring4 测试的时候，需要servlet3.0的支持
 * Created by 王乾 on 2018/1/9.
 *
 */
/* 用的是spring的单元测试 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcher-servlet.xml"})
public class MvcTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public  void initMockMvc(){
        mockMvc =  MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值

        MvcResult result =  mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();

        //请求成功后，请求中会有pageInfo，我们可以取出pageInfo进行校验

        MockHttpServletRequest request = result.getRequest();

        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");

        System.out.println("当前页码:" + pi.getPageNum());
        System.out.println("总页码:" + pi.getPages());
        System.out.println("总记录数:" + pi.getTotal());
        System.out.println("连续显示的页码:");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums){
            System.out.print(" " + i);
        }

        //获取员工数据
        List<Employee> list = pi.getList();
        for (Employee employee : list){
            System.out.println("ID" + employee.getEmpId()+"name" + employee.getEmpName());
        }
    }
}
