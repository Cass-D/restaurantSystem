<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker.min.css">
    <title>点餐系统</title>

    <script>
        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            int id = Integer.parseInt(session1.getAttribute("userId").toString());
            String userAccount = session1.getAttribute("userAccount").toString();
            String userPass = session1.getAttribute("userPass").toString();
            int roleId = Integer.parseInt(session1.getAttribute("roleId").toString());
            String faceimg = session1.getAttribute("faceimg").toString();
        %>
    </script>

</head>

<body onload="getOrderList()">
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
                        <a href="adminAmendUser.jsp?id=<%=id%>&userAccount=<%=userAccount%>&userPass=<%=userPass%>&faceimg=<%=faceimg%>">修改个人信息</a>
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
            <h2 class="panel-title">历史订单</h2>
        </div>
        <div class="panel-body" style="padding-bottom: 0px">
            <form class="form-inline">
                <div class="form-group">
                    <div class="input-append date form_datetime">
                        <label >开始时间：</label>
                        <input size="16" id="orderEndDateMin" type="text" value="" readonly>
                            <span class="add-on">
                                <i class="icon-th glyphicon glyphicon-calendar"></i>
                            </span>
                    </div>
                </div>
                &nbsp;&nbsp;
                <div class="form-group">
                    <div class="input-append date form_datetime">
                        <label >结束时间：</label>
                        <input size="16" id="orderEndDateMax" type="text" value="" readonly>
                            <span class="add-on">
                                <i class="icon-th glyphicon glyphicon-calendar"></i>
                            </span>
                    </div>


                </div>
                <input type="button" class="btn btn-primary btn-ms"  value="开始搜索" onclick="orderSearch()" style="margin:auto 20px;"/>
                <input type="button" class="btn btn-primary btn-ms"  value="全部订单" onclick="getOrderList()"/>
            </form>


            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>桌号</th>
                        <th>结账时间</th>
                        <th>服务员</th>
                        <th>总价</th>
                        <th>详情</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">

                    </tbody>
                </table>
            </div>

        </div>
    </div>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="/js/ajax.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.zh-CN.min.js"></script>
<script>

    function getOrderList(){
        xmlAjaxRequest("/getOrder?sql="+"SELECT orderinfo.*,userinfo.userAccount FROM orderinfo,userinfo WHERE waiterId=userId AND orderState BETWEEN 2 AND 3 ORDER BY orderEndDate DESC", "post", true, null, showOrderList, null, null);
    }

    function orderSearch(){
        orderEndDateMin = document.getElementById("orderEndDateMin").value;
        orderEndDateMax = document.getElementById("orderEndDateMax").value;
        xmlAjaxRequest("/getOrder?sql="+"SELECT orderinfo.*,userinfo.userAccount FROM orderinfo,userinfo WHERE waiterId=userId AND orderState BETWEEN 2 AND 3 AND orderEndDate BETWEEN '" + orderEndDateMin + "' AND '" + orderEndDateMax +"' ORDER BY orderEndDate DESC", "post", true, null, showOrderList, null, null);
    }

    function showOrderList(responseXml, obj) {
        var table = document.getElementById("orderTable");
        table.innerHTML = "";
        var orders = responseXml.getElementsByTagName("order");
        for ( var i = 0; i < orders.length; i++) {
            var order = orders[i];
            var attrs = order.childNodes;
            var orderId;
            var tableId;
            var orderBeginDate;
            var orderEndDate;
            var sum;
            var userAccount;
            for ( var j = 0; j < attrs.length; j++) {
                var attr = attrs[j];
                if (attr.nodeName == "orderId") {
                    orderId = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "tableId") {
                    tableId = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "orderBeginDate") {
                    orderBeginDate = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "orderEndDate") {
                    orderEndDate = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "sum") {
                    sum = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "userAccount") {
                    userAccount = attr.childNodes[0].nodeValue;
                }
            }

            var newLine ="<td class='tableCenter'>" + tableId + "</td>"
                    +  "<td class='tableCenter'>" + orderEndDate + "</td>"
                    +  "<td class='tableCenter'>" + userAccount + "</td>"
                    +  "<td class='tableCenter'>" + sum + "</td>"
                    +  "<td class='tableCenter'>"
                    +  "    <a href='#' title='订单详情'>"
                    +  "        <span class='glyphicon glyphicon-list-alt'></span>"
                    +  "    </a>"
                    +  "</td>";
            table.innerHTML += newLine;
        }
    }
            $(".form_datetime").datepicker({
                language: 'zh-CN',
                todayHighlight: 1,
                autoclose: 1,
                format: 'yyyy-mm-dd'
            });
</script>

</body>
</html>
