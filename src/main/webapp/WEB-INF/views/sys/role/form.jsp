<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />

    <jsp:include page="${initParam.tpl_path}/header.jsp"/>

</head>

<body>
<div class="x-body">
    <form id="form-data" method="post" class="layui-form layui-form-pane">

        <div class="layui-form-item">
            <label for="roleName" class="layui-form-label">
                <span class="x-red">*</span>角色名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="roleName" name="roleName" required="" lay-verify="required|roleName"
                       autocomplete="off" class="layui-input" value="${Row.roleName}">
            </div>
        </div>

        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">
                拥有权限
            </label>
            <table  class="layui-table layui-input-block">
                <tbody>

                <c:set var="menuIdArr" value="${fn:split(Row.roleMenuIds, ',')}"></c:set>

                <c:forEach items="${menuList}" var="iterm" varStatus="s">
                    <c:if test="${iterm.menuLevel == 1}" >
                        <tr>
                            <td width="25%">
                                <input class="power" type="checkbox"  value="${iterm.menuId}" lay-skin="primary" title="${iterm.menuName}"
                                    <c:forEach var="val" items="${menuIdArr}">
                                        <c:if test="${val==iterm.menuId}">checked</c:if>
                                    </c:forEach>
                                >
                            </td>
                            <td>

                            </td>
                        </tr>
                    </c:if>

                    <c:if test="${iterm.menuLevel == 2}" >
                        <tr>
                            <td>
                                &nbsp;&nbsp;&nbsp;&nbsp;├
                                <input lay-skin="primary" class="power"  type="checkbox" value="${iterm.menuId}" title="${iterm.menuName}"
                                <c:forEach var="val" items="${menuIdArr}">
                                       <c:if test="${val==iterm.menuId}">checked</c:if>
                                </c:forEach>
                                >
                            </td>
                            <td>
                                <div class="layui-input-block">
                                    <c:forEach items="${menuList}" var="iterm2" varStatus="s">
                                        <c:if test="${iterm.menuId == iterm2.menuPid}" >
                                            <input lay-skin="primary" class="power" type="checkbox" value="${iterm2.menuId}" title="${iterm2.menuName}"
                                            <c:forEach var="val" items="${menuIdArr}">
                                                   <c:if test="${val==iterm2.menuId}">checked</c:if>
                                            </c:forEach>
                                            >
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="layui-form-item layui-form-text">
            <label for="roleIntro" class="layui-form-label">
                描述
            </label>
            <div class="layui-input-block">
                <textarea placeholder="请输入内容" id="roleIntro" name="roleIntro" class="layui-textarea">${Row.roleIntro}</textarea>
            </div>
        </div>

        <%--<div class="layui-form-item" pane="" style="display: none">--%>
            <%--<label class="layui-form-label">角色状态</label>--%>
            <%--<div class="layui-input-block">--%>
                <%--<input type="checkbox" name="RoleStatus" id="RoleStatus" lay-skin="switch" lay-text="ON|OFF" value="{{.RoleRow.RoleStatus}}" lay-filter="Status">--%>
                <%--<div class="layui-unselect layui-form-switch" lay-skin="_switch"><em>OFF</em><i></i></div>--%>
            <%--</div>--%>
        <%--</div>--%>

        <div class="layui-form-item">
            <input type="hidden" id="roleId" name="roleId" value="${Row.roleId}">
            <input type="hidden" id="roleMenuIds" name="roleMenuIds" value="${Row.roleMenuIds}">
            <button class="layui-btn" lay-submit="" lay-filter="sub">提交</button>
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
            $("input[class='power']:checked").each(function () {
                var current = $(this).val()
                str += current + ","
            });
            str = str.substring(0,str.length-1)
            $("#roleMenuIds").val(str)
            formSubmit('${pageContext.request.contextPath}/sys/role/doSave', $("#form-data").serialize(),"alert","reload")
            layer.close(loading);
            return false
        })
    })
</script>
</body>
</html>