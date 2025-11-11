<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MilkLore | Payment Status</title>
    <link rel="shortcut icon" href="images/milklore.png" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4e73df;
            --primary-light: #9ab8ff;
            --primary-dark: #2e59d9;
            --accent-color: #ffc107;
            --light-bg: #f8f9fc;
            --text-primary: #2c3e50;
            --text-secondary: #6c757d;
            --success: #1cc88a;
            --warning: #f6c23e;
            --danger: #e74a3b;
            --white: #ffffff;
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --card-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Poppins', sans-serif;
            color: var(--text-primary);
        }

        /* Navbar Styling */
        .navbar {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            box-shadow: var(--card-shadow);
            padding: 0.5rem 0;
        }

        .navbar-brand img {
            height: 45px;
            transition: transform 0.3s ease;
        }

        .navbar-brand img:hover {
            transform: scale(1.05);
        }

        .nav-link {
            color: var(--white) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            margin: 0 0.2rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.15);
            transform: translateY(-1px);
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: var(--primary-dark) !important;
            font-weight: 600;
        }

        /* Card Styling */
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: var(--card-shadow);
            margin-bottom: 1.5rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.15);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: var(--white);
            border-radius: 8px 8px 0 0 !important;
            padding: 1rem 1.25rem;
            font-weight: 600;
        }

        /* Table Styling */
        .table {
            margin-bottom: 0;
            font-size: 0.9rem;
        }

        .table th {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: var(--white);
            font-weight: 500;
            padding: 0.75rem 1rem;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            border: none;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: var(--gray-200);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(78, 115, 223, 0.05);
        }

        /* Status Badges */
        .status-badge {
            padding: 0.4em 0.8em;
            font-size: 0.8rem;
            font-weight: 600;
            border-radius: 50px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-paid {
            background-color: #d4edda;
            color: #155724;
        }

        /* Buttons */
        .btn {
            font-weight: 500;
            padding: 0.5rem 1.25rem;
            font-size: 0.9rem;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(78, 115, 223, 0.3);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(78, 115, 223, 0.2);
        }

        /* Profile Image */
        .profile-img {
            width: 36px;
            height: 36px;
            object-fit: cover;
            border: 2px solid var(--white);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .profile-img:hover {
            transform: scale(1.1);
        }

        /* Dropdown Menu */
        .dropdown-menu {
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            padding: 0.5rem;
            min-width: 220px;
        }

        .dropdown-item {
            padding: 0.5rem 1rem;
            border-radius: 4px;
            font-weight: 500;
            color: var(--text-primary);
            transition: all 0.2s;
        }

        .dropdown-item:hover {
            background-color: rgba(78, 115, 223, 0.1);
            color: var(--primary-dark);
        }

        .dropdown-divider {
            margin: 0.5rem 0;
            border-color: var(--gray-200);
        }

        /* Empty State */
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #dee2e6;
        }

        /* Footer */
        footer {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
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
            color: var(--accent-color);
            transform: translateY(-2px);
        }

        /* Modal Styling */
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
        }

        .modal-header .btn-close {
            filter: invert(1);
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .navbar-nav {
                padding: 0.5rem 0;
            }
            .nav-link {
                padding: 0.5rem 1rem !important;
                margin: 0.1rem 0;
            }
            .table-responsive {
                border-radius: 0.5rem;
                overflow: hidden;
            }
            .card-header {
                flex-direction: column;
                text-align: center;
                gap: 0.5rem;
            }
            .btn {
                padding: 0.4rem 0.8rem;
                font-size: 0.85rem;
            }
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="images/milklore.png" alt="MilkLore Logo" />
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
                                <img src="images/default.png" alt="Profile" class="profile-img rounded-circle">
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
<main class="flex-grow-1" style="margin-top: 70px; margin-bottom: 20px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-credit-card me-2"></i>Payment Status
                        </div>
                        <div class="text-white small">
                            <i class="fas fa-user me-1"></i> ${dto.firstName} ${dto.lastName}
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                <tr>
                                    <th>Period Start</th>
                                    <th>Period End</th>
                                    <th class="text-end">Amount (₹)</th>
                                    <th>Payment Date</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty paymentList}">
                                        <c:forEach var="record" items="${paymentList}">
                                            <tr>
                                                <td>${record.periodStart}</td>
                                                <td>${record.periodEnd}</td>
                                                <td class="text-end fw-bold">₹${record.totalAmount}</td>
                                                <td>${record.paymentDate}</td>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${record.paymentStatus eq 'PENDING'}">
                                                                <span class="status-badge status-pending">
                                                                    <i class="fas fa-clock me-1"></i>${record.paymentStatus}
                                                                </span>
                                                        </c:when>
                                                        <c:when test="${record.paymentStatus eq 'PAID'}">
                                                                <span class="status-badge status-paid">
                                                                    <i class="fas fa-check-circle me-1"></i>${record.paymentStatus}
                                                                </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${record.paymentStatus}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <form action="generateInvoiceForSupplier">
                                                        <input type="hidden" name="periodStart" value="${record.periodStart}" />
                                                        <input type="hidden" name="periodEnd" value="${record.periodEnd}" />
                                                        <input type="hidden" name="paymentDate" value="${record.paymentDate}">
                                                        <input type="hidden" name="supplierId" value="${dto.supplierId}"/>
                                                        <button type="submit" class="btn btn-primary btn-sm">Download PDF</button>
                                                    </form>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center py-5">
                                                <div class="empty-state">
                                                    <i class="fas fa-inbox"></i>
                                                    <h5 class="mt-3 mb-2">No payment records found</h5>
                                                    <p class="text-muted">Your payment history will appear here</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <c:if test="${not empty paymentList}">
                        <div class="card-footer bg-white">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="text-muted small">
                                    Showing ${paymentList.size()} records
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Supplier Profile Modal -->
<div class="modal fade" id="supplierProfileModal" tabindex="-1" aria-labelledby="supplierProfileModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(90deg, var(--primary-dark), var(--primary-color));">
                <h5 class="modal-title text-white" id="supplierProfileModalLabel">Supplier Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-4">
                    <c:choose>
                        <c:when test="${empty dto.profilePath}">
                            <img src="images/default.png" alt="Profile" class="rounded-circle" width="120"
                                 height="120" style="object-fit: cover; border: 3px solid var(--primary-light);">
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile"
                                 class="rounded-circle" width="120" height="120"
                                 style="object-fit: cover; border: 3px solid var(--primary-light);">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card p-3 shadow-sm">
                    <ul class="list-group list-group-flush">
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold"><i class="fa-solid fa-user me-2 text-primary"></i>First Name:</div>
                            <div class="col-sm-8 text-break">${dto.firstName}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold"><i class="fa-solid fa-user me-2 text-primary"></i>Last Name:</div>
                            <div class="col-sm-8 text-break">${dto.lastName}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold"><i class="fa-solid fa-envelope me-2 text-primary"></i>Email:</div>
                            <div class="col-sm-8 text-break">${dto.email}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold"><i class="fa-solid fa-phone me-2 text-primary"></i>Phone:</div>
                            <div class="col-sm-8">${dto.phoneNumber}</div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 fw-bold"><i class="fa-solid fa-bottle-water me-2 text-primary"></i>Type of Milk:</div>
                            <div class="col-sm-8 text-capitalize">${dto.typeOfMilk}</div>
                        </div>
                    </ul>
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
<div class="modal fade" id="supplierBankModal" tabindex="-1" aria-labelledby="supplierBankModalLabel"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(90deg, var(--primary-dark), var(--primary-color));">
                <h5 class="modal-title text-white" id="supplierBankModalLabel">
                    <i class="fas fa-university me-2"></i>Bank Details
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <c:choose>
                    <c:when test="${empty dto.supplierBankDetails}">
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>No bank details found. Please add your bank details.
                        </div>
                        <div class="text-center mt-3">
                            <a href="redirectToAddBankDetails?email=${dto.email}" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Add Bank Details
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card p-3 shadow-sm">
                            <ul class="list-group list-group-flush">
                                <div class="row mb-3">
                                    <div class="col-sm-4 fw-bold"><i class="fas fa-university me-2 text-primary"></i>Bank Name:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.bankName}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-4 fw-bold"><i class="fas fa-code-branch me-2 text-primary"></i>Branch Name:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.bankBranch}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-4 fw-bold"><i class="fas fa-hashtag me-2 text-primary"></i>Account Number:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.accountNumber}</div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-4 fw-bold"><i class="fas fa-key me-2 text-primary"></i>IFSC Code:</div>
                                    <div class="col-sm-8 text-break">${dto.supplierBankDetails.IFSCCode}</div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4 fw-bold"><i class="fas fa-list-check me-2 text-primary"></i>Account Type:</div>
                                    <div class="col-sm-8 text-break text-capitalize">${dto.supplierBankDetails.accountType}</div>
                                </div>
                            </ul>
                        </div>
                        <div class="alert alert-info mt-3" role="alert">
                            <i class="fas fa-info-circle me-2"></i>To update bank details, please contact Admin.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-auto">
    <div class="container">
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
                    <a href="#" class="me-3"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="me-3"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <div class="mt-4">
                    <p class="mb-2">Subscribe to our newsletter</p>
                    <div class="input-group">
                        <input type="email" class="form-control" placeholder="Your email">
                        <button class="btn btn-primary" type="button">Subscribe</button>
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

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Enable Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });

    // Auto-hide alert messages after 5 seconds
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
</script>
</body>
</html>