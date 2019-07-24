package test.controller;

import com.github.pagehelper.PageInfo;
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
import top.gn.ssm.bean.Employment;
import top.gn.ssm.controller.EmploymentHandler;
import top.gn.ssm.dto.BaseResult;

import java.util.List;

/**
 * Created by Administrator on 11/07/2019.
 */
@WebAppConfiguration /* 用于需要声明使用ioc容器集成test时使用 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "classpath:spring/applicationContext.xml",
        "classpath:spring/spring-mvc.xml"})
public class EmploymentControllerTest {
    // mock 一个虚假的mvc
    MockMvc mock;

    @Autowired
    private EmploymentHandler employmentHandler;

    /*
     WebApplicationContext : 是spring-mvc的ioc容器
     @Autowired只能自动注入ioc容器当中配置的bean,
     对于ioc容器本身要注入需要@WebAppConfiguration */
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMockMvc(){
         this.mock = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void pageTest() throws Exception {
        /* MockMvcRequestBuilders 就可以发送get,post,delete,put等请求
            在通过param() 方法传入参数
            mock.perform(): 执行一个请求并返回结果(andReturn())
         */
        MvcResult result = mock.perform(MockMvcRequestBuilders
                .get("/emps")
                .param("pn", "1")).andReturn();
        PageInfo<Employment> page = (PageInfo)result.getRequest().getAttribute("pageInfo");
        // 获取pageInfo的信息
        System.out.println("当前页码" + page.getPageNum());
        System.out.println("总页码: " + page.getPages());
        System.out.println("总记录数: " + page.getTotal());
        System.out.println(page.isIsFirstPage());
        System.out.println(page.isHasPreviousPage());
        System.out.print("页码导航: ");
        int[] navigatepageNums = page.getNavigatepageNums();
        for (int nowNum: navigatepageNums) {
            System.out.print(nowNum+ " ");
        }
        System.out.println(); // 换行
        // 获取数据信息
        List<Employment> datas = page.getList();
        for (Employment e: datas) {
            System.out.print("姓名: "+ e.getEmpName());
            System.out.println("----部门: " + e.getDepartment().getDeptName());
        }
    }


    @Test
    public void validateEmpNameOrNotRepeatTest(){
        BaseResult baseResult = this.employmentHandler.validateEmpName("胡杨");
        System.out.println(baseResult.getMeg());
    }

}
