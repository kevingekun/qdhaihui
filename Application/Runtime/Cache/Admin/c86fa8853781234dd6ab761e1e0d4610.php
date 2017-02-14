<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>合伙人登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <link rel="stylesheet" href="/assets/admin/haixin/css/index.css"/>

</head>
<body>
<div class="login-main">
    <div class="banner-bg">
        <img src="/assets/admin/haixin/img/smart.jpg" alt="" width="100%"/>
    </div>
    <div class="login-form">
        <div class="login-box">
            <div class="mt">
                <h1>
                    登录合伙人系统
                </h1>
            </div>
            <div class="msg-wrap">
                <div class="msg-warn"><b></b>公共场所不建议自动登录，以防账号丢失</div>
            </div>
            <div class="form">
                <form name="form1" method="post" acction="/Admin/Login/login" data-toggle='validate'>
                    <div class="item item-fore1">
                        <label class="login-label name-label">
                            用户名：
                        </label>
                        <input type="text" class="itxt" name="username" tabindex="1" placeholder="请输入用户名"  data-rule-required='true'>
                    </div>
                    <div id="entry" class="item item-fore2">
                        <label class="login-label pwd-label">
                            密&nbsp;&nbsp;&nbsp;码：
                        </label>
                        <input type="password" name="password" class="itxt itxt-error" tabindex="2" placeholder="请输入密码" data-rule-required='true'  data-rule-minlength="6">
                    </div>
                    <div class="item item-fore3">
                        <div class="safe">
                            <span>
                                <input id="autoLogin" name="chkRememberMe" type="checkbox" class="jdcheckbox" >
                                <label for="autoLogin">
                                    自动登录
                                </label>
                            </span>
                            <!--<a href="#" class="forget-pw-safe" target="_blank">
                                忘记密码?
                            </a>-->
                        </div>
                    </div>
                    <div class="item item-fore5">
                        <div class="login-btn">
                            <button type="submit" tabindex="3">
                                立即登录
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="/assets/admin/sui/jquery.min.js"></script>
<script src="/assets/admin/sui/validation.js"></script>

</body>
</html>