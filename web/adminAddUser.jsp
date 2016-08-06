<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>

    <script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
    <script src="js/jquery-form.js"></script>
    <script src="js/ajax.js"></script>
    <script type="text/javascript" charset="UTF-8">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            int roleId = Integer.parseInt(session1.getAttribute("roleId").toString());
        %>

        $(document).ready(function() {
            // bind 'myForm' and provide a simple callback function
            $('#myForm').ajaxForm(function(data) {
                document.getElementById('faceimg').value = data;
                document.getElementById('face').src = "img/"+data;
            });
        });

        function check() {
            if (ajaxRequest2("/checkUser?userAccount="+document.forms.addUserForm.userAccount.value, "post", false) == "true") {
                alert("用户名已存在！");
                document.forms.addUserForm.userAccount.focus();
                return false;
            }
            if (document.forms.addUserForm.userAccount.value == "") {
                alert("请输入用户名！");
                document.forms.addUserForm.userAccount.focus();
                return false;
            }
            if (document.forms.addUserForm.userPass.value == "") {
                alert("请输入密码！");
                document.forms.addUserForm.userPass.focus();
                return false;
            }
            if (document.forms.addUserForm.userPass1.value == "") {
                alert("请确认密码！");
                document.forms.addUserForm.userPass1.focus();
                return false;
            }
            if (document.forms.addUserForm.userPass1.value != document.forms.addUserForm.userPass.value) {
                alert("输入的密码不一致！");
                document.forms.addUserForm.userPass.value = null;
                document.forms.addUserForm.userPass1.value = null;
                return false;
            }
        }
    </script>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    <title>点餐系统</title>
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
<div class="container">
    <div class="row" style="padding-top: 0px">
        <div style="width: 50%;display: inline-block;">
            <div>
                <h2>请填写员工账户信息：</h2>
                <p>请在下面的表单中填写新增加的员工所使用的用户名及密码</p>
                <div class="panel panel-danger">
                    <div class="panel-heading"><i class="icon-warning-sign"></i>&nbsp;注意事项</div>
                    <div class="panel-body">
                        本系统中用户名唯一，即不能使用系统中已经存在的用户名，两次输入的密码必须一致，否则系统拒绝添加用户，如果不再左边的界面中为用户选择自定义的头像，用户将拥有系统默认的头像图片。
                    </div>
                </div>
                <p>

                <form class="form-horizontal" role="form" style="margin-top: 20px" method="post"
                      action="<%=request.getContextPath()%>/userInsert" name="addUserForm">
                    <icss:token></icss:token>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">用户名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="firstname" name="userAccount"
                                   placeholder="请输入新员工的用户名" style="text-align: left;">
                        </div>
                        <div style="color: red;float: right;" id="usererror"></div>
                    </div>
                    <div class="form-group">
                        <label for="userPass" class="col-sm-2 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="userPass" name="userPass"
                                   placeholder="请输入新员工的密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userPass1" class="col-sm-2 control-label">确&nbsp;&nbsp;&nbsp;&nbsp;认:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="userPass1" name="userPass1"
                                   placeholder="请再次输入新员工的密码" onblur="checkpass()">
                        </div>
                        <div style="color: red;float: right;" id="passerror"></div>
                    </div>
                <%
                    if (roleId == 1){
                %>
                <div class="form-group">
                    <label for="roleId" class="col-sm-2 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;色:</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="roleId" name="roleId">
                            <option value="2">管理员
                            </option>
                            <option value="3">点餐员
                            </option>
                            <option value="4">厨师
                            </option>
                        </select>
                    </div>
                </div>
                <%
                    }
                    if (roleId == 2){
                %>
                <div class="form-group">
                    <label for="roleId2" class="col-sm-2 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;色:</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="roleId2" name="roleId">
                            <option value="3">点餐员
                            </option>
                            <option value="4">厨师
                            </option>
                        </select>
                    </div>
                </div>
                <%
                    }
                %>
                    <input type="hidden" value="userIcon.jpg" id="faceimg" name="faceimg"/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <input type="submit" class="btn btn-primary" id="addbtu" value="添加用户"
                                   onclick="return check();"/>

                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div style="width: 5%;display: inline-block;padding-top: 0px;margin-top: 0px;vertical-align: top;padding-left: 20px">
            <div style="background-color:#CCC; width:1px;height: 490px;margin-top: 0px"></div>
        </div>
        <div style="width: 40%;display: inline-block;vertical-align: top;">
            <h2>您可以为新员工设置头像：</h2>
            <p style="margin-bottom: 10px">您选择的头像图片上传成功后将可以在下面直接预览。</p>
            <div style="text-align: center;">
                <img src="img/userIcon.jpg" id="face" width="200px" height="200px" class="img-circle"
                     style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                <p style="margin-top: 15px">当前的头像预览</p>
                <p style="margin-top: 15px">
                    为员工指定新的头像图片，请选择头像文件后，点击<span style="color: red;font-weight: bold;">上传员工新头像</span>按钮
                </p>
                <div>
                    <form class="form-inline" id="myForm" role="form" enctype="multipart/form-data" action="<%=request.getContextPath()%>/servlet/UploadHandleServlet" name="imgform" target="submitform" method="post">
                        <div class="form-group">
                            <label class="sr-only" for="inputfile">文件输入</label>
                            <input type="file" id="inputfile" name="uploadFile">
                        </div>
                        <input type="submit" value="上传员工的新头像" />
                    </form>
                </div>
            </div>
        </div>
        <hr style="border-color: #C0BDBD">
        <footer>
            <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
        </footer>
    </div>
    <!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->

    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    </div>
</body>

</html>

