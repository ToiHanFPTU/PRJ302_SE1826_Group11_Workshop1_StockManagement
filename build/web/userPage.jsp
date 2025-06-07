<%-- 
    Document   : userPage
    Created on : Jun 3, 2025, 11:05:55 AM
    Author     : HP
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <style>
            body {
                background-color: #f9f9f9;
            }
            .content {
                padding: 20px;
            }
            .welcome-context {
                margin: 20px 0;
                text-align: left;
            }

            .welcome-context h1 {
                color: #333;
            }

            .searchZone {
                margin-bottom: 20px;
                text-align: center;
            }

            .searchZone input[type="text"] {
                padding: 5px;
                width: 200px;
            }

            .searchZone input[type="submit"] {
                padding: 5px 10px;
                margin-left: 10px;
            }

            .addButton {
                margin: 10px 0;
                padding: 8px 15px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                display: block;
                border-radius: 5px;
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

            table, th, td {
                border: 0px solid #ddd;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #eee;
            }

            .actions button {
                padding: 5px 10px;
                margin: 0 5px;
                cursor: pointer;
            }
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }

            /* Navbar tổng thể */
            .navbar {
                background-color: #000;
                height: 60px;
                display: flex;
                align-items: center; /* Căn giữa theo chiều dọc */
                padding: 0 20px;
                color: white;
            }

            .nav-container {
                display: flex;
                justify-content: left;
                align-items: center;
                width: 100%;
            }

            /* Logo */
            .nav-logo {
                font-size: 20px;
                font-weight: bold;
            }

            /* Danh sách menu */
            .nav-links {
                list-style: none;
                display: flex;
                gap: 20px;
                margin: 0;
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
            .nav-links {
                margin: 0 auto;
            }
            .search-welcome {
                display: flex;
                justify-content: left;
            }
            .searchZone {
                margin-left: 240px;
            }

            .welcome-context a {
                display: inline-block;
                padding: 8px 16px;
                margin-top: 10px;
                background-color: #4CAF50;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }
            .welcome-context {
                margin-top: 0px;
            }
            .welcome-context a:hover {
                background-color: #0056b3; /* Màu nền khi hover */
            }
            .insertHeader {
                display: flex;
                justify-content: center;
            }

        </style>

    </head>

    <body>
        <!--phân quyền của user nếu user có quyền admin thì mới được xem trang này-->
        <% 
            User user = (User) session.getAttribute("user");
            if (!user.getRoleID().equalsIgnoreCase("ad")) {
                response.sendRedirect("checkAuthorized.jsp");
                return;
            }
        
        %>


        <!-- Navigation Bar -->
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-logo">Stock Manager</div>
                <ul class="nav-links">
                    <li><a href="StockController?action=SearchStock" active>Stock</a></li>
                    <li><a href="UserController">User</a></li>
                    <li><a href="AlertController?action=SearchAlerts">Alert</a></li>
                    <li><a href="transactionList.jsp">Transaction</a></li>
                </ul>
            </div>
        </nav>
        <div class="content">
            <div class="search-welcome">
                <!-- chỗ xin chào người dùng -->
                <div class="welcome-context">
                    <h1>Welcome ${user.getFullName()}</h1>
                    <a href="${pageContext.request.contextPath}/LogoutController">Logout</a>
                </div>
                <!-- CHỗ để search user -->
                <div class="searchZone">
                    <h2>Search User</h2>
                    <!-- form để search -->

                    <form action="UserController?action=search" method="post">
                        <!-- chỗ nhập tên để search -->
                        <input type="text" name="searchBox" placeholder="Enter user name">
                        <!-- nút submit -->
                        <input type="submit" name="searchButton" value="search">
                    </form>
                </div>
            </div>
            <button onclick="addUser()" class="addButton">Add</button>
            <!--form để insert user-->
            <form action="UserController?action=insert" id="form-insert" style="display: none" class="form-container" method="post">
                <h2 class="insertHeader">Insert new user</h2>
                <table>
                    <tr>
                        <td>User ID</td>
                        <td>
                            <input type="text" name="userIDInsert" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Full Name</td>
                        <td>
                            <input type="text" name="fullNameInsert" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Role ID</td>
                        <td>
                            <input type="text" name="roleIDInsert" required>
                        </td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="passwordInsert" required></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <button type="submit" name="submitForm">Add User</button>
                        </td>
                    </tr>
                </table>
            </form>
            <!-- List user -->
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Role ID</th>
                        <th>Password</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user" varStatus="record">
                        <tr>
                    <form action="UserController" method="POST">
                        <!-- No: dùng để đến số dùng -->
                        <td>
                            <input type="text" name="No" value="${record.count}" readonly>
                        </td>
                        <%--userID này để delete hoặc update--%>
                        <input type="hidden" name="userID" value="${user.userID}" />
                        <%--Hiển thị userID--%>
                        <td>
                            <input type="text" value="${user.userID}" readonly/>
                        </td>
                        <%--Hiển thị full name--%>
                        <td>
                            <input type="text"  name="fullName"   value="${user.fullName}" required/>
                        </td>
                        <%--Hiển thị role--%>
                        <td>
                            <input type="text"  name="roleID" value="${user.roleID}" required/>
                        </td>
                        <%--hiển thị password--%>
                        <td>
                            <input type="text"  name="password"  value="${user.password}" required/>
                        </td>
                        <%--Hành độngc ảu người dùng--%>
                        <td class="actions">
                            <button type="submit" name="action" value="update">Update</button>
                            <button type="submit" name="action" value="remove">Delete</button>
                        </td>
                    </form>
                    </tr>
                </c:forEach>
                </tbody>
        </div>
    </table>
    <p class="alert" hidden>${msg}</p>
    <script>
        function displayForm() {
            let form = document.querySelector("#form-insert");
            if (form.style.display === 'none') {
                form.style.display = 'block';
            } else {
                form.style.display = 'none';
            }
        }
        function addUser() {
            displayForm();
        }
        window.addEventListener('DOMContentLoaded', function () {
            const alertBox = document.querySelector(".alert");
            const message = alertBox?.textContent?.trim();
                    if (message) {
                alert(message);
            }
        });
    </script>
</body>

</html>
