<%@ page import="JDBC.JDBC" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: Cass
  Date: 2016/6/5
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>view notice</title>
</head>
<%
    //查询数据库最后一条数据
    String sql ="SELECT * FROM notice ORDER BY ID DESC LIMIT 1";
    Connection conn = JDBC.getConnection();
    ResultSet rs = JDBC.select(sql,conn);
    //输出查询结果
    try {
        rs.next();
        out.print(rs.getString("content"));
        rs.close();
        conn.close();
    } catch (Exception e) {}
    // request.setAttribute("userAccount",rs.getString("userAccount"));
%>
</body>
<%--<jsp:forward page="view.jsp"></jsp:forward>--%>
</html>

