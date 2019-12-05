<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html  class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>后台登录-X-admin2.1</title>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <jsp:include page="/WEB-INF/views/header.jsp"/>

</head>
<body class="login-bg">

<div class="login layui-anim layui-anim-up">
    <div class="message">x-admin2.0-管理登录</div>
    <div id="darkbannerwrap"></div>

    <form method="post" class="layui-form" id="form-data" >
        <input name="username" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
        <hr class="hr15">
        <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
        <hr class="hr15">
        <input value="登录" lay-submit lay-filter="sub" style="width:100%;" type="submit">
        <hr class="hr20" >
    </form>
</div>

<script>
    $(function () {
        layui.use('form', function () {
            var form = layui.form
            var layer = layui.layer

            form.on('submit(sub)', function (data) {
                var loading = layer.load(1, {shade: [0.1, '#fff']});
                formSubmit('${pageContext.request.contextPath}/sys/user/login.do', $("#form-data").serialize(), "msg", "href")
                layer.close(loading);
                return false
            })
        })
    })
</script>
</body>
</html>
