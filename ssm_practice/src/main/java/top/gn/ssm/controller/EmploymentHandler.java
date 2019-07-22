package top.gn.ssm.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.dto.BaseResult;
import top.gn.ssm.service.EmploymentService;

/**
 * Created by Administrator on 10/07/2019.
 * 处理employment的相关请求
 */
@RestController
public class EmploymentHandler {

    @Autowired
    private EmploymentService employmentServiceImpl;

    public BaseResult getEmpsAjax(){
        return null;
    }


    public EmploymentService getEmploymentServiceImpl() {
        return employmentServiceImpl;
    }

    public void setEmploymentServiceImpl(EmploymentService employmentServiceImpl) {
        this.employmentServiceImpl = employmentServiceImpl;
    }


    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public BaseResult addOneEmp(Employment employment){
        int i = this.employmentServiceImpl.addEmployment(employment);
        BaseResult baseResult = null;
        if(i != 0){
            baseResult = new BaseResult("添加成功",true,200);
        }else {
            baseResult = new BaseResult("添加失败",false,-1);
        }
        return baseResult;
    }

    @RequestMapping("/emps")
    public BaseResult getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNum) {
        PageInfo<Employment> page = null;
        // 查询出分页后的employment信息
        if (pageNum <= 0) {
            page = employmentServiceImpl.getEmploymentPage(1);
        } else {
            page = employmentServiceImpl.getEmploymentPage(pageNum);
        }
        return BaseResult.success().addShowField("pageInfo", page);
    }


    //老版本
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNum
            , Model model){
        PageInfo<Employment> page = null;
        // 查询出分页后的employment信息
        if(pageNum<=0){
            page = employmentServiceImpl.getEmploymentPage(1);
        }else{
            page = employmentServiceImpl.getEmploymentPage(pageNum);
        }
        // model自动添加到request域当中
        model.addAttribute("pageInfo",page);
        return "list";
        //        //
//        Map<String,Object> basemap = new HashMap<String,Object>();
//        basemap.put("datas",page.getList());  // 数据
//        basemap.put("size",page.getSize()); // 每页数量
//        basemap.put("pages" ,page.getPages()); // 总页数
//        basemap.put("total",page.getTotal()); // 总记录数
//
//        basemap.put("hasPreviousPage",page.isHasPreviousPage()); // 是否有上一页
//        basemap.put("hasNextPage",page.isHasNextPage()); // 是否有下一页
//
//        basemap.put("prePage" , page.getPrePage()); // 上一页数
//        basemap.put("nextPage",page.getNextPage()); // 下一页数
// 数据的封装
        //BaseResult baseResult = new BaseResult("200 ok",basemap);
    }






}
