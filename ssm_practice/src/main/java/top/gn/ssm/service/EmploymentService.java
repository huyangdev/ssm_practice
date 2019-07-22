package top.gn.ssm.service;

import com.github.pagehelper.PageInfo;
import top.gn.ssm.bean.Employment;

/**
 * employment的service层标准
 * @author Hu Ji mi
 * @date 10/07/2019 20:34
 */
public interface EmploymentService {

    PageInfo<Employment> getEmploymentPage(Integer pageNum);

    int addEmployment(Employment employment);
}
