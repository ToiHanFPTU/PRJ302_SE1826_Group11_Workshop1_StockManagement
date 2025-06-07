<%-- 
    Document   : login
    Created on : Jun 3, 2025, 10:27:40 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .login-container {
                background-color: #ffffff;
                padding: 30px 40px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                width: 300px;
            }

            .login-container h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            button[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
            }

            button[type="submit"]:hover {
                background-color: #45a049;
            }

            p {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <h2>Login</h2>
            <form action="LoginController" method="POST">
                <label for="username">User ID</label>
                <input type="text" id="username" name="username" required />
                <br>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required />
                <br>
                <button type="submit">Login</button>
                <br>
                <p style="color: red">${error}</p>
            </form>
        </div>
    </body>
</html>
