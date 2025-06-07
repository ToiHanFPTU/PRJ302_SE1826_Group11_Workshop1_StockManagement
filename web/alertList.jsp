<%-- 
    Document   : alertList
    Created on : Jun 2, 2025, 4:43:12 PM
    Author     : ACER
--%>

<%@page import="model.Alert"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alert List Page</title>
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
            <!-- Navigation Bar -->
            <nav class="navbar">
                <div class="nav-container">
                    <div class="nav-logo">Stock Manager</div>
                    <ul class="nav-links">
                        <li><a href="StockController?action=SearchStock" active>Stock</a></li>
                        <li><a href="UserController">User</a></li>
                        <li><a href="transactionList.jsp">Transaction</a></li>
                        <li><a href="AlertController?action=SearchAlerts">Alert</a></li>
                    </ul>
                </div>
            </nav>

            <div class="main-content">
                <div class="header">
                    <h1>Welcome, <c:out value="${sessionScope.user.fullName}"/></h1>
                    <p><a href="${pageContext.request.contextPath}/LogoutController">Logout</a></p>
                </div>


                <form action="AlertController" method="POST">
                    <input type="text" name="search" placeholder="Search">
                    <select name="direction">
                        <option value="">Any</option>
                        <option value="increase">Increase</option>
                        <option value="decrease">Decrease</option>
                    </select>

                    <select name="status">
                        <option value="">Any</option>
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>

                    <button type="submit" name="action" value="SearchAlerts">Search</button>
                </form>
                <a href="AlertController?action=CreateAlert">Create New Alert</a><br/>

                <%
                    String MSG = (String) request.getAttribute("MSG");
                    if (MSG != null && MSG.contains("successfully")) {
                %>
                <h3 style="color: green;"> <%= MSG%> </h3>
                <%
                    } else if (MSG != null) {
                %>
                <h3 style="color: red;"> <%= MSG%> </h3>
                <%
                    }
                    ArrayList<Alert> list = (ArrayList<Alert>) request.getAttribute("list");
                    if (list != null) {
                %>
                <table>
                    <tr>
                        <th>No</th>
                        <th>Ticker</th>
                        <th>Threshold</th>
                        <th>Direction</th>
                        <th>Status</th>
                        <th>Function</th>
                    </tr>
                    <%
                        int count = 0;
                        for (Alert alert : list) {
                            count++;
                    %>
                    <tr>
                        <td><%= count%></td>
                        <td><%= alert.getTicker()%></td>
                        <td><input type="text" name="threshold" value="<%= alert.getThreshold()%>" readonly></td>
                        <td><input type="text" name="direction" value="<%= alert.getDirection()%>" readonly></td>
                        <td><input type="text" name="status" value="<%= alert.getStatus()%>" readonly></td>
                        <td>
                            <div class="function-buttons">
                                <form action="AlertController" method="POST">
                                    <input type="hidden" name="alertID" value="<%= alert.getAlertID() %>">
                                    <button type="submit" name="action" value="UpdateAlert">Update</button>
                                </form>
                                <% if ("inactive".equals(alert.getStatus())) { %>
                                <form action="AlertController" method="POST">
                                    <input type="hidden" name="alertID" value="<%= alert.getAlertID() %>">
                                    <button class="butDelete" type="submit" name="action" value="DeleteAlert">Delete</button>
                                </form>
                                <% } else { %>
                                <div class="delete-placeholder"></div>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <% }
                    %>
                </table>
                <% String msg = (String) request.getAttribute("MSG"); %>
                <% if (msg != null) { %>
                <p style="color: red;"><%= msg %></p>
                <% } %>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>