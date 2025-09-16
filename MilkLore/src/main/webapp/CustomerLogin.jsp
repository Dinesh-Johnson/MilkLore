<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customer Login - Milklore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" />
</head>
<body style="padding-top: 80px;">
<div class="page-wrapper">
<header>
  <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
          <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
          <span>Milklore</span>
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
          </ul>
        </div>
      </div>
    </nav>
</header>

<main class="flex-grow-1 d-flex align-items-center justify-content-center">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-12 col-md-8 col-lg-6">
        <h2 class="mb-4">Customer Login</h2>
        <form action="customerLogin" method="post" class="needs-validation" novalidate>
          <div class="mb-3">
            <label for="username" class="form-label">Email or Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
            <div class="invalid-feedback">Please enter email or username.</div>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="invalid-feedback">Please enter password.</div>
          </div>
          <input type="hidden" name="role" value="customer">
          <button type="submit" class="btn btn-primary">Login</button>
                <a href="toIndex" class="btn btn-link">Cancel</a>
                <a href="CustomerRegister.jsp" class="btn btn-link">Register</a>
        </form>
      </div>
    </div>
  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
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
          <h2 style="font-weight:400;letter-spacing:1px;">Follow us:
            <a href="#" class="ms-2 me-1"><i class="bi bi-facebook"></i></a>
            <a href="#" class="me-1"><i class="bi bi-instagram"></i></a>
            <a href="#" class="me-1"><i class="bi bi-youtube"></i></a>
            <a href="#" class="me-1"><i class="bi bi-envelope"></i></a>
            <a href="#" class="me-1"><i class="bi bi-twitter-x"></i></a>
          </h2>
        </div>
        <div class="col-md-4 mb-3">
          <h5>Address</h5>
          <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
          <p class="mb-1"><i class="bi bi-geo-alt-fill text-danger"></i> 123, Milklore Dairy Road, Chennai, Tamil Nadu, India</p>
        </div>
        <div class="col-md-4 mb-3">
          <h5>Telephone</h5>
          <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
          <p class="mb-1"><i class="bi bi-telephone-fill text-primary"></i> 044-12345678 (10:00AM - 5:45PM, Mon-Sat)</p>
        </div>
        <div class="col-md-4 mb-3">
          <h5>Email</h5>
          <hr style="width:60px; border:2px solid #b3d8fd; margin-left:0;">
          <p class="mb-1"><i class="bi bi-envelope-fill text-danger"></i> customercare@milklore.coop</p>
        </div>
      </div>
      <div class="row">
        <div class="col-12 text-center">
          <p class="mb-0">© 2025 Milklore • Created with passion.</p>
        </div>
      </div>
    </div>
  </footer>
</footer>
</div>
</body>
</html>
