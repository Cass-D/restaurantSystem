<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:13
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

    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/ajax.js"></script>
    <script src="js/jquery-form.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            // bind 'myForm' and provide a simple callback function
            $('#myForm').ajaxForm(function (data) {
                document.getElementById('dishesImg').value = data;
                document.getElementById('face').src = "img/" + data;
            });
        });

        function check() {
            if (document.getElementById("dishesName").value == "") {
                alert("请输入菜品名称！");
                document.forms.amendDishesForm.dishesName.focus();
                return false;
            }
            if (ajaxRequest2("/checkDishes?dishesName=" + document.forms.amendDishesForm.dishesName.value, "post", false) == "true" && document.getElementById("dishesName").value !="<%=new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8")%>") {
                alert("该菜品已存在！");
                document.forms.amendDishesForm.dishesName.focus();
                return false;
            }
            if (document.forms.amendDishesForm.dishesName.value.length > 20) {
                alert("菜品名称不要超过20个字符！");
                document.forms.amendDishesForm.dishesName.focus();
                return false;
            }
            if (document.forms.amendDishesForm.dishesDiscript.value.length > 200) {
                alert("菜品简介不要超过200个字符！");
                document.forms.amendDishesForm.dishesDiscript.focus();
                return false;
            }
            if (document.forms.amendDishesForm.dishesTxt.value.length > 400) {
                alert("菜品说明不要超过400个字符！");
                document.forms.amendDishesForm.dishesDiscript.focus();
                return false;
            }
            if (document.forms.amendDishesForm.dishesPrice.value == "") {
                alert("请输入价格！");
                document.forms.amendDishesForm.dishesPrice.focus();
                return false;
            }
            if (!/^(-?\d+)(\.\d+)?$/.test(document.forms.amendDishesForm.dishesPrice.value)) {
                alert("菜品价格请输入正确的数字格式！");
                document.forms.amendDishesForm.dishesPrice.focus();
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
                <a href="#" role="button" aria-haspopup="true"
                   aria-expanded="false">
                    <span class="glyphicon glyphicon-user navFont">&nbsp当前用户：<shiro:principal/></span>
                    <span class="caret navFont"></span>
                </a>
            </li>
            <li class="" style="padding-right:35px; ">
                <a href="adminMain.jsp"><span class="navFont">返回主界面</span></a>
            </li>
        </ul>
    </div>
</nav>

<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-1 main container">
    <%--<div class="container" style="width:100%">--%>
    <div class="row" style="padding-top: 0px">
        <div style="width: 55%;display: inline-block;">
            <div>
                <h2>请填写菜品信息：</h2>
                <p>请在下面的表单中填写新增加的菜品名称、价格等描述信息</p>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <i class="icon-warning-sign"></i>&nbsp;注意事项
                    </div>
                    <div class="panel-body">
                        请正确填写菜品描述信息，菜品名称不要超过20个字符，菜品简介不要超过200个字符，菜品详细描述不要超过400个字符，菜品价格请输入正确的数字格式
                    </div>
                </div>
                <p>
                <form class="form-horizontal" name="amendDishesForm" role="form" style="margin-top: 20px" method="post"
                      action="<%=request.getContextPath()%>/dishesUpDate">
                    <icss:token></icss:token>

                    <div class="form-group">
                        <label for="dishesName" class="col-sm-2 control-label">名&nbsp;&nbsp;&nbsp;&nbsp;称:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="dishesName"
                                   value="<%=new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8")%>"
                                   size="20" name="dishesName" placeholder="请输入菜品名称">
                        </div>
                        <div style="color: red;float: right;" id="nameerror"></div>
                    </div>
                    <div class="form-group">
                        <label for="dishesName" class="col-sm-2 control-label">分&nbsp;&nbsp;&nbsp;&nbsp;类:</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="type">
                                <option value="主菜">主菜</option>
                                <option value="小食">小食</option>
                                <option value="汤水">汤水</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dishesDiscript"
                               class="col-sm-2 control-label">简&nbsp;&nbsp;&nbsp;&nbsp;介:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="dishesDiscript"
                                   value="<%=new String(request.getParameter("discript").getBytes("ISO-8859-1"),"UTF-8")%>"
                                   name="dishesDiscript" placeholder="请输入少于100字的简介">
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="dishesTxt" class="col-sm-2 control-label">说&nbsp;&nbsp;&nbsp;&nbsp;明:</label>
                        <div class="col-sm-10">
                                <textarea rows="8" class="form-control" id="dishesTxt"
                                          name="dishesTxt"><%=new String(request.getParameter("txt").getBytes("ISO-8859-1"), "UTF-8")%></textarea>
                        </div>
                        <div style="color: red;float: right;" id="passerror"></div>
                    </div>
                    <div class="form-group">
                        <label for="dishesPrice" class="col-sm-2 control-label">价&nbsp;&nbsp;&nbsp;&nbsp;格:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="dishesPrice" name="dishesPrice"
                                   placeholder="请输入菜品价格" value="<%=request.getParameter("price")%>"
                                   onblur="checkprice()">
                        </div>
                        <div style="color: red;float: right;"></div>
                    </div>
                    <div class="form-group">
                        <label for="recommend" class="col-sm-2 control-label"></label>
                        <div class="col-sm-10">
                            <input type="checkbox" name="recommend" id="recommend"
                                   value="1" <%=Integer.parseInt(request.getParameter("recommend")) == 1 ? "checked=\"checked\"" : ""%>  />
                            <span style="font-size: 16px;font-weight: bold;">推荐菜品</span>
                        </div>
                        <div style="color: red;float: right;" id="priceerror"></div>
                    </div>
                    <input type="hidden" value="<%=request.getParameter("id")%>" id="dishesId" name="dishesId"/>
                    <input type="hidden" value="<%=request.getParameter("dishesImg")%>" id="dishesImg"
                           name="dishesImg"/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <input type="submit" class="btn btn-primary" id="addbtu" value="确认修改"
                                   onclick="return check()"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div style="width: 5%;display: inline-block;padding-top: 0px;margin-top: 0px;vertical-align: top;padding-left: 20px">
            <div style="background-color:#CCC; width:1px;height: 710px;margin-top: 0px"></div>
        </div>
        <div style="width: 25%;display: inline-block;vertical-align: top;">
            <h2>设置图片：</h2>
            <p style="margin-bottom: 10px">菜品图片上传成功后将在下面直接预览。</p>
            <div style="text-align: center;">
                <img src="<%="img/"+request.getParameter("dishesImg")%>" id="face" width="160px" height="160px"
                     class="img-circle" style="border:3px solid #CCC;"/>
                <p style="margin-top: 15px">当前菜品图像预览</p>
                <p style="margin-top: 15px">
                    为菜品指定新的图片，请选择图片文件后，点击<span style="color: red;font-weight: bold;">上传图片</span>按钮
                </p>
                <div>
                    <form class="form-inline" role="form" enctype="multipart/form-data" id="myForm"
                          action="<%=request.getContextPath()%>/servlet/UploadHandleServlet" target="submitform"
                          method="post">
                        <div class="form-group">
                            <label class="sr-only" for="inputfile">文件输入</label>
                            <input type="file" id="inputfile" name="uploadFile" style="width: 90px;">
                        </div>
                        <input type="submit" class="btn btn-primary" value="上传图片"/>
                    </form>
                </div>
            </div>
        </div>
        <%--</div>--%>
    </div>
    <iframe src="" width="0" height="0" style="display: none" name="submitform"></iframe>
    <div style="height:1px;width: 100%;background: #CCC;margin-bottom: 10px"></div>
    <footer>
        <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
    </footer>
</div>
</div>
<!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>

</html>

