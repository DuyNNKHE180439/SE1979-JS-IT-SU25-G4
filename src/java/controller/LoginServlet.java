/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GoogleAccount;
import model.User;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

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
            String code = request.getParameter("code");
            GoogleLogin gg = new GoogleLogin();
            String accessToken = gg.getToken(code);
            GoogleAccount acc = gg.getUserInfo(accessToken);
            User user = UserDAO.getUserByEmail(acc.getEmail());

            if (user == null) {
                String error = "Sai tên tài khoản hoặc mật khẩu!";
                request.setAttribute("error", error);
                RequestDispatcher rs = request.getRequestDispatcher("view/login.jsp");
                rs.forward(request, response);
            } else {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                 int role = user.getRoleId();
                switch (role) {  // phan quyen chuyen trang tai day 1
                    case 1:
                        out.println("Bạn là ADMIN");
                        return;
                    case 2:
                        response.sendRedirect("view/studentHome.jsp");
                        return;
                    case 3:
                        response.sendRedirect("rooms");
                        return;
                    default:
                        response.sendRedirect("login.jsp");
                        return;
                }
            }
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
        try (PrintWriter out = response.getWriter()) {
            String code = request.getParameter("code");
            if (code != null) {
                processRequest(request, response);
                return;
            }
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null) {
                RequestDispatcher rs = request.getRequestDispatcher("view/login.jsp");
                rs.forward(request, response);
            } else {
                 int role = user.getRoleId();
                switch (role) {  // phan quyen chuyen trang tai day 2
                    case 1:
                        out.println("Bạn là ADMIN");
                        return;
                    case 2:
                        response.sendRedirect("view/studentHome.jsp");
                        return;
                    case 3:
                        response.sendRedirect("rooms");
                        return;
                   // tại đay tưng có 1 default chuyển về login.jsp
                }
            }
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
        // processRequest(request, response);
        response.setContentType("text/html,charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String loginId = request.getParameter("email");
            String password = request.getParameter("pass");
            String action= request.getParameter("action");
            User user = UserDAO.getUserByLoginIdAndPassword(loginId, password);
            if (user == null) {
                String error = "Sai tên tài khoản hoặc mật khẩu!";
                request.setAttribute("error", error);
                RequestDispatcher rs = request.getRequestDispatcher("view/login.jsp");
                rs.forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                int role = user.getRoleId();
                switch (role) { // phan quyen chuyen trang tai day 3
                    case 1:
                        out.println("Bạn là ADMIN");
                        return;
                    case 2:
                        response.sendRedirect("view/studentHome.jsp");
                        return;
                    case 3:
                        response.sendRedirect("rooms");
                        return;
                    default:
                        response.sendRedirect("login.jsp");
                        return;
                }
            }
            
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
