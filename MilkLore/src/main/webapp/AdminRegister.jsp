<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Registration - Milklore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" />
</head>
<body>
<div class="page-wrapper">
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
          <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
          <span>Milklore</span>
        </a>
      </div>
    </nav>
</header>
<main class="flex-grow-1 d-flex align-items-center justify-content-center">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-12 col-md-8 col-lg-6">
        <h2 class="mb-4">Admin Registration</h2>
        <form action="adminRegister" method="post" class="needs-validation" novalidate>
          <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
            <div class="invalid-feedback">Please enter a username.</div>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div class="invalid-feedback">Please enter a valid email.</div>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="invalid-feedback">Please enter a password.</div>
          </div>
          <button type="submit" class="btn btn-primary">Register</button>
          <a href="AdminLogin.jsp" class="btn btn-link">Back to Login</a>
        </form>
      </div>
    </div>
  </div>
</main>
<footer>
  <div class="container text-center py-3">
    <div class="footer-links mb-2">
      <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a> | <a href="#">Site Map</a>
    </div>
    <p class="mb-0">© 2025 Milklore • Brought to you with love.</p>
  </div>
</footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
</body>
</html>
