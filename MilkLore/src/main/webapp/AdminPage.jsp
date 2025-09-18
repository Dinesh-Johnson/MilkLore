<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products – Milklore</title>
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="toIndex">
            <i class="bi bi-bucket me-2"></i> Milklore Admin
        </a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="toIndex" class="nav-link">Home</a>
                </li>
                <li class="nav-item">
                    <a href="manageProducts" class="nav-link active">Manage Products</a>
                </li>
                <li class="nav-item">
                    <a href="logout" class="nav-link text-warning">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <!-- Add / Edit Product Form -->
    <div class="card shadow-lg rounded-3">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">
                <c:choose>
                    <c:when test="${not empty editProduct}">
                        <i class="bi bi-pencil-square me-2"></i>Edit Product
                    </c:when>
                    <c:otherwise>
                        <i class="bi bi-plus-circle me-2"></i>Add New Product
                    </c:otherwise>
                </c:choose>
            </h4>
        </div>
        <div class="card-body">
            <!-- Success / Error Message -->
            <c:if test="${not empty message}">
                <div class="alert alert-info">${message}</div>
            </c:if>

            <form action="<c:choose>
                            <c:when test='${not empty editProduct}'>updateProduct</c:when>
                            <c:otherwise>saveProduct</c:otherwise>
                          </c:choose>"
                  method="post" enctype="multipart/form-data">
                <c:if test="${not empty editProduct}">
                    <input type="hidden" name="id" value="${editProduct.id}">
                </c:if>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Product Title</label>
                        <input type="text" name="title" class="form-control" required
                               value="<c:out value='${editProduct.title}'/>"
                               placeholder="e.g. Paneer">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Price (₹)</label>
                        <input type="number" step="0.01" name="price" class="form-control" required
                               value="<c:out value='${editProduct.price}'/>" placeholder="e.g. 150">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="3" required
                                  placeholder="Enter product details"><c:out value='${editProduct.description}'/></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Product Image</label>
                        <input type="file" name="imageFile" class="form-control" accept="image/*">
                        <small class="text-muted">Upload JPG/PNG product image. Leave blank to keep existing image.</small>

                        <c:if test="${not empty editProduct}">
                            <div class="mt-2">
                                <p class="mb-1 small text-muted">Current Image:</p>
                                <img src="uploads/${editProduct.imagePath}" alt="${editProduct.title}"
                                     style="height:100px; object-fit:cover; border-radius:5px;">
                            </div>
                        </c:if>
                    </div>
                </div>

                <div class="d-flex justify-content-end mt-4">
                    <button type="reset" class="btn btn-outline-secondary me-2">Reset</button>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty editProduct}">
                                <i class="bi bi-save me-2"></i>Update Product
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-save me-2"></i>Save Product
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Existing Products List -->
    <div class="card mt-5 shadow-lg rounded-3">
        <div class="card-header bg-secondary text-white">
            <h4 class="mb-0"><i class="bi bi-box-seam me-2"></i>Existing Products</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty productList}">
                <p class="text-muted">No products available. Add your first product above!</p>
            </c:if>

            <c:if test="${not empty productList}">
                <div class="row g-3">
                    <c:forEach var="p" items="${productList}">
                        <div class="col-md-4">
                            <div class="card h-100 shadow-sm">
                                <img src="uploads/${p.imagePath}" class="card-img-top" alt="${p.title}" style="height:200px; object-fit:cover;">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${p.title}</h5>
                                    <p class="card-text small text-muted">${p.description}</p>
                                    <p class="fw-bold">₹${p.price}</p>

                                    <div class="mt-auto d-flex justify-content-between">
                                        <!-- Edit Button -->
                                        <form action="editProduct" method="get">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit" class="btn btn-warning btn-sm">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </button>
                                        </form>

                                        <!-- Delete Button -->
                                        <form action="deleteProduct" method="post"
                                              onsubmit="return confirm('Are you sure you want to delete this product?');">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
