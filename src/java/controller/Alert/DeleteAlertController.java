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
import model.Alert;
import model.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "DeleteAlertController", urlPatterns = {"/DeleteAlertController"})
public class DeleteAlertController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            User loginUser = (User) request.getSession().getAttribute("user");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int alertID = Integer.parseInt(request.getParameter("alertID"));
            AlertDAO dao = new AlertDAO();
            Alert alert = dao.getAlertById(alertID);
            if (!alert.getUserID().equals(loginUser.getUserID())) {
                request.setAttribute("MSG", "Access denied!!");
            } else if (!alert.getStatus().equals("inactive")) {
                request.setAttribute("MSG", "Cannot delete the active alert!!");
            } else if (dao.deleteAlert(alertID)) {
                request.setAttribute("MSG", "Alert deleted successfully.");
            } else {
                request.setAttribute("MSG", "Failed to delete alert. Only inactive alerts can be deleted.");
            }
            request.getRequestDispatcher("alertList.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("MSG", "Invalid alert ID format.");
            request.getRequestDispatcher("alertList.jsp").forward(request, response);
        } catch (Exception e) {
            log("Error at DeleteAlertController: " + e.toString());
            request.setAttribute("MSG", "An error occurred while deleting the alert.");
            request.getRequestDispatcher("alertList.jsp").forward(request, response);
        }
    }

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
