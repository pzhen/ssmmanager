<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="false" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<div class="x-nav">
    <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">用户管理</a>
        <a><cite>用户列表</cite></a>
    </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="${pageContext.request.contextPath}/sys/user/list.do" method="get">
            <input type="text" name="username" value="${username}"  placeholder="登录名" autocomplete="off" class="layui-input">
            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="deleteDataByBatch('${pageContext.request.contextPath}/sys/admin/delete')"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn layui-bg-green" onclick="modifyStatusByBatch('${pageContext.request.contextPath}/sys/admin/modifyStatus',1)"><i class="layui-icon"></i>批量开启</button>
        <button class="layui-btn layui-btn-normal" onclick="modifyStatusByBatch('${pageContext.request.contextPath}/sys/admin/modifyStatus',0)"><i class="layui-icon"></i>批量关闭</button>
        <button class="layui-btn" onclick="x_admin_show('添加用户','${pageContext.request.contextPath}/sys/user/form.do')"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共 ${pageList.totalCount} 条记录，共 ${pageList.totalPage} 页</span>
    </xblock>
    <table class="layui-table x-admin">
        <thead>
        <tr>
            <th width="20">
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>
            <th width="30">ID</th>
            <th width="70">登录名</th>
            <th width="250">角色</th>
            <%--<th width="100">邮箱</th>--%>
            <%--<th width="100">手机</th>--%>
            <th width="30">状态</th>
            <th width="50">操作</th>
        </thead>
        <tbody>
        <c:forEach items="${pageList.list}" var="item" varStatus="s">
            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='${item.userId}'><i class="layui-icon">&#xe605;</i></div>
                </td>

                <td>${item.userId}</td>
                <td>${item.username}</td>
                <td>
                    <c:set var="roleIdArr" value="${fn:split(item.userRoles, ',')}"></c:set>

                    <c:forEach var="val" items="${roleIdArr}">
                        <c:forEach var="row" items="${roleList}">
                            <c:if test="${val==row.roleID}"><span class="layui-badge layui-bg-green">${row.roleName}</span></c:if>
                        </c:forEach>
                    </c:forEach>

                </td>
                <%--<td>${item.email}</td>--%>
                <%--<td>${item.mobile}</td>--%>
                <td>
                    <c:if test="${item.userStatus == 1}">
                        <font color="#228b22">开启</font>
                    </c:if>

                    <c:if test="${item.userStatus == 0}">
                        <font color="red">关闭</font>
                    </c:if>
                </td>
                <td class="td-manage">
                    <a title="编辑"  onclick="x_admin_show('编辑','${pageContext.request.contextPath}/sys/user/form.do?userId=${item.userId}')" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="deleteDataByOne('${pageContext.request.contextPath}/sys/user/delete.do',this,'${item.userId}')" href="javascript:;">
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
            elem: 'pageDiv'
            , count: "${pageList.totalCount}" //数据总数，从服务端得到
            , limit: "${pageList.rows}" //每页显示的条数
            , curr:  "${pageList.currentPage}"
            , theme: "#c00"
            , layout: ['count', 'prev', 'page', 'next', 'skip']
            , jump: function (obj, first) {
                console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                console.log(obj.limit); //得到每页显示的条数
                //首次不执行
                if (!first) {
                    window.location.href = "${pageContext.request.contextPath}/sys/user/list.do?pageNum=" + obj.curr + "&rows=${pageList.rows}&username=${condition.adminname[0]}";
                }
            }
        });
    });

</script>
</body>

</html>
