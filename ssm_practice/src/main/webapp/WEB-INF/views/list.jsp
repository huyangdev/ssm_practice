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
        <tr>
            <th>checkbox</th>
            <th>id</th>
            <th>name</th>
            <th>email</th>
            <th>gender</th>
            <th>depaName</th>
            <th>other choose</th>
        </tr>
        <c:forEach items="${pageInfo.list}" var="emp">
            <tr>
                <td><input type="checkbox"></td>
                <td>${emp.empId}</td>
                <td>${emp.empName}</td>
                <td>${emp.gender=="M"?"男":"女"}</td>
                <td>${emp.emall}</td>
                <td>${emp.department.deptName}</td>
                <td>
                    <button type="button" class="btn btn-info btn-sm">
                        <span class="glyphicon glyphicon-pencil"></span>
                        编辑
                    </button>
                    <button type="button" class="btn btn-danger btn-sm">
                        <span class="glyphicon glyphicon-trash"></span>
                        删除
                    </button>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div class="row">
        <!-- 页码,记录数, 等分页信息 -->
        <div class="col-md-7">
            <span>当前页码/总页数: ${pageInfo.pageNum}/${pageInfo.pages}</span>
            <span>---共有${pageInfo.total}条数据</span>
        </div>
        <!-- 页码导航按钮
            col-md-5: bootstrap格栅系统中的列(占用5个列)
            col-md-offset-8: 偏移量8
        -->
        <div class="col-md-5 col-md-offset-8">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <!-- 显示首页判断 -->
                    <c:choose>
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
                    <!-- 导航栏 -->
                    <c:forEach items="${pageInfo.navigatepageNums}" var="navPage">
                        <li class="${navPage==pageInfo.pageNum?"active":""}"><a href="${basePath}/emps?pn=${navPage}">${navPage}</a></li>
                    </c:forEach>
                    <!-- 下一页和末页的的判断 -->
                    <c:choose>
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
                    </c:choose>
                </ul>
            </nav>
        </div>
    </div>
</div>


</body>
<!-- 引入bootstrap和Jquery -->
<script type="text/javascript" src="${basePath}/static/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="${basePath}/static/bootstrap337/js/bootstrap.min.js"></script>
</html>
