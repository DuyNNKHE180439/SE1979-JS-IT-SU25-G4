/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Address;
import model.User;

/**
 *
 * @author Admin
 */
public class RegisterServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        String userName = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String fName = request.getParameter("firstName");
        String lName = request.getParameter("lastName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String street = request.getParameter("street");
        // validate ở đây 
        if (userName.length() > 50 || !userName.matches("[a-zA-Z0-9\\s]+")) {
            request.setAttribute("usernameError", "Vui lòng để tên tài khoản không quá dài và không chứa ký tự đặc biệt");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        } if (UserDAO.getUserByUserName(userName) != null) {
            request.setAttribute("usernameError", "Tên tài khoản đã tồn tại");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        } if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("emailError", "Email không hợp lệ");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        } if (UserDAO.getUserByEmail(email) != null) {
            request.setAttribute("emailError", "Email đã tồn tại");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        } if (UserDAO.getUserByPhoneNumber(phoneNumber) != null) {
            request.setAttribute("phoneError", "Số điện thoại đã tồn tại");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        }

        Address address = new Address();
        address.setProvince(province);
        address.setDistrict(district);
        address.setWard(ward);
        address.setStreet(street);
        User user = new User();
        user.setUserName(userName);
        user.setPassWord(password);
        user.setEmail(email);
        user.setFirstName(fName);
        user.setLastName(lName);
        user.setDateOfBirth(dateOfBirth);
        user.setGender(gender);
        user.setPhoneNumber(phoneNumber);
        User registedUser = UserDAO.registerUser(user, address);
        if (registedUser == null) {
            request.setAttribute("success", "Đăng ký thất bại");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
            return;
        } else {
            request.setAttribute("success", "Đăng ký thành công");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
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
