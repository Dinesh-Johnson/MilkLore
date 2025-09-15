<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Bootstrap Icons -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Customer Registration - Milklore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" />
</head>
<body style="padding-top: 80px;">
<div class="page-wrapper">
<header>
  <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
          <img src="images/milklore.png" alt="Milklore Logo" height="50" class="me-2"/>
          <span class="d-flex flex-column align-items-start">
            <span style="font-weight:bold; font-size:1.3rem; line-height:1;">Milklore</span>
            <span style="font-size:0.95rem; color:#23405a; line-height:1;">Tales and Taste of Tradition</span>
          </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Products</a></li>
            <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="loginDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Login
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="loginDropdown">
                <li><a class="dropdown-item" href="AdminLogin.jsp">Admin Login</a></li>
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
        <h2 class="mb-4">Customer Registration</h2>
        <form action="customerRegister" method="post" class="needs-validation" novalidate>
          <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
            <div class="invalid-feedback">Please enter your name.</div>
          </div>
          <div class="mb-3">
            <label for="gender" class="form-label">Gender</label>
            <select class="form-select" id="gender" name="gender" required>
              <option value="">Select Gender</option>
              <option value="Male">Male</option>
              <option value="Female">Female</option>
              <option value="Other">Other</option>
            </select>
            <div class="invalid-feedback">Please select your gender.</div>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <div class="invalid-feedback">Please enter a valid email.</div>
          </div>
          <div class="mb-3">
            <label for="phone" class="form-label">Phone Number</label>
            <input type="tel" class="form-control" id="phone" name="phone" pattern="[0-9]{10}" required>
            <div class="invalid-feedback">Please enter a valid 10-digit phone number.</div>
          </div>
          <div class="mb-3">
            <label for="state" class="form-label">State</label>
            <select class="form-select" id="state" name="state" required>
              <option value="">Select State</option>
            </select>
            <div class="invalid-feedback">Please select your state.</div>
          </div>
          <div class="mb-3">
            <label for="district" class="form-label">District</label>
            <select class="form-select" id="district" name="district" required>
              <option value="">Select District</option>
            </select>
            <div class="invalid-feedback">Please select your district.</div>
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
            <div class="invalid-feedback">Please enter your address.</div>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="invalid-feedback">Please enter a password.</div>
          </div>
          <button type="submit" class="btn btn-primary">Register</button>
          <a href="CustomerLogin.jsp" class="btn btn-link">Back to Login</a>
        </form>
      </div>
    </div>
  </div>
</main>
<script>
// Fetch states and districts from a CORS-friendly API
document.addEventListener('DOMContentLoaded', function () {
  fetch('https://indian-cities-api-nocors.vercel.app/api/states')
    .then(response => response.json())
    .then(states => {
      const stateSelect = document.getElementById('state');
      states.forEach(state => {
        const option = document.createElement('option');
        option.value = state;
        option.textContent = state;
        stateSelect.appendChild(option);
      });
    });

  document.getElementById('state').addEventListener('change', function () {
    const stateName = this.value;
    const districtSelect = document.getElementById('district');
    districtSelect.innerHTML = '<option value="">Select District</option>';
    if (stateName) {
  fetch(`https://indian-cities-api-nocors.vercel.app/api/cities?State=${'$'}{encodeURIComponent(stateName)}`)
        .then(response => response.json())
        .then(cities => {
          // Remove duplicates and sort
          const uniqueDistricts = Array.from(new Set(cities.map(city => city.District))).sort();
          uniqueDistricts.forEach(district => {
            if (district) {
              const option = document.createElement('option');
              option.value = district;
              option.textContent = district;
              districtSelect.appendChild(option);
            }
          });
        });
    }
  });
});
</script>
      </div>
    </div>
  </div>
</main>
<footer>
  <footer class="footer mt-auto bg-light pt-4">
    <div class="container">
      <div class="row text-center text-md-start">
        <div class="col-12 mb-3">
          <h2 style="font-weight:400;letter-spacing:1px;">Follow us:
            <a href="https://facebook.com/" class="ms-2 me-1" target="_blank" rel="noopener" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
            <a href="https://instagram.com/" class="me-1" target="_blank" rel="noopener" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
            <a href="https://youtube.com/" class="me-1" target="_blank" rel="noopener" aria-label="YouTube"><i class="bi bi-youtube"></i></a>
            <a href="mailto:customercare@milklore.coop" class="me-1" aria-label="Email"><i class="bi bi-envelope"></i></a>
            <a href="https://twitter.com/" class="me-1" target="_blank" rel="noopener" aria-label="Twitter"><i class="bi bi-twitter-x"></i></a>
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
