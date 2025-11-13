<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/includes/sessionCheck.jspf" %>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Payment Details - Milklore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f8f9fc;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-top: 70px;
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
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 0.75rem 2rem rgba(0,0,0,0.12);
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 1rem 1rem 0 0 !important;
            padding: 1.25rem 1.5rem;
            font-weight: 600;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 4px solid #fff;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.1);
        }
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
        }
        .text-primary {
            color: #667eea !important;
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminSuccess?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminPaymentHistory?email=${dto.email}&page=1&size=10"><i
                            class="fa-solid fa-money-bill-transfer me-2"></i> Payment History</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToCollectMilk?email=${dto.email}">
                        <i class="fa-solid fa-box me-2"></i> Manage Products
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToProductsPrice?email=${dto.email}">
                        <i class="fa-solid fa-tag me-2"></i> Products Price
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToMilkSuppliersList?email=${dto.email}&page=1&size=10">
                        <i class="fa-solid fa-bottle-droplet me-2"></i> Milk Suppliers
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="redirectToCollectMilk?email=${dto.email}">
                        <i class="fa-solid fa-glass-water-droplet me-2"></i> Milk Receiver Details
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link position-relative" href="#" id="notificationDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-bell fa-lg"></i>
                        <c:if test="${unreadCount > 0}">
                                <span
                                        class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${unreadCount}
                                </span>
                        </c:if>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown"
                        style="width: 350px; max-height: 400px; overflow-y: auto;">
                        <li>
                            <h6 class="dropdown-header">Notifications</h6>
                        </li>

                        <c:choose>
                            <c:when test="${empty notifications}">
                                <li>
                                    <span class="dropdown-item text-muted">No new notifications</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="notification" items="${notifications}">
                                    <li data-notification-id="${notification.id}" data-admin-email="${dto.email}"
                                        data-notification-type="${notification.notificationType}">
                                        <a class="dropdown-item notification-item" href="#"
                                           data-notification-id="${notification.id}"
                                           data-admin-email="${dto.email}"
                                           data-notification-type="${notification.notificationType}">
                                            <i class="fas fa-bell me-2"></i>
                                            ${notification.message}
                                            <br />
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
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
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#adminProfileModal"><i class="bi bi-person-circle me-2"></i> View Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="adminLogout?email=${dto.email}"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <!-- Profile Card -->
            <div class="card mb-4">
                <div class="card-header d-flex align-items-center">
                    <i class="fas fa-user-circle me-2"></i>
                    <span>Supplier Profile</span>
                </div>
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center mb-4 mb-md-0">
                            <c:choose>
                                <c:when test="${empty supplier.profilePath}">
                                    <img src="images/default.png" alt="Profile" class="rounded-circle profile-img">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/uploads/${supplier.profilePath}'/>" alt="Profile" class="rounded-circle profile-img">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-9">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <h5 class="fw-bold mb-3">${supplier.firstName} ${supplier.lastName}</h5>
                                    <p class="mb-2"><i class="fas fa-envelope me-2 text-primary"></i> ${supplier.email}</p>
                                    <p class="mb-2"><i class="fas fa-phone me-2 text-primary"></i> ${supplier.phoneNumber}</p>
                                    <p class="mb-0"><i class="fas fa-map-marker-alt me-2 text-primary"></i> ${supplier.address}</p>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="text-uppercase text-muted mb-3">Bank Details</h6>
                                    <c:choose>
                                        <c:when test="${not empty supplier.supplierBankDetails}">
                                            <p class="mb-2"><i class="fas fa-university me-2 text-primary"></i> ${supplier.supplierBankDetails.bankName}</p>
                                            <p class="mb-2"><i class="fas fa-credit-card me-2 text-primary"></i> ${supplier.supplierBankDetails.accountNumber}</p>
                                            <p class="mb-2"><i class="fas fa-code me-2 text-primary"></i> ${supplier.supplierBankDetails.IFSCCode}</p>
                                            <p class="mb-0"><i class="fas fa-code-branch me-2 text-primary"></i> ${supplier.supplierBankDetails.bankBranch}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-warning">
                                                <i class="fas fa-exclamation-triangle me-2"></i> No bank details found. Please update your bank information.
                                            </div>
                                            <form action="/MilkLore/requestSupplierBankDetails" method="post" class="mt-3">
                                                <input type="hidden" name="supplierEmail" value="${supplier.email}" />
                                                <input type="hidden" name="adminEmail" value="${dto.email}" />
                                                <input type="hidden" name="notificationId" value="${notificationId}">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-envelope me-2"></i>Request Bank Details
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Milk Collection Details -->
            <div class="card">
                <div class="card-header d-flex align-items-center">
                    <i class="fas fa-glass-water me-2"></i>
                    <span>Milk Collection History</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                            <tr>
                                <th>Date</th>
                                <th>Milk Type</th>
                                <th>Quantity (L)</th>
                                <th>Rate (₹/L)</th>
                                <th>Total (₹)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${not empty milkList}">
                                    <c:forEach var="milk" items="${milkList}">
                                        <tr>
                                            <td>${milk.collectedDate}</td>
                                            <td>${milk.typeOfMilk}</td>
                                            <td>${milk.quantity}</td>
                                            <td>₹${milk.price}</td>
                                            <td class="fw-bold">₹${milk.totalAmount}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-4">
                                            <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                            <p class="mb-0">No milk collection records found</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Payment Section -->
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-header d-flex align-items-center">
                    <i class="fas fa-money-bill-wave me-2"></i>
                    <span>Payment Details</span>
                </div>
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5 class="mb-0">Total Amount to Pay:</h5>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <h4 class="text-success mb-0">₹
                                <c:set var="totalAmount" value="${0}"/>
                                <c:forEach var="milk" items="${milkList}">
                                    <c:set var="totalAmount" value="${totalAmount + milk.totalAmount}"/>
                                </c:forEach>
                                <fmt:formatNumber value="${totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </h4>
                        </div>
                    </div>
                    <div class="mt-4 text-end">
                        <c:choose>
                            <c:when test="${not empty supplier.supplierBankDetails}">
                                <form action="payToSupplier" method="post" class="d-inline">
                                    <input type="hidden" name="supplierEmail" value="${supplier.email}"/>
                                    <input type="hidden" name="notificationId" value="${notificationId}">
                                    <input type="hidden" name="email" value="${dto.email}">
                                    <button type="submit" class="btn btn-primary btn-lg px-4">
                                        <i class="fas fa-money-bill-wave me-2"></i>Pay Now
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-secondary btn-lg px-4" disabled>
                                    <i class="fas fa-money-bill-wave me-2"></i>Payment Unavailable
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-auto">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Milklore</h5>
                <p class="mb-0">Tales and Taste of Tradition</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="mb-0">&copy; 2023 Milklore. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            setTimeout(function() {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }, 5000);
        });
    });
</script>
</body>
</html>