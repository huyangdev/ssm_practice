package top.gn.ssm.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import top.gn.ssm.bean.Employment;
import top.gn.ssm.common.ConstantField;
import top.gn.ssm.dto.BaseResult;
import top.gn.ssm.service.EmploymentService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

/**
 * Created by Administrator on 10/07/2019.
 * 处理employment的相关请求
 */
@RestController
public class EmploymentHandler {

    @Autowired
    private EmploymentService employmentServiceImpl;


    public EmploymentService getEmploymentServiceImpl() {
        return employmentServiceImpl;
    }

    public void setEmploymentServiceImpl(EmploymentService employmentServiceImpl) {
        this.employmentServiceImpl = employmentServiceImpl;
    }

/* =================================== delete start ========================================== */

    /**
     *
     * @author Hu Ji mi
     * @param ids : @RequestBody 表明该参数由 : HttpMessageConverter 进行解析然后封装
     * @return
     * @date 2019/7/28 13:02
     */
    @RequestMapping(value = "/delete_emps",method = RequestMethod.DELETE)
    public BaseResult deleteEmploymentsByIds(@RequestBody List<Integer> ids){
        System.out.println("员工ids : "+ids);

        if( (ids == null) || (ids.size() == 0) ){ return BaseResult.fail("参数为空或参数错误");  }

        int effectLine = this.employmentServiceImpl.deleteEmpsByInId(ids);

        if(effectLine >= 1) {
            return BaseResult.success("删除"+ effectLine +"条数据成功");
        }else if(effectLine == 0) {
            return BaseResult.fail("删除0条数据");
        }else{
            return BaseResult.fail("删除数据失败");
        }
    }


    @RequestMapping(value = "/delete_emp/{empId}",method = RequestMethod.DELETE)
    public BaseResult deleteEmploymentById(@PathVariable("empId") Integer empId){
        if(empId == null || empId <= 0){
            return BaseResult.fail("参数错误: 为空 或者 小于0");
        }
        int i = this.employmentServiceImpl.deleteById(empId);
        System.out.println(i);
        System.out.println(empId);
        if(i > 0){
            return BaseResult.success("删除成功");
        }else{
            return BaseResult.fail("删除失败");
        }
    }

/* =================================== delete end ========================================== */



/* =================================== update start ========================================== */

    @RequestMapping(value = "/update",method = RequestMethod.PUT)
    public BaseResult updateEmpById(@Valid Employment employment, BindingResult result, HttpServletRequest q){
        System.out.println(employment);
        System.out.println(q.getParameter("empId"));

        BaseResult baseResult = null;
        if(result.hasErrors()){
            // 拿到错误信息, 封装到BaseResult当中, 返回给前台显示
            List<FieldError> errors = result.getFieldErrors();
            baseResult = new BaseResult("字段校验失败",false,-2);
            for (FieldError f :errors) {
                System.out.println("错误字段: "+f.getField()+" 错误消息:"+ f.getDefaultMessage());
                baseResult.addShowField(f.getField() , f.getDefaultMessage());
            }
        }else{
            // 更新员工
            int effectLine = this.employmentServiceImpl.updateEmpById(employment);
            // 根据影响的行数判断是否修改成功
            if(effectLine != 0){ // 成功
                baseResult = BaseResult.success("更新成功");
            }else{ // 失败
                baseResult = BaseResult.fail();
            }
        }
        return baseResult;
    }

/* =================================== upodate end ========================================== */



/* =================================== insert start ========================================== */

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public BaseResult addOneEmp(@Valid Employment employment, BindingResult bindingResult){
        BaseResult baseResult = null;
        if(bindingResult.hasErrors()){
            // 拿到错误信息, 封装到BaseResult当中, 返回给前台显示
            List<FieldError> errors = bindingResult.getFieldErrors();
            baseResult = new BaseResult("字段校验失败",false,-2);
            for (FieldError f :errors) {
                System.out.println("错误字段: "+f.getField()+" 错误消息:"+ f.getDefaultMessage());
                baseResult.addShowField(f.getField() , f.getDefaultMessage());
            }
            return baseResult;
        }else{
            int i = this.employmentServiceImpl.addEmployment(employment);
            System.out.println("添加员工: "+i);
            if(i != 0){
                baseResult = new BaseResult("添加成功",true,200);
            }else {
                baseResult = new BaseResult("添加失败",false,-1);
            }
            return baseResult;
        }
    }
/* =================================== insert end ========================================== */



/* =================================== select start ========================================== */

    @RequestMapping(value = "/redisplayEmp/{empId}",method = RequestMethod.GET)
    public BaseResult getEmploymentById(@PathVariable("empId") Integer empId){
        // 参数判断是否为空
        if(empId==null || "".equals(empId)) return new BaseResult("处理失败, 参数不能为空!!" , false , -1);

        // 参数判断 是否为数字 true : 是数字, false: 不是纯数字
        if(!empId.toString().matches(ConstantField.RegExpOrNotNumber0to10)){
            return new BaseResult("处理失败, 参数不合法!!" , false , -1);
        }

        Employment emp = this.employmentServiceImpl.getEmploymentById(empId);
        BaseResult baseResult = null;
        if(emp == null){
            baseResult = BaseResult.fail();
        }else{
            baseResult = BaseResult.success().addShowField("emp",emp);
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

    @RequestMapping("/empNameRepeat")
    public BaseResult validateEmpName(@RequestParam("empName") String empName){
        List<Employment> employments = this.employmentServiceImpl
                .validateEmpNameOrNotRepeat(empName);
        System.out.println(empName);
        BaseResult baseResult = null;
        if(employments.size() == 0){
            baseResult = new BaseResult("员工名称无重复",true,200);
        }else {
            baseResult = new BaseResult("员工名称重复",false,-1);
        }
        return baseResult;
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

/* =================================== select end ========================================== */




}
