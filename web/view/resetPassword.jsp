<%-- 
    Document   : resetPassword
    Created on : Jun 3, 2025, 12:34:59 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
        <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-6/assets/css/login-6.css">
    </head>

    <body class="bg-primary">
        <section class="p-3 p-md-4 p-xl-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6 col-xxl-5">
                        <div class="card border-0 shadow-sm rounded-4" style="margin-top: 170px">
                            <div class="card-body p-3 p-md-4 p-xl-5">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="mb-5">
                                            <h3>Reset password</h3>
                                        </div>
                                    </div>
                                </div>
                                <form action="resetPassword" method="POST" id="form">
                                    <div class="row gy-3 overflow-hidden">
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="email" class="form-control" value="${email}" name="email" id="email" placeholder="name@example.com" required>
                                                <label for="email" class="form-label">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                                <label for="password" class="form-label">Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating mb-3">
                                                <input type="password" class="form-control" name="confirm_password" id="confirm_password" value="" placeholder="Password" required>
                                                <label for="confirm_password" class="form-label">Confirm Password</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="d-grid">
                                                <button class="btn bsb-btn-2xl btn-primary" type="submit">Reset password</button>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="text-danger">${mess}</p>
                                    <p class="text-danger" id="jsErrorMessage"></p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>
            document.getElementById('form').addEventListener('submit', function (event) {
                const password = document.getElementById('password').value.trim();
                const jsMessage = document.getElementById('jsErrorMessage');
                jsMessage.textContent = ""; // Xóa lỗi cũ

// Regex: ít nhất 6 ký tự, ít nhất 1 chữ và 1 số, không có khoảng trắng
                const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;

                if (!regex.test(password)) {
                    jsMessage.textContent = "Mật khẩu phải có ít nhất 6 ký tự, gồm chữ và số, không chứa khoảng trắng.";
                    event.preventDefault(); // Ngăn form submit
                }
            });
        </script>
    </body>
</html>


