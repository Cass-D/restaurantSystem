<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.session.Session" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <title>点餐系统</title>

    <script src="js/ajax.js"></script>
    <script type="text/javascript">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            String faceimg = session1.getAttribute("faceimg").toString();
        %>

        setInterval("getOrderList()","5000");

        function check(id, obj){
            msg = '确认收到买单款项？';
            if (confirm(msg)) {
                xmlAjaxRequest("/orderStatus?id=" + id + "&orderState=" + 2, "post", true, null, callBack, obj, null)
            }
        }

        function cancelCheck(id, obj){
            msg = '此订单将不结账而直接作废？';
            if (confirm(msg)) {
                xmlAjaxRequest("/orderStatus?id=" + id + "&orderState=" + 3, "post", true, null, callBack, obj, null)
            }
        }

        function callBack(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

        function getOrderList() {
            xmlAjaxRequest("/getOrder?sql="+"SELECT orderinfo.*,userinfo.userAccount FROM orderinfo,userinfo WHERE waiterId=userId AND orderState=1 ORDER BY orderEndDate ASC", "post", true, null, showList, null, null);
        }

        function showList(responseXml, obj) {

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

                var newLine = "<tr>"
                    + "<td class=\"tableCenter\">" + tableId + " </td>"
                    + "<td class=\"tableCenter\">" + orderBeginDate + "</td>"
                    + "<td class=\"tableCenter\">" + orderEndDate + "</td>"
                    + "<td class=\"tableCenter\">" + sum + "</td>"
                    + "<td class=\"tableCenter\">"
                    + "    <a href=\"#\" title=\"确认订单\" onclick=\"check("
                    + orderId + ", this)\">"
                    + "        <span class=\"glyphicon glyphicon-ok\"></span>&nbsp"
                    + "    </a>"
                    + "    <a href=\"#\" title=\"订单作废\" onclick='cancelCheck("
                    + orderId + ", this)'>"
                    + "        <span class=\"glyphicon glyphicon-remove\"></span>&nbsp"
                    + "    </a>"
                    + "    <a href=\"#\" title=\"订单详情\" onclick='detail("
                    + "\"" + tableId + "\",\"" + orderBeginDate + "\",\"" + orderEndDate + "\",\"" + userAccount + "\",\"" + sum + "\",\"" + orderId + "\")'>"
                    + "        <span class=\"glyphicon glyphicon-list-alt\"></span>"
                    + "    </a>"
                    + "</td>"
                +"</tr>";

                table.innerHTML += newLine;
            }
        }

        function detail(tId, beginDate, endDate, account, orderSum, orderId) {
            var tableId = document.getElementById("tableId");
            tableId.innerHTML = tId;
            var orderBeginDate = document.getElementById("orderBeginDate");
            orderBeginDate.innerHTML = beginDate;
            var orderEndDate = document.getElementById("orderEndDate");
            orderEndDate.innerHTML = endDate;
            var userAccount = document.getElementById("userAccount");
            userAccount.innerHTML = account;
            var sum = document.getElementById("sum");
            sum.innerHTML = orderSum;
            getThisOrderDishes(orderId);
            $('#myModal').modal('show');
        }

        function getThisOrderDishes(orderId){
            xmlAjaxRequest("/getThisOrderDishes?orderId="+orderId, "post", true, null, showThisOrderDishesList, null, null);
        }

        function showThisOrderDishesList(responseXml, obj){
            var table = document.getElementById("thisOrderDishes");
            table.innerHTML = "";
            var orderdisheses = responseXml.getElementsByTagName("orderdishes");
            for ( var i = 0; i < orderdisheses.length; i++) {
                var orderdishes = orderdisheses[i];
                var attrs = orderdishes.childNodes;
                var dishesName;
                var dishesPrice;
                var num;
                for ( var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "dishesName") {
                        dishesName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesPrice") {
                        dishesPrice = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "num") {
                        num = attr.childNodes[0].nodeValue;
                    }
                }

                var newLine = "<td class='tableCenter'>" + dishesName + "</td>"
                        +  "<td class='tableCenter'>" + dishesPrice + "</td>"
                        +  "<td class='tableCenter'>" + num + "</td>"

                table.innerHTML += newLine;
            }
        }

    </script>
</head>

