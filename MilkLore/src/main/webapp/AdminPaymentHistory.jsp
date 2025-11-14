<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes/sessionCheck.jspf" %>
<html lang="en" xmlns:c="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MilkLore | Payment History</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background-color: #f8f9fc; color: #333; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
       .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15); padding: 0.8rem 0; }
       .navbar-brand { font-weight: 700; color: white !important; }
       .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 500; padding: 0.5rem 1rem !important; transition: all 0.3s ease; }
       .nav-link:hover { color: white !important; transform: translateY(-1px); }
       .welcome-card { background: white; border-radius: 1rem; box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.1); padding: 2rem; text-align: center; transition: all 0.3s ease; }
       .welcome-card:hover { transform: translateY(-3px); box-shadow: 0 0.75rem 2rem rgba(0,0,0,0.15); }
       .footer { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2.5rem 0 1.5rem; margin-top: auto; }
       .footer h5::after { content: ''; position: absolute; width: 50px; height: 3px; background: rgba(255,255,255,0.3); bottom: -10px; left: 0; border-radius: 2px; }
       .social-links { display: flex; gap: 1rem; margin-top: 1.5rem; }
       .social-links a { display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: rgba(255,255,255,0.1); border-radius: 50%; color: white; font-size: 1.25rem; transition: all 0.3s ease; }
       .social-links a:hover { background: white; color: #764ba2; transform: translateY(-3px); }
       /* Add this to your CSS */
#notificationList {
   max-height: 300px;
   overflow-y: auto;
}
.notification-item {
   font-weight: bold;
}
#notificationList .list-group-item {
   cursor: pointer;
   transition: background-color 0.2s;
}

#notificationList .list-group-item:hover {
   background-color: #f8f9fa;
}

#notificationList .list-group-item.fw-bold {
   background-color: #f8f9fa;
}

#notificationCount {
   font-size: 0.75em;
   padding: 0.25em 0.5em;
   border-radius: 10px;
}
       body {
           overflow-y: auto !important;
       }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

<<!-- Navbar -->
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
                aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item">
                    <a class="nav-link" href="redirectToProductsPrice"><i
                            class="fa-solid fa-tag me-2"></i> Products Price</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToCollectMilk"><i
                            class="fa-solid fa-glass-water-droplet me-2"></i> Collect Milk</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="redirectToMilkSuppliersList?page=1&size=10">
                        <i class="fa-solid fa-glass-water-droplet me-2"></i> Milk Supplier Details
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="redirectToGetCollectMilkList">
                        <i class="fa-solid fa-glass-water-droplet me-2"></i> Milk Product List
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToAdminSuccess?page=1&size=10"><i
                            class="fa-solid fa-grip"></i> DashBoard</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link position-relative" href="#" id="notificationDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-bell-fill"></i>
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
                <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button"
                   data-bs-toggle="dropdown" aria-expanded="false">
                    <c:choose>
                        <c:when test="${empty dto.profilePath}">
                            <img src="images/dummy-profile.png" alt="Profile" class="rounded-circle" width="40"
                                 height="40" style="object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile"
                                 class="rounded-circle" width="40" height="40" style="object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                </a>

                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal"
                           data-bs-target="#adminProfileModal"><i class="fa-solid fa-user me-2"></i>View
                        Profile</a></li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <a class="dropdown-item text-danger" href="adminLogout"><i
                                class="fa-solid fa-right-from-bracket me-2"></i> Logout</a>
                    </li>
                </ul>
            </ul>
        </div>
    </div>
</nav>

<!-- MAIN CONTENT -->
<main class="container my-5 pt-5">

    <h2 class="text-center mb-4">Payment History</h2>

    <c:if test="${empty paymentList}">
        <p class="text-center fw-bold text-danger">No payment records found.</p>
    </c:if>

    <c:if test="${not empty paymentList}">
        <div class="d-flex justify-content-center">
            <div class="table-responsive w-100" style="max-width: 1000px;">
                <table class="table table-bordered table-hover align-middle text-center">
                    <thead>
                    <tr class="fw-bold">
                        <th>Supplier Name</th>
                        <th>Admin Name</th>
                        <th>Period</th>
                        <th>Payment Date</th>
                        <th>Payment Status</th>
                        <th>Total Amount</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="payment" items="${paymentList}">
                        <tr>
                            <td>${payment.supplier.firstName} ${payment.supplier.lastName}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${empty payment.admin.adminName}">-</c:when>
                                    <c:otherwise>${payment.admin.adminName}</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${payment.periodStart} to ${payment.periodEnd}</td>
                            <td>${payment.paymentDate}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${payment.paymentStatus eq 'PENDING'}">
                                        <span class="text-danger fw-semibold">${payment.paymentStatus}</span>
                                    </c:when>
                                    <c:when test="${payment.paymentStatus eq 'PAID'}">
                                        <span class="text-success fw-semibold">${payment.paymentStatus}</span>
                                    </c:when>
                                    <c:otherwise>
                                        ${payment.paymentStatus}
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${payment.totalAmount}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="d-flex justify-content-center gap-3 mt-3">
                    <c:if test="${currentPage > 1}">
                        <a class="btn btn-outline-success"
                           href="redirectToAdminPaymentHistory?page=${currentPage - 1}&size=${pageSize}">
                            Previous
                        </a>
                    </c:if>

                    <span class="fw-semibold">Page ${currentPage} of ${totalPages}</span>

                    <c:if test="${currentPage < totalPages}">
                        <a class="btn btn-outline-success"
                           href="redirectToAdminPaymentHistory?page=${currentPage + 1}&size=${pageSize}">
                            Next
                        </a>
                    </c:if>
                </div>

            </div>
        </div>
    </c:if>

</main>

<!-- FOOTER -->
<footer class="text-center mt-auto py-3 bg-light">
    <span class="fw-semibold">© 2025 MilkLore. All Rights Reserved.</span>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/admin-notification.js"></script>
</body>
</html>
