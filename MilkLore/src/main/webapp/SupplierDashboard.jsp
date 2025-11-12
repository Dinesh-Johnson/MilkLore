<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore | Supplier Dashboard</title>
    <link rel="shortcut icon" href="images/milklore.png" type="image/x-icon">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <style>

        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #6b8cae;
            --accent-color: #ff6b6b;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            color: var(--dark-text);
        }

        .navbar-custom {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--accent-color) !important;
            transform: translateY(-2px);
        }

        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .stat-card {
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
        }

        .stat-card i {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .profile-img {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border: 2px solid white;
        }

        .welcome-section {
            background: linear-gradient(rgba(255,255,255,0.9), rgba(255,255,255,0.9)),
                        url('images/milk-pattern.png');
            background-size: cover;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="images/milklore.png" alt="Milklore" height="40" class="me-2">
            <span class="fw-bold">Milklore</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="redirectToSupplierDashboard?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToMilkCollection?email=${dto.email}">
                        <i class="fas fa-fw fa-cow me-1"></i> Milk Collection
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="getCollectMilkListBySupplierEmail?email=${dto.email}">
                        <i class="fas fa-fw fa-cow me-1"></i> View Milk Collection
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="redirectToPaymentStatus?email=${dto.email}">
                        <i class="fas fa-money-bill-wave me-1"></i> Payments
                    </a>
                </li>
                <li class="nav-item dropdown ms-lg-2">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="images/default-avatar.png" class="profile-img rounded-circle me-2" alt="Profile">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="profile-img rounded-circle me-2" alt="Profile">
                            </c:otherwise>
                        </c:choose>
                        <span>${dto.firstName}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#profileModal">
                                <i class="fas fa-user-circle me-2"></i>My Profile
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal"
                               data-bs-target="#supplierBankModal"><i
                                class="fa-solid fa-building-columns me-2"></i>View Bank Details</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item text-danger" href="logoutSupplier">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<!-- Main Content -->
<div class="container" style="margin-top: 80px;">

    <!-- Welcome Section -->
    <div class="welcome-section p-4 mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold mb-2">Welcome back, ${dto.firstName}!</h2>
                <p class="text-muted mb-0">Here’s your complete dashboard overview.</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                <span class="badge bg-primary p-2">
                    <i class="fas fa-shield-alt me-1"></i> Supplier Account
                </span>
            </div>
        </div>
    </div>

    <!-- Dashboard Stats -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stat-card bg-primary rounded-3 h-100 p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Total Milk Collected</h6>
                        <h2 class="mb-0 text-white">${totalLitres} Ltr</h2>
                    </div>
                    <div class="icon-shape bg-white bg-opacity-10 rounded-circle p-3">
                        <i class="fas fa-fw fa-cow text-white"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card bg-success rounded-3 h-100 p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Total Amount Paid</h6>
                        <h2 class="mb-0 text-white">${totalAmountPaid}</h2>
                    </div>
                    <div class="icon-shape bg-white bg-opacity-10 rounded-circle p-3">
                        <i class="fas fa-fw fa-wallet text-white"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-card bg-warning rounded-3 h-100 p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Last Collection Date</h6>
                        <h2 class="mb-0 text-white">${lastCollectedDate}</h2>
                    </div>
                    <div class="icon-shape bg-white bg-opacity-10 rounded-circle p-3">
                        <i class="fas fa-fw fa-calendar-check text-white"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Two-Column Layout -->
    <div class="row">
        <!-- Left Side: Tables -->
        <div class="col-lg-8">

            <!-- Milk Collections -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white border-0 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-cow me-2 text-primary"></i>Recent Milk Collections</h5>
                    <a href="getCollectMilkListBySupplierEmail?email=${dto.email}" class="btn btn-sm btn-outline-primary">View All</a>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Date</th>
                            <th>Milk Type</th>
                            <th>Quantity (L)</th>
                            <th>Price (₹)</th>
                            <th>Total (₹)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty collectionList}">
                                <tr><td colspan="5" class="text-center text-muted">No milk collections found.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="milk" items="${collectionList}">
                                    <tr>
                                        <td>${milk.collectedDate}</td>
                                        <td>${milk.typeOfMilk}</td>
                                        <td>${milk.quantity}</td>
                                        <td>${milk.price}</td>
                                        <td>${milk.totalAmount}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Payment History -->
            <div class="card shadow-sm">
                <div class="card-header bg-white border-0 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-money-bill-wave me-2 text-success"></i>Recent Payments</h5>
                    <a href="redirectToPaymentStatus?email=${dto.email}" class="btn btn-sm btn-outline-success">View All</a>
                </div>
                <div class="card-body table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>Payment Date</th>
                            <th>Period</th>
                            <th>Amount (₹)</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty paymentList}">
                                <tr><td colspan="4" class="text-center text-muted">No payment records found.</td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="pay" items="${paymentList}">
                                    <tr>
                                        <td>${pay.paymentDate}</td>
                                        <td>${pay.periodStart} - ${pay.periodEnd}</td>
                                        <td>${pay.amountPaid}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${pay.status == 'PAID'}">
                                                    <span class="badge bg-success">Paid</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-warning text-dark">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Right Side: Profile & Bank -->
        <div class="col-lg-4 mt-4 mt-lg-0">

            <!-- Profile Overview -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-user me-2 text-info"></i>Profile Overview</h5>
                </div>
                <div class="card-body">
                    <p><strong>Name:</strong> ${dto.firstName} ${dto.lastName}</p>
                    <p><strong>Email:</strong> ${dto.email}</p>
                    <p><strong>Phone:</strong> ${dto.phoneNumber}</p>
                    <p><strong>Milk Type:</strong> ${dto.typeOfMilk}</p>
                    <a href="redirectToUpdateSupplierProfile?email=${dto.email}" class="btn btn-outline-primary btn-sm w-100 mt-2">
                        <i class="fas fa-edit me-2"></i>Update Profile
                    </a>
                </div>
            </div>

            <!-- Bank Details -->
            <div class="card shadow-sm">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fa-solid fa-building-columns me-2 text-secondary"></i>Bank Details</h5>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty dto.supplierBankDetails}">
                            <div class="alert alert-warning">No bank details found.</div>
                            <a href="redirectToUpdateSupplierBankDetails?email=${dto.email}" class="btn btn-sm btn-primary w-100">Add Bank Details</a>
                        </c:when>
                        <c:otherwise>
                            <p><strong>Bank:</strong> ${dto.supplierBankDetails.bankName}</p>
                            <p><strong>Branch:</strong> ${dto.supplierBankDetails.bankBranch}</p>
                            <p><strong>Account:</strong> ${dto.supplierBankDetails.accountNumber}</p>
                            <p><strong>IFSC:</strong> ${dto.supplierBankDetails.IFSCCode}</p>
                            <p><strong>Type:</strong> ${dto.supplierBankDetails.accountType}</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- Footer -->
