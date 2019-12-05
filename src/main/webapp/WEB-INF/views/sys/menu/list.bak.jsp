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
<div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="javascript:void(0)">首页</a>
        <a href="javascript:void(0)">菜单管理</a>
        <a>
          <cite>菜单列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>
<div class="x-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 x-so" action="${pageContext.request.contextPath}/sys/menu/list" method="get">
            <input type="text" name="menu_url" value="${condition.menu_url[0]}"  placeholder="URI" autocomplete="off" class="layui-input">
            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <xblock>
        <button class="layui-btn layui-btn-danger" onclick="delAll()"><i class="layui-icon"></i>批量删除</button>
        <button class="layui-btn" onclick="x_admin_show('添加用户','${pageContext.request.contextPath}/sys/menu/menuForm')"><i class="layui-icon"></i>添加</button>
        <span class="x-right" style="line-height:40px">共 ${sysMenuListByPage.totalCount} 条记录，共 ${sysMenuListByPage.totalPage} 页</span>
    </xblock>

    <table class="layui-table">
        <thead>
        <tr>
            <th width="20">
                <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
            </th>

            <th width="20">ID</th>
            <th width="70">所属项目</th>
            <th width="200">菜单名称</th>
            <th>URI</th>
            <th width="30">图标</th>
            <th width="30">显示</th>
            <th width="30">状态</th>
            <th width="30">层级</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sysMenuListByPage.list}" var="menu" varStatus="s">

            <tr>
                <td>
                    <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='${menu.menuId}'><i class="layui-icon">&#xe605;</i></div>
                </td>

                <td>${menu.menuId}</td>
                <td>${menu.menuProject}</td>
                <td>
                    <c:if test="${menu.menuLevel != 1}">
                        <c:forEach var="i" begin="1" end="${menu.menuLevel}" step="1">
                            &nbsp;&nbsp;&nbsp;
                        </c:forEach>
                        ↳
                    </c:if>

                    <c:if test="${menu.menuLevel == 1}">
                        ✚
                    </c:if>
                    ${menu.menuName}
                </td>
                <td>${menu.menuUrl}</td>
                <td><i class="iconfont">${menu.menuIcon}</i></td>
                <td>
                    <c:if test="${menu.menuShow == 1}">
                        <font color="#228b22">显示</font>
                    </c:if>

                    <c:if test="${menu.menuShow == 0}">
                        <font color="red">隐藏</font>
                    </c:if>
                </td>
                <td>
                    <c:if test="${menu.menuStatus == 1}">
                        <font color="#228b22">开启</font>
                    </c:if>

                    <c:if test="${menu.menuStatus == 0}">
                        <font color="red">关闭</font>
                    </c:if>
                </td>
                <td>${menu.menuLevel}</td>
                <td class="td-manage">
                    <a title="编辑"  onclick="x_admin_show('编辑','${pageContext.request.contextPath}/sys/menu/menuForm?menu_id=${menu.menuId}')" href="javascript:;">
                        <i class="layui-icon">&#xe642;</i>
                    </a>
                    <a title="删除" onclick="deleteDataByOne('${pageContext.request.contextPath}/sys/menu/deleteMenu',this,'${menu.menuId}')" href="javascript:;">
                        <i class="layui-icon">&#xe640;</i>
                    </a>
                </td>
            </tr>

        </c:forEach>

        </tbody>
    </table>
    <div class="page">
        <div>

            <c:if test="${sysMenuListByPage.currentPage == 1}">
                <span class="prev">&lt;&lt;</span>
            </c:if>

            <c:if test="${sysMenuListByPage.currentPage != 1}">
                <a class="prev" href="${pageContext.request.contextPath}/sys/menu/list?currentPage=${sysMenuListByPage.currentPage - 1}&rows=${initParam.page_rows}&menu_url=${condition.menu_url[0]}">&lt;&lt;</a>
            </c:if>

            <c:forEach begin="1" end="${sysMenuListByPage.totalPage}" var="i" >

                <c:if test="${sysMenuListByPage.currentPage == i}">
                    <span class="current">${i}</span>
                </c:if>

                <c:if test="${sysMenuListByPage.currentPage != i}">
                    <a class="num" href="${pageContext.request.contextPath}/sys/menu/list?currentPage=${i}&rows=${initParam.page_rows}&menu_url=${condition.menu_url[0]}">${i}</a>
                </c:if>

            </c:forEach>

            <c:if test="${sysMenuListByPage.currentPage == sysMenuListByPage.totalPage}">
                <span class="next">&gt;&gt;</span>
            </c:if>

            <c:if test="${sysMenuListByPage.currentPage != sysMenuListByPage.totalPage}">
                <a class="next" disabled="disabled" href="${pageContext.request.contextPath}/sys/menu/list?currentPage=${sysMenuListByPage.currentPage + 1}&rows=${initParam.page_rows}&menu_url=${condition.menu_url[0]}">&gt;&gt;</a>
            </c:if>

        </div>
    </div>

</div>
<script>


</script>
</body>

</html>
