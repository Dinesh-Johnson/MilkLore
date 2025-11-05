<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore | Supplier Dashboard</title>
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
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
                            <a class="dropdown-item text-danger" href="logout">
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
<div class="container" style="margin-top: 80px;">
    <!-- Welcome Section -->
    <div class="welcome-section p-4 mb-4">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h2 class="fw-bold mb-2">Welcome back, ${dto.firstName}!</h2>
                <p class="text-muted mb-0">Here's your dashboard overview and recent activities.</p>
            </div>
            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                    <span class="badge bg-primary p-2">
                        <i class="fas fa-shield-alt me-1"></i> Supplier Account
                    </span>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-4">
            <div class="stat-card bg-primary rounded-3 h-100 p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Total Collection</h6>
                        <h2 class="mb-0 text-white">10 Ltr</h2>
                        <span class="text-white-50 small">+2.5% from last month</span>
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
                        <h6 class="text-uppercase text-white-50 mb-1">Pending Payments</h6>
                        <h2 class="mb-0 text-white">₹100</h2>
                        <span class="text-white-50 small">Next payout in 2 days</span>
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
                        <h6 class="text-uppercase text-white-50 mb-1">Last Collection</h6>
                        <h2 class="mb-0 text-white">10/03/2025</h2>
                        <span class="text-white-50 small">2 days ago</span>
                    </div>
                    <div class="icon-shape bg-white bg-opacity-10 rounded-circle p-3">
                        <i class="fas fa-fw fa-calendar-check text-white"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity Section -->
    <div class="row">
        <div class="col-lg-8">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0">Recent Activities</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex mb-4">
                        <div class="flex-shrink-0">
                            <div class="bg-primary bg-opacity-10 text-primary rounded-circle p-3">
                                <i class="fas fa-fw fa-cow"></i>
                            </div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-1">Milk Collection Added</h6>
                            <p class="text-muted small mb-0">You've added 2L of milk to your collection</p>
                            <span class="text-muted small">2 hours ago</span>
                        </div>
                    </div>
                    <div class="d-flex mb-4">
                        <div class="flex-shrink-0">
                            <div class="bg-success bg-opacity-10 text-success rounded-circle p-3">
                                <i class="fas fa-fw fa-money-bill-wave"></i>
                            </div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-1">Payment Received</h6>
                            <p class="text-muted small mb-0">Payment of ₹500 has been credited to your account</p>
                            <span class="text-muted small">1 day ago</span>
                        </div>
                    </div>
                    <div class="d-flex">
                        <div class="flex-shrink-0">
                            <div class="bg-info bg-opacity-10 text-info rounded-circle p-3">
                                <i class="fas fa-fw fa-bell"></i>
                            </div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-1">New Notification</h6>
                            <p class="text-muted small mb-0">Your profile has been updated successfully</p>
                            <span class="text-muted small">3 days ago</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 mt-4 mt-lg-0">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <a href="redirectToMilkCollection?email=${dto.email}" class="btn btn-outline-primary w-100 mb-3">
                        <i class="fas fa-plus-circle me-2"></i>Add Milk Collection
                    </a>
<!--                    <a href="redirectToPaymentStatus?email=${dto.email}" class="btn btn-outline-success w-100 mb-3">-->
<!--                        <i class="fas fa-history me-2"></i>View Payment History-->
<!--                    </a>-->
                    <a href="#" class="btn btn-outline-info w-100 mb-3" data-bs-toggle="modal" data-bs-target="#profileModal">
                        <i class="fas fa-user-edit me-2"></i>Update Profile
                    </a>
                    <a href="#" class="btn btn-outline-secondary w-100">
                        <i class="fas fa-question-circle me-2"></i>Help & Support
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Profile Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));">
                <h5 class="modal-title text-white">My Profile</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-4">
                    <div class="position-relative d-inline-block">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="images/default-avatar.png" class="rounded-circle border border-4 border-light" width="120" height="120" alt="Profile">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="rounded-circle border border-4 border-light" width="120" height="120" alt="Profile">
                            </c:otherwise>
                        </c:choose>
                        <button class="btn btn-sm btn-primary rounded-circle position-absolute bottom-0 end-0" style="width: 36px; height: 36px;">
                            <i class="fas fa-camera"></i>
                        </button>
                    </div>
<!--                    <h4 class="mt-3 mb-0">${dto.firstName} ${dto.lastName}</h4>-->
<!--                    <span class="badge bg-primary mt-2">${dto.typeOfMilk} Supplier</span>-->
                </div>

                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label text-muted small mb-1">Full Name</label>
                            <div class="form-control bg-light">${dto.firstName} ${dto.lastName}</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small mb-1">Email Address</label>
                            <div class="form-control bg-light">${dto.email}</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small mb-1">Phone Number</label>
                            <div class="form-control bg-light">${dto.phoneNumber}</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small mb-1">Milk Type</label>
                            <div class="form-control bg-light">${dto.typeOfMilk}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <a href="redirectToUpdateSupplierProfile?email=${dto.email}" class="btn btn-primary">
                    <i class="fas fa-edit me-2"></i>Edit Profile
                </a>
            </div>
        </div>
    </div>
</div>
<!-- Bank Details Modal -->
<div class="modal fade" id="supplierBankModal" tabindex="-1" aria-labelledby="supplierBankModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="supplierBankModalLabel">
                    <i class="fa-solid fa-building-columns me-2"></i>Bank Details
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <c:choose>
                    <c:when test="${empty dto.supplierBankDetails}">
                        <div class="alert alert-warning" role="alert">
                            No bank details found. Please add your bank details.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card p-3 shadow-sm">
                            <ul class="list-group list-group-flush">
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold"><i class="fa-solid fa-building-columns me-2"></i>Bank Name:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.bankName}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold"><i class="fa-solid fa-code-branch me-2"></i>Branch Name:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.bankBranch}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold"><i class="fa-solid fa-hashtag me-2"></i>Account Number:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.accountNumber}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold"><i class="fa-solid fa-key me-2"></i>IFSC Code:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.IFSCCode}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold"><i class="fa-solid fa-list-check me-2"></i>Account Type:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.accountType}</div>
                                </div>
                            </ul>
                        </div>
                        <div class="alert alert-warning mt-3" role="alert">
                            To update bank details, please contact Admin.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <c:if test="${empty dto.supplierBankDetails}">
                    <a href="redirectToUpdateSupplierBankDetails?email=${dto.email}" class="btn btn-primary">Fill Bank Details</a>
                </c:if>
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