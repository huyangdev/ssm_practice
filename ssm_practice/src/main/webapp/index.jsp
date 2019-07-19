<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<% pageContext.setAttribute("basePath",request.getContextPath()); %>

<head>
<title>所有雇员</title>
<link href="${basePath}/static/bootstrap337/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        .page_title{

        }
        .table-hover tr:hover {
            background: #eee !important;
        }

        .global_operate{
            margin-bottom:26px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="page_title">SSM项目小练习</h1>
    <div class="global_operate">
        <button type="button" class="btn btn-info btn-sm">
            <span class="glyphicon glyphicon-pencil"></span>
            编辑
        </button>
        <button type="button" class="btn btn-danger btn-sm">
            <span class="glyphicon glyphicon-trash"></span>
            删除
        </button>
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
        <div id="page_num_info" class="col-md-7"></div>
        <!-- 页码导航按钮
            col-md-5: bootstrap格栅系统中的列(占用5个列)
            col-md-offset-8: 偏移量8
        -->
        <div class="col-md-5 col-md-offset-8">
            <nav aria-label="Page navigation">
                <ul id="navPageNums" class="pagination">
                    <!-- 显示首页判断 -->
<%--                    <c:choose>
                        <c:when test="${pageInfo.isFirstPage}">
                            <li class="disabled"><span aria-hidden="true">首页</span></li>
                            <li class="disabled">
                                <span aria-hidden="true">&laquo;</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${basePath}/emps?pn=1">首页</a></li>
                            <li class="">
                                <a href="${basePath}/emps?pn=${pageInfo.pageNum-1}">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
--%>
                    <!-- 导航栏 -->


                    <!-- 下一页和末页的的判断 -->
<%-- <c:choose>
                        <c:when test="${pageInfo.isLastPage}">
                            <li class="disabled">
                                <span aria-hidden="true">&raquo;</span>
                            </li>
                            <li class="disabled"><span aria-hidden="true">末页</span></li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a href="${basePath}/emps?pn=${pageInfo.pageNum+1}" aria-label="Previous">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li><a href="${basePath}/emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:otherwise>
                    </c:choose> --%>
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
    $(function(){
        sendEmpsAjax(1);
    })

    function sendEmpsAjax(pn){
        $.ajax({
            url:"${basePath}/emps",
            data:'pn='+pn,
            type:"get",
            dataType:"json",
            success: function(response){
                buildEmpTable(response);
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

            empTable.html(""); // tbody内html清除

        $.each(empList , function(index,item){
            tdCheckbox = $("<input type='checkbox' />");
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


            trEmp = $("<tr></tr>")
                .append(tdCheckbox)
                .append(tdEmpId)
                .append(tdEmpName)
                .append(tdEmpEmail)
                .append(tdGender)
                .append(tdDeptName)
                .append(tdOtherChoose);

            empTable.append(trEmp);
        })

        buildEmpPageInfo(result.data.pageInfo);
    }

    // 设置分页信息(页码, 首尾页等..)
    function buildEmpPageInfo(pageInfo){
        var oSpan1 = $("<span></span>").append("当前页码/总页数: " + pageInfo.pageNum+ "/" + pageInfo.pages),
            oSpan2 = $("<span></span>").append("---共有" + pageInfo.total+ "条数据");
        // 将span添加到 div当中
        $("#page_num_info").html("").append(oSpan1).append(oSpan2);

        // 处理页码
        var navNums = pageInfo.navigatepageNums,
            oDivBox = $("#navPageNums"),
            oLi = null,
            oA = null,
            activeShowClass = "";
            oDivBox.html("");  // 防止不断添加, 每次查询进行一次清除
        for(var num in navNums){  // 创建页码导航
            oA = $("<a href='javascript:void(0)' onclick='sendEmpsAjax("+ navNums[num] +")'></a>")
                .append(navNums[num]);

                activeShowClass = navNums[num] == pageInfo.pageNum?"active":"";
            oLi = $("<li class = '+ activeShowClass +'></li>").append(oA);
            oDivBox.append(oLi);
        }
    }


</script>

</html>
