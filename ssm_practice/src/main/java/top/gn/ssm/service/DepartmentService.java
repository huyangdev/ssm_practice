package top.gn.ssm.service;

import top.gn.ssm.bean.Department;

import java.util.List;

/**
 * 定义部门表的服务标准
 */
public interface DepartmentService {

    List<Department> getAll();
}
