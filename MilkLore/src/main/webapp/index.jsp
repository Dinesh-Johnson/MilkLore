<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore – Pure Tales of Milk</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
    <link href="css/adminSuccess.css" rel="stylesheet"/>
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

        .nav-link:hover, .nav-link:focus {
            color: white !important;
            transform: translateY(-1px);
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            border-radius: 0.5rem;
            margin-top: 0.5rem;
        }

        .dropdown-item {
            padding: 0.5rem 1.5rem;
            transition: all 0.2s;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
            padding-left: 1.75rem;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.95)),
                        url('images/milk-splash.jpg') center/cover no-repeat;
            padding: 8rem 0 6rem;
            margin-top: 76px; /* Height of navbar */
            text-align: center;
        }

        .hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero p {
            font-size: 1.25rem;
            color: #5a5c69;
            max-width: 700px;
            margin: 0 auto 2rem;
            line-height: 1.6;
        }

        /* Products Section */
        .section {
            padding: 5rem 0;
        }

        .section h2 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 3rem;
            position: relative;
            display: inline-block;
        }

        .section h2::after {
            content: '';
            position: absolute;
            width: 50%;
            height: 4px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            bottom: -10px;
            left: 25%;
            border-radius: 2px;
        }

        .product-card {
            border: none;
            border-radius: 1rem;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            margin-bottom: 2rem;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.15);
        }

        .product-card img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }

        .product-card .card-body {
            padding: 1.5rem;
        }

        .product-card .card-title {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 0.75rem;
        }

        .product-card .card-text {
            color: #6c757d;
            margin-bottom: 1.25rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0 2rem;
            margin-top: 3rem;
        }

        .footer h5 {
            font-weight: 700;
            margin-bottom: 1.5rem;
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

        .footer ul {
            list-style: none;
            padding: 0;
        }

        .footer ul li {
            margin-bottom: 0.75rem;
        }

        .footer a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .footer a:hover {
            color: white;
            transform: translateX(5px);
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
            background: rgba(255,255,255,0.3);
            color: #fff;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .hero {
                padding: 6rem 0 4rem;
                margin-top: 64px;
            }

            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1.1rem;
                padding: 0 1rem;
            }

            .section {
                padding: 3rem 0;
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
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="index.jsp"><i class="bi bi-house-door me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="bi bi-box-seam me-1"></i> Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="bi bi-info-circle me-1"></i> About</a>
                    </li>
                    <li class="nav-item dropdown ms-2">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="loginDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-box-arrow-in-right me-1"></i>
                            <span>Login</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown">
                            <li><a class="dropdown-item" href="AdminLogin"><i class="bi bi-person-fill-gear me-2"></i>Admin Login</a></li>
                            <li><a class="dropdown-item" href="AgentLogin.jsp"><i class="bi bi-person-fill me-2"></i>Agent Login</a></li>
                            <li><a class="dropdown-item" href="CustomerLogin.jsp"><i class="bi bi-person-fill me-2"></i>Customer Login</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Milklore – Pure Tales of Milk</h1>
            <p class="lead">
                Experience the freshness of farm-to-table dairy, delivered with care and tradition.
                Discover our range of pure, wholesome milk products for your family's health and happiness.
            </p>
            <a href="#products" class="btn btn-primary btn-lg mt-3">
                <i class="bi bi-cart3 me-2"></i>Shop Now
            </a>
        </div>
    </section>

    <!-- Products Section -->
    <section id="products" class="section bg-light">
        <div class="container">
            <h2 class="text-center">Our Premium Products</h2>
            <div class="row g-4" id="products-container">
                <!-- Product cards will be loaded here by renderProducts.js -->
                <div class="col-12 text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-3">Loading our delicious products...</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="section">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="bg-primary bg-opacity-10 d-inline-flex align-items-center justify-content-center rounded-circle mb-3"
                             style="width: 80px; height: 80px;">
                            <i class="bi bi-truck text-primary" style="font-size: 2rem;"></i>
                        </div>
                        <h4>Free Delivery</h4>
                        <p class="text-muted">On all orders over ₹500. Fast and reliable delivery to your doorstep.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="bg-success bg-opacity-10 d-inline-flex align-items-center justify-content-center rounded-circle mb-3"
                             style="width: 80px; height: 80px;">
                            <i class="bi bi-shield-check text-success" style="font-size: 2rem;"></i>
                        </div>
                        <h4>100% Natural</h4>
                        <p class="text-muted">Pure, natural milk products with no artificial additives or preservatives.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-4">
                        <div class="bg-warning bg-opacity-10 d-inline-flex align-items-center justify-content-center rounded-circle mb-3"
                             style="width: 80px; height: 80px;">
                            <i class="bi bi-headset text-warning" style="font-size: 2rem;"></i>
                        </div>
                        <h4>24/7 Support</h4>
                        <p class="text-muted">Our customer care team is always here to help you with any queries.</p>
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
                    <ul>
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="#products">Products</a></li>
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Contact Us</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <i class="bi bi-geo-alt-fill me-2"></i>
                            <span>123, Milklore Dairy Road, Chennai, Tamil Nadu, India</span>
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

    <!-- Back to Top Button -->
    <a href="#" class="btn btn-primary btn-lg position-fixed bottom-0 end-0 m-4 rounded-circle shadow"
       id="back-to-top" style="width: 50px; height: 50px; display: none; z-index: 99;">
        <i class="bi bi-arrow-up"></i>
    </a>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Scripts -->
    <script>
        // Back to top button
        const backToTopButton = document.getElementById('back-to-top');

        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopButton.style.display = 'flex';
                backToTopButton.style.alignItems = 'center';
                backToTopButton.style.justifyContent = 'center';
            } else {
                backToTopButton.style.display = 'none';
            }
        });

        backToTopButton.addEventListener('click', (e) => {
            e.preventDefault();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });

        // Initialize tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    </script>

    <!-- Products Render Script -->
    <script src="js/renderProducts.js" defer></script>
</body>
</html>
