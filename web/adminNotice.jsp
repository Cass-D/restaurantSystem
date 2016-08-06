<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <title>点餐系统</title>

    <script>

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            String faceimg = session1.getAttribute("faceimg").toString();
        %>

        function check(){
            if (document.getElementById("news").value == ""){
                alert("发布消息为空！");
                return false;
            }
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
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="panel panel-info" style="min-height: 500px;">
        <div class="panel-heading">
            <h3 class="panel-title">实时公告</h3>
        </div>
        <div class="panel-body">
            <div class="table-responsive">

                <form action="/sendNews" method="post">
                        <textarea class="notice" name="news" id="news" type="text" autofocus style="resize:none;"></textarea>
                    <input type="submit" value="发布" onclick="return check();" class="btn btn-primary btn-md addUserAndDishes" id="submitBtn">
                </form>
            </div>
        </div>


    </div>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统ETC 2015</p>
    </footer>
</div>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>

</html>

