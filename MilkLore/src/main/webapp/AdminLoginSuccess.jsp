<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Milklore</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
    <style>
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
            filter: brightness(0) invert(1);
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: white !important;
            transform: translateY(-1px);
        }

        /* Dashboard Section */
        .dashboard-section {
            flex: 1;
            display: flex;
            align-items: center;
            padding: 6rem 0 4rem;
        }

        .welcome-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.1);
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .welcome-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.75rem 2rem rgba(0, 0, 0, 0.15);
        }

        .welcome-card h2 {
            font-weight: 700;
            color: #4e73df;
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
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span class="d-flex flex-column">
                <span style="font-weight: 700; font-size: 1.4rem; line-height: 1.2;">Milklore</span>
                <span style="font-size: 0.8rem; opacity: 0.9; font-weight: 400;">Tales and Taste of Tradition</span>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
<!--                <li class="nav-item">-->
<!--                    <a class="nav-link" href="toIndex"><i class="bi bi-house-door me-1"></i> Home</a>-->
<!--                </li>-->
<!--                <li class="nav-item">-->
<!--                    <a class="nav-link" href="#"><i class="bi bi-box-seam me-1"></i> Products</a>-->
<!--                </li>-->
<!--                <li class="nav-item">-->
<!--                    <a class="nav-link" href="#"><i class="bi bi-info-circle me-1"></i> About</a>-->
<!--                </li>-->
<!--                <li class="nav-item">-->
<!--                    <a class="nav-link" href="#"><i class="bi bi-telephone me-1"></i> Contact</a>-->
<!--                </li>-->
                <li class="nav-item dropdown ms-3">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <c:choose>
                            <c:when test="${not empty dto.profilePath}">
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>"
                                     class="rounded-circle me-2"
                                     style="width: 40px; height: 40px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="images/default.png"
                                     alt="Profile"
                                     class="rounded-circle me-2"
                                     style="width: 40px; height: 40px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
                        <li>
                            <a class="dropdown-item" href="viewProfile?email=${dto.email}">
                                <i class="bi bi-person-circle me-2"></i> Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="toIndex">
                                <i class="bi bi-box-arrow-right me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Dashboard Section -->
<section class="dashboard-section">
    <div class="container">
        <div class="welcome-card">
            <h2>✅ Successfully Logged In!</h2>
            <p class="lead mt-3">Welcome back, <strong>${dto.adminName}</strong>!<br>
                Use the navigation bar to manage your account and products.</p>
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
                    <li class="mb-2"><a href="toIndex">Home</a></li>
                    <li class="mb-2"><a href="#">Products</a></li>
                    <li class="mb-2"><a href="#">About Us</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Contact Us</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="bi bi-geo-alt-fill me-2"></i> Chennai, India</li>
                    <li class="mb-2"><i class="bi bi-telephone-fill me-2"></i> +91 44 1234 5678</li>
                    <li><i class="bi bi-envelope-fill me-2"></i> customercare@milklore.coop</li>
                </ul>
            </div>
            <div class="col-lg-3">
                <h5>Newsletter</h5>
                <p class="text-white-50">Subscribe to get the latest updates and offers.</p>
                <form>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email" required>
                        <button class="btn btn-light" type="submit"><i class="bi bi-send"></i></button>
                    </div>
                </form>
            </div>
        </div>
        <div class="footer-bottom">
            <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
