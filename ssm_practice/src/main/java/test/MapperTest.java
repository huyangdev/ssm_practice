package test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import top.gn.ssm.dao.EmploymentMapper;

/**
 * 使用Spring-Test进行测试
 * 1. 导入spring-test依赖
 * 2. @ContextConfiguration(locations={})
 *      设置applicationContext.xml文件位置
 * 3. 使用@RunWith(class)
 *     设置spring对Junit的支持类, 运行测试使用的就是该类
 * 4. 直接可以用 @Autowired 进行依赖注入
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MapperTest {

    @Autowired
    private EmploymentMapper employmentMapper;

    @Test
    public void testCRUD(){
        System.out.println(employmentMapper);
    }

}