<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="JDBC.JDBC" %><%--
  Created by IntelliJ IDEA.
  User: Cass
  Date: 2016/6/5
  Time: 0:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<script type="text/javascript">
    alert("发布成功！！返回管理界面");
</script>
<%
    String content=request.getParameter("notice");
    request.setAttribute("notice",content);
    JDBC.notice(content);
    response.sendRedirect("adminUser.jsp");
%>

</html>

