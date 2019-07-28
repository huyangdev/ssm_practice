<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% pageContext.setAttribute("basePath", request.getContextPath()); %>

<head>
    <title>所有雇员</title>
    <link href="${basePath}/static/bootstrap337/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        .page_title {
        }

        .table-hover tr:hover {
            background: #eee !important;
        }

        .global_operate {
            margin-bottom: 26px;
        }

        .table .btn {
            margin-left: 5px;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
         id="create-modal-edit">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工编辑</h4>
                </div>
                <div class="modal-body" id="modal-box-edit">
                    <form id="emp-form-edit">
                        <input type="hidden" name="empId" />
                        <div class="form-group">
                            <label for="emp_name">Name</label>
                            <p class="form-control-static"></p>
                            <span class="help-block"></span>
                        </div>
                        <div class="from-groug">
                            <label for="emp_email">Email</label>
                            <input id="emp_email-edit" class="form-control" name="emall" type="email" placeholder=" 邮箱">
                            <span class="help-block"></span>
                        </div>
                        <div class="checkbox">
                            <input type="radio" name="gender" value="M"/> 男
                            <label></label>
                            <input type="radio" name="gender" value="W" checked/> 女
                        </div>

                        <div class="from-select col-sm-2 select_department_box">
                            <label class="control-label">部门</label>
                            <select class="form-control" name="deptId">
                                <!-- 动态添加 部门选项 -->
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="submit-edit">修改</button>
                </div>
            </div>
        </div>
    </div>
    <h1 class="page_title">SSM项目小练习</h1>
    <div class="global_operate">
        <button type="button" class="btn btn-info btn-sm btn-primary" data-target="#myModal" id="btn-modal">
            新增
        </button>
        <button type="button" class="btn btn-danger btn-sm" id="del-all">
            <span class="glyphicon glyphicon-trash"></span>
            删除
        </button>

        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             id="create-modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body" id="modal-box">
                        <form id="emp-form">
                            <div class="form-group">
                                <label for="emp_name">Name</label>
                                <input class="form-control" name="empName" type="text" placeholder=" 名称" id="emp_name">
                                <span class="help-block"></span>
                            </div>
                            <div class="from-groug">
                                <label for="emp_email">Email</label>
                                <input id="emp_email" class="form-control" name="emall" type="email" placeholder=" 邮箱">
                                <span class="help-block"></span>
                            </div>
                            <div class="checkbox">
                                <input type="radio" name="gender" value="M"/> 男
                                <label></label>
                                <input type="radio" name="gender" value="W" checked/> 女
                            </div>

                            <div class="from-select col-sm-2 select_department_box">
                                <label class="control-label">部门</label>
                                <select class="form-control" name="deptId">
                                    <!-- 动态添加 部门选项 -->
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="submit">添加</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th><input type="checkbox" id="check-all" /> </th>
            <th>id</th>
            <th>name</th>
            <th>email</th>
            <th>gender</th>
            <th>depaName</th>
            <th>other choose</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>

    <div class="row">
        <!-- 页码,记录数, 等分页信息 -->
        <div id="page_num_info" class="col-md-7">
            <span class="pageInfo_pageNum_and_pages">
            当前页码/总页数:
        <span></span>/
        <span></span>
        </span>
            <span class="pageInfo_total">---共有<span></span>条数据</span>
        </div>
        <!-- 页码导航按钮
            col-md-5: bootstrap格栅系统中的列(占用5个列)
            col-md-offset-8: 偏移量8
        -->
        <div class="col-md-5 col-md-offset-8">
            <nav aria-label="Page navigation">
                <ul id="navPageNums" class="pagination">
                    <li><a href="javascript:void(0)">首页</a></li>
                    <li>
                        <a href="javascript:void(0)">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <!-- 导航栏 -->
                    <li class="my_nav">
                        <a href="javascript:void(0)">1</a>
                    </li>
                    <li class="my_nav">
                        <a href="javascript:void(0)">2</a>
                    </li>
                    <li class="my_nav">
                        <a href="javascript:void(0)">3</a>
                    </li>
                    <li class="my_nav">
                        <a href="javascript:void(0)">4</a>
                    </li>
                    <li class="my_nav">
                        <a href="javascript:void(0)">5</a>
                    </li>

                    <!-- 下一页和末页的的判断 -->
                    <li>
                        <a href="javascript:void(0)" aria-label="Previous">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li><a href="javascript:void(0)">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>


</div>
</body>

<!-- 引入bootstrap和Jquery -->
<script type="text/javascript" src="${basePath}/static/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${basePath}/static/bootstrap337/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${basePath}/static/js/emp_edit.js"></script>
<script type="text/javascript" src="${basePath}/static/js/ajaxCodes.js"></script>
<script type="text/javascript">
    var pageTotalSize = 0,
        pageNum = 0;

    $(function () {
        sendEmpsAjax(1);
    });

/* 员工删除 start */

/* 批量删除 */
// 全选, 全不选
var del_data = {
  flag : 0,
  _ps:[]
};
$("#check-all").click(function(){
    if((del_data.flag % 2) == 0){
        $(".checkbok-item").prop("checked",true);
    }else{
        $(".checkbok-item").prop("checked",false);
    }
    del_data.flag++;
});

$("#del-all").click(function(){
    var i = 0;
    del_data._ps.length = 0;  // 清除数组中的旧元素
    // 将页面当中选中的checkbox的id取出
    $(".checkbok-item").each(function(index, item){
        if(item.checked) {
            del_data._ps[i++] = item.getAttribute("del-box");
        }
    });

    if(!confirm("确定要删除【选中】的员工吗？？")){
        return;
    }
    var idsJSON = JSON.stringify(del_data._ps);
    sendDeleteEmpsInIdAjax(idsJSON,function(response){
        if(response.code = 200){
            alertDelMessage(response.meg , pageNum);
        }else{
            alert(response.meg);
        }
    });
});

/* 单个删除 */
    $(".table tbody").on("click",".del_emp",function(){
        var id = $(this).attr("del-data"),
            name = $(this).attr("emp-name");

        if(!confirm("是否确认删除【"+ name +"】")) return;

        sendDeleteEmpAjax(id,function(response){

            if(response.code == 200){
                alertDelMessage(response.meg , pageNum);
            }else{
                alert(response.meg);
            }
        })
    });

function alertDelMessage(meg,num){
    // 提示
    alert(meg);
    // 从新查询当前页
    sendEmpsAjax(num);
}

/* 员工删除 end */



/* 编辑员工模态框 start */
    // 模态框
    $("table").on("click", ".btn-modal-edit", function () {
        var tempId = this.getAttribute("edit-data");
        // 显示部门信息
        sendShowDeptName();
        // 每次编辑时, 弹出的form都进行数据回显
        redisplayEmpInfo(tempId);
        $("#emp-form-edit input[name=empId]").val(tempId);
        // 弹出模态框
        $("#create-modal-edit").modal({
            backdrop: "static",
            keyboard: false
        });
    });


    // 回显Employment数据
    function redisplayEmpInfo(id) {
        var checkGender = $("#emp-form-edit input[name=gender]"),
            allOption = $("#emp-form-edit .from-select option");

        $("#emp-form-edit")[0].reset();  // 初始化表单

        $.get("${basePath}/redisplayEmp/" + id, function (response) {
            console.log(response);
            $("#emp-form-edit p").html(response.data.emp.empName);
            $("#emp-form-edit input[type=email]").val(response.data.emp.emall);
            $("#emp-form-edit input[name=gender]").val([response.data.emp.gender]);
            $("#emp-form-edit select").val([response.data.emp.deptId]);
        });
    }

    // 点击修改
    $("#submit-edit").click(function () {
        var oEmail = $("#emp_email-edit"),
            oFromPrama = $("#emp-form-edit").serialize(); // 参数序列化
        // 郵箱校驗
        if (!RegExps.email.test(oEmail.val())) {
            return validate_common(oEmail, false, "邮箱格式不合法");
        } else {
            validate_common(oEmail, true, null);
        }
        // 发送更新请求
        sendUpdateEmpAjax(oFromPrama,function(response){
            //成功
            if(response.code == 200){
                // 提示添加结果
                alert(response.meg);
                // 关闭窗口
                $("#create-modal-edit").modal("hide");
                // 刷新当前页
                sendEmpsAjax(pageNum);
            }else{
                alert("更新失败--原因: "+ response.meg)
            }
        });
    });

    $("#emp_email-edit").blur(function () {
        var oEmail = $("#emp_email-edit");
        // 郵箱校驗
        if (!RegExps.email.test(oEmail.val())) {
            return validate_common(oEmail, false, "邮箱格式不合法");
        } else {
            validate_common(oEmail, true, null);
        }
    });

/* 编辑员工模态框 end */


/* 添加员工 start */
    $("#submit").click(function () {
        //0. 数据校验
        if (!validate_form()) {
            return;
        }
        // 1. 拿到添加数据
        var data = $("#modal-box form").serialize();
        // 2. 发送Ajax
        $.post("${basePath}/emp", data, function (response) {
            if (response.code == -2) {
                if (response.data.emall) {
                    validate_common($("#emp_email"), false, "邮箱格式不合法");
                }
                if (response.data.empName) {
                    validate_common($("#emp_name"), false, "员工名称4-12个数字和字母或者2-4个汉字");
                }
            } else {
                // 3. 获取返回结果
                alert(response.meg);
                // 4. 关闭添加窗口
                $("#create-modal").modal("hide");
                // 5. 跳转到最后一页,显示刚刚添加的员工
                sendEmpsAjax(pageTotalSize);
            }
        });
    });

    // 对员工重复的name进行校验
    var emp_nameFlag = false;
    $("#emp_name").blur(function () {
        var name = $(this).val();
        if (validate_form("name")) {
            $.get("${basePath}/empNameRepeat?empName=" + name, function (response) {
                if (response.code == 200) { // 可用
                    validate_common($("#emp-form input[name=empName]"), true, null);
                    emp_nameFlag = true;
                } else {
                    validate_common($("#emp-form input[name=empName]"), false, response.meg);
                    emp_nameFlag = false;
                }
            });
        }
    });

    $("#emp_email").blur(function () {
        validate_form("email");
    });

    var RegExps = {
        user: /^([a-zA-Z0-9_-]){4,12}|([\u2E80-\u9FFF]){2,4}$/,
        email: /^[a-zA-Z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/
    };

    // 对员工进行校验
    function validate_form(useFeild) {
        var empName = $("#emp-form input[name=empName]"),
            empEmail = $("#emp-form input[name=emall]"),
            empGender = $("#emp-form input[name=gender]"),
            empDeptId = $("#emp-form select[name=deptId]");
        if (useFeild == 'name' || !useFeild) {
            if (!RegExps.user.test(empName.val())) {
                return validate_common(empName, false, "员工名称4-12个数字和字母或者2-4个汉字");
            } else {
                validate_common(empName, true, null);
            }
        }

        if (useFeild == 'repeatName' || !useFeild) {
            if (emp_nameFlag) { // 可用
                validate_common($("#emp-form input[name=empName]"), true, null);
            } else {
                validate_common($("#emp-form input[name=empName]"), false, "员工名称重复");
                return emp_nameFlag;
            }
        }

        if (useFeild == 'email' || !useFeild) {
            if (!RegExps.email.test(empEmail.val())) {
                return validate_common(empEmail, false, "邮箱格式不合法");
            } else {
                validate_common(empEmail, true, null);
            }
        }
        return true;
    }

    /*抽取(可重用)校验结果显示的操作代码
     el: JQ封装后的Dom对象
     flag: true表示校验成功, false表示校验失败
     meg: 需要提升的信息*/
    function validate_common(el, flag, meg) {
        if (flag) { // 成功进入
            el.parent().removeClass("has-error").addClass("has-success");
            el.next("span").empty();
        } else {  // 失败进入
            el.parent().removeClass("has-success").addClass("has-error");
            el.next("span").text(meg);
            return false;
        }
    }
/* 添加员工 end */


/*主页分页相关操作 start  */
    // 查询员工分页数据
    function sendEmpsAjax(pn) {
        $.ajax({
            url: "${basePath}/emps",
            data: 'pn=' + pn,
            type: "get",
            dataType: "json",
            success: function (response) {
                buildEmpTable(response);
                buildEmpPageInfo(response.data.pageInfo);
                // 设置当前页, 为其他共同提供服务
                pageNum = response.data.pageInfo.pageNum;

            },
            error: function (response) {
                alert("数据加载失败");
            }
        });
    }

    function buildEmpTable(result) {
        var empList = result.data.pageInfo.list,
            empTable = $(".table tbody"),
            trEmp = null,
            tdCheckbox = null,
            tdEmpId = null,
            tdEmpName = null,
            tdEmpEmail = null,
            tdGender = null,
            tdDeptName = null,
            tdOtherChoose = null,
            oButEdit = null,
            oButDelete = null;

        empTable.empty(); // tbody内html清除

        $.each(empList, function (index, item) {
            tdCheckbox = $("<td></td>")
                .append($("<input type='checkbox'/>").addClass("checkbok-item").attr("del-box",item.empId));
            tdEmpId = $("<td></td>").append(item.empId);
            tdEmpName = $("<td></td>").append(item.empName);
            tdEmpEmail = $("<td></td>").append(item.emall);
            tdGender = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            tdDeptName = $("<td></td>").append(item.department.deptName);
            // 删除按钮
            oButDelete = $("<button type='button' class='btn btn-danger btn-sm del_emp'></button>")
                .attr("del-data", item.empId).attr("emp-name",item.empName)
                .append("<span class='glyphicon glyphicon-trash'></span>").append("删除");
            // 编辑按钮
            oButEdit = $("<button type='button' class='btn btn-info btn-sm btn-modal-edit'></button>")
                .attr("edit-data", item.empId)
                .append("<span class='glyphicon glyphicon-pencil'></span>").append("编辑");
            // 删除和编辑所在的td
            tdOtherChoose = $("<td></td>").append(oButEdit).append(oButDelete);
            // 一层一层添加到其中
            trEmp = $("<tr></tr>")
                .append(tdCheckbox)
                .append(tdEmpId)
                .append(tdEmpName)
                .append(tdEmpEmail)
                .append(tdGender)
                .append(tdDeptName)
                .append(tdOtherChoose);

            // 最后将tr添加到table当中
            empTable.append(trEmp);
        })
    }
    // 设置分页信息(页码, 首尾页等..)
    function buildEmpPageInfo(pageInfo) {
        //底部导航的左侧
        buildNavLeft(pageInfo);

        //底部导航的右侧
        buildNavRight(pageInfo);
    }
    var preClickIndex = -1;  // 记录上一页的, 点击高亮, 用于下一页将其class取消
    // 底部导航的右侧
    function buildNavRight(pageInfo) {
        var navNums = pageInfo.navigatepageNums,
            oDivBox = $("#navPageNums"),
            oLi = null,
            oA = null,
            oFirstPageLi = null,
            oLastPageLi = null,
            oPrePageLi = null,
            oNextPageLi = null,
            activeShowClass = "";

        // 首页和上一页的逻辑
        var navLiAll = $("#navPageNums li");
        if (pageInfo.isFirstPage) {
            navLiAll.eq(0).addClass("disabled").find("a").attr("onClick", null);
            navLiAll.eq(1).addClass("disabled").find("a").attr("onClick", null);
        } else {
            navLiAll.eq(0).removeClass("disabled").find("a").attr("onClick", "sendEmpsAjax(1)");
            navLiAll.eq(1).removeClass("disabled").find("a").attr("onClick", "sendEmpsAjax(" + (pageInfo.pageNum - 1) + ")");
        }

        // 中间导航栏
        for (var num in navNums) {
            activeShowClass = navNums[num] == pageInfo.pageNum ? "active" : "";
            var i = parseInt(num) + 2;
            navLiAll.eq(i).find("a")
                .attr("onClick", "sendEmpsAjax(" + navNums[num] + ")")
                .html(navNums[num]);
            // 将上次点击页数,取消高亮
            navLiAll.eq(preClickIndex).removeClass(activeShowClass);
            // 將本次点击页数,高亮
            if (pageInfo.pageNum == navNums[num]) {
                navLiAll.eq(i).addClass(activeShowClass);
                preClickIndex = i; // 记录上一次高亮的li的下标
            }
        }

        // 尾页和下一页
        if (pageInfo.isLastPage) {
            navLiAll.eq(7).addClass("disabled").find("a").attr("onClick", null);
            navLiAll.eq(8).addClass("disabled").find("a").attr("onClick", null);
        } else {
            navLiAll.eq(7).removeClass("disabled").find("a").attr("onClick", "sendEmpsAjax(" + (pageInfo.pageNum + 1) + ")");
            navLiAll.eq(8).removeClass("disabled").find("a").attr("onClick", "sendEmpsAjax(" + pageInfo.pages + ")");
        }
    }
    // 底部导航左侧
    function buildNavLeft(pageInfo) {
        var oSpan1 = $(".pageInfo_pageNum_and_pages span"),
            oSpan2 = $(".pageInfo_total span");

        oSpan1.eq(0).html(pageInfo.pageNum);
        oSpan1.eq(1).html(pageInfo.pages);
        oSpan2.eq(0).html(pageInfo.total);
        pageTotalSize = pageInfo.total;
    }
/* 主页分页相关操作 end */


/* 添加员工模态框 start */
    $("#btn-modal").click(function () {
        // 每次添加时, 弹出的form都进行一次重置
        $("#create-modal form")[0].reset();
        // 显示部门信息
        sendShowDeptName();

        // 弹出模态框
        $("#create-modal").modal({
            backdrop: "static",
            keyboard: false
        });
    });
    // 查询部门名称用于添加员工选择
    function sendShowDeptName() {
        $(".select_department_box select").empty();
        $.ajax({
            url: "${basePath}/depts",
            type: "get",
            success: function (response) {
                var depts = response.data.departmentList,
                    oSelect = $(".select_department_box select"),
                    oOption = null;

                for (var index in depts) {
                    oOption = $("<option></option>").attr("value", depts[index].deptId)
                        .html(depts[index].deptName);
                    // 将option添加到select当中
                    oSelect.append(oOption);
                }
            }
        })
    }
/* 添加员工模态框 end */


</script>

</html>
