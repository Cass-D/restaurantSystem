<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/15
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" type="text/css" href="../css/dashboard.css">
    <title>点餐系统</title>


</head>

<body onload="getDishesList('主菜')">
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
                <a href="#" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-user navFont">&nbsp当前用户：<shiro:principal/></span>
                    <span class="caret navFont"></span>
                </a>
            </li>
            <li class="" style="padding-right:35px; ">
                <a href="/waiter/waiterMain.jsp">
                    <span class="navFont">返回</span>
                </a>
            </li>
        </ul>
    </div>
</nav>
<!-- 左边 -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2.5 sidebar">
            <form action="/placeAnOrder?orderId=<%=request.getParameter("orderId")%>" method="post">
                <table class="table table-striped table-bordered" id="waiterTable">
                    <thead>
                    <tr>
                        <th class="tableCenter">
                            数量
                        </th>
                        <th class="tableCenter">
                            已点菜品列表
                        </th>
                    </tr>
                    </thead>
                    <tbody id="cart">
                    <tr v-for="item in dishes">
                        <td class='tableCenter'>
                            <input type='hidden' name="id" value='{{item.id}}'/>
                            <input type="button" value="-" onclick="reduce('{{$index}}')"/>
                            <input type="text" name="number" v-model="item.number" style="width:23px;"/>
                            <input type="button" value="+" onclick="add('{{$index}}')">
                        </td>
                        <td class='tableCenter'>
                            {{item.name}}
                        </td>

                    </tr>

                    </tbody>

                </table>
                <p class="btn btn-primary" onclick="sub(this.parentNode)">确认下单</p>
            </form>


        </div>
    </div>
</div>
<!-- 右边详细内容 -->
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-comment" style="color: #FFFFFF;"></span>&nbsp
                最新公告消息</h2>
        </div>
        <div class="panel-body" style="padding-bottom: 10px">
            <textarea style="width:500px;height:80px;"></textarea>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h2 class="panel-title"><span class="glyphicon glyphicon-align-justify"></span>&nbsp 菜品清单

            </h2>
        </div>
        <nav>
            <ul class="pager">
                <li><a href="#" onclick="getDishesList('主菜')">主菜</a></li>
                <li><a href="#" onclick="getDishesList('小食')">小食</a></li>
                <li><a href="#" onclick="getDishesList('汤水')">汤水</a></li>
            </ul>
        </nav>
        <div class="panel-body" style="padding-bottom: 0px">
            <div class="row placeholders" id="dishesTable">

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
    <script type="text/javascript" src="/js/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
</div>
<!-- 模态框 -->
<!-- Modal -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">详细信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-primary" style="margin-top: 10px">
                    <div class="panel-heading">
                        <h3 class="panel-title">菜品详情</h3>
                    </div>
                    <div class="panel-body">
                        <div style="text-align: center;">
                            <img src="" id="dishesImg" width="200px" height="200px"
                                 class="img-circle"
                                 style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                        </div>
                        <p>
                        <h2 style="text-align: center;">
                            菜品名称： <span id="dishesName"></span>
                        </h2>
                        <h3 style="text-align: center;">
                            <span style="color: red;font-weight: bold;" id="recommend"></span>
                        </h3>
                        <hr/>
                        <p>
                        <h3>
                            菜品分类：
                        </h3>
                        <p><span id="dishesType"></span></p>
                        <h3>菜品简介：</h3>
                        <p>
                            <span id="dishesDiscript"></span>
                        </p>
                        <p>
                        <h3>菜品描述：</h3>
                        <p>
                            <span id="dishesTxt"></span>
                        </p>
                        <h3>
                            菜品价格：<span id="dishesPrice"> </span> (元)
                        </h3>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
            <iframe name="formtarget" width="0" height="0" style="display: none"></iframe>
        </div>
    </div>
</div>

