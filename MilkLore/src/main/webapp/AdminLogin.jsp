<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="light" xmlns:c="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Milklore</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --dark-color: #5a5c69;
        }

        body {
            background-color: #f8f9fc;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Gradient Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 0.8rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            color: white !important;
        }

        .navbar-brand img {
            filter: none;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link:focus {
            color: white !important;
            transform: translateY(-1px);
        }

        /* Login Section */
        .login-section {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 6rem 0;
            background: url('images/milk-pattern.png') center/cover no-repeat;
        }

        .login-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            border: none;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.75rem 2rem rgba(0, 0, 0, 0.15);
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .login-header h2 {
            margin: 0;
            font-weight: 700;
        }

        .login-body {
            padding: 2.5rem;
        }

        .form-control, .form-select {
            border-radius: 0.5rem;
            padding: 0.75rem 1rem;
            border: 1px solid #d1d3e2;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #b7b9cc;
            box-shadow: 0 0 0 0.25rem rgba(78, 115, 223, 0.25);
        }

        .form-label {
            font-weight: 600;
            color: #5a5c69;
            margin-bottom: 0.5rem;
        }

        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            width: 100%;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            color: white;
        }

        .btn-link {
            color: #4e73df;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-link:hover {
            color: #2e59d9;
            text-decoration: underline;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2.5rem 0 1.5rem;
            margin-top: auto;
        }

        .footer h5 {
            font-weight: 700;
            margin-bottom: 1.25rem;
            position: relative;
            display: inline-block;
        }

        .footer h5::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background: rgba(255, 255, 255, 0.3);
            bottom: -10px;
            left: 0;
            border-radius: 2px;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .footer a:hover {
            color: white;
            text-decoration: none;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            color: white;
            font-size: 1.25rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: white;
            color: #764ba2;
            transform: translateY(-3px);
        }

        .footer-bottom {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 1.5rem;
            margin-top: 2.5rem;
            text-align: center;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .login-section {
                padding: 4rem 0;
            }

            .login-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span class="d-flex flex-column">
                    <span style="font-weight: 700; font-size: 1.4rem; line-height: 1.2;">Milklore</span>
                    <span style="font-size: 0.8rem; opacity: 0.9; font-weight: 400;">Tales and Taste of Tradition</span>
                </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-box-seam me-1"></i> Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-info-circle me-1"></i> About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-telephone me-1"></i> Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Login Section -->
<section class="login-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="login-card">
                    <div class="login-header">
                        <h2><i class="bi bi-person-fill-gear me-2"></i> Admin Login</h2>
                    </div>
                    <div class="login-body">
                        <div id="loginMessage" class="d-none"></div>
                        <c:if test='${message eq "Account blocked. Please reset your password using \'Forgot Password\'."}'>
                        <br/>
                        </c:if>
                        <p id="errorMsg">${errorMessage}</p>
                        <form action="adminLogin" method="post"  id="loginForm" class="needs-validation" novalidate>
                            <!-- Email input -->
                            <div class="mb-4">
                                <label for="adminEmail" class="form-label">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                                    <input type="email" class="form-control" id="adminEmail" name="email" value="${email}" required />
                                </div>
                                <div class="invalid-feedback">Please enter your email.<span class="text-danger">*</span></div>
                            </div>

                            <!-- Password input -->
                            <div class="mb-4">
                                <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                    <input type="password" class="form-control" id="password" name="password"
                                           minlength="5"
                                           pattern=^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{5,}$"
                                           required />
                                </div>
                                <div class="invalid-feedback">Please enter your password.</div>
                            </div>

                            <input type="hidden" name="role" value="admin">
                            <div class="d-grid gap-2 mb-3">
                                <button id="loginBtn" type="submit" class="btn btn-login">
                                    <i class="bi bi-box-arrow-in-right me-2"></i> Login
                                </button>
                            </div>
                            <div class="text-center">
                                <a href="toIndex" class="btn-link">
                                    <i class="bi bi-arrow-left me-1"></i> Back to Home
                                </a>
                                <a href="#" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal" class="btn btn-link">
                                    <i class="bi bi-key me-1"></i> Forgot Password?
                                </a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <h5>Milklore</h5>
                <p class="text-white-50">Tales and Taste of Tradition. Bringing you the finest dairy products with a touch of heritage.</p>
                <div class="social-links">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-twitter-x"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="index.jsp">Home</a></li>
                    <li class="mb-2"><a href="#">Products</a></li>
                    <li class="mb-2"><a href="#">About Us</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Contact Us</h5>
                <ul class="list-unstyled">
                    <li class="mb-2">
                        <i class="bi bi-geo-alt-fill me-2"></i>
                        <span>123, Milklore Dairy Road, Chennai, India</span>
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-telephone-fill me-2"></i>
                        <a href="tel:+914412345678">+91 44 1234 5678</a>
                    </li>
                    <li>
                        <i class="bi bi-envelope-fill me-2"></i>
                        <a href="mailto:customercare@milklore.coop">customercare@milklore.coop</a>
                    </li>
                </ul>
            </div>
            <div class="col-lg-3">
                <h5>Newsletter</h5>
                <p class="text-white-50">Subscribe to our newsletter for the latest updates and offers.</p>
                <form class="mb-3">
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email" aria-label="Your email" required>
                        <button class="btn btn-light" type="submit">
                            <i class="bi bi-send"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="row">
                <div class="col-12 text-center">
                    <p class="mb-0">&copy; ${pageContext.response.locale == null ? '2024' : ''} Milklore. All rights reserved.</p>
                </div>
            </div>
        </div>
    </div>
</footer>
<!-- Forgot Password Modal -->
<div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="forgotPasswordLabel">
                    <i class="bi bi-key me-2"></i>Reset Password
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="forgotPassword" method="post" id="forgotForm">
                    <div class="mb-3">
                        <label for="resetEmail" class="form-label">Enter your email address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                            <input type="email" class="form-control" id="resetEmail" name="email" required>
                        </div>
                        <div id="emailFeedback" class="form-text text-danger d-none"></div>
                        <div class="form-text">We'll send you a link to reset your password.</div>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" id="sendBtn" class="btn btn-primary">
                            <i class="bi bi-send-fill me-2"></i>Send Reset Link
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Back to Top Button -->
<a href="#" class="btn btn-primary btn-lg position-fixed bottom-0 end-0 m-4 rounded-circle shadow"
   id="back-to-top" style="width: 50px; height: 50px; display: none; z-index: 99;">
    <i class="bi bi-arrow-up"></i>
</a>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Custom Scripts -->

<script src="js/login-vaidation.js"></script>
</body>
</html>
