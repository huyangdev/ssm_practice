package top.gn.ssm.dto;

import java.io.Serializable;

/**
 * 用于封装Department当中需要向前台显示的字段
 */
public class DepartmentDTO implements Serializable {

    private String deptName;

    public DepartmentDTO() {
    }

    public DepartmentDTO(String deptName) {
        this.deptName = deptName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
