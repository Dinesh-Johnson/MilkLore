<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Milklore – Pure Tales of Milk</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
</head>
<body>
<div class="page-wrapper d-flex flex-column min-vh-100">

    <!-- Header -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="#">
                    <img src="${pageContext.request.contextPath}/images/milklore.png" alt="Milklore Logo" height="50"
                         class="me-2"/>
                    <span class="d-flex flex-column align-items-start">
                        <span style="font-weight:bold; font-size:1.3rem; line-height:1;">Milklore</span>
                        <span style="font-size:0.95rem; color:#23405a; line-height:1;">Tales and Taste of Tradition</span>
                    </span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Products</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">Login</a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown">
                                <li><a class="dropdown-item" href="AdminLogin">Admin Login</a></li>
                                <li><a class="dropdown-item" href="AgentLogin.jsp">Agent Login</a></li>
                                <li><a class="dropdown-item" href="CustomerLogin.jsp">Customer Login</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Hero -->
    <section class="hero text-center pt-5 mt-5">
        <div>
            <h1>Milklore – Pure Tales of Milk</h1>
            <p class="fs-5 mt-3 text-dark mx-auto" style="max-width:600px;">
                Experience the freshness of farm-to-table dairy, delivered with care and tradition. Discover our
                range of pure, wholesome milk products for your family’s health and happiness.
            </p>
        </div>
    </section>

    <!-- Products -->
    <main class="flex-grow-1">
        <section class="section products">
            <h2 class="text-center mb-4">Our Products</h2>
            <div class="row justify-content-center" id="products-container">
                <!-- Product cards will be loaded here -->
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="footer bg-light mt-auto pt-4">
        <div class="container">
            <div class="row text-center text-md-start">
                <div class="col-12 mb-3">
                    <h2 style="font-weight:400;letter-spacing:1px;">Follow us:
                        <a href="https://facebook.com/" class="ms-2 me-1" target="_blank"><i class="bi bi-facebook"></i></a>
                        <a href="https://instagram.com/" class="me-1" target="_blank"><i class="bi bi-instagram"></i></a>
                        <a href="https://youtube.com/" class="me-1" target="_blank"><i class="bi bi-youtube"></i></a>
                        <a href="mailto:customercare@milklore.coop" class="me-1"><i class="bi bi-envelope"></i></a>
                        <a href="https://twitter.com/" class="me-1" target="_blank"><i class="bi bi-twitter-x"></i></a>
                    </h2>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Address</h5>
                    <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
                    <p><i class="bi bi-geo-alt-fill text-danger"></i> 123, Milklore Dairy Road, Chennai, Tamil Nadu,
                        India</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Telephone</h5>
                    <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
                    <p><i class="bi bi-telephone-fill text-primary"></i> 044-12345678 (10:00AM - 5:45PM, Mon-Sat)</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Email</h5>
                    <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
                    <p><i class="bi bi-envelope-fill text-danger"></i> customercare@milklore.coop</p>
                </div>
            </div>
            <div class="row">
                <div class="col-12 text-center">
                    <p class="mb-0">© 2025 Milklore • Created with passion.</p>
                </div>
            </div>
        </div>
    </footer>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/renderProducts.js" defer></script>
</body>
</html>
