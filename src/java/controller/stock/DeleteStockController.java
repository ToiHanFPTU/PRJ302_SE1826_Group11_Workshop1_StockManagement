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
import java.util.List;
import model.Stock;
import model.User;

public class DeleteStockController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user"); 
        if (user == null || !"AD".equals(user.getRoleID())) {
        response.sendRedirect("checkAuthorized.jsp");
        return;
    }

        String ticker = request.getParameter("ticker");
        try {
            StockDAO dao = new StockDAO();
            boolean success = dao.deleteStock(ticker);
            if (success) {
                request.setAttribute("MESSAGE", "Deleted successfully!");
            } else {
                request.setAttribute("ERROR", "Delete failed!");
            }
        } catch (Exception e) {
            request.setAttribute("ERROR", "Error: " + e.getMessage());
        }

        // Load lại danh sách sau khi xóa
        try {
            List<Stock> list = new StockDAO().ListStock();
            request.setAttribute("STOCK_LIST", list);
        } catch (Exception e) {
            request.setAttribute("ERROR", "Could not reload stock list.");
        }

        request.getRequestDispatcher("stockList.jsp").forward(request, response);
    }
}