<script src="/js/ajax.js"></script>
<script src="/js/vue.min.js"></script>
<script type="text/javascript">

    function getDishesList(dishesType) {
        xmlAjaxRequest("/getDishes?dishesType="+dishesType, "post", true, null, showList, null, null);
    }

    function showList(responseXml, obj) {
        var table = document.getElementById("dishesTable");
        table.innerHTML = "";
        var disheses = responseXml.getElementsByTagName("dishes");
        for (var i = 0; i < disheses.length; i++) {
            var dishes = disheses[i];
            var attrs = dishes.childNodes;
            var dishesId;
            var dishesName;
            var dishesType;
            var dishesDiscript;
            var dishesImg;
            var dishesTxt;
            var recommend;
            var dishesPrice;
            for (var j = 0; j < attrs.length; j++) {
                var attr = attrs[j];
                if (attr.nodeName == "dishesId") {
                    dishesId = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesType") {
                    dishesType = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesName") {
                    dishesName = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesDiscript") {
                    dishesDiscript = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesImg") {
                    dishesImg = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesTxt") {
                    dishesTxt = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "recommend") {
                    recommend = attr.childNodes[0].nodeValue;
                }
                if (attr.nodeName == "dishesPrice") {
                    dishesPrice = attr.childNodes[0].nodeValue;
                }
            }

            var subDiscript = dishesDiscript;
//                var subRecommend = recommend == 1 ? "<span style='color: red;font-size: 12px'><i class='icon-heart '></i></span>&nbsp;"
//                        : "";
            var newLine = "<div class=\"col-md-4\">"
                    + "    <table class=\"dishesTable\">"
                    + "        <tr>"
                    + "            <td rowspan=\"3\" class=\"tableCenter\"   onclick=\"dishesDetails("
                    + "'" + dishesImg + "','" + dishesName + "','" + dishesDiscript + "','" + dishesTxt + "','" + dishesPrice + "','" + dishesType + "')\">"
                    + "                <img src=\"/img/" + dishesImg + "\" class=\"waiterDishesImg\">"
                    + "            </td>"
                    + "            <td class=\"dishesName dishesTable\" style=\"vertical-align: middle;text-align: center;border: 1px solid #A9A9A9;\">"
                    + dishesName
                    + "            </td>"
                    + "        </tr>"
                    + "        <tr>"
                    + "            <td class=\"dishesPrice dishesTable tableCenter\" style=\"vertical-align: middle;text-align: center;border: 1px solid #A9A9A9;\">"
                    + "￥" + dishesPrice
                    + "            </td>"
                    + "        </tr>"
                    + "        <tr>"
                    + "            <td class=\"tableCenter dishesTable tableCenter\" style=\"vertical-align: middle;text-align: center;border: 1px solid #A9A9A9;\">"
                    + "                <button href=\"#\" class=\"btn btn-primary\" onclick='addCart(\"" + dishesId + "\",\"" + dishesName + "\")'> 加入购物车</button>"
                    + "            </td>"
                    + "        </tr>"
                    + "    </table>"
                    + "</div>"

            table.innerHTML += newLine;

        }
    }

    var mydishes = [];

    var dishesList = new Vue({
        el: "#cart",
        data: {
            dishes: mydishes
        }
    });
    function addCart(dishesId, dishesName) {

        var length = mydishes.length;
        var existed = false;
        for (var i = 0; i < length; i++) {
            if (mydishes[i].id == dishesId) {
                mydishes[i].number++;
                existed = true;
                break;
            }
        }
        if(! existed){
            mydishes.push({id:dishesId, name:dishesName, number:1});
        }

        /*  var tr = document.getElementById("cart").insertRow();

         tr.innerHTML = "<tr>"
         +"      <td class='tableCenter'>"
         +"      <input type='hidden' value='" + dishesId + "'name='" + setName() + "'>"
         +"      <input type='button' value='-' name='" + setName() + "'onclick='reduceCount(this)'>"
         +"      <input type='text' name='" + setName() + "' value='1' style='width:23px;'>"
         +"      <input type='button' value='+' name='" + setName() + "'onclick='addCount(this)'>"
         +"      </td>"
         +"      <td class='tableCenter' >"
         + dishesName
         +"      </td>"
         +"      </tr>";*/
    }

    function add(index){
        mydishes[index].number++ ;
    }
    function reduce(index,obj){
        if (mydishes[index].number>0){
            mydishes[index].number-- ;
        }
    }

/*    function setName() {
        i += 1;
        return i - 1;
    }

    function addCount(obj) {
        var count = document.getElementsByName(parseInt(obj.name) - 1)[0];
        count.value = parseInt(count.value) + 1;
    }

    function reduceCount(obj) {
        var count = document.getElementsByName(parseInt(obj.name) + 1)[0];
        if (count.value > 1) {
            count.value = parseInt(count.value) - 1;
        } else {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }
    }*/

    function dishesDetails(dishesImg,dishesName,dishesDiscript,dishesTxt,dishesPrice,dishesType) {
        document.getElementById("dishesImg").src = "/img/"+dishesImg;
        document.getElementById("dishesName").innerHTML = dishesName;
        document.getElementById("dishesDiscript").innerHTML = dishesDiscript;
        document.getElementById("dishesTxt").innerHTML = dishesTxt;
        document.getElementById("dishesPrice").innerHTML = dishesPrice;
        document.getElementById("dishesType").innerHTML = dishesType;
        $('#myModal1').modal('show');
    }

    function sub(obj) {
        obj.submit();
    }

</script>

</body>

</html>