<footer class="bg-dark text-white mt-5">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-4">
                <h5 class="text-uppercase mb-4">Milklore</h5>
                <p>Connecting dairy farmers with consumers through quality milk products and transparent supply chain.</p>
                <div class="social-links mt-4">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6">
                <h6 class="text-uppercase mb-4">Quick Links</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none">Home</a></li>
                    <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none">About Us</a></li>
                    <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none">Products</a></li>
                    <li class="mb-2"><a href="#" class="text-white-50 text-decoration-none">Contact</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h6 class="text-uppercase mb-4">Contact Info</h6>
                <ul class="list-unstyled">
                    <li class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 123 Dairy Farm Rd, Bangalore, India</li>
                    <li class="mb-2"><i class="fas fa-phone-alt me-2"></i> +91 98765 43210</li>
                    <li class="mb-2"><i class="fas fa-envelope me-2"></i> info@milklore.com</li>
                </ul>
            </div>
            <div class="col-lg-3">
                <h6 class="text-uppercase mb-4">Newsletter</h6>
                <p>Subscribe to our newsletter for the latest updates and offers.</p>
                <div class="input-group mb-3">
                    <input type="email" class="form-control" placeholder="Your Email" aria-label="Your Email">
                    <button class="btn btn-primary" type="button">Subscribe</button>
                </div>
            </div>
        </div>
        <hr class="my-4">
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-white-50 me-3 text-decoration-none">Privacy Policy</a>
                <a href="#" class="text-white-50 me-3 text-decoration-none">Terms of Service</a>
                <a href="#" class="text-white-50 text-decoration-none">Sitemap</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Custom JS -->
<script>
    // Enable tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Active nav link highlight
    document.addEventListener('DOMContentLoaded', function() {
        const currentPage = window.location.pathname.split('/').pop() || 'dashboard';
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            if (link.getAttribute('href').includes(currentPage)) {
                link.classList.add('active');
            } else {
                link.classList.remove('active');
            }
        });
    });
</script>
</body>
</html>