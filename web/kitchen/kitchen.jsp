<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" type="text/css" href="../css/dashboard.css">
    <title>点餐系统</title>

    <script src="../js/ajax.js"></script>
    <script type="text/javascript">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            String faceimg = session1.getAttribute("faceimg").toString();
        %>

        setInterval("getOrderDishesList()","5000");

        function getOrderDishesList(){
            xmlAjaxRequest("/getOrderDishes", "post", true, null, showList, null, null);
            xmlAjaxRequest("/getNews", "post", true, null, showNews, null, null);
        }
        function showList(responseXml, obj) {
            var table = document.getElementById("orderTable");
            table.innerHTML = "";
            var orderdisheses = responseXml.getElementsByTagName("orderdishes");
            for ( var i = 0; i < orderdisheses.length; i++) {
                var orderdishes = orderdisheses[i];
                var attrs = orderdishes.childNodes;
                var odId;
                var dishesName;
                var tableId;
                var num;
                var cookingStatus;
                var waiterId;
                for ( var j = 0; j < attrs.length; j++) {
                    var attr = attrs[j];
                    if (attr.nodeName == "odId") {
                        odId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "dishesName") {
                        dishesName = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "tableId") {
                        tableId = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "num") {
                        num = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "cookingStatus") {
                        cookingStatus = attr.childNodes[0].nodeValue;
                    }
                    if (attr.nodeName == "waiterId") {
                        waiterId = attr.childNodes[0].nodeValue;
                    }
                }
                var newLine = ""
                +"  <td class='tableCenter'>"
                + tableId
                +"  </td>"
                +"  <td class='tableCenter'>"
                + dishesName
                +"  </td>"
                +"  <td class='tableCenter'>"
                + num
                +"  </td>"
                +"  <td class='tableCenter'>"
                +"          <input type='hidden' name='cookingStatus' value='" + cookingStatus + "'>"
                +"          <a class='" + getClass(cookingStatus) + "' style='width:80px;' onclick='deal("
                + "\"" + odId + "\",\"" + waiterId + "\",\"" + tableId + "\",\"" + dishesName + "\",this)'>" + getCooking(cookingStatus) + "</a>"
                +"  </td>"

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

        function getClass(cookingStatus){
            if (cookingStatus == 0){
                return "btn btn-primary";
            }
            if (cookingStatus == 1){
                return "btn btn-danger";
            }
        }

        function getCooking(cookingStatus){
            if (cookingStatus == 0){
                return "未烹饪";
            }
            if (cookingStatus == 1){
                return "正在烹饪";
            }
        }

        function deal(odId,waiterId,tableId,dishesName,obj){
            var cookingStatus = document.getElementsByName("cookingStatus")[obj.parentNode.parentNode.rowIndex-1];
            if (cookingStatus.value == 0) {
                obj.className = "btn btn-danger";
                obj.innerHTML = "正在烹饪";
                cookingStatus.value = 1;
                ajaxRequest("/setCookingStatus?odId=" + odId + "&cookingStatus=" + 1, "post", true, null, null);

            }else{
                obj.className = "btn btn-success";
                obj.innerHTML = "完成烹饪";
                cookingStatus.value = 2;
                ajaxRequest("/setCookingStatus?odId=" + odId + "&cookingStatus=" + 2, "post", true, null, null);
                var content = "桌号["+tableId+"]的菜品["+dishesName+"]已经烹制完成，请传菜！";
                ajaxRequest("/sendDishNews?waiterId=" + waiterId + "&content=" + content, "post", true, null, null);
            }
        }

        function cookingStatus(obj){
            alert("sadf");
//            if (document.getElementsByName("cookingStatus")[obj.rowIndex])
        }

    </script>
</head>

<body onload="getOrderDishesList()">
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
                <span class="glyphicon glyphicon-home navFont"> <strong class=“systemTitle”>木叶村-餐厅到店点餐系统</strong>
                </span>
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
                <a href="/exit">
                    <span class="navFont">退出登录</span>
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- 详细内容 -->

<div class=" main">
    <div class="panel panel-primary" style="width: 50%;">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-comment" style="color: #FFFFFF;"></span>&nbsp 最新公告消息</h2>
        </div>
        <div class="panel-body" style="padding-bottom: 10px">
            <table class="table  table-hover" >
                <tbody id="news">
                </tbody>
            </table>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">顾客点餐列表</h3>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="tableCenter">桌号</th>
                        <th class="tableCenter">菜品</th>
                        <th class="tableCenter">数量</th>
                        <th class="tableCenter">操作</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">
                    <tr>
                        <td class="tableCenter">
                            1
                        </td>
                        <td class="tableCenter">
                            鱼香茄子
                        </td>
                        <td class="tableCenter">
                            2
                        </td>
                        <td class="tableCenter">
                            <input type="hidden" name="cookingStatus" value="0">
                            <a class="btn btn-primary" id="cooking" onload="cookingStatus(this.parentNode.parentNode)" style="width:80px;" onclick="deal();">未烹饪</a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
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
    <script type="text/javascript" src="../js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>
</div>
</body>

</html>
