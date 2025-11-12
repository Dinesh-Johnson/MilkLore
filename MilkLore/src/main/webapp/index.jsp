<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore – Fresh Dairy, Pure Tradition</title>

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="images/icon.png">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            color: #2d2d2d;
            background-color: #f9f9fb;
            overflow-x: hidden;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            padding: 0.8rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            color: #fff !important;
        }

        .navbar-brand img {
            height: 45px;
            margin-right: 8px;
        }

        .nav-link {
            color: #f1f1f1 !important;
            font-weight: 500;
            transition: 0.3s;
        }

        .nav-link:hover {
            color: #fff !important;
            transform: translateY(-1px);
        }

        /* Hero Section */
        .hero {
    position: relative;
    background: url('images/bg.png') center/cover no-repeat;
    color: white;
    text-align: center;
    padding: 9rem 2rem 8rem;
    overflow: hidden;
}


        .hero h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero p {
            font-size: 1.25rem;
            opacity: 0.95;
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        .hero .btn {
            border-radius: 50px;
            font-weight: 600;
            padding: 0.75rem 1.75rem;
            letter-spacing: 0.4px;
        }

        .hero::after {
            content: "";
            position: absolute;
            bottom: -80px;
            left: 50%;
            transform: translateX(-50%);
            width: 130%;
            height: 200px;
            background: url('images/milk-wave.png') center/contain no-repeat;
            opacity: 0.25;
        }

        /* Products */
        .products-section {
            padding: 5rem 0;
        }

        .products-section h2 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 3rem;
            color: #333;
        }

        .product-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            background: white;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .product-card img {
            height: 220px;
            object-fit: cover;
            width: 100%;
        }

        .product-card .card-body {
            padding: 1.5rem;
        }

        .product-card h5 {
            font-weight: 700;
            color: #2c3e50;
        }

        .product-card p {
            color: #6c757d;
            font-size: 0.95rem;
        }

        /* Features */
        .features {
            background-color: #fff;
            padding: 4rem 0;
        }

        .feature-icon {
            font-size: 2.5rem;
            color: #667eea;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }

        .footer h5 {
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .footer a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            display: block;
            margin-bottom: 0.5rem;
            transition: 0.3s;
        }

        .footer a:hover {
            color: #fff;
            transform: translateX(3px);
        }

        /* Scroll to top */
        #back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }

        #back-to-top:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo">
            Milklore
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="toIndex">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" data-bs-toggle="dropdown">Login</a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="redirectToAdminLogin">Admin Login</a></li>
                        <li><a class="dropdown-item" href="redirectToSupplierLogin">Supplier Login</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section with Background -->
<section class="hero">
    <div class="container">
        <h1>Fresh. Natural. Milklore.</h1>
        <p>From farm to your table — experience the true purity and richness of traditional dairy.</p>
        <a href="#products" class="btn btn-light btn-lg text-primary fw-bold">
            <i class="bi bi-cart-fill me-2"></i> Shop Now
        </a>
    </div>
</section>

<!-- Products Section -->
<section id="products" class="products-section">
    <div class="container">
        <h2>Our Premium Dairy Range</h2>
        <div class="row g-4" id="products-container">
            <div class="col-12 text-center py-5">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-3">Loading our freshest products...</p>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="features text-center">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <i class="bi bi-truck feature-icon mb-3"></i>
                <h5>Fast Delivery</h5>
                <p>Guaranteed freshness with doorstep delivery across your city.</p>
            </div>
            <div class="col-md-4">
                <i class="bi bi-shield-check feature-icon mb-3"></i>
                <h5>100% Natural</h5>
                <p>We ensure purity from farm to bottle, with zero preservatives.</p>
            </div>
            <div class="col-md-4">
                <i class="bi bi-chat-dots feature-icon mb-3"></i>
                <h5>Customer Support</h5>
                <p>Need help? We’re here 24/7 to make sure your experience is smooth.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container text-center">
        <h5>Milklore Dairy Cooperative</h5>
        <p>Bringing you stories of purity and freshness every single day.</p>
        <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
    </div>
</footer>

<!-- Scroll to top -->
<button id="back-to-top">
    <i class="bi bi-arrow-up"></i>
</button>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/renderProducts.js" defer></script>

<script>
    // Scroll to top visibility
    const backToTopButton = document.getElementById('back-to-top');
    window.addEventListener('scroll', () => {
        backToTopButton.style.display = window.scrollY > 200 ? 'flex' : 'none';
    });
    backToTopButton.addEventListener('click', () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
</script>
</body>
</html>
