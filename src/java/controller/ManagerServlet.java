/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.viewRegistrations;
import model.LeaveRequest;

/**
 *
 * @author Admin
 */
public class ManagerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        // processRequest(request, response);

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        User user = (User) session.getAttribute("user");
        if (user == null) {
            request.setAttribute("success", "Session hết hạn vui lòng đăng nhập lại!");
            response.sendRedirect("view/login.jsp");
            return;
        }

        if ("view".equalsIgnoreCase(action)) {
            List<viewRegistrations> reg = RegistrationDAO.getAllPendingRegistration();
            request.setAttribute("list", reg);
            request.getRequestDispatcher("viewRegistrations.jsp").forward(request, response);
            return;
        }
        if ("viewLeave".equalsIgnoreCase(action)) {
            List<LeaveRequest> reg = RegistrationDAO.getAllPendingLeaveRequest();
            request.setAttribute("list", reg);
            request.getRequestDispatcher("viewLeaveRequest.jsp").forward(request, response);
            return;
        }
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if (action == null) {
            // do nothing
        } else if (action.equalsIgnoreCase("approve")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            RegistrationDAO.updateRegistrationByApprove(id, userId, "Approve");
            request.setAttribute("mess", "Đồng Ý Thành Công!");
            response.sendRedirect("Manager?action=view");
            return;
        } else if (action.equalsIgnoreCase("reject")) {
            int id = Integer.parseInt(request.getParameter("id"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            RegistrationDAO.updateRegistrationByApprove(id, userId, "Reject");
            request.setAttribute("mess", "Từ Chối Thành Công!");
            response.sendRedirect("Manager?action=view");
            return;
        } else if (action.equalsIgnoreCase("approveLeave")) {
            int leaveId = Integer.parseInt(request.getParameter("leaveId"));
            int regisId = Integer.parseInt(request.getParameter("regisId"));
            int bedId = Integer.parseInt(request.getParameter("bedId"));
            try {
                RegistrationDAO.updateLeaveRequestByApprove(leaveId, user.getUserId(), bedId, regisId);
            } catch (SQLException ex) {
                Logger.getLogger(ManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("mess", "Đồng Ý Thành Công!");
            response.sendRedirect("Manager?action=viewLeave");
            return;
        } else if (action.equalsIgnoreCase("rejectLeave")) {
            int leaveId = Integer.parseInt(request.getParameter("leaveId"));
            int regisId = Integer.parseInt(request.getParameter("regisId"));
            int bedId = Integer.parseInt(request.getParameter("bedId"));
            try {
                RegistrationDAO.updateLeaveRequestByReject(leaveId, user.getUserId());
            } catch (SQLException ex) {
                Logger.getLogger(ManagerServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("mess", "Từ Chối Thành Công!");
            response.sendRedirect("Manager?action=viewLeave");
            return;
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
