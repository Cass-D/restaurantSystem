<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/4
  Time: 23:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="JDBC.JDBC" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <title>点餐系统</title>
    <script src="js/ajax.js"></script>
    <script>

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            int roleId = Integer.parseInt(session1.getAttribute("roleId").toString());
            String faceimg = session1.getAttribute("faceimg").toString();
        %>

        function checkRecover(id, name, obj) {
            msg = '是否将'+ name +'复职？';
            if (confirm(msg)) {
                xmlAjaxRequest("/userStatus?id=" + id + "&locked=" + 0, "post", true, null, RecoverCallback, obj, null)
            }
        }

        function RecoverCallback(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

        //显示员工详情调用模态框
        function detail(account, role, img) {
            var userAccount = document.getElementById("userAccount");
            var userRole = document.getElementById("role");
            var faceimg = document.getElementById("faceimg");
            faceimg.src = "img/" + img;
            userAccount.innerHTML = account;
            userRole.innerHTML = role;
            $('#myModal').modal('show');
        }

    </script>

</head>

<body>
<!-- 顶部导航 -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand " href="#" style="padding-left: 35px">
            <span class="glyphicon glyphicon-home navFont"><strong class=“systemTitle”> 木叶村-餐厅到店点餐系统</strong></span>
        </a>
    </div>
    <div id="navbar" class="navbar-collapse collapse navbar-right">
        <ul class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-user navFont">&nbsp当前用户：<shiro:principal/></span>
                    <span class="caret navFont"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <img src="<%="/img/"+faceimg%>" style="width: 85px;height:85px"></li>
                    <li>
                        <a href="/adminAmendOwnUser.jsp?">修改个人信息</a>
                    </li>
                    <li role="separator" class="divider"></li>
                </ul>
            </li>
            <li class="" style="padding-right:35px; ">
                <a href="/exit"><span class="navFont">退出登录</span></a>
            </li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
                <li>
                    <a href="#panel1" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-cog"></i> 运营功能
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="panel1" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="adminMain.jsp"><i class="glyphicon glyphicon-user"></i> 顾客结账</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#panel2" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-cog"></i> 餐厅管理
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="panel2" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="adminUser.jsp"><i class="glyphicon glyphicon-user"></i> 员工管理</a></li>
                        <li><a href="adminDishes.jsp"><i class="glyphicon glyphicon-list-alt"></i> 菜品管理</a></li>
                        <li><a href="adminData.jsp"><i class="glyphicon glyphicon-asterisk"></i> 查看经营数据</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#panel3" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-cog"></i> 实时公告
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="panel3" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="adminNotice.jsp"><i class="glyphicon glyphicon-user"></i> 发布实时公告</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
<!-- 右边详细内容 -->
<!-- <div class="container"> -->
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">员工列表</h3>
        </div>
        <nav>
            <ul class="pager">
                <li><a href="adminUser.jsp" >在职员工</a></li>
                <li><a href="adminUserLeave.jsp">离职员工</a></li>
            </ul>
        </nav>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th class="tableCenter">员工编号</th>
                        <th class="tableCenter">员工帐号</th>
                        <th class="tableCenter">员工角色</th>
                        <th class="tableCenter">员工状态</th>
                        <th class="tableCenter">操作</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">
                    <%
                        String sql = "SELECT userinfo.*,roleinfo.roleName FROM userinfo,roleinfo WHERE userinfo.roleId=roleinfo.roleId AND locked=1 AND userinfo.roleId>"+roleId;
                        Connection conn = JDBC.getConnection();
                        ResultSet rs = JDBC.select(sql,conn);
                        try {
                            while (rs.next()) {
                    %>
                    <tr>
                        <td class="tableCenter"><%=rs.getInt("userId")%>
                        </td>
                        <td class="tableCenter"><%=rs.getString("userAccount")%>
                        </td>
                        <td class="tableCenter"><%=rs.getString("roleName")%>
                        </td>
                        <td class="tableCenter"><%=rs.getInt("locked")==0?"在职":"离职"%>
                        </td>
                        <td class="tableCenter">
                            <a href="adminAmendUser.jsp?id=<%=rs.getInt("userId")%>&userAccount=<%=rs.getString("userAccount")%>&userPass=<%=rs.getString("userPass")%>&faceimg=<%=rs.getString("faceimg")%>"
                               title="修改员工信息">
                                <span class="glyphicon glyphicon-cog"></span>&nbsp
                            </a>
                            <a href="#" title="查看员工详情"
                               onclick="detail('<%=rs.getString("userAccount")%>','<%=rs.getString("roleName")%>','<%=rs.getString("faceimg")%>')">
                                <span class="glyphicon glyphicon-list-alt"></span>&nbsp
                            </a>
                            <%--<a href="#" onclick="checkDelete('<%=rs.getInt(1)%>','<%=rs.getString("userAccount")%>',this)" title="员工离职">--%>
                                <%--<span class="glyphicon glyphicon-remove"></span>--%>
                            <%--</a>--%>
                            <a href="#" title="员工复职" onclick="checkRecover('<%=rs.getInt(1)%>','<%=rs.getString("userAccount")%>',this)"><span class="glyphicon glyphicon-play"></span></a>
                            </form>
                        </td>
                    </tr>
                    <%
                            }
                            rs.close();
                            conn.close();
                        } catch (Exception e) {
                        }
                    %>
                    </tbody>
                </table>
                <nav style="text-align: center">
                    <ul class="pagination pagination-lg pager">
                        <li class="disabled">
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li>
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <hr>
        <div style="text-align: center;">
            如果您需要在系统中添加一名员工，请点击右边的按钮：<a href="adminAddUser.jsp" class="btn btn-primary addUserAndDishes">添加员工</a>
        </div>
    </div>

    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
</div>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>


<!-- 模态框Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">详细信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-info" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title"><strong>员工详情</strong></h3>
                    </div>
                    <div class="panel-body" style="text-align: center;">
                        <img src="img/userIcon.jpg" id="faceimg" width="200px" height="200px" class="img-circle"
                             style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                        <p>
                        <h2>员工帐号：
                            <span id="userAccount"></span>
                        </h2>
                        </p>
                        <p>
                        <h3>
                            员工角色：<span id="role"></span></h3>
                        </p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>

</html>
