<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>页面出错了</title>


    <script src="${pageContext.request.contextPath}${initParam.tpl_path}/static/js/jquery.min.js"></script>

    <style>
        body {
            background-color: #fff;
        }
        .auto {
            width: 1000px;
            margin: 230px auto;
        }
        .container {
            background: url(${pageContext.request.contextPath}${initParam.tpl_path}/static/images/error-bg.png) no-repeat 560px top;
        }
        .settings {
            padding-left: 200px;
            padding-bottom: 50px;
        }
        .settings .icon {
            display: block;
            width: 242px;
            height: 106px;
            background: url(${pageContext.request.contextPath}${initParam.tpl_path}/static/images/404.png) no-repeat 0 0;
        }
        .settings h4 {
            margin: 30px 0 15px 0;
            font-size: 18px;
            color: #2cb7fd;
        }
        .settings p {
            font-size: 14px;
            color: #999;
        }
        .settings > div {
            margin-top: 40px;
            font-size: 0;
        }
        .settings > div a {
            display: inline-block;
            padding: 10px 40px;
            border: 1px solid #2cb7fd;
            font-size: 15px;
            color: #2cb7fd;
            text-decoration: none;
        }
        .settings > div a:first-child {
            margin-right: 20px;
            color: #fff;
            background-color: #2cb7fd;
        }
    </style>

</head>
<body>
<div class="auto">
    <div class="container">
        <div class="settings">
            <i class="icon"></i>

            <c:if test="${empty requestScope['error_msg']}">
                对不起, 服务器繁忙, 请重试...
            </c:if>

            <c:if test="${not empty requestScope['error_msg']}">
                <h4>${requestScope['error_msg']}</h4>
            </c:if>

            <p><span id="num">5</span> 秒后将自动跳转到首页</p>
            <div>
                <a href="${pageContext.request.contextPath}" title="返回首页">返回首页</a>
                <a href="javascript:;" title="上一步" id="reload-btn">上一步</a>
            </div>
        </div>
    </div>
</div>

<script>
    //倒计时跳转到首页的js代码
    var $_num=$("#num");
    var num=parseInt($_num.html());
    var numId=setInterval(function(){
        num--;
        $_num.html(num);
        if(num===0){
            //跳转地址写在这里
            window.location.href="${requestScope['referer']}";
        }
    },1000);
    //返回按钮单击事件
    var reloadPage = $("#reload-btn");
    reloadPage.click(function(e){
        window.history.back();
    });
</script>

</body>
</html>


