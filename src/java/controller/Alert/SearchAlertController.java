/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Alert;

import DAO.AlertDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Alert;
import model.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "SearchAlertController", urlPatterns = {"/SearchAlertController"})
public class SearchAlertController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        try {
            String keyword = request.getParameter("search") != null ? request.getParameter("search") : "";
            String direction = request.getParameter("direction") != null ? request.getParameter("direction") : "";
            String status = request.getParameter("status") != null ? request.getParameter("status") : "";
            AlertDAO dao = new AlertDAO();
            List<Alert> list = dao.getAlertsByUser(loginUser.getUserID(), keyword, direction, status);
            request.setAttribute("ALERT_LIST", list);
            request.setAttribute("keyword", keyword);
            request.setAttribute("direction", direction);
            request.setAttribute("status", status);
            request.setAttribute("list", list);
            request.getRequestDispatcher("alertList.jsp").forward(request, response);
        } catch (Exception e) {
            log(e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
