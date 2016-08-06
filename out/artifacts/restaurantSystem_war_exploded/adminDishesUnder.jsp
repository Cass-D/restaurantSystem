<><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:18
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
    <script type="text/javascript">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            String faceimg = session1.getAttribute("faceimg").toString();
        %>

        function checkRecover(id, name, obj) {
            msg = '是否将'+ name +'上架？';
            if (confirm(msg)) {
                xmlAjaxRequest("/dishesStatus?id=" + id + "&shelvesed=" + 1, "post", true, null, RecoverCallback, obj, null)
            }
        }

        function RecoverCallback(responseTxt, obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        }

        //显示菜品详情调用模态框
        function detail(name, discript, txt, price, img, dishesType) {
            var dishesName = document.getElementById("dishesName");
            var dishesDiscript = document.getElementById("dishesDiscript");
            var dishesTxt = document.getElementById("dishesTxt");
            var dishesPrice = document.getElementById("dishesPrice");
            var dishesImg = document.getElementById("dishesImg");
            var type = document.getElementById("type");
            type.innerHTML = dishesType;
            dishesImg.src = "img/" + img;
            dishesName.innerHTML = name;
            dishesDiscript.innerHTML = discript;
            dishesTxt.innerHTML = txt;
            dishesPrice.innerHTML = price;
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
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h3 class="panel-title">菜品列表</h3>
        </div>
        <div>
            <nav>
                <ul class="pager">
                    <li><a href="adminDishes.jsp" >上架菜品</a></li>
                    <li><a href="adminDishesUnder.jsp">下架菜品</a></li>
                </ul>
            </nav>
        </div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                    <tr>
                        <th class="tableCenter">菜品编号</th>
                        <th class="tableCenter">菜品名称</th>
                        <th class="tableCenter">菜品简介</th>
                        <th class="tableCenter">菜品价格</th>
                        <th class="tableCenter">是否推荐</th>
                        <th class="tableCenter">菜品状态</th>
                        <th class="tableCenter">操作</th>
                    </tr>
                    </thead>
                    <tbody id="orderTable">
                    <%
                        String sql = "SELECT dishesinfo.* FROM dishesinfo WHERE shelvesed=0";
                        Connection conn = JDBC.getConnection();
                        ResultSet rs = JDBC.select(sql,conn);
                        try {
                            while (rs.next()) {
                    %>
                    <tr>
                        <td class="tableCenter"><%=rs.getInt("dishesId")%></td>
                        <td class="tableCenter"><%=rs.getString("dishesName")%></td>
                        <td class="tableCenter"><%=rs.getString("dishesDiscript")%></td>
                        <td class="tableCenter"><%=rs.getFloat("dishesPrice")%></td>
                        <td class="tableCenter"><%=rs.getInt("recommend")==0?"非推荐":"推荐"%></td>
                        <td class="tableCenter"><%=rs.getInt("shelvesed")==0?"下架":"上架"%></td>
                        <td class="tableCenter">
                            <a href="adminAmendDishes.jsp?id=<%=rs.getInt("dishesId")%>&name=<%=rs.getString("dishesName")%>&discript=<%=rs.getString("dishesDiscript")%>&txt=<%=rs.getString("dishesTxt")%>&price=<%=rs.getString("dishesPrice")%>&recommend=<%=rs.getInt("recommend")%>&dishesImg=<%=rs.getString("dishesImg")%>" title="编辑菜品">
                                <span class="glyphicon glyphicon-cog"></span> &nbsp
                            </a>
                            <a href="#" title="查看菜品" onclick="detail('<%=rs.getString("dishesName")%>','<%=rs.getString("dishesDiscript")%>','<%=rs.getString("dishesTxt")%>','<%=rs.getFloat("dishesPrice")%>','<%=rs.getString("dishesImg")%>','<%=rs.getString("dishesType")%>')">
                                <span class="glyphicon glyphicon-list-alt"></span> &nbsp
                            </a>
                            <%--<a href="#" title="下架菜品">--%>
                                <%--<span class="glyphicon glyphicon-remove"></span> &nbsp--%>
                            <%--</a>--%>
                            <a href="#" title="菜品上架" onclick="checkRecover('<%=rs.getInt("dishesId")%>','<%=rs.getString("dishesName")%>',this)">
                            <span class="glyphicon glyphicon-play"></span>&nbsp
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                            rs.close();
                        }catch (Exception e){
                        }
                    %>

                    </tbody>
                </table>
                <nav style="text-align: center">
                    <ul class="pagination pagination-lg pager">
                        <li class="disabled">
                            <a  href="#" aria-label="Previous">
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
        <div style="text-align: center">
            如果您需要在系统中添加一个新菜品，请点击右边的按钮：
            <a href="adminAddDishes.jsp" class="btn btn-primary addUserAndDishes">添加菜品</a>
        </div>
    </div>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
</div>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<%--查看菜品详情的模态框--%>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
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
                            <img src="/img/userIcon.jpg" id="dishesImg" width="200px"
                                 height="200px" class="img-circle"
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
                        <p><span id="type">主菜</span></p>
                        <h3>
                            菜品简介：
                        </h3>
                        <p><span id="dishesDiscript"></span></p>
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
                <button type="button" class="btn btn-primary addUserAndDishes" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
</body>

</html>

</>