<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dto.Alert"%>
<!DOCTYPE html>
<html>
    <head>
        <title>UPDATE ALERT</title>
    </head>
    <body>
        <%
            Alert alert = (Alert) request.getAttribute("ALERT");
            if (alert == null) {
                response.sendRedirect("alertList.jsp");
                return;
            }
        %>
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
                <a href="AlertController?action=SearchUser">Stocks List</a>
                <a href="AlertController?action=SearchStock">Transactions List</a>
                <a href="AlertController?action=ViewAlert">Alerts List</a>
                <% if ("AD".equals(loginUser.getRoleID())) { %>
                <a href="AlertController?action=ViewUsers">Users List</a><br>
                <% } %>
            </div>

            <div class="main-content">
                <div class="header">
                    <h1>Welcome, <c:out value="${sessionScope.user.fullName}"/></h1>
                    <p><a href="${pageContext.request.contextPath}/LogoutController">Logout</a></p>
                </div>
                <h2>Update Alert</h2>
                <% String msg = (String) request.getAttribute("MSG");%>
                <% if (msg != null && msg.contains("successfully")) { %>
                <p style="color:green"><%= msg %></p>
                <% } else if (msg != null) { %>
                <p style="color:red"><%= msg %></p>
                <% } %>
                <form action="AlertController" method="POST">
                    ID: <input type="text" name="alertID" value="<%= alert.getAlertID() %>" readonly><br>
                    Ticker: <input type="text" name="ticker" value="<%= alert.getTicker() %>" readonly><br>
                    Threshold: <input type="number" name="threshold" value="<%= alert.getThreshold() %>" step="0.01" required><br>
                    Direction: <select name="direction">
                        <option value="increase" <%= "increase".equals(alert.getDirection()) ? "selected" : "" %>>Increase</option>
                        <option value="decrease" <%= "decrease".equals(alert.getDirection()) ? "selected" : "" %>>Decrease</option>
                    </select><br>
                    Status: <select name="status">
                        <option value="inactive" <%= "inactive".equals(alert.getStatus()) ? "selected" : "" %>>Inactive</option>
                        <option value="active" <%= "active".equals(alert.getStatus()) ? "selected" : "" %>>Active</option>
                        <option value="pending" <%= "pending".equals(alert.getStatus()) ? "selected" : "" %>>Pending</option>
                    </select><br>
                    <input type="submit" name="action" value="UpdateAlert">
                    <a href="AlertController?action=ViewAlerts">Back to Alert List</a>
                </form>
            </div>
        </div>
    </body>
</html>