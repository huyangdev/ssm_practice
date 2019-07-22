<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<% pageContext.setAttribute("basePath",request.getContextPath()); %>

<head>
<title>所有雇员</title>
<link href="${basePath}/static/bootstrap337/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        .page_title{}
        .table-hover tr:hover {
            background: #eee !important;
        }

        .global_operate{
            margin-bottom:26px;
        }
        .table .btn{
            margin-left:5px;
        }

    </style>
</head>
<body>
<div class="container">
    <h1 class="page_title">SSM项目小练习</h1>
    <div class="global_operate">
        <button type="button" class="btn btn-info btn-sm btn-primary" data-target="#myModal" id="btn-modal" >
            新增
        </button>
        <button type="button" class="btn btn-danger btn-sm">
            <span class="glyphicon glyphicon-trash"></span>
            删除
        </button>

        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="create-modal">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">

                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body" id="modal-box">
                        <form>
                            <div class="form-group">
                                <label for="emp_name">Name</label>
                                <input class="form-control" name="empName" type="text" placeholder=" 名称" id="emp_name">
                            </div>
                            <div class="from-groug">
                                <label for="emp_email">Email</label>
                                <input id="emp_email" class="form-control" name="emall" type="email" placeholder=" 邮箱">
                            </div>
                            <div class="checkbox">
                                <input type="radio" name="gender" value="M" /> 男
                                <label></label>
                                <input type="radio" name="gender" value="W" /> 女
                            </div>

                            <div id="select_department_box" class="from-select col-sm-2">
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
                <th>checkbox</th>
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
                        <%--${basePath}/emps?pn=${pageInfo.pageNum-1}--%>
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
                    <%--${basePath}/emps?pn=${pageInfo.pageNum+1}--%>
                    <li>
                        <a href="javascript:void(0)" aria-label="Previous">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <%--${basePath}/emps?pn=${pageInfo.pages}--%>
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

<script type="text/javascript">
    var pageTotalSize = 0;
    $(function(){
        sendEmpsAjax(1);
    });

/* 添加员工 start */
    $("#submit").click(function(){
        // 1. 拿到添加数据
        var data = $("#modal-box form").serialize();
        // 2. 发送Ajax
        $.post("${basePath}/emp",data,function(response){
            // 3. 获取返回结果
            alert(response.meg);
            // 4. 关闭添加窗口
            $("#create-modal").modal("hide");
            // 5. 跳转到最后一页,显示刚刚添加的员工
            sendEmpsAjax(pageTotalSize);
        });
    });
/* 添加员工 end */


/*主页分页相关操作 start  */
    // 查询员工分页数据
    function sendEmpsAjax(pn){
        $.ajax({
            url:"${basePath}/emps",
            data:'pn='+pn,
            type:"get",
            dataType:"json",
            success: function(response){
                buildEmpTable(response);
                buildEmpPageInfo(response.data.pageInfo);
            },
            error: function(response){
                alert("数据加载失败");
            }
        });
    }

    function buildEmpTable(result){
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

        $.each(empList , function(index,item){
            tdCheckbox = $("<td></td>")
                .append($("<input type='checkbox' />").addClass("input-checkbok"));
            tdEmpId = $("<td></td>").append(item.empId);
            tdEmpName = $("<td></td>").append(item.empName);
            tdEmpEmail = $("<td></td>").append(item.emall);
            tdGender = $("<td></td>").append(item.gender == "M"?"男":"女");
            tdDeptName = $("<td></td>").append(item.department.deptName);
            // 删除按钮
            oButDelete = $("<button type='button' class='btn btn-danger btn-sm'></button>")
                .append("<span class='glyphicon glyphicon-trash'></span>").append("删除");
            // 编辑按钮
            oButEdit = $("<button type='button' class='btn btn-info btn-sm'></button>")
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
    function buildEmpPageInfo(pageInfo){
        //底部导航的左侧
        buildNavLeft(pageInfo);

        //底部导航的右侧
        buildNavRight(pageInfo);
    }
    var preClickIndex = -1;  // 记录上一页的, 点击高亮, 用于下一页将其class取消
    // 底部导航的右侧
    function buildNavRight(pageInfo){
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
        if(pageInfo.isFirstPage){
            navLiAll.eq(0).addClass("disabled").find("a").attr("onClick",null);
            navLiAll.eq(1).addClass("disabled").find("a").attr("onClick",null);
        }else {
            navLiAll.eq(0).removeClass("disabled").find("a").attr("onClick","sendEmpsAjax(1)");
            navLiAll.eq(1).removeClass("disabled").find("a").attr("onClick","sendEmpsAjax("+ (pageInfo.pageNum-1) +")");
        }

        // 中间导航栏
        for(var num in navNums){
            activeShowClass = navNums[num] == pageInfo.pageNum?"active":"";
            var i = parseInt(num)+2;
            navLiAll.eq(i).find("a")
                .attr("onClick","sendEmpsAjax(" + navNums[num] + ")")
                .html(navNums[num]);
            // 将上次点击页数,取消高亮
            navLiAll.eq(preClickIndex).removeClass(activeShowClass);
            // 將本次点击页数,高亮
            if(pageInfo.pageNum == navNums[num]){
                navLiAll.eq(i).addClass(activeShowClass);
                preClickIndex = i; // 记录上一次高亮的li的下标
            }
        }

        // 尾页和下一页
        if(pageInfo.isLastPage){
            navLiAll.eq(7).addClass("disabled").find("a").attr("onClick",null);
            navLiAll.eq(8).addClass("disabled").find("a").attr("onClick",null);
        }else {
            navLiAll.eq(7).removeClass("disabled").find("a").attr("onClick","sendEmpsAjax("+ (pageInfo.pageNum+1) +")");
            navLiAll.eq(8).removeClass("disabled").find("a").attr("onClick","sendEmpsAjax("+ pageInfo.pages +")");
        }
    }
    // 底部导航左侧
    function buildNavLeft(pageInfo){
        var oSpan1 = $(".pageInfo_pageNum_and_pages span"),
            oSpan2 = $(".pageInfo_total span");

        oSpan1.eq(0).html(pageInfo.pageNum);
        oSpan1.eq(1).html(pageInfo.pages);
        oSpan2.eq(0).html(pageInfo.total);
        pageTotalSize = pageInfo.total;
    }
/* 主页分页相关操作 end */


/* 模态框 start */
    $("#btn-modal").click(function(){
        // 显示部门信息
        sendShowDeptName();

        // 弹出模态框
        $("#create-modal").modal({
            backdrop:"static",
            keyboard:false
        });
    });
    // 查询部门名称用于添加员工选择
    function sendShowDeptName(){
        $.ajax({
            url:"${basePath}/depts",
            type:"get",
            success:function(response){
                var depts = response.data.departmentList,
                    oSelect = $("#select_department_box select"),
                    oOption = null;

                for(var index in depts){
                    oOption = $("<option></option>").attr("value",depts[index].deptId)
                        .html(depts[index].deptName);
                    // 将option添加到select当中
                    oSelect.append(oOption);
                }
            }
        })
    }
/* 模态框 end */





</script>

</html>
