package controller.Alert;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AlertController", urlPatterns = {"/AlertController"})
public class AlertController extends HttpServlet {

    private static final String SEARCH_ALERT = "SearchAlerts";
    private static final String SEARCH_ALERT_CONTROLLER = "SearchAlertController";
    private static final String CREATE_ALERT = "CreateAlert";
    private static final String CREATE_ALERT_CONTROLLER = "CreateAlertController";
    private static final String UPDATE_ALERT = "UpdateAlert";
    private static final String UPDATE_ALERT_CONTROLLER = "UpdateAlertController";
    private static final String DELETE_ALERT = "DeleteAlert";
    private static final String DELETE_ALERT_CONTROLLER = "DeleteAlertController";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "error.jsp";

        String action = request.getParameter("action");
        System.out.println("hành động: " + action);
        try {
            if (action != null) {
                switch (action) {
                    case SEARCH_ALERT:
                        url = SEARCH_ALERT_CONTROLLER;
                        break;
                    case CREATE_ALERT:
                        url = CREATE_ALERT_CONTROLLER;
                        break;
                    case UPDATE_ALERT:
                        url = UPDATE_ALERT_CONTROLLER;
                        break;
                    case DELETE_ALERT:
                        url = DELETE_ALERT_CONTROLLER;
                        break;
                    default:
                        url = "login.jsp";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
