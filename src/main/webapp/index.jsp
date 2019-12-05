<html>
<body>
<h2>Hello World!</h2>
<%
    request.getRequestDispatcher("/WEB-INF/views/sys/user/login.jsp").forward(request, response);
%>
</body>
</html>
