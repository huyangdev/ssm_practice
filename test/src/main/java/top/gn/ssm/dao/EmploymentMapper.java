package top.gn.ssm.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.bean.EmploymentExample;

public interface EmploymentMapper {
    long countByExample(EmploymentExample example);

    int deleteByExample(EmploymentExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employment record);

    int insertSelective(Employment record);

    List<Employment> selectByExample(EmploymentExample example);

    Employment selectByPrimaryKey(Integer empId);

    int updateByExampleSelective(@Param("record") Employment record, @Param("example") EmploymentExample example);

    int updateByExample(@Param("record") Employment record, @Param("example") EmploymentExample example);

    int updateByPrimaryKeySelective(Employment record);

    int updateByPrimaryKey(Employment record);
}