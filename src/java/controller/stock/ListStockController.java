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
import java.io.IOException;
import java.util.List;
import model.Stock;

@WebServlet(name = "StockListController", urlPatterns = {"/StockListController"})
public class ListStockController extends HttpServlet{
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            StockDAO dao = new StockDAO();
            List<Stock> list = dao.ListStock();

            request.setAttribute("STOCK_LIST", list);
        } catch (Exception e) {
            request.setAttribute("ERROR", "Error loading stock list: " + e.getMessage());
        }

        request.getRequestDispatcher("stockList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); 
    } 
}