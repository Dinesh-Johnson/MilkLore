<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milk Suppliers - MilkLore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body { background-color: #f8f9fc; color: #333; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); padding: 0.8rem 0; }
        .navbar-brand { font-weight: 700; color: white !important; }
        .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 500; padding: 0.5rem 1rem !important; transition: all 0.3s ease; }
        .nav-link:hover { color: white !important; transform: translateY(-1px); }
        .welcome-card { background: white; border-radius: 1rem; box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.1); padding: 2rem; text-align: center; transition: all 0.3s ease; }
        .welcome-card:hover { transform: translateY(-3px); box-shadow: 0 0.75rem 2rem rgba(0,0,0,0.15); }
        .action-btns .btn { margin: 0 3px; }
        .table th { white-space: nowrap; }
        .modal-header { background-color: #0d6efd; color: #fff; }

        /* Footer styles */
        .footer { margin-top: auto; }
        .footer h5 { position: relative; margin-bottom: 1.5rem; font-weight: 600; }
        .footer h5::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background: rgba(255,255,255,0.3);
            bottom: -10px;
            left: 0;
            border-radius: 2px;
        }
        .footer .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
        }
        .footer .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background: rgba(255,255,255,0.1);
            border-radius: 50%;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        .footer .social-links a:hover {
            background: white;
            color: #764ba2;
            transform: translateY(-3px);
        }
        .footer a.text-white {
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .footer a.text-white:hover {
            text-decoration: underline;
            opacity: 0.9;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span class="d-flex flex-column">
                <span style="font-weight: 700; font-size: 1.4rem;">Milklore</span>
                <span style="font-size: 0.8rem; opacity: 0.9;">Tales and Taste of Tradition</span>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminSuccess?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToMilkSuppliersList?email=${dto.email}&page=1&size=10">
                        <i class="fa-solid fa-bottle-droplet me-1"></i> Milk Suppliers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToProductsPrice?email=${dto.email}"><i
                            class="fa-solid fa-tag me-2"></i> Products Price</a>
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
                    <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="profileDropdown">
                        <li><a class="dropdown-item" href="viewProfile?email=${dto.email}"><i
                                class="bi bi-person-circle me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main content -->
<div class="container" style="margin-top: 80px;">
    <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2><i class="fas fa-cow me-2"></i> Milk Suppliers</h2>
        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addSupplierModal">
            <i class="fas fa-plus me-1"></i> Add Supplier
        </button>

        <form action="searchSuppliers" method="get" class="d-flex">
            <input type="hidden" name="email" value="${dto.email}">
            <input type="text" name="keyword" class="form-control me-2" placeholder="Search suppliers...">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <!-- Toast Notifications -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
        <c:if test="${not empty success}">
            <div class="toast align-items-center text-bg-success border-0 show" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-check-circle me-2"></i>${success}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                            data-bs-dismiss="toast"></button>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="toast align-items-center text-bg-danger border-0 show" role="alert">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto"
                            data-bs-dismiss="toast"></button>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Table Card -->
    <div class="card shadow-sm">
        <div class="card-body table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-primary">
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Milk Type</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${milkSuppliers}" var="supplier" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td><i class="fas fa-user me-1 text-muted"></i>${supplier.firstName} ${supplier.lastName}</td>
                        <td>${supplier.email}</td>
                        <td>${supplier.phoneNumber}</td>
                        <td><span class="badge bg-info text-dark">${supplier.typeOfMilk}</span></td>
                        <td>${supplier.address}</td>
                        <td class="action-btns">
                            <button type="button" class="btn btn-primary btn-sm me-2 viewSupplierBtn"
                                    data-bs-toggle="modal" data-bs-target="#viewSupplierModal"
                                    data-firstname="${supplier.firstName}" data-lastname="${supplier.lastName}"
                                    data-email="${supplier.email}" data-phone="${supplier.phoneNumber}"
                                    data-address="${supplier.address}" data-milk="${supplier.typeOfMilk}">
                                <i class="fa-solid fa-eye"></i> View
                            </button>
                            <button class="btn btn-warning btn-sm edit-btn"
                                    data-id="${supplier.supplierId}"
                                    data-firstname="${supplier.firstName}"
                                    data-lastname="${supplier.lastName}"
                                    data-email="${supplier.email}"
                                    data-phone="${supplier.phoneNumber}"
                                    data-type="${supplier.typeOfMilk}"
                                    data-address="${supplier.address}">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button type="button"
                                    class="btn btn-danger btn-sm delete-btn"
                                    data-email="${supplier.email}"
                                    data-admin="${dto.email}">
                                <i class="fas fa-trash"></i>
                            </button>

                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty milkSuppliers}">
                    <tr>
                        <td colspan="7" class="text-center text-muted">No suppliers found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="d-flex justify-content-center mt-3">
                <c:if test="${currentPage > 1}">
                    <a class="btn btn-outline-secondary me-2"
                       href="?email=${dto.email}&page=${currentPage - 1}&size=${pageSize}">Previous</a>
                </c:if>
                <span class="align-self-center"> Page ${currentPage} of ${totalPages} </span>
                <c:if test="${currentPage < totalPages}">
                    <a class="btn btn-outline-secondary ms-2"
                       href="?email=${dto.email}&page=${currentPage + 1}&size=${pageSize}">Next</a>
                </c:if>
            </div>
            <!-- End Pagination -->

        </div>
    </div>

</div>

<!-- Add Supplier Modal -->
<div class="modal fade" id="addSupplierModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content shadow">
            <form action="registerSupplier" method="post" id="supplierForm">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-plus-circle me-2"></i>Add Supplier</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="supplierId">
                    <input type="hidden" name="adminEmail" value="${dto.email}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" id="firstName" class="form-control" name="firstName" required>
                            <small id="firstNameError"></small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                            <small id="lastNameError"></small>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                            <small id="emailError"></small>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            <small id="phoneNumberError"></small>
                        </div>
                        <div class="col-12">
                            <label for="typeOfMilk" class="form-label">Type of Milk</label>
                            <select class="form-select" id="typeOfMilk" name="typeOfMilk" required>
                                <option value="">Select milk type</option>
                            </select>
                            <div id="typeOfMilkError" class="error-msg text-danger small"></div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            <small id="addressError"></small>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Save Supplier</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--view supplier-->
<div class="modal fade" id="viewSupplierModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content border-0 shadow">
            <div class="modal-header text-white" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <h5 class="modal-title fw-bold">
                    <i class="fas fa-user-circle me-2"></i>Supplier Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="bg-light p-3 rounded-3 mb-3">
                            <p class="mb-2 text-muted small">First Name</p>
                            <h6 class="mb-0" id="modalFirstName"></h6>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light p-3 rounded-3 mb-3">
                            <p class="mb-2 text-muted small">Last Name</p>
                            <h6 class="mb-0" id="modalLastName"></h6>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light p-3 rounded-3 mb-3">
                            <p class="mb-2 text-muted small">Email Address</p>
                            <h6 class="mb-0" id="modalEmail"></h6>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="bg-light p-3 rounded-3 mb-3">
                            <p class="mb-2 text-muted small">Phone Number</p>
                            <h6 class="mb-0" id="modalPhone"></h6>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="bg-light p-3 rounded-3 mb-3">
                            <p class="mb-2 text-muted small">Address</p>
                            <h6 class="mb-0" id="modalAddress"></h6>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="bg-light p-3 rounded-3">
                            <p class="mb-2 text-muted small">Type of Milk</p>
                            <h6 class="mb-0">
                                <span class="badge"
                                      style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;"
                                      id="modalMilk"></span>
                            </h6>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times me-1"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Edit Modal (similar styling as Add) -->
<div class="modal fade" id="editSupplierModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content shadow">
            <form action="updateMilkSupplier" method="post" id="editSupplierForm">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Edit Supplier</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="supplierId" id="editSupplierId">
                    <input type="hidden" name="adminEmail" value="${dto.email}">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" id="editFirstName" name="firstName" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="editLastName" name="lastName" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" id="editEmail" name="email" readonly>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="editPhoneNumber" name="phoneNumber" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Type of Milk</label>
                            <select class="form-select" id="editTypeOfMilk" name="typeOfMilk" required>
                                <option>Cow Milk</option>
                                <option>Buffalo Milk</option>
                                <option>Goat Milk</option>
                                <option>A2 Milk</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" id="editAddress" name="address" rows="3" required></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button class="btn btn-primary">Update Supplier</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-0">Are you sure you want to delete this supplier?</p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a id="confirmDeleteBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-auto py-4 text-white" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <h5>Milklore</h5>
                <p>Tales and Taste of Tradition. Finest dairy products with a touch of heritage.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
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
                <p>Subscribe to our newsletter for the latest updates.</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control" placeholder="Your email" aria-label="Your email"
                           aria-describedby="button-addon2">
                    <button class="btn btn-outline-light" type="button" id="button-addon2">Subscribe</button>
                </div>
            </div>
        </div>
        <hr class="mt-4" style="background-color: rgba(255,255,255,0.1);">
        <div class="text-center">
            <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/supplier-validation.js"></script>
</body>
</html>
