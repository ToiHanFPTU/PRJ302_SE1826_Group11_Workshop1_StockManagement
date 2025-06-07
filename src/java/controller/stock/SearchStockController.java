/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.stock;

/**
 *
 * @author Log
 */
import DAO.StockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Stock;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchStockController", urlPatterns = {"/SearchStockController"})
public class SearchStockController extends HttpServlet{
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // lay thong tin stock
        String keyword = request.getParameter("keyword");

        try {
            List<Stock> list;
            //check keyword da duoc nhap chua
            if (keyword == null || keyword.trim().isEmpty()) {
                list = new StockDAO().ListStock(); // nếu không có từ khóa → load all
            } else {
                //tuong tac voi DB qua DAO de search stock
                list = new StockDAO().searchStock(keyword);
            }
            request.setAttribute("STOCK_LIST", list);
            request.setAttribute("SEARCH_KEYWORD", keyword);
        } catch (Exception e) {
            request.setAttribute("ERROR", "Error while searching: " + e.getMessage());
        }

        request.getRequestDispatcher("stockList.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    } 
}
