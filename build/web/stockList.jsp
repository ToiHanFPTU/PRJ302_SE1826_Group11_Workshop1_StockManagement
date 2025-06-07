<%-- 
    Document   : stockList
    Created on : Jun 4, 2025, 9:02:29 PM
    Author     : Log
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Stock"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%
    User loginUser = (User) session.getAttribute("user");
    boolean isAdmin = loginUser != null && "AD".equalsIgnoreCase(loginUser.getRoleID());

    List<Stock> list = (List<Stock>) request.getAttribute("STOCK_LIST");
    String message = (String) request.getAttribute("MESSAGE");
    String error = (String) request.getAttribute("ERROR");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Stock Management</title>
    </head>
    <style>
        body {
            background-color: #f9f9f9;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background-color: #000;
            height: 60px;
            display: flex;
            align-items: center;
            padding: 0 20px;
            color: white;
        }

        .nav-container {
            display: flex;
            justify-content: left;
            align-items: center;
            width: 100%;
        }

        .nav-logo {
            font-size: 20px;
            font-weight: bold;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0 auto;
            padding: 0;
            align-items: center;
            height: 100%;
        }

        .nav-links li {
            display: flex;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: white;
            padding: 10px 15px;
            display: flex;
            align-items: center;
            height: 100%;
            transition: background-color 0.3s ease;
        }

        .nav-links a:hover {
            background-color: #333;
            border-radius: 5px;
        }

        .content {
            padding: 20px;
        }

        .welcome-context {
            margin: 20px 0;
            text-align: left;
        }

        .welcome-context h2 {
            color: #333;
        }

        .search-welcome {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .searchZone input[type="text"] {
            padding: 5px;
            width: 200px;
        }

        .searchZone input[type="submit"] {
            padding: 5px 10px;
            margin-left: 10px;
        }

        .form-container {
            margin: 20px auto;
            width: fit-content;
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #eee;
        }

        .actions a, .actions input[type="submit"] {
            padding: 5px 10px;
            margin: 0 5px;
            background-color: #4CAF50;
            color: white;
            border: none;
            text-decoration: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .actions a:hover, .actions input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .message {
            color: green;
        }

        .error {
            color: red;
        }
        .main-content {
            padding: 20px;
        }
    </style>
    <body>
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-logo">Stock Manager</div>
                <ul class="nav-links">
                    <li><a href="StockController?action=SearchStock" active>Stock</a></li>
                    <li><a href="UserController">User</a></li>
                    <li><a href="AlertController?action=SearchAlerts">Alert</a></li>
                    <li><a href="TransactionController">Transaction</a></li>
                </ul>
            </div>
        </nav>
        <div class="main-content">
            <h2>Welcome: <%= (loginUser != null) ? loginUser.getFullName() : "Guest" %></h2>

            <% if (message != null) { %>
            <p style="color:green;"><%= message %></p>
            <% } %>
            <% if (error != null) { %>
            <p style="color:red;"><%= error %></p>
            <% } %>

            <%-- Form thêm mới stock --%>
            <% if (isAdmin) { %>
            <h3>Add New Stock</h3>
            <form action="CreateStockController" method="post">
                Ticker: <input type="text" name="ticker" required />
                Name: <input type="text" name="name" required />
                Sector: <input type="text" name="sector" required />
                Price: <input type="number" step="0.01" name="price" required />
                Status:
                <select name="status">
                    <option value="1">Active</option>
                    <option value="0">Inactive</option>
                </select>
                <input type="submit" value="AddStock" />
            </form>
            <% } %>

            <hr>

            <h3>List of Stocks</h3>
            <form action="SearchStockController" method="get">
                <input type="text" name="keyword" value="<%= request.getAttribute("SEARCH_KEYWORD") != null ? request.getAttribute("SEARCH_KEYWORD") : "" %>" placeholder="Enter ticker, name or sector" />
                <input type="submit" value="SearchStock" />
            </form>
            <table border="1" cellpadding="5" cellspacing="0">
                <tr>
                    <th>Ticker</th>
                    <th>Name</th>
                    <th>Sector</th>
                    <th>Price</th>
                    <th>Status</th>
                        <% if (isAdmin) { %>
                    <th>Actions</th>
                        <% } %>
                </tr>

                <% if (list != null && !list.isEmpty()) {
       for (Stock stock : list) { %>
                <form action="UpdateStockController" method="post">
                    <tr>
                        <td><input type="text" name="ticker" value="<%= stock.getTicker() %>" readonly /></td>
                        <td><input type="text" name="name" value="<%= stock.getName() %>" required /></td>
                        <td><input type="text" name="sector" value="<%= stock.getSector() %>" required /></td>
                        <td><input type="number" step="0.01" name="price" value="<%= stock.getPrice() %>" required /></td>
                        <td>
                            <select name="status">
                                <option value="1" <%= stock.getStatus() == 1 ? "selected" : "" %>>Active</option>
                                <option value="0" <%= stock.getStatus() == 0 ? "selected" : "" %>>Inactive</option>
                            </select>
                        </td>
                        <% if (isAdmin) { %>
                        <td>
                            <input type="submit" value="Update" />
                            <a href="DeleteStockController?ticker=<%= stock.getTicker() %>"
                               onclick="return confirm('Are you sure to delete <%= stock.getTicker() %>?');
                                       value ="deleteStock">
                                Delete</a>
                        </td>
                        <% } %>
                    </tr>
                </form>
                <% } } else { %>
                <tr><td colspan="6">No stock found.</td></tr>
                <% } %>
            </table>
        </div>

    </body>
</html>