<body onload="getOrderList()">
<!-- 顶部导航 -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
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
<!-- 左边 -->
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
    <!-- 待结账餐桌信息面板 -->
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">待结账餐桌信息</h3>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th class="tableCenter">桌号</th>
                        <th class="tableCenter">开餐时间</th>
                        <th class="tableCenter">结账时间</th>
                        <th class="tableCenter">总价</th>
                        <th class="tableCenter">操作</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">

                    </tbody>
                </table>

                <nav>
                    <ul class="pager">
                        <li><a href="#" id="firstpage">&larr;首页</a></li>
                        <li><a href="#" id="pre">上一页</a></li>
                        <li><a href="#" id="next">下一页</a></li>
                        <li><a href="#" id="last">末页&rarr;</a></li>
                    </ul>
                </nav>

            </div>
        </div>
    </div>
    <!--今日特色菜 -->
    <%--<div class="panel panel-info" >--%>
        <%--<div class="panel-heading">--%>
            <%--<h2 class="panel-title">今日特色推荐菜品</h2>--%>
        <%--</div>--%>
        <%--<div class="panel-body" style="padding-bottom: 0px;border:1px solid #bbbebf">--%>
            <%--&lt;%&ndash;测试内容&ndash;%&gt;--%>
                <%--<div class="" >--%>
                    <%--<table class="placeholders row "  style="border: 1px solid #bbbebf;">--%>
                        <%--<tr style="border: 1px solid #bbbebf;">--%>
                            <%--<td class="col-xs-6 col-sm-3 placeholder" ><a href="#"> <img class="img-circle" style='border-radius:75px;width:150px;height:150px' alt="Generic placeholder thumbnail" src="img/dishes.jpg"></a></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                            <%--<td class="col-xs-6 col-sm-3"><img data-src="holder.js/200x200/auto/vine" class="img-circle" alt="Generic placeholder thumbnail" style='border-radius:75px;width:150px;height:150px' src="img/dishes.jpg"></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr style="border: 1px solid #bbbebf;">--%>
                            <%--<td class="col-xs-6 col-sm-3 placeholder" ><a href="#"> <img class="img-circle" style='border-radius:75px;width:150px;height:150px' alt="Generic placeholder thumbnail" src="img/dishes.jpg"></a></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                            <%--<td class="col-xs-6 col-sm-3"><img data-src="holder.js/200x200/auto/vine" class="img-circle" alt="Generic placeholder thumbnail" style='border-radius:75px;width:150px;height:150px' src="img/dishes.jpg"></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr style="border: 1px solid #bbbebf;">--%>
                            <%--<td class="col-xs-6 col-sm-3 placeholder" ><a href="#"> <img class="img-circle" style='border-radius:75px;width:150px;height:150px' alt="Generic placeholder thumbnail" src="img/dishes.jpg"></a></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                            <%--<td class="col-xs-6 col-sm-3"><img data-src="holder.js/200x200/auto/vine" class="img-circle" alt="Generic placeholder thumbnail" style='border-radius:75px;width:150px;height:150px' src="img/dishes.jpg"></td>--%>
                            <%--<td><span class="glyphicon glyphicon-chevron-right"></span></td>--%>
                            <%--<td class="col-xs-6 col-sm-3">--%>
                                <%--<h4>鱼香肉丝</h4><br>--%>
                                <%--<span class="text-muted">色香味俱全，顾客都喜欢</span>--%>
                            <%--</td>--%>
                        <%--</tr>--%>

                    <%--</table>--%>
                <%--</div>--%>

            <%--<button class="col-sm-offset-10"  id="moreDishes">--%>
                <%--更多菜品<span class="glyphicon glyphicon-chevron-right"></span>--%>
            <%--</button>--%>
        <%--</div>--%>
    <%--</div>--%>

    <!-- 脚部 -->
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
</div>
</div>
<br>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- 模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title " id="myModalLabel"><strong>订单详情</strong></h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid" style="padding: 0px 0px;">
                    <div class="row-fluid">
                        <table class="table-bordered table table-striped table-hover">
                            <tr>
                                <td style="width:50%">
                                    桌号
                                </td>
                                <td id="tableId">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    开始时间
                                </td>
                                <td id="orderBeginDate">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    结餐时间
                                </td>
                                <td id="orderEndDate">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    点餐服务员
                                </td>
                                <td id="userAccount">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    总价（元）
                                </td>
                                <td id="sum">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="panel panel-info" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">该桌的订单详情如下</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>菜品</th>
                                <th>单价</th>
                                <th>数量</th>
                            </tr>
                            </thead>
                            <tbody id="thisOrderDishes">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary addUserAndDishes" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>

</html>

