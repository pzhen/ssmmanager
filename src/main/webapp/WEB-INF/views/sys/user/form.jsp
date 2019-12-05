<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.1</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />

    <jsp:include page="/WEB-INF/views/header.jsp"/>

</head>

<body>
<div class="x-body">
    <form class="layui-form" id="form-data">


        <div class="layui-form-item">
            <label for="username" class="layui-form-label">
                <span class="x-red">*</span>登录名
            </label>
            <div class="layui-input-inline">
                <input width="200px" type="text" id="username" name="username" required="" lay-verify="required"
                       autocomplete="off" value="${userRow.username}" class="layui-input">
            </div>
        </div>

        <%--<div class="layui-form-item">--%>
            <%--<label for="email" class="layui-form-label">--%>
                <%--<span class="x-red">*</span>邮箱--%>
            <%--</label>--%>
            <%--<div class="layui-input-inline">--%>
                <%--<input width="200px" type="text" id="email" name="email" required="" lay-verify="required"--%>
                       <%--autocomplete="off" value="${adminRow.email}" class="layui-input">--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="layui-form-item">--%>
            <%--<label for="mobile" class="layui-form-label">--%>
                <%--<span class="x-red">*</span>手机--%>
            <%--</label>--%>
            <%--<div class="layui-input-inline">--%>
                <%--<input width="200px" type="text" id="mobile" name="mobile" required="" lay-verify="required"--%>
                       <%--autocomplete="off" value="${adminRow.mobile}" class="layui-input">--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="layui-form-item">
            <label for="password" class="layui-form-label">
                <span class="x-red">*</span>密码
            </label>
            <div class="layui-input-inline">
                <input width="200px" type="text" id="password" name="password" required="" lay-verify="required"
                       autocomplete="off" value="${userRow.password}" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label"><span class="x-red">*</span>选择角色</label>
            <div class="layui-input-block">
                <c:set var="roleIdArr" value="${fn:split(userRow.userRoles, ',')}"></c:set>

                <c:forEach var="roleRow" items="${roleList}">
                    <input type="checkbox" class="admin-role" value="${roleRow.roleID}" title="${roleRow.roleName}"
                        <c:forEach var="val" items="${roleIdArr}">
                            <c:if test="${val==roleRow.roleID}">checked</c:if>
                        </c:forEach>
                    >
                </c:forEach>
            </div>
        </div>

        <input type="hidden" name="userId" value="${userRow.userId}" />

        <input type="hidden" id="roleId" name="userRoles" value="" />


        <div class="layui-form-item">
            <label  class="layui-form-label">
            </label>
            <button  class="layui-btn" lay-filter="sub" lay-submit="">
                保存
            </button>
        </div>
    </form>
</div>
<script>
    layui.use(['form','layer'], function(){
        var form = layui.form
        var layer = layui.layer

        form.on('submit(sub)', function(data){
            var loading = layer.load(1, {shade: [0.1,'#fff']});
            var str = ''
            $("input[class='admin-role']:checked").each(function () {
                var current = $(this).val()
                str += current + ","
            });
            str = str.substring(0,str.length-1)
            $("#roleId").val(str)
            formSubmit('${pageContext.request.contextPath}/sys/user/save.do', $("#form-data").serialize(),"alert","reload")
            layer.close(loading);
            return false
        })
    })
</script>

</body>

</html>