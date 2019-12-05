<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="x-nav">
    <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">角色管理</a>
        <a><cite>角色列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="${pageContext.request.contextPath}/sys/role/list" method="get">
            <input type="text" name="role_name" value="${condition.role_name[0]}"  placeholder="角色名称" autocomplete="off" class="layui-input">
            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="deleteDataByBatch('${pageContext.request.contextPath}/sys/role/delete')"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加用户','${pageContext.request.contextPath}/sys/role/form')"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共 ${pageList.totalCount} 条记录，共 ${pageList.totalPage} 页</span>
    </xblock>
    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th width="20">
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th width="20">ID</th>
            <th width="200">角色名称</th>
            <th width="">角色简介</th>
            <th width="100">操作</th>
        </thead>
        <tbody>
        <c:forEach items="${pageList.list}" var="iterm" varStatus="s">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='${iterm.roleId}'><i class="layui-icon">&#xe605;</i></div>
                </td>

                <td>${iterm.roleId}</td>
                <td>${iterm.roleName}</td>
                <td>${iterm.roleIntro}</td>
                <td class="td-manage">
                    <a title="编辑"  onclick="x_admin_show('编辑','${pageContext.request.contextPath}/sys/role/form?role_id=${iterm.roleId}')" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="deleteDataByOne('${pageContext.request.contextPath}/sys/role/delete',this,'${iterm.roleId}')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

    <div id="pageDiv"></div>



</div>
<script>



    //分页
    layui.use('laypage', function () {
        var laypage = layui.laypage;
        //执行一个laypage实例
        laypage.render({
            elem: 'pageDiv' //注意，这里的 test1 是 ID，不用加 # 号
            , count: "${pageList.totalCount}" //数据总数，从服务端得到
            , limit: "${initParam.page_rows}" //每页显示的条数
            , curr:  "${pageList.currentPage}"
            , theme: "#c00"
            , layout: ['count', 'prev', 'page', 'next', 'skip']
            , jump: function (obj, first) {
                //首次不执行
                if (!first) {
                    window.location.href = "${pageContext.request.contextPath}/sys/role/list?currentPage=" + obj.curr + "&rows=${initParam.page_rows}&role_name=${condition.role_name[0]}";
                }
            }
        });
    });


</script>
</body>

</html>
