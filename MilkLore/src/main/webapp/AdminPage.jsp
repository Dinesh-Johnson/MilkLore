<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login - Milklore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" />
    <link href="css/common-styles.css" rel="stylesheet" />
</head>
<body class="with-fixed-header">
<div class="page-wrapper">
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand d-flex align-items-center" href="toIndex">
                    <img src="images/milklore.png" alt="Milklore Logo" height="50" class="me-2"/>
                    <span class="d-flex flex-column align-items-start">
                        <span class="brand-name">Milklore</span>
                        <span class="brand-tagline">Tales and Taste of Tradition</span>
                    </span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavDropdown">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="toIndex">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Products</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Login
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown">
                                <li><a class="dropdown-item" href="AgentLogin.jsp">Agent Login</a></li>
                                <li><a class="dropdown-item" href="CustomerLogin.jsp">Customer Login</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <main class="flex-grow-1 d-flex align-items-center justify-content-center">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">
                    <h2 class="mb-4">Admin Details</h2>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script>
        // Simple bootstrap validation
        (function () {
          'use strict'
          var forms = document.querySelectorAll('.needs-validation')
          Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
              if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
              }
              form.classList.add('was-validated')
            }, false)
          })
        })()
    </script>
    <footer>
        <footer class="footer mt-auto bg-light pt-4">
            <div class="container">
                <div class="row text-center text-md-start">
                    <div class="col-12 mb-3">
                        <h2 class="section-header">Follow us:
                            <a href="#" class="ms-2 me-1"><i class="bi bi-facebook"></i></a>
                            <a href="#" class="me-1"><i class="bi bi-instagram"></i></a>
                            <a href="#" class="me-1"><i class="bi bi-youtube"></i></a>
                            <a href="#" class="me-1"><i class="bi bi-envelope"></i></a>
                            <a href="#" class="me-1"><i class="bi bi-twitter-x"></i></a>
                        </h2>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Address</h5>
                        <hr class="hr-custom">
                        <p class="mb-1"><i class="bi bi-geo-alt-fill text-danger"></i> 123, Milklore Dairy Road, Chennai, Tamil Nadu, India</p>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Telephone</h5>
                        <hr class="hr-custom">
                        <p class="mb-1"><i class="bi bi-telephone-fill text-primary"></i> 044-12345678 (10:00AM - 5:45PM, Mon-Sat)</p>
                    </div>
                    <div class="col-md-4 mb-3">
                        <h5>Email</h5>
                        <hr class="hr-custom">
                        <p class="mb-1"><i class="bi bi-envelope-fill text-danger"></i> customercare@milklore.coop</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 text-center">
                        <p class="mb-0"> 2025 Milklore • Created with passion.</p>
                    </div>
                </div>
            </div>
        </footer>
    </footer>
</div>
</body>
</html>
