package test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import top.gn.ssm.bean.Department;
import top.gn.ssm.bean.DepartmentExample;
import top.gn.ssm.dao.DepartmentMapper;
import top.gn.ssm.dao.EmploymentMapper;

import java.util.ArrayList;
import java.util.List;

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
        @Autowired
        private DepartmentMapper departmentMapper;
        @Test
        public void insertAndDeleteTest(){
            // 测试部门添加操作
            this.departmentMapper.insertSelective(new Department("开发部"));
            this.departmentMapper.insertSelective(new Department("销售部"));
            this.departmentMapper.insertSelective(new Department("测试部"));
            // 测试部门删除
            ArrayList<Integer> ids = new ArrayList<>(); // 添加要删除的id
            ids.add(5); ids.add(6); ids.add(7);
            DepartmentExample departmentExample = new DepartmentExample();
            DepartmentExample.Criteria criteria = departmentExample.createCriteria();
            criteria.andDeptIdIn(ids);
            int i = this.departmentMapper.deleteByExample(departmentExample);
            System.out.println(i);
        }
        @Test
        public void updateAndSelectTest(){
            // 测试修改
            this.departmentMapper.updateByPrimaryKey(new Department(1,"策划部"));
            // 测试查询
            List<Department> departments = this.departmentMapper.selectByExample(null);
            for (Department d: departments) {
                System.out.println(d.getDeptId() + ", " + d.getDeptName());
            }
        }
}