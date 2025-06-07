<%-- 
    Document   : createAlert
    Created on : Jun 2, 2025, 4:45:30 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Alert Page</title>
    </head>
    <body>
        <%
            User loginUser = (User) session.getAttribute("user");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div class="container">
            <div class="sidebar">
                <h2>Menu</h2>
                <a href="AlertController?action=SearchStock">Stocks List</a>
                <a href="AlertController?action=searchTransaction">Transactions List</a>
                <a href="AlertController?action=SearchAlerts">Alerts List</a>
                <% if ("AD".equals(loginUser.getRoleID())) { %>
                <a href="AlertController?action=SearchUser">Users List</a><br>
                <% } %>
            </div>

            <div class="main-content">
                <div class="header">
                    <h1>Welcome, <c:out value="${sessionScope.user.fullName}"/></h1>
                    <p><a href="${pageContext.request.contextPath}/LogoutController">Logout</a></p>
                </div>
                <h1>Create Alert</h1>
                <form action="AlertController" method="POST">
                    Ticker: <input type="text" name="ticker" placeholder="Enter ticker" required /><br/>
                    Threshold: <input type="number" name="threshold" placeholder="Enter threshold" step="0.01" required /><br/>
                    Direction: 
                    <select name="direction" required>
                        <option value="increase">increase</option>
                        <option value="decrease">decrease</option>
                    </select><br/>
                    <input type="submit" name="action" value="CreateAlert" /><br/>
                    <a href="AlertController?action=SearchAlerts">Back to Alert List</a>
                </form>
                <% String msg = (String) request.getAttribute("MSG"); %>
                <% if (msg != null && msg.contains("successfully")) { %>
                <p style="color: green;"><%= msg %></p>
                <% } else if (msg != null) { %>
                <p style="color: red;"><%= msg %></p>
                <% } %>
            </div>
        </div>
    </body>
</html>