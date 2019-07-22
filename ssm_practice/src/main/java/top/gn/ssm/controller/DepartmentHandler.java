package top.gn.ssm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import top.gn.ssm.dto.BaseResult;
import top.gn.ssm.service.DepartmentService;

/**
 * 处理与部门有关的controller
 */
@RestController
public class DepartmentHandler {

    @Autowired
    private DepartmentService departmentServiceImpl;

    public DepartmentHandler() {
    }

    @RequestMapping("/depts")
    public BaseResult getDepartmentAll(){
        return BaseResult.success().addShowField("departmentList",this.departmentServiceImpl.getAll());
    }


}