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
        body {
            background-color: #f8f9fa;
        }
        #sidebar {
            min-height: 100vh;
        }
        #sidebar .nav-link:hover {
            background: #495057;
            border-radius: 5px;
        }
        .table th {
            white-space: nowrap;
        }
        .modal-header {
            background-color: #0d6efd;
            color: #fff;
        }
        .action-btns .btn {
            margin: 0 3px;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">MilkLore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
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
                        <li><a class="dropdown-item" href="viewProfile?email=${dto.email}"><i class="bi bi-person-circle me-2"></i> Profile</a></li>
                        <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="redirectToAdminSuccess?email=${dto.email}">
                            <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white active bg-primary rounded"
                           href="redirectToMilkSuppliersList?email=${dto.email}">
                            <i class="fas fa-truck me-2"></i> Milk Suppliers
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2><i class="fas fa-cow me-2"></i> Milk Suppliers</h2>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addSupplierModal">
                    <i class="fas fa-plus me-1"></i> Add Supplier
                </button>
            </div>

            <!-- Toast Notifications -->
            <div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
                <c:if test="${not empty success}">
                    <div class="toast align-items-center text-bg-success border-0 show" role="alert">
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="fas fa-check-circle me-2"></i>${success}
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="toast align-items-center text-bg-danger border-0 show" role="alert">
                        <div class="d-flex">
                            <div class="toast-body">
                                <i class="fas fa-exclamation-circle me-2"></i>${error}
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
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
                                <td>
                                    <span class="badge bg-info text-dark">${supplier.typeOfMilk}</span>
                                </td>
                                <td>${supplier.address}</td>
                                <td class="action-btns">
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
                                    <a href="deleteMilkSupplier?email=${supplier.email}&adminEmail=${dto.email}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this supplier?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
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
                </div>
            </div>
        </main>
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
                            <input type="text" class="form-control" name="firstName" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" name="lastName" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phoneNumber" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Type of Milk</label>
                            <select class="form-select" name="typeOfMilk" required>
                                <option value="">Select</option>
                                <option>Cow Milk</option>
                                <option>Buffalo Milk</option>
                                <option>Goat Milk</option>
                                <option>A2 Milk</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address" rows="3" required></textarea>
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

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    $(function () {
        $('.edit-btn').on('click', function () {
            $('#editSupplierId').val($(this).data('id'));
            $('#editFirstName').val($(this).data('firstname'));
            $('#editLastName').val($(this).data('lastname'));
            $('#editEmail').val($(this).data('email'));
            $('#editPhoneNumber').val($(this).data('phone'));
            $('#editTypeOfMilk').val($(this).data('type'));
            $('#editAddress').val($(this).data('address'));
            new bootstrap.Modal(document.getElementById('editSupplierModal')).show();
        });
    });
</script>
</body>
</html>
