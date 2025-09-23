<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Milklore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/_variables.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fc; color: #333; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); padding: 0.8rem 0; }
        .navbar-brand { font-weight: 700; color: white !important; }
        .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 500; padding: 0.5rem 1rem !important; transition: all 0.3s ease; }
        .nav-link:hover { color: white !important; transform: translateY(-1px); }
        .welcome-card { background: white; border-radius: 1rem; box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.1); padding: 2rem; text-align: center; transition: all 0.3s ease; }
        .welcome-card:hover { transform: translateY(-3px); box-shadow: 0 0.75rem 2rem rgba(0,0,0,0.15); }
        .footer { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2.5rem 0 1.5rem; margin-top: auto; }
        .footer h5::after { content: ''; position: absolute; width: 50px; height: 3px; background: rgba(255,255,255,0.3); bottom: -10px; left: 0; border-radius: 2px; }
        .social-links { display: flex; gap: 1rem; margin-top: 1.5rem; }
        .social-links a { display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 50%; color: white; font-size: 1.25rem; transition: all 0.3s ease; }
        .social-links a:hover { background: white; color: #764ba2; transform: translateY(-3px); }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span class="d-flex flex-column">
                <span style="font-weight: 700; font-size: 1.4rem;">Milklore</span>
                <span style="font-size: 0.8rem; opacity: 0.9;">Tales and Taste of Tradition</span>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item dropdown ms-3">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <c:choose>
                            <c:when test="${not empty dto.profilePath}">
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="rounded-circle me-2" style="width: 40px; height: 40px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="images/default.png" alt="Profile" class="rounded-circle me-2" style="width: 40px; height: 40px; object-fit: cover;">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="viewProfile?email=${dto.email}"><i class="bi bi-person-circle me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Dashboard -->
<section class="dashboard-section py-5 mt-5">
    <div class="container">
        <!-- Welcome Card -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="welcome-card">
                    <h2 class="text-primary">✅ ${dto.adminName} Logged In!</h2>
                    <p class="lead mt-2">Hello <strong>${dto.adminName}</strong>! Manage <strong>users, products, orders & reports</strong> here.</p>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row g-3 mb-4">
            <!-- Users Card -->
            <div class="col-md-3 col-sm-6">
                <div class="card shadow-sm text-center p-3 h-100">
                    <i class="bi bi-people-fill text-primary" style="font-size:2rem;"></i>
                    <h5 class="mt-3">Users</h5>
                    <p class="text-muted">Manage registered users</p>
                    <a href="manageUsers" class="btn btn-primary btn-sm">View</a>
                </div>
            </div>

            <!-- Products Card with Carousel -->
            <div class="col-md-3 col-sm-6">
                <div class="card shadow-sm text-center p-3 h-100">
                    <div id="productCardCarousel" class="carousel slide mb-2" data-bs-ride="carousel">
                        <div class="carousel-inner" id="card-carousel-products"></div>
                    </div>
                    <h5>Products</h5>
                    <p class="text-muted">Add or update products</p>
                    <a href="manageProducts" class="btn btn-success btn-sm">Manage</a>
                </div>
            </div>

            <!-- Orders Card -->
            <div class="col-md-3 col-sm-6">
                <div class="card shadow-sm text-center p-3 h-100">
                    <i class="bi bi-cart-check-fill text-warning" style="font-size:2rem;"></i>
                    <h5 class="mt-3">Orders</h5>
                    <p class="text-muted">View customer orders</p>
                    <a href="manageOrders" class="btn btn-warning btn-sm">Check</a>
                </div>
            </div>

            <!-- Reports Card -->
            <!-- Suppliers Card -->
            <div class="col-md-3 col-sm-6">
                <div class="card shadow-sm text-center p-3 h-100">
                    <i class="bi bi-truck text-info" style="font-size:2rem;"></i>
                    <h5 class="mt-3">Suppliers</h5>
                    <p class="text-muted">Manage milk suppliers</p>
                    <a href="redirectToMilkSuppliersList?email=${dto.email}" class="btn btn-info btn-sm">View</a>
                </div>
            </div>

        </div>

        <!-- Notifications & Quick Stats -->
        <div class="row g-3">
            <!-- Notifications -->
            <div class="col-lg-6 col-md-12">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-primary text-white fw-bold">
                        <i class="bi bi-bell-fill me-2"></i> Latest Notifications
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush" id="notificationList">
                            <li class="list-group-item">New user registered today</li>
                            <li class="list-group-item">3 new orders received</li>
                            <li class="list-group-item">Low stock alert: Milk 1L</li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="col-lg-6 col-md-12">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-success text-white fw-bold">
                        <i class="bi bi-graph-up me-2"></i> Quick Stats
                    </div>
                    <div class="card-body">
                        <p><strong>Total Users:</strong> 120</p>
                        <p><strong>Total Products:</strong> 45</p>
                        <p><strong>Orders Today:</strong> 8</p>
                        <p><strong>Revenue:</strong> ₹12,350</p>
                        <div class="progress mt-3" style="height:6px;">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 70%;"></div>
                        </div>
                        <small class="text-muted">70% of daily sales goal achieved</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer mt-auto py-4 text-white">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <h5>Milklore</h5>
                <p>Tales and Taste of Tradition. Finest dairy products with a touch of heritage.</p>
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
                    <li><a href="toIndex" class="text-white">Home</a></li>
                    <li><a href="#" class="text-white">Products</a></li>
                    <li><a href="#" class="text-white">About</a></li>
                    <li><a href="#" class="text-white">Contact</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Contact Us</h5>
                <ul class="list-unstyled">
                    <li>Chennai, India</li>
                    <li>+91 44 1234 5678</li>
                    <li>customercare@milklore.coop</li>
                </ul>
            </div>
            <div class="col-lg-3">
                <h5>Newsletter</h5>
                <form>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email" required>
                        <button class="btn btn-light" type="submit"><i class="bi bi-send"></i></button>
                    </div>
                </form>
            </div>
        </div>
        <div class="footer-bottom text-center mt-4">
            &copy; 2025 Milklore. All rights reserved.
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/dashboardProductRender.js"></script>
</body>
</html>