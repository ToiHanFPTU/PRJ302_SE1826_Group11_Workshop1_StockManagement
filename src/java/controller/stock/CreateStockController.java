/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.stock;

import DAO.StockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Stock;
import model.User;

/**
 *
 * @author Log
 */ 
    public class CreateStockController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"AD".equals(user.getRoleID())) {
            response.sendRedirect("checkAuthorized.jsp");
            return;
        }
        String ticker = request.getParameter("ticker");
        String name = request.getParameter("name");
        String sector = request.getParameter("sector");
        double price = Double.parseDouble(request.getParameter("price"));
        int status = Integer.parseInt(request.getParameter("status"));

        Stock stock = new Stock(ticker, name, sector, price, status);

        try {
            StockDAO dao = new StockDAO();
            boolean created = dao.createStock(stock);
            if (created) {
                request.setAttribute("MESSAGE", "Stock created successfully!");
            } else {
                request.setAttribute("ERROR", "Create failed!");
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "Error: " + e.getMessage());
        }
        request.getRequestDispatcher("stockList.jsp").forward(request, response);
    }
}