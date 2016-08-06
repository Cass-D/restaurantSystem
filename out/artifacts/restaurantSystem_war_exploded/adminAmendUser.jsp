<%@ page import="org.apache.shiro.session.Session" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="org.apache.shiro.subject.Subject" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/5
  Time: 16:15
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
    <script src="js/jquery-form.js"></script>
    <script type="text/javascript">

        <%
            Subject subject = SecurityUtils.getSubject();
            Session session1 = subject.getSession();
            int roleId = Integer.parseInt(session1.getAttribute("roleId").toString());
        %>

        $(document).ready(function () {
            // bind 'myForm' and provide a simple callback function
            $('#myForm').ajaxForm(function (data) {
                document.getElementById('faceimg').value = data;
                document.getElementById('face').src = "img/" + data;
            });
        });

        function check(form) {
            if (document.forms.amendUserForm.userPass.value == "") {
                alert("请输入密码！");
                document.forms.amendUserForm.userPass.focus();
                return false;
            }
            if (document.forms.amendUserForm.userPass1.value == "") {
                alert("请确认密码！");
                document.forms.amendUserForm.userPass1.focus();
                return false;
            }
            if (document.forms.amendUserForm.userPass1.value != document.forms.amendUserForm.userPass.value) {
                alert("输入的密码不一致！");
                document.forms.amendUserForm.userPass.value = null;
                document.forms.amendUserForm.userPass1.value = null;
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
<div class="container">
    <div class="row" style="padding-top: 0px">
        <div style="width: 50%;display: inline-block;">
            <div>
                <h2>您可以在此修改员工的账户信息：</h2>
                <p>请在下面的界面中修改员工的密码（管理员不需要提供现密码用于认证），员工的账号名信息由餐厅管理员指定后，不能修改</p>
                <div class="panel panel-info">
                    <div class="panel-heading"><i class="icon-warning-sign"></i> &nbsp;注意事项
                    </div>
                    <div class="panel-body">两次输入的新密码必须一致，否则系统拒绝修改用户，如果不在左边的界面中修改自定义的头像，将继续使用用户原有的头像图片。</div>
                </div>
                <p>
                <form class="form-horizontal" role="form" style="margin-top: 20px" method="post"
                      action="<%=request.getContextPath()%>/userUpDate" name="amendUserForm">
                    <icss:token></icss:token>
                    <input type="hidden" name="userId" id="userId" value="<%=request.getParameter("id")%>"/>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">用户名:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="firstname" name="userAccount"
                                   placeholder="请输入新员工的用户名" disabled="disabled"
                                   value="<%=new String(request.getParameter("userAccount").getBytes("ISO-8859-1"),"UTF-8")%>">
                        </div>
                        <div style="color: red;float: right;">员工的用户名由系统管理员指定后，不能修改</div>
                    </div>
                    <div class="form-group">
                        <label for="userPass" class="col-sm-2 control-label">新密码:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="userPass" name="userPass"
                                   placeholder="请输入新员工的密码"
                                   value="<%=new String(request.getParameter("userPass").getBytes("ISO-8859-1"),"UTF-8")%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userPass1" class="col-sm-2 control-label">确&nbsp;&nbsp;&nbsp;&nbsp;认:</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="userPass1" name="userPass1"
                                   placeholder="请再次输入新员工的密码"
                                   value="<%=new String(request.getParameter("userPass").getBytes("ISO-8859-1"),"UTF-8")%>">
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
                    <input type="hidden" value="<%=request.getParameter("faceimg")%>" id="faceimg" name="faceimg"/>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <input type="submit" class="btn btn-primary" id="addbtu" value="确认修改"
                                   onclick="return check(this)"/>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div style="width: 5%;display: inline-block;padding-top: 0px;margin-top: 0px;vertical-align: top;padding-left: 20px">
            <div style="background-color:#CCC; width:1px;height: 540px;margin-top: 0px"></div>
        </div>
        <div style="width: 40%;display: inline-block;vertical-align: top;">
            <h2>您可以为员工设置新的头像信息：</h2>
            <p style="margin-bottom: 10px">您选择的新头像图片上传成功后将在下面直接预览。</p>
            <div style="text-align: center;">
                <img src=<%="img/"+request.getParameter("faceimg")%> id="face" width="200px" height="200px"
                     class="img-circle" style="border:1px solid #CCC;box-shadow:0 0 10px rgba(100, 100, 100, 1);"/>
                <p style="margin-top: 15px">当前的头像预览</p>
                <p style="margin-top: 15px">
                    更新头像图片，请选择头像文件后，点击
                    <span style="color: red;font-weight: bold;">更新头像图片</span> 按钮，上传头像后需要点击左侧
                    <span style="color: red;font-weight: bold;">确定修改</span> 按钮才能生效
                </p>
                <div>
                    <form class="form-inline" id="myForm" role="form" enctype="multipart/form-data"
                          action="<%=request.getContextPath()%>/servlet/UploadHandleServlet" name="imgform"
                          target="submitform" method="post">
                        <div class="form-group">
                            <label class="sr-only" for="inputfile">文件输入</label>
                            <input type="file" id="inputfile" name="uploadFile">
                        </div>
                        <input type="submit" class="btn btn-primary" value="更新用户头像"/>
                    </form>
                </div>
            </div>
        </div>
        <hr style="border-color: #C0BDBD">
        <footer>
            <p>&copy; ${ORDER_SYS_NAME}-木叶村-餐厅到店点餐系统</p>
        </footer>
        <!-- 将外部文件引入放在最后面这里更多为了提高用户体验，不必像传统的放前面后必须加载完后页面才显示内容，延缓了页面响应 -->
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
</body>

</html>

