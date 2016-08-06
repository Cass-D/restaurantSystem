<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/6/22
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
    <title>餐厅点餐系统登录页面</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="style">
    <style type="text/css">
        html,
        body {
            height: 100%;
        }

        .loginBg {
            height: 680px;
            width: 100%;
            position: absolute;
            background-position: center center;
            background-size: cover;
            background-image: url("/img/loginImg.jpg") !important;
            opacity: 0.9;
        }

        .box {
            filter: progid: DXImageTransform.Microsoft.gradient(startColorstr='#6699FF', endColorstr='#6699FF');
            /*  IE */
            background-image: linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
            background-image: -o-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
            background-image: -moz-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
            background-image: -webkit-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
            background-image: -ms-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
            margin: 0 auto;
            position: relative;
        }

        .login-box {
            width: 100%;
            max-width: 500px;
            height: 450px;
            position: absolute;
            top: 50%;
            margin-top: -200px;
            /*设置负值，为要定位子盒子的一半高度*/
        }

        @media screen and (min-width:500px) {
            .login-box {
                left: 50%;
                /*设置负值，为要定位子盒子的一半宽度*/
                margin-left: -250px;
            }
        }

        .form {
            width: 100%;
            max-width: 500px;
            height: 300px;
            margin: 25px auto 0px auto;
            padding-top: 25px;
        }

        .login-content {
            height: 345px;
            width: 100%;
            max-width: 500px;
            background-color: rgba(255, 250, 2550, .6);
            float: left;
        }

        .input-group {
            margin: 0px 0px 30px 0px !important;
        }

        .form-control,
        .input-group {
            height: 40px;
        }

        .form-group {
            margin-bottom: 0px !important;
        }

        .login-title {
            padding: 20px 10px;
            background-color: #686565;
            opacity: 0.8;
            /*background-color: rgba(0, 0, 0, .6);*/
        }

        .login-title h1 {
            margin-top: 10px !important;
        }

        .login-title small {
            color: #fff;
            font-size: 40px;
        }

        .link p {
            line-height: 20px;
            margin-top: 30px;
        }

        .verSpan {
            font-family: "微软雅黑";
            font-size: 20px;
            margin-left: -35px;
        }

        .btn-sm {
            margin-top: 10px;
            padding: 8px 24px !important;
            font-size: 16px !important;
            width: 100px;
            height: 42px;
            border-color: #5BC0DE;
            background-color: #5BC0DE;
            transition-property: all;
            transition-duration: .3s;
            transition-timing-function: ease-in;
            transition-delay: 0.3s;
        }

        .btn-sm:hover {
            font-size: 18px !important;
            width: 110px;
            height: 50px;
            background-color: #5CB85C;
            border-color: #5CB85C;
        }
    </style>
</head>
<body>
<div class="box loginBg">
    <div class="login-box">
        <div class="login-title text-center">
            <h1>
                <small>登录</small>
            </h1>
        </div>
        <div class="login-content ">
            <div class="form">
                <form action="/login" method="post">
                    <div class="form-group">
                        <div class="col-xs-12  ">
                            <div class="input-group">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-user"></span>
                                    </span>
                                <input type="text" id="username" name="username" class="form-control" placeholder="用户名">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12  ">
                            <div class="input-group">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-lock"></span>
                                    </span>
                                <input type="password" id="password" name="password" class="form-control" placeholder="密码">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12 col-xs-6">
                            <div class="input-group">
                                    <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-th-large"></span>
                                    </span>
                                <input type="text" id="checkcode" name="checkcode" oninput="checkCode(this)" class="form-control" placeholder="验证码" style="width:205px;">
                            </div>
                        </div>
                        <div class="col-xs-12 col-xs-6">
                            <div class="input-group">
                                <img id="image" src="/ImageServlet" style="width:180px;height:37px;margin-right: 5px;" onclick="reloadCode()">
                                <div id="checkGo" class="btn btn-xs btn-danger glyphicon glyphicon-remove"></div>
                            </div>

                        </div>
                        <span class="col-xs-12 col-xs-6 col-xs-offset-4" style="color:#fc0000;">${errorInfo }</span>
                    </div>
                    <div class="form-group form-actions">
                        <div class="col-xs-4 col-xs-offset-5 ">
                            <button type="submit" class="btn btn-sm btn-info" onclick="return check()">
                                <span class="glyphicon glyphicon-ok-circle"></span> 登录
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="js/ajax.js"></script>
<script type="text/javascript">

    function checkCode(obj){
        if (ajaxRequest2("/checkCode?checkCode="+obj.value,"post",false) == "true"){
            document.getElementById("checkGo").setAttribute("class","btn btn-xs btn-success glyphicon glyphicon-ok");
        }else{
            document.getElementById("checkGo").className = "btn btn-xs btn-danger glyphicon glyphicon-remove";
        }
    }
    function reloadCode(){
        var time = new Date().getTime();
        document.getElementById("image").src="/ImageServlet?d="+time;
    }
    function check(){
        if (ajaxRequest2("/checkCode?checkCode="+document.getElementById("checkcode").value,"post",false) == "false"){
            return false;
        }
    }
</script>

</body>
</html>
