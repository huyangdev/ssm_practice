<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="top.gn.ssm.bean.Employment" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>显示所有雇员信息</title>
</head>
<body>

<%
    PageInfo<Employment> emps = (PageInfo<Employment>)request.getAttribute("pageInfo");
    for (Employment e:emps.getList()) {
        System.out.println(e);
    }
    System.out.println(emps);
%>


</body>
</html>
