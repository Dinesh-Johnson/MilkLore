<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes/sessionCheck.jspf" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore | Products Price</title>
    <meta charset="UTF-8">
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f8f9fc;
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 0.8rem 0;
        }
        .navbar-brand {
            font-weight: 700;
            color: white !important;
        }
        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            color: white !important;
            transform: translateY(-1px);
        }
        .nav-link.active {
            font-weight: 600;
            color: white !important;
            border-bottom: 2px solid white;
        }
        .page-wrapper {
            margin-top: 80px;
        }
        .table th {
            background-color: #f8f9fa;
        }
        /* Product card styles */
        .product-card {
            border: 0;
            border-radius: 0.75rem;
            overflow: hidden;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0.75rem 1.5rem rgba(0,0,0,0.08);
        }
        .product-hero {
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 0.4rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 0.75rem;
        }
        .product-type {
            font-size: 0.62rem;
            letter-spacing: .03em;
            text-transform: uppercase;
            opacity: 0.95;
        }
        .product-price-bubble {
            background: rgba(255,255,255,0.12);
            padding: 0.12rem 0.28rem;
            border-radius: 999px;
            font-weight: 700;
            color: white;
            font-size: 0.75rem;
        }
        .card-product-body { padding: 0.28rem 0.5rem 0.45rem; }
        .card .card-title { font-size: 0.86rem; font-weight: 700; margin-bottom: 0.05rem; }
        .product-actions .btn { flex: 0 0 auto; padding: 0.16rem 0.22rem; font-size: 0.72rem; }
        .product-card { border-radius: 0.42rem; box-shadow: 0 4px 8px rgba(30,30,70,0.03); position: relative; margin: 4px; }
        .action-icon { width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; }
        .product-badge-price { font-size: 0.92rem; font-weight: 700; }
        /* Custom 8-per-row column for large screens */
        @media (min-width: 992px) {
            .col-lg-8per {
                -webkit-box-flex: 0;
                -ms-flex: 0 0 12.5%;
                flex: 0 0 12.5%;
                max-width: 12.5%;
            }
        }
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="redirectToAdminSuccess">
                            <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="redirectToProductsPrice">
                            <i class="fa-solid fa-tag me-2"></i> Products Price
                        </a>
                    </li>
                    <li class="nav-item dropdown ms-3">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <c:choose>
                                <c:when test="${not empty dto.profilePath}">
                                    <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="rounded-circle me-2"
                                        style="width: 40px; height: 40px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img src="images/default.png" alt="Profile" class="rounded-circle me-2"
                                        style="width: 40px; height: 40px; object-fit: cover;">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li>
                                <a class="dropdown-item" href="viewProfile">
                                    <i class="bi bi-person-circle me-2"></i> Profile
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" href="logout">
                                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav><br><br>

    <div class="container mt-5 pt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="mb-0"><i class="fa-solid fa-tag me-2"></i>Products Price</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductWithPriceModal">
                <i class="fa-solid fa-plus me-2"></i>Add Product
            </button>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Products Table -->
        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Type</th>
                                <th class="text-end">Price (₹)</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${productsPrice}">
                                <tr>
                                    <td>${product.productName}</td>
                                    <td><span class="badge bg-secondary">${product.productType}</span></td>
                                    <td class="text-end">₹${product.price}</td>
                                    <td class="text-end">
                                        <div class="btn-group" role="group">
                                            <a href="#" class="btn btn-sm btn-outline-primary editProductBtn" data-id="${product.productId}"
                                               data-name="${product.productName}" data-price="${product.price}" data-type="${product.productType}"
                                               data-bs-toggle="modal" data-bs-target="#editProductModal">Edit</a>
                                            <a href="#" class="btn btn-sm btn-outline-danger deleteProductItem ms-1" data-delete-url="deleteProductPrice?productId=${product.productId}&adminEmail=${dto.email}" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">Delete</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty productsPrice}">
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="fa-solid fa-inbox me-2"></i>No products found
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductWithPriceModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <h5 class="modal-title">Add Product Price</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="addProductWithPrice?adminEmail=${dto.email}" method="post" id="productPriceForm">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Product Name</label>
                            <input type="text" class="form-control" id="productName" name="productName" required>
                            <div id="productNameError" class="error-msg text-danger small"></div>
                        </div>
                        <div class="mb-3">
                            <label for="price" class="form-label">Price (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" required>
                            <div id="priceError" class="error-msg text-danger small"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label d-block">Product Type</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="productType" id="buyType" value="BUY"
                                       required>
                                <label class="form-check-label" for="buyType">Buy</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="productType" id="sellType"
                                       value="SELL" required>
                                <label class="form-check-label" for="sellType">Sell</label>
                            </div>
                            <div id="productTypeError" class="error-msg text-danger small"></div>
                        </div>
                        <div class="modal-footer px-0 pb-0">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-plus me-1"></i> Add Product
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Product Modal -->
    <div class="modal fade" id="editProductModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                    <h5 class="modal-title">Edit Product Price</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProductForm" method="post" action="updateProductPrice?adminEmail=${dto.email}">
                        <input type="hidden" name="productId" id="editProductId">
                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" class="form-control" name="productName" id="editProductName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price (₹)</label>
                            <input type="number" step="0.01" min="0" class="form-control" name="price" id="editProductPrice" required>
                        </div>
                        <div class="mb-3">
                            <label for="editProductType">Product Type</label>
                            <select class="form-select" id="editProductType" name="productType" required>
                                <option value="BUY">Buy</option>
                                <option value="SELL">Sell</option>
                            </select>
                        </div>
                        <div class="modal-footer px-0 pb-0">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fa-solid fa-save me-1"></i> Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirm Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">Confirm Deletion</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <i class="fas fa-exclamation-triangle text-danger mb-3" style="font-size: 3rem;"></i>
                        <h5>Are you sure you want to delete this product?</h5>
                        <p class="text-muted">This action cannot be undone.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <a id="confirmDeleteBtn" href="#" class="btn btn-danger">
                        <i class="fa-solid fa-trash me-1"></i> Delete
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer mt-auto py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">© 2025 Milklore. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <a href="#" class="text-decoration-none text-muted me-3">Privacy Policy</a>
                    <a href="#" class="text-decoration-none text-muted">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/supplier-validation.js"></script>
    <script src="js/product-price.js"></script>
</body>
</html>
