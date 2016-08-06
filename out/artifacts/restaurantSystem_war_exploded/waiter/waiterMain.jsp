<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.session.Session" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/15
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" type="text/css" href="../css/dashboard.css">
    <title>点餐系统</title>

    <script src="/js/ajax.js"></script>
    <script type="text/javascript">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            int id = Integer.parseInt(session1.getAttribute("userId").toString());
            String faceimg = session1.getAttribute("faceimg").toString();
        %>
        var id = <%=session1.getAttribute("userId").toString()%>;

        getDishNews();
        setInterval("getDishNews()","5000");

        function getDishNews(){
            xmlAjaxRequest("/getDishNews?waiterId="+id, "post", true, null, showDishNewsList, null, null);
            xmlAjaxRequest("/getNews", "post", true, null, showNews, null, null);
        }
        function showDishNewsList(responseXml, obj){
            var table = document.getElementById("dishNews");
            table.innerHTML = "";
            var dishNews = responseXml.getElementsByTagName("dishNew");
            for ( var i = 0; i < dishNews.length; i++) {
                var dishNew = dishNews[i];
                var attrs = dishNew.childNodes;
                var dateTime;
                var content;
                for ( var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "dateTime") {
                        dateTime = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "content") {
                        content = attr.childNodes[0].nodeValue;
                    }
                }
                var newLine = "<tr>"
                +  "<td class='tableCenter' style='width: 15%;'>"
                +      "<span style='width:500px;height:80px;'>" + dateTime + "</span>"
                +  "</td>"
                +  "<td style='width: 35%;'>"
                +      "<span style='width:500px;height:80px;'>" + content + "</span>"
                +  "</td>"
                +"</tr>";

                table.innerHTML += newLine;
            }
        }
        function showNews(responseXml, obj){
            var table = document.getElementById("news");
            table.innerHTML = "";
            var news = responseXml.getElementsByTagName("dishNew");
            var New = news[0];
            var attrs = New.childNodes;
            var dateTime;
            var content;
            for ( var i = 0; i < attrs.length; i++) {
                var attr = attrs[i];
                if (attr.nodeName == "dateTime") {
                    dateTime = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "content") {
                    content = attr.childNodes[0].nodeValue;
                }
            }
            var newLine = "<tr>"
                    +  "<td class='tableCenter' style='width: 20%;'>"
                    +      "<span style='width:500px;height:80px;'>" + dateTime + "</span>"
                    +  "</td>"
                    +  "<td style='width: 30%;'>"
                    +      "<span style='width:500px;height:80px;'>" + content + "</span>"
                    +  "</td>"
                    +"</tr>";

            table.innerHTML += newLine;
        }

        function getOrderList() {
            xmlAjaxRequest("/getWaiterOrder?id="+id, "post", true, null, showList, null, null);
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
                    if (attr.nodeName == "userAccount") {
                        userAccount = attr.childNodes[0].nodeValue;
                    }
                }

                var newLine = "<tr>"
                    + "<td class=\"tableCenter\">"
                    + tableId
                    +"</td>"
                    +"<td class=\"tableCenter\">"
                    + userAccount
                    +"</td>"
                    +"<td class=\"tableCenter\">"
                    + orderBeginDate
                    + "</td>"
                    + "<td class=\"tableCenter\">"
                    + "    <a herf=\"#\" onclick='toOrderDishes(" + orderId + ")'><p class=\"btn btn-primary btn-sm\" style=\"width:60px;\">点菜</p></a>"
                    + "    <a herf=\"#\" ><p class=\"btn btn-primary btn-sm\" onclick='dishesDetails("
                    + "\""+orderId+"\",\""+tableId+"\",\""+orderBeginDate+"\",\""+userAccount+"\",\""+"\")' style=\"width:60px;\">查看</p></a>"
                    + "    <a herf=\"#\"><p class=\"btn btn-primary btn-sm\" onclick='checkOut("
                    + orderId + ")' style=\"width:60px;\">买单</p></a>"
                    +"</td>"
                +"</tr>";

                table.innerHTML += newLine;
            }
        }

        function toOrderDishes(orderId){
            window.location.href = "/waiter/waiterDishes-main.jsp?orderId="+orderId;
        }

        function newOrder(waiterId, tableId){
            if ( tableId != "0"){
                if (confirm("是否生成新订单？")) {
                    ajaxRequest("/orderInsert?tableId=" + tableId + "&waiterId=" + waiterId, "post", true, getOrderList, null);
                }
            }else {
                alert("请选择桌号");
            }
        }

        function checkOut(orderId) {
            ajaxRequest("/checkOut?orderId=" + orderId, "post", true, getOrderList, null)
        }

        function dishesDetails(orderId,tableId,orderBeginDate,userAccount) {
            document.getElementById("tableId2").innerHTML = tableId;
            document.getElementById("orderBeginDate").innerHTML = orderBeginDate;
            document.getElementById("userAccount").innerHTML = userAccount;
            getThisOrderDishes(orderId);

            $("#myModal").modal("show");
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
                var odId;
                var dishesName;
                var dishesPrice;
                var num;
                var cookingStatus;
                for ( var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "odId") {
                        odId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesName") {
                        dishesName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesPrice") {
                        dishesPrice = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "num") {
                        num = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "cookingStatus") {
                        cookingStatus = attr.childNodes[0].nodeValue;
                    }
                }

                var newLine = "<td class='tableCenter'>" + dishesName + "</td>"
                +  "<td class='tableCenter'>" + dishesPrice + "</td>"
                +  "<td class='tableCenter'>" + num + "</td>"
                +  "<td class='tableCenter'>" + getCookingStatus(cookingStatus) + "</td>"
                +  "<td class='tableCenter'><div class='btn btn-xs btn-danger' onclick='dishesCancel("
                + "\"" + cookingStatus + "\",\"" + odId + "\",this)'>取消</div></td>"

                table.innerHTML += newLine;
            }
        }

        function getCookingStatus(cookingStatus){
            if (cookingStatus == 0){
                return "未烹饪";
            }else if (cookingStatus == 1){
                return "正在烹饪";
            }else{
                return "烹饪完成";
            }
        }

        function dishesCancel(cookingStatus,odId,obj){
            if (cookingStatus > 0){
                alert("该菜品已烹饪");
            }else{
                if (confirm("是否取消该菜品？")){
                    xmlAjaxRequest("/orderDishesDelete?odId=" + odId, "post", true, null, deleteCallback, obj, null);
                }
            }
        }
        function deleteCallback(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

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
                <span class="glyphicon glyphicon-home navFont"> <strong class=“systemTitle”>木叶村-餐厅到店点餐系统</strong>
                </span>
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
                        <a href="/adminAmendOwnUser.jsp">修改个人信息</a>
                    </li>
                    <li role="separator" class="divider"></li>
                </ul>
            </li>
            <li class="" style="padding-right:35px; ">
                <a href="/exit">
                    <span class="navFont">退出登录</span>
                </a>
            </li>
        </ul>
    </div>
</nav>
<!-- 右边详细内容 -->
<!-- <div class="container">
-->
<div class=" main">
    <div class="panel panel-primary" style="width: 50%;height:204px;position: relative;float: left;display: inline;">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-comment" style="color: #FFFFFF;"></span>&nbsp
                最新传菜消息</h2>
        </div>
        <div class="panel-body" style="padding-bottom: 10px">
            <table class="table  table-hover" >
                <tbody id="dishNews">
                <tr>
                    <td class="tableCenter">
                        <span style="width:500px;height:80px;"></span>
                    </td>
                    <td class="tableCenter">
                        <span style="width:500px;height:80px;"></span>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>
    <div class="panel panel-primary" style="width: 48%;height:204px;position: relative;float: right;display: inline;">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-comment" style="color: #FFFFFF;"></span>&nbsp
                最新公告消息</h2>
        </div>
        <div class="panel-body" style="padding-bottom: 10px">
            <table class="table  table-hover" >
                <tbody id="news">

                </tbody>
            </table>

        </div>
    </div>
    <div class="panel panel-primary" style="clear: both;">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-th-list" style="color: #FFFFFF;"></span>&nbsp
                顾客点餐列表
                <select type="text" id="tableId" name="tableId" style="margin-left:900px;color:#030303;height:30px;">
                    <option value="0">请选择桌号...</option>
                    <option value="1">1号桌</option>
                    <option value="2">2号桌</option>
                    <option value="3">3号桌</option>
                    <option value="4">4号桌</option>
                    <option value="5">5号桌</option>
                    <option value="6">6号桌</option>
                    <option value="7">7号桌</option>
                    <option value="8">8号桌</option>
                    <option value="9">9号桌</option>
                    <option value="10">10号桌</option>
                    <option value="11">11号桌</option>
                    <option value="12">12号桌</option>
                    <option value="13">13号桌</option>
                    <option value="14">14号桌</option>
                    <option value="15">15号桌</option>
                    <option value="16">16号桌</option>
                    <option value="17">17号桌</option>
                    <option value="18">18号桌</option>
                    <option value="19">19号桌</option>
                    <option value="20">20号桌</option>
                    <option value="21">21号桌</option>
                </select>
                <a href="#" onclick="newOrder('<%=id%>',document.getElementById('tableId').value)" class="btn btn-default btn-sm" style="color:#000000;">新订单</a>
            </h2>
        </div>
        <div class="panel-body">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                <tr>
                    <th class="tableCenter">
                        桌号
                    </th>
                    <th class="tableCenter">
                        服务员
                    </th>
                    <th class="tableCenter">
                        开餐时间
                    </th>
                    <th class="tableCenter">
                        操作
                    </th>
                </tr>
                </thead>

                <tbody id="orderTable">
                <tr>
                    <td class="tableCenter">
                        1
                    </td>
                    <td class="tableCenter">
                        小a
                    </td>
                    <td class="tableCenter">
                        2016-6-14 09:00
                    </td>
                    <td class="tableCenter">
                        <a herf="#"><p class="btn btn-primary btn-sm" style="width:60px;">点菜</p></a>
                        <a herf="#"><p class="btn btn-primary btn-sm" style="width:60px;">查看</p></a>
                        <a herf="#"><p class="btn btn-primary btn-sm" style="width:60px;">买单</p></a>
                    </td>
                </tr>
                </tbody>


            </table>
        </div>
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
    <br>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
    <!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script type="text/javascript" src="/js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
</div>
<!-- 模态框 -->
<!-- Modal -->
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
                                <td id="tableId2">
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
                                    点餐服务员
                                </td>
                                <td id="userAccount">
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
                        <table class="table table-striped table-bordered">
                            <thead>
                            <tr>
                                <th class="tableCenter">菜品</th>
                                <th class="tableCenter">单价</th>
                                <th class="tableCenter">数量</th>
                                <th class="tableCenter">状态</th>
                                <th class="tableCenter">操作</th>
                            </tr>
                            </thead>
                            <tbody id="thisOrderDishes">
                            <tr>
                                <td class="tableCenter">鱼香肉丝</td>
                                <td class="tableCenter">￥:50.00</td>
                                <td class="tableCenter">1</td>
                                <td class="tableCenter">未烹饪</td>
                                <td class="tableCenter"><div class="btn btn-ms btn-danger">取消</div>></td>
                            </tr>
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