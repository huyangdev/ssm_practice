package test.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import top.gn.ssm.bean.Department;
import top.gn.ssm.controller.DepartmentHandler;
import top.gn.ssm.dto.BaseResult;

import java.util.List;

/**
 * 测试DepartmentHandler
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "classpath:spring/applicationContext.xml",
        "classpath:spring/spring-mvc.xml"})
public class DepartmentHandlerTest {

    @Autowired
    private DepartmentHandler departmentHandler;

    @Autowired
    WebApplicationContext context;

    MockMvc mockMvc;

    @Test
    public void getDeptAllTest(){
        BaseResult result = departmentHandler.getDepartmentAll();
        for (Department dept:(List<Department>)result.getData().get("departmentList")) {
            System.out.println(dept.getDeptName());
        }
    }

    // 初始化mock
    @Before
    public void initMock(){
        this.mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void getDeptAllMockTest() throws Exception {
        MvcResult mvcResult = this.mockMvc.perform(MockMvcRequestBuilders.get("/depts")).andReturn();
        System.out.println(mvcResult);
    }
}
