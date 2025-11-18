<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/includes/sessionCheck.jspf" %>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products – Milklore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea, #764ba2);
            --secondary-color: #1cc88a;
            --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            --hover-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.15);
            --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fc;
            font-family: var(--font-family);
            color: #333;
        }

        /* Navbar */
        .navbar {
            background: var(--primary-gradient);
            box-shadow: var(--card-shadow);
        }

        .navbar-brand {
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 40px;
            margin-right: 10px;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
        }

        .nav-link:hover, .nav-link.active {
            color: white;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .card-header {
            font-weight: 700;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            background: var(--primary-gradient);
            color: white;
            border-top-left-radius: 1rem;
            border-top-right-radius: 1rem;
        }

        /* Buttons */
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
        }

        .btn-outline-secondary, .btn-outline-warning, .btn-outline-danger {
            border-radius: 50px;
        }

        /* Form Inputs */
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        /* Product Cards */
        .product-card {
            transition: all 0.3s ease;
            border-radius: 1rem;
            overflow: hidden;
        }

        .product-card:hover {
            box-shadow: var(--hover-shadow);
        }

        .product-image {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }

        /* Image Preview */
        #imagePreview img {
            max-height: 150px;
            border-radius: 0.5rem;
            margin-top: 10px;
        }

        /* Product Inventory Header */
        .card-header.bg-secondary {
            background: var(--secondary-color);
        }
         .footer { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2.5rem 0 1.5rem; margin-top: auto; }
        .footer h5::after { content: ''; position: absolute; width: 50px; height: 3px; background: rgba(255,255,255,0.3); bottom: -10px; left: 0; border-radius: 2px; }
        .social-links { display: flex; gap: 1rem; margin-top: 1.5rem; }
        .social-links a { display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 50%; color: white; font-size: 1.25rem; transition: all 0.3s ease; }
        .social-links a:hover { background: white; color: #764ba2; transform: translateY(-3px); }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo">
            <span class="d-flex flex-column">
                    <span style="font-weight: 700; font-size: 1.4rem; line-height: 1.2;">Milklore</span>
                    <span style="font-size: 0.8rem; opacity: 0.9; font-weight: 400;">Tales and Taste of Tradition</span>
                </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="redirectToAdminSuccess"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
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
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#adminProfileModal">
                                <i class="fa-solid fa-user me-2"></i> View Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#adminEditModal">
                                <i class="fa-solid fa-pen me-2"></i> Edit Profile
                            </a>
                        </li>                        <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-5">
    <!-- Add / Edit Product Form -->
    <div class="card shadow mb-5">
        <div class="card-header d-flex align-items-center">
            <i class="bi bi-plus-circle me-2"></i>
            <h5 class="mb-0" id="formTitle">Add New Product</h5>
        </div>
        <div class="card-body">
            <div id="message" class="alert d-none"></div>
            <form id="productForm" enctype="multipart/form-data" action="saveProduct" method="post">
                <input type="hidden" id="productId" name="id">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Product Title</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag"></i></span>
                            <input type="text" id="productTitle" name="title" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Price (₹)</label>
                        <div class="input-group">
                            <span class="input-group-text">₹</span>
                            <input type="number" step="0.01" id="productPrice" name="price" class="form-control" required>
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Description</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                            <textarea id="productDescription" name="description" class="form-control" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold">Product Image</label>
                        <div class="input-group">
                            <label class="input-group-text"><i class="bi bi-image"></i></label>
                            <input type="file" id="productImage" name="imageFile" class="form-control" accept="image/*">
                        </div>
                        <small class="text-muted">Upload JPG/PNG product image (Max 5MB)</small>
                        <div id="imagePreview" class="mt-2 text-center"></div>
                    </div>
                </div>
                <div class="d-flex justify-content-end mt-4">
                    <button type="button" id="cancelEdit" class="btn btn-outline-secondary me-2 d-none">
                        <i class="bi bi-x-lg me-1"></i> Cancel
                    </button>
                    <button type="reset" class="btn btn-outline-secondary me-2">
                        <i class="bi bi-arrow-counterclockwise me-1"></i> Reset
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <span class="spinner-border spinner-border-sm d-none me-1" id="submitSpinner" role="status" aria-hidden="true"></span>
                        <i class="bi bi-save me-1"></i>
                        <span id="submitText">Save Product</span>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Products List -->
    <div class="card shadow">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0"><i class="bi bi-grid me-2"></i>Product Inventory</h5>
            <div class="d-flex align-items-center">
                <span class="me-2 small">Total: <span id="productCount">0</span> products</span>
                <div class="spinner-border spinner-border-sm text-light" id="loadingSpinner" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row g-4" id="productList">
                <!-- Products will be loaded here -->
            </div>
        </div>
    </div>
</div>

<!-- Product Card Template -->
<template id="productCardTemplate">
    <div class="col-md-4 col-lg-3">
        <div class="card h-100 product-card">
            <div class="position-relative">
                <img src="" class="card-img-top product-image" alt="">
                <div class="position-absolute top-0 end-0 p-2">
                    <span class="badge bg-success product-stock">In Stock</span>
                </div>
            </div>
            <div class="card-body d-flex flex-column">
                <h5 class="card-title product-title text-truncate"></h5>
                <p class="card-text text-muted small product-description" style="-webkit-line-clamp: 2; display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden;"></p>
                <p class="fw-bold text-primary product-price mb-3"></p>
                <div class="mt-auto d-flex justify-content-between">
                    <button class="btn btn-sm btn-outline-warning edit-btn">
                        <i class="bi bi-pencil-square me-1"></i> Edit
                    </button>
                    <button class="btn btn-sm btn-outline-danger delete-btn">
                        <i class="bi bi-trash me-1"></i> Delete
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
<!-- View Profile Modal -->
<div class="modal fade" id="adminProfileModal" tabindex="-1" aria-labelledby="adminProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="adminProfileModalLabel">Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex gap-3 align-items-center">
                    <div style="width:96px; height:96px;">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="${pageContext.request.contextPath}/images/dummy-profile.png" alt="Profile" class="rounded-circle" width="96" height="96" style="object-fit:cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile"
                                     class="rounded-circle" width="96" height="96" style="object-fit:cover;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <h5 class="mb-1">${dto.adminName}</h5>
                        <p class="mb-0"><strong>Email:</strong> ${dto.email}</p>
                        <p class="mb-0"><strong>Mobile:</strong> ${dto.mobileNumber}</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <!-- open edit modal from here -->
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#adminEditModal" data-bs-dismiss="modal">Edit</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="adminEditModal" tabindex="-1" aria-labelledby="adminEditModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/AdminEdit" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    <h5 class="modal-title" id="adminEditModalLabel">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-3">
                        <div style="width:120px; height:120px; margin:0 auto;">
                            <c:choose>
                                <c:when test="${empty dto.profilePath}">
                                    <img id="profilePreview" src="${pageContext.request.contextPath}/images/dummy-profile.png" alt="Profile" class="rounded-circle" width="120" height="120" style="object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    <img id="profilePreview" src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile" class="rounded-circle" width="120" height="120" style="object-fit:cover;">
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <input type="hidden" name="email" value="${dto.email}" />

                    <div class="mb-3">
                        <label for="adminName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="adminName" name="adminName" value="${dto.adminName}" required>
                    </div>

                    <div class="mb-3">
                        <label for="mobileNumber" class="form-label">Mobile Number</label>
                        <input type="text" class="form-control" id="mobileNumber" name="mobileNumber" value="${dto.mobileNumber}" pattern="^[0-9]{10}$" required>
                    </div>

                    <div class="mb-3">
                        <label for="profileImage" class="form-label">Change Profile Picture</label>
                        <input class="form-control" type="file" id="profileImage" name="profileImage" accept="image/*">
                        <small class="text-muted">Optional — leave blank to keep current picture.</small>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Save changes</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>
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

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script src="js/manageProducts.js"></script>
<script>
    (function(){
      const fileInput = document.getElementById('profileImage');
      const preview = document.getElementById('profilePreview');
      if(fileInput && preview){
        fileInput.addEventListener('change', function(e){
          const file = e.target.files && e.target.files[0];
          if(!file) return;
          const reader = new FileReader();
          reader.onload = function(ev){
            preview.src = ev.target.result;
          };
          reader.readAsDataURL(file);
        });
      }
    })();
</script>
</body>
</html>
