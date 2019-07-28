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
    public int deleteById(Integer id){
        return this.employmentMapper.deleteByPrimaryKey(id);
    }





    /**
     * 添加一个员工对象
     * @author Hu Ji mi
     * @param employment 为需要添加到数据库的员工对象封装体
     * @date 2019/7/24 20:42
     */
    @Override
    public int addEmployment(Employment employment){
        return this.employmentMapper.insertSelective(employment);
    }

    /**
     *
     * @author Hu Ji mi
     * @param
     * @date 2019/7/24 20:44
     */
    @Override
    public int updateEmpById(Employment employment){
        return this.employmentMapper.updateByPrimaryKeySelective(employment);
    }


    /**
     * 删除多个员工 , 根据前台返回的id集合, 通过in关键字
     * @author Hu Ji mi
     * @param ids 要删除的员工的id集合
     * @date 2019/7/27 22:07
     */
    @Override
    public int deleteEmpsByInId(List<Integer> ids){
        EmploymentExample employmentExample = new EmploymentExample();
        EmploymentExample.Criteria criteria = employmentExample.createCriteria();
        criteria.andEmpIdIn(ids);
        int effectLine = this.employmentMapper.deleteByExample(employmentExample);
        return effectLine;
    }

    /**
     * 根据指定的id, 查询对应的员工
     * @author Hu Ji mi
     * @param id:员工id
     * @date 2019/7/24 20:41
     */
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
        PageInfo<Employment> page = new PageInfo<Employment>(emps,5);
        return page;
    }

    /**
     * 验证员工名称是否重复
     * @author Hu Ji mi
     * @param empName 为员工名称
     * @date 2019/7/24 20:44
     */
    @Override
    public List<Employment> validateEmpNameOrNotRepeat(String empName){
        EmploymentExample employmentExample = new EmploymentExample();
        EmploymentExample.Criteria criteria = employmentExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        return this.employmentMapper.selectByExample(employmentExample);
    }
}
