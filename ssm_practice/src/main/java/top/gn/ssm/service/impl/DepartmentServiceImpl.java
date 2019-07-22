package top.gn.ssm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.gn.ssm.bean.Department;
import top.gn.ssm.dao.DepartmentMapper;
import top.gn.ssm.service.DepartmentService;

import java.util.List;

/**
 * 部门表服务的标准具体实现
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {


    @Autowired
    private DepartmentMapper departmentMapper ;

    @Override
    public List<Department> getAll(){
        return this.departmentMapper.selectByExample(null);
    }
}
