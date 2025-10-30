<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform" xmlns:jsp="" xmlns:fmt="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Receive - MilkLore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
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
            color: #fff;
            transition: all 0.3s ease;
        }
        .footer .social-links a:hover {
            background: #fff;
            color: #667eea;
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span class="d-flex flex-column">
                <span>MilkLore</span>
                <small class="text-white-50" style="font-size: 0.7rem; line-height: 1;">Dairy Management</small>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="toSuppliersList?email=${dto.email}"><i class="fas fa-users me-1"></i>
                        Suppliers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminSuccess?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="toProductReceive?email=${dto.email}"><i
                            class="fas fa-truck-loading me-1"></i> Product
                        Receive</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="toManageProducts?email=${dto.email}"><i class="fas fa-boxes me-1"></i>
                        Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminPaymentHistory?email=${dto.email}&page=1&size=10"><i
                            class="fa-solid fa-money-bill-transfer me-2"></i> Payment History</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="toProductsPrice?email=${dto.email}"><i class="fas fa-tags me-1"></i>
                        Pricing</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToCollectMilk?email=${dto.email}"><i
                            class="fa-solid fa-glass-water-droplet me-2"></i> Collect Milk</a>
                </li>
                <!-- Notification Dropdown -->
                <li class="nav-item dropdown ms-3">
                    <a class="nav-link position-relative" href="#" id="notificationDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-bell-fill"></i>
                        <c:if test="${unreadCount > 0}">
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
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
                                <li><span class="dropdown-item text-muted">No new notifications</span></li>
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
                                        </a>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
                <!-- Profile Dropdown -->
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
<br>

<!-- Main Content -->
<div class="container" style="margin-top: 80px;">
    <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h2><i class="fas fa-truck-loading me-2"></i> Product Receive</h2>
        <button type="button"
                class="btn btn-primary"
                data-email="${dto.email}"
                data-bs-toggle="modal"
                data-bs-target="#addProductReceiveModal">
            <i class="fas fa-plus me-1"></i> Receive Product
        </button>
    </div>

    <!-- Form to get milk collection list for a specific date -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <jsp:useBean id="now" class="java.util.Date"/>
            <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>

            <form action="getCollectMilkList" method="get" class="row g-3" id="milkListForm">
                <input type="hidden" name="email" value="${dto.email}">
                <div class="col-md-4">
                    <label for="collectedDate" class="form-label">Collected Date</label>
                    <input type="date" id="collectedDate" name="collectedDate" class="form-control"
                           value="<c:choose>
                         <c:when test='${not empty param.collectedDate}'>
                             ${param.collectedDate}
                         </c:when>
                         <c:otherwise>${today}</c:otherwise>
                      </c:choose>">
                </div>
                <div class="col-md-4 align-self-end">
                    <button type="submit" class="btn btn-primary">Get List</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Display milk collection list -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-primary">
                    <tr>
                        <th>Name</th>
                        <th>Phone Number</th>
                        <th>Type of Milk</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="milk" items="${collectMilkList}">
                        <tr>
                            <td>${milk.supplier.firstName} ${milk.supplier.lastName}</td>
                            <td>${milk.supplier.phoneNumber}</td>
                            <td>${milk.typeOfMilk}</td>
                            <td>${milk.price}</td>
                            <td>${milk.quantity}</td>
                            <td>${milk.totalAmount}</td>
                            <td>

                                <button type="button"
                                        class="btn btn-info btn-sm view-details-btn"
                                        data-bs-toggle="modal"
                                        data-bs-target="#milkDetailsModal"
                                        data-name="${milk.supplier.firstName} ${milk.supplier.lastName}"
                                        data-email="${milk.supplier.email}"
                                        data-phone="${milk.supplier.phoneNumber}"
                                        data-address="${milk.supplier.address}"
                                        data-milk="${milk.supplier.typeOfMilk}"
                                        data-quantity="${milk.quantity}"
                                        data-typeMilk="${milk.typeOfMilk}"
                                        data-price="${milk.price}"
                                        data-total="${milk.totalAmount}"
                                        data-date="${milk.collectedDate}"
                                >
                                    <i class="fa fa-eye"></i> View
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty collectMilkList}">
                        <tr>
                            <td colspan="8" class="text-center">No milk collections found for this date.</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- Milk Details Modal -->
<div class="modal fade" id="milkDetailsModal" tabindex="-1" aria-labelledby="milkDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content shadow-lg border-0 rounded-4">
            <div class="modal-header text-white"
                 style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-top-left-radius: 1rem; border-top-right-radius: 1rem;">
                <h5 class="modal-title fw-bold" id="milkDetailsModalLabel">
                    <i class="fa fa-info-circle me-2"></i>Milk Collection Details
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                        aria-label="Close"></button>
            </div>

            <div class="modal-body p-4" id="milkDetailsModalBody">
                <!-- Content dynamically injected by JS -->
                <div class="text-center text-muted py-5">
                    <i class="fa fa-spinner fa-spin fa-2x mb-3"></i>
                    <p>Loading details...</p>
                </div>
            </div>

            <div class="modal-footer bg-light rounded-bottom-4">
                <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">
                    <i class="fa fa-times me-1"></i> Close
                </button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
      const dateInput = document.getElementById("collectedDate");
      const form = document.getElementById("milkListForm");

      if (dateInput) {
        // 1️⃣ Set today's date if empty
        if (!dateInput.value) {
          const today = new Date();
          const formatted = today.toISOString().split("T")[0];
          dateInput.value = formatted;
        }

        // 2️⃣ Automatically submit the form if no param.collectedDate was passed
        const urlParams = new URLSearchParams(window.location.search);
        if (!urlParams.has("collectedDate")) {
          form.submit();
        }
      }
    });
</script>

<script src="js/get-milk-product-receive.js"></script>
<script src="js/admin-notification.js"></script>
</body>
</html>