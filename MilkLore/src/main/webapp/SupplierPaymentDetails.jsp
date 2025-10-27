<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MilkLore | Payment Status</title>
    <link rel="shortcut icon" href="images/milklore.png" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="css/style.css" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand img {
            transition: transform 0.3s ease;
        }

        .navbar-brand img:hover {
            transform: scale(1.05);
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: #e0e0e0 !important;
            transform: translateY(-2px);
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .card-header {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.25rem;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .status-pending {
            color: #dc3545;
            font-weight: 600;
        }

        .status-paid {
            color: #198754;
            font-weight: 600;
        }

        .profile-img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .modal-header {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white;
        }

        .modal-header .btn-close {
            filter: invert(1);
        }

        footer {
            background: linear-gradient(135deg, #1b5e20, #2e7d32);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }

        .social-links a {
            color: white;
            font-size: 1.2rem;
            margin-right: 15px;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            color: #e0e0e0;
            transform: translateY(-3px);
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="images/milklore.png" alt="MilkLore Logo" height="60" />
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="redirectToSupplierDashboard?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToMilkCollection?email=${dto.email}">
                        <i class="fas fa-fw fa-tachometer-alt me-2"></i>Milk Collection
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="redirectToPaymentStatus?email=${dto.email}">
                        <i class="fas fa-rupee-sign me-2"></i>Payment Status
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="images/dummy-profile.png" alt="Profile" class="profile-img rounded-circle">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile"
                                     class="profile-img rounded-circle">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#supplierProfileModal">
                                <i class="fas fa-user me-2"></i>View Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#supplierBankModal">
                                <i class="fas fa-university me-2"></i>Bank Details
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="supplierLogout?email=${dto.email}">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main class="flex-grow-1" style="margin-top: 80px; margin-bottom: 40px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-rupee-sign me-2"></i>Payment History</h4>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>Period Start</th>
                                    <th>Period End</th>
                                    <th class="text-end">Amount (₹)</th>
                                    <th>Payment Date</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="record" items="${paymentList}">
                                    <tr>
                                        <td><fmt:formatDate value="${record.periodStart}" pattern="dd MMM yyyy" /></td>
                                        <td><fmt:formatDate value="${record.periodEnd}" pattern="dd MMM yyyy" /></td>
                                        <td class="text-end"><fmt:formatNumber value="${record.totalAmount}" maxFractionDigits="2" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty record.paymentDate}">
                                                    <fmt:formatDate value="${record.paymentDate}" pattern="dd MMM yyyy" />
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${record.paymentStatus eq 'PENDING'}">
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </c:when>
                                                <c:when test="${record.paymentStatus eq 'PAID'}">
                                                    <span class="badge bg-success">Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${record.paymentStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty paymentList}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4">
                                            <div class="text-muted">
                                                <i class="fas fa-inbox fa-3x mb-3"></i>
                                                <p class="mb-0">No payment records found</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Profile Modal -->
<div class="modal fade" id="supplierProfileModal" tabindex="-1" aria-labelledby="supplierProfileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="supplierProfileModalLabel">
                    <i class="fas fa-user-circle me-2"></i>Supplier Profile
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-4">
                    <c:choose>
                        <c:when test="${empty dto.profilePath}">
                            <img src="images/dummy-profile.png" alt="Profile"
                                 class="rounded-circle" width="150" height="150" style="object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile"
                                 class="rounded-circle" width="150" height="150" style="object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card p-3 shadow-sm">
                    <div class="mb-3">
                        <h6 class="text-muted mb-1">Full Name</h6>
                        <p class="mb-0">${dto.firstName} ${dto.lastName}</p>
                    </div>
                    <div class="mb-3">
                        <h6 class="text-muted mb-1">Email</h6>
                        <p class="mb-0 text-break">${dto.email}</p>
                    </div>
                    <div class="mb-3">
                        <h6 class="text-muted mb-1">Phone</h6>
                        <p class="mb-0">${dto.phoneNumber}</p>
                    </div>
                    <div>
                        <h6 class="text-muted mb-1">Milk Type</h6>
                        <p class="mb-0">${dto.typeOfMilk}</p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <a href="redirectToUpdateSupplierProfile?email=${dto.email}" class="btn btn-primary">
                    <i class="fas fa-edit me-1"></i>Update Profile
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Bank Details Modal -->
<div class="modal fade" id="supplierBankModal" tabindex="-1" aria-labelledby="supplierBankModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="supplierBankModalLabel">
                    <i class="fas fa-university me-2"></i>Bank Details
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <c:choose>
                    <c:when test="${empty dto.supplierBankDetails}">
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>No bank details found. Please add your bank details.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-light p-3 rounded-circle me-3">
                                            <i class="fas fa-university text-primary fa-lg"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-0">Bank Name</h6>
                                            <p class="mb-0">${dto.supplierBankDetails.bankName}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-light p-3 rounded-circle me-3">
                                            <i class="fas fa-code-branch text-primary fa-lg"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-0">Branch</h6>
                                            <p class="mb-0">${dto.supplierBankDetails.bankBranch}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-light p-3 rounded-circle me-3">
                                            <i class="fas fa-hashtag text-primary fa-lg"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-0">Account Number</h6>
                                            <p class="mb-0">${dto.supplierBankDetails.accountNumber}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-light p-3 rounded-circle me-3">
                                            <i class="fas fa-key text-primary fa-lg"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-0">IFSC Code</h6>
                                            <p class="mb-0">${dto.supplierBankDetails.IFSCCode}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-light p-3 rounded-circle me-3">
                                            <i class="fas fa-credit-card text-primary fa-lg"></i>
                                        </div>
                                        <div>
                                            <h6 class="text-muted mb-0">Account Type</h6>
                                            <p class="mb-0">${dto.supplierBankDetails.accountType}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="alert alert-info mt-4" role="alert">
                                <i class="fas fa-info-circle me-2"></i>To update bank details, please contact Admin.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <c:if test="${empty dto.supplierBankDetails}">
                    <a href="redirectToUpdateSupplierBankDetails?email=${dto.email}" class="btn btn-primary">
                        <i class="fas fa-plus-circle me-1"></i>Add Bank Details
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="mt-5">
    <div class="container py-4">
        <div class="row">
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="mb-3">MilkLore</h5>
                <p class="mb-2">
                    <i class="fas fa-map-marker-alt me-2"></i> 123 Dairy Farm Road, Bangalore, Karnataka 560001
                </p>
                <p class="mb-2">
                    <i class="fas fa-phone me-2"></i> +91 98765 43210
                </p>
                <p class="mb-0">
                    <i class="fas fa-envelope me-2"></i> info@milklore.com
                </p>
            </div>
            <div class="col-md-4 mb-4 mb-md-0">
                <h5 class="mb-3">Quick Links</h5>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none">Home</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none">About Us</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none">Services</a></li>
                    <li class="mb-2"><a href="#" class="text-white text-decoration-none">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5 class="mb-3">Follow Us</h5>
                <div class="social-links mb-3">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <div class="mt-4">
                    <p class="mb-2">Subscribe to our newsletter</p>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email">
                        <button class="btn btn-light" type="button">Subscribe</button>
                    </div>
                </div>
            </div>
        </div>
        <hr class="my-4 bg-light">
        <div class="row">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2023 MilkLore. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-white text-decoration-none me-3">Privacy Policy</a>
                <a href="#" class="text-white text-decoration-none">Terms of Service</a>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-hide alert messages after 5 seconds
    setTimeout(function() {
        var alert = document.querySelector('.alert');
        if (alert) {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(function() {
                alert.remove();
            }, 500);
        }
    }, 5000);
</script>
</body>
</html>