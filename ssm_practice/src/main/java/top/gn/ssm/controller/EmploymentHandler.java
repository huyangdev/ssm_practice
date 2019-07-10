package top.gn.ssm.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.service.EmploymentService;

/**
 * Created by Administrator on 10/07/2019.
 * 处理employment的相关请求
 */
@Controller
@RequestMapping("/employment")
public class EmploymentHandler {

    @Autowired
    private EmploymentService employmentServiceImpl;

    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNum
            , Model model){
        // 查询出分页后的employment信息
        PageInfo<Employment> page = employmentServiceImpl.getEmploymentPage(pageNum);
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
        model.addAttribute("pageInfo",page);

        return "list";
    }






}
