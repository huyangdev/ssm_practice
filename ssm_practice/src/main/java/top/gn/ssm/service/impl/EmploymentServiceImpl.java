package top.gn.ssm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.bean.EmploymentExample;
import top.gn.ssm.dao.EmploymentMapper;
import top.gn.ssm.service.EmploymentService;

import java.util.List;

/**
 * employment服务层具体实现
 * @author Hu Ji mi
 * @date 10/07/2019 20:33
 */
@Service
public class EmploymentServiceImpl implements EmploymentService{

    @Autowired
    private EmploymentMapper employmentMapper;

    @Override
    public Employment getEmploymentById(Integer id){
        return this.employmentMapper.selectByPrimaryKeyWithDept(id);
    }

    /**
     * 返回的pageInfo可以进行页码的连续显示
     * @param pageNum
     * @return
     */
    @Override
    public PageInfo<Employment> getEmploymentPage(Integer pageNum) {
        PageHelper.startPage(pageNum,5);
        List<Employment> emps = employmentMapper.selectByExampleWithDept(null);
//       navigatePages : 用于分页底部的导航栏的显示
        PageInfo<Employment> page = new PageInfo<Employment>(emps,5);
        return page;
    }

    @Override
    public int addEmployment(Employment employment){
        return this.employmentMapper.insertSelective(employment);
    }

    @Override
    public List<Employment> validateEmpNameOrNotRepeat(String empName){
        EmploymentExample employmentExample = new EmploymentExample();
        EmploymentExample.Criteria criteria = employmentExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        return this.employmentMapper.selectByExample(employmentExample);
    }
}
