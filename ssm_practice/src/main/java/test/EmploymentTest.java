package test;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.dao.EmploymentMapper;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class EmploymentTest {

    @Autowired
    private EmploymentMapper employmentMapper;

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    /* 测试员工的单个插入

    public Employment(Integer empId, String empName, String gender, String emall,
                      Integer deptId, Department department) {
     */
    @Test
    public void insertTest(){
        int result = this.employmentMapper.insertSelective(new Employment(null, "小米", "M",
                "huyang@like.com", 1, null));
        System.out.println(result);
    }

    /* 测试员工的批量插入 */
    @Test
    public void batchInsertTest(){
        // 获取到能够执行批量操作的mapper
        EmploymentMapper mapper = this.sqlSessionTemplate.getMapper(EmploymentMapper.class);

        for(int i=1; i<10; i++) {
            // 利用uuid随机设置emplName
            String uid = UUID.randomUUID().toString().substring(2, 7) + i;
            mapper.insertSelective(new Employment(null, uid, "M",
                    uid + "@huyang.com", 4, null));
        }
    }


}
