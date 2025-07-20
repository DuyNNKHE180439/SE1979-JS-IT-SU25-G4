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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.util.ArrayList;
import model.Profile;
import model.User;
import model.Order;
import model.LeaveRequest;
import dao.BedDAO;
import dao.StudentDAO;
import java.util.List;

/**
 *
 * @author Admin
 */
@MultipartConfig
public class UserServlet extends HttpServlet {

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
            out.println("<title>Servlet UserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String action = (String) request.getParameter("action");
        User user = (User) session.getAttribute("user");
        if (user == null) {
            request.setAttribute("success", "Session hết hạn vui lòng đăng nhập lại!");
            response.sendRedirect("view/login.jsp");
            return;
        } else if (action.equalsIgnoreCase("viewProfile")) {
            Profile profile = UserDAO.getUserInFoById(user.getUserId());
            session.setAttribute("profile", profile);
            request.getRequestDispatcher("view/profile.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("editProfile")) {
            request.getRequestDispatcher("view/editProfile.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("listOrder")) {
            List<Order> order = BedDAO.getAllOrderById(user.getUserId());
            request.setAttribute("order", order);
            request.getRequestDispatcher("view/listOrder.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("listResidentHistory")) {
            List<Order> order = BedDAO.getResidentHistory(user.getUserId());
            request.setAttribute("order", order);
            request.getRequestDispatcher("view/listResidentHistory.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("createLeaveRequest")) {
            List<Order> or = BedDAO.getResidentHistory(user.getUserId());
            List<Order> order = new ArrayList<>();
            for (Order order1 : or) {
                if (order1.getActive().equalsIgnoreCase("Valid")) {
                    order.add(order1);
                }
            }
            request.setAttribute("order", order);
            request.getRequestDispatcher("view/addLeaveRequest.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("editLeaveRequest")) {
            String roomNum= request.getParameter("roomNum");
            String bedNum= request.getParameter("bedNum");
            String startDate= request.getParameter("startDate");
            String endDate= request.getParameter("endDate");
            int regisId= Integer.parseInt(request.getParameter("regisId"));
            int stuId= StudentDAO.getStudentIdByUserId(user.getUserId());
            LeaveRequest leave= new LeaveRequest();
            leave.setStuId(stuId);
            leave.setRegisId(regisId);
            leave.setBedNum(bedNum);
            leave.setEndDate(endDate);
            leave.setRoomNum(roomNum);
            leave.setStartDate(startDate);
            request.setAttribute("leave", leave);
            request.getRequestDispatcher("view/editLeaveRequest.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            // do nothing
        } else if (action.equalsIgnoreCase("editProfile")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int addressId = Integer.parseInt(request.getParameter("addressId"));
            String userName = request.getParameter("username");
            String passWord = request.getParameter("password");
            String email = request.getParameter("email");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            String phoneNumber = request.getParameter("phoneNumber");
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String street = request.getParameter("street");
            Part filePart = request.getPart("profilePic");
            String originalPhone = request.getParameter("originalPhoneNumber").trim();
            String imagePath = null;

            // Phone number validation
            if (!phoneNumber.equals(originalPhone)) {
                if (UserDAO.getUserByPhoneNumber(phoneNumber) != null) {
                    request.setAttribute("success", "Số điện thoại đã tồn tại");
                    Profile profile = UserDAO.getUserInFoById(userId);
                    request.setAttribute("profile", profile);
                    request.getRequestDispatcher("view/editProfile.jsp").forward(request, response);
                    return;
                }
            }

            // Image upload
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                // Determine save directory: <project_root>/web/images
                String appPath = getServletContext().getRealPath(""); // e.g., .../build/web
                File projectRoot = new File(appPath).getParentFile().getParentFile(); // go up two levels to project root
                String savePath = new File(projectRoot, "web" + File.separator + "images").getAbsolutePath() + File.separator;
                File uploadDir = new File(savePath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                filePart.write(savePath + fileName);
                imagePath = "images/" + fileName;
            }

            // Create Profile object and set properties
            Profile profile = new Profile();
            profile.setUserId(userId);
            profile.setAddressId(addressId);
            profile.setUserName(userName);
            profile.setEmail(email);
            profile.setPassword(passWord);
            profile.setFirstName(firstName);
            profile.setLastName(lastName);
            profile.setDateOfBirth(dateOfBirth);
            profile.setGender(gender);
            profile.setPhoneNumber(phoneNumber);
            profile.setProvice(province);
            profile.setDistrict(district);
            profile.setWard(ward);
            profile.setStreet(street);
            if (imagePath == null) {
                // If no new image is uploaded, keep the old one
                Profile oldProfile = UserDAO.getUserInFoById(userId);
                profile.setImage(oldProfile.getImage());
            } else {
                profile.setImage(imagePath);
            }
            // Update user in DB
            if (UserDAO.updateUserAddress(profile, addressId, userId)) {
                HttpSession session = request.getSession();
                session.setAttribute("profile", profile);
                request.setAttribute("success", "Cập nhật thông tin thành công!");
                request.getRequestDispatcher("view/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("profile", profile);
                request.setAttribute("success", "Cập nhật thông tin thất bại!");
                request.getRequestDispatcher("view/profile.jsp").forward(request, response);
            }
        } else if(action.equalsIgnoreCase("editLeaveRequest")){
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
