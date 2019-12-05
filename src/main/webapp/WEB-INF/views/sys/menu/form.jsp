<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="x-admin-sm">

<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.1</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />

    <jsp:include page="${initParam.tpl_path}/header.jsp"/>

</head>

<body>
<div class="x-body">
    <form class="layui-form" id="form-data">

        <div class="layui-form-item">
            <label for="menuProject" class="layui-form-label">
                <span class="x-red">*</span>选择项目
            </label>
            <div class="layui-input-inline">
                <select id="menuProject" name="menuProject" class="valid">
                    <option value="${initParam.project_name}" <c:if test="${sysMenuRow.menuProject == initParam.project_name}">selected</c:if>>${initParam.project_name}</option>
                    <c:forEach items="${childSysArr}" var="project">
                        <option value="${project}" <c:if test="${sysMenuRow.menuProject == project}">selected</c:if> >${project}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="layui-form-mid layui-word-aux">
                <span class="x-red">*</span>所属项目
            </div>
        </div>

        <div class="layui-form-item">
            <label for="menuName" class="layui-form-label">
                <span class="x-red">*</span>菜单名称
            </label>
            <div class="layui-input-inline">
                <input width="200px" type="text" id="menuName" name="menuName" required="" lay-verify="required"
                       autocomplete="off" value="${sysMenuRow.menuName}" class="layui-input">
            </div>
        </div>


        <div class="layui-form-item">
            <label for="menuPid" class="layui-form-label">
                <span class="x-red">*</span>上级菜单
            </label>
            <div class="layui-input-inline">
                <select id="menuPid" name="menuPid" class="valid">
                    <option value="0">顶级菜单</option>
                    <c:forEach items="${sysMenuList}" var="menu">
                        <option value="${menu.menuId}" <c:if test="${sysMenuRow.menuPid == menu.menuId}">selected</c:if>><c:if test="${menu.menuLevel != 1}"><c:forEach var="i" begin="1" end="${menu.menuLevel}" step="1">&nbsp;&nbsp;&nbsp;</c:forEach>↳</c:if>${menu.menuName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label for="menuUrl" class="layui-form-label">
                <span class="x-red">*</span>菜单URI
            </label>
            <div class="layui-input-inline">
                <input width="200px" type="text" id="menuUrl" name="menuUrl" required="" lay-verify=""
                       autocomplete="off" value="${sysMenuRow.menuUrl}" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label for="menuIcon" class="layui-form-label">
                菜单图标
            </label>
            <div class="layui-input-inline">
                <input type="text" id="menuIcon" name="menuIcon" required="" lay-verify=""
                       autocomplete="off" value="${sysMenuRow.menuIcon}" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label"><span class="x-red">*</span>是否显示</label>
            <div class="layui-input-block">
                <input type="radio" name="menuShow" <c:if test="${sysMenuRow.menuShow == 1}">checked</c:if> value="1" lay-skin="primary" title="显示" >
                <input type="radio" name="menuShow" <c:if test="${sysMenuRow.menuShow == 0}">checked</c:if> value="0" lay-skin="primary" title="隐藏">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label"><span class="x-red">*</span>是否开启</label>
            <div class="layui-input-block">
                <input type="radio" name="menuStatus" <c:if test="${sysMenuRow.menuStatus == 1}">checked</c:if> value="1" lay-skin="primary" title="开启">
                <input type="radio" name="menuStatus" <c:if test="${sysMenuRow.menuStatus == 0}">checked</c:if> value="0" lay-skin="primary" title="关闭">
            </div>
        </div>

        <input type="hidden" name="menuId" value="${sysMenuRow.menuId}" />


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
            formSubmit('${pageContext.request.contextPath}/sys/menu/doSaveMenu', $("#form-data").serialize(),"alert","reload")
            layer.close(loading);
            return false
        })
    })
</script>

</body>

</html>