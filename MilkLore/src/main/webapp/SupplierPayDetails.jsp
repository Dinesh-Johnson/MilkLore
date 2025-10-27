<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MilkLore | Supplier Payment Details</title>
    <link rel="shortcut icon" href="images/milklore.png" type="image/x-icon" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
        crossorigin="anonymous" />
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
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 2rem;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.25rem;
        }

        .btn-primary {
            background-color: #2e7d32;
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1b5e20;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        footer {
            background: linear-gradient(135deg, #1b5e20, #2e7d32);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
        }

        .payment-card {
            background: #ffffff;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
        }

        .payment-amount {
            font-size: 2rem;
            font-weight: 700;
            color: #2e7d32;
        }

        .payment-details {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1.25rem;
            margin-top: 1.5rem;
        }

        .payment-status {
            display: inline-block;
            padding: 0.35rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-failed {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="images/logo.png" alt="MilkLore Logo" height="60" class="d-inline-block align-top" />
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="SupplierDashboard"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="SupplierPaDetails"><i class="fas fa-rupee-sign me-2"></i>Payment Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="SupplierProfile"><i class="fas fa-user-circle me-2"></i>Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="SupplierLogout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-5 pt-4">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-rupee-sign me-2"></i>Payment Details</h4>
                        <span class="payment-status ${payment.status == 'COMPLETED' ? 'status-completed' : payment.status == 'PENDING' ? 'status-pending' : 'status-failed'}">
                            ${payment.status}
                        </span>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="payment-card">
                                    <h5 class="text-muted mb-4">Payment Summary</h5>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted">Payment ID:</span>
                                        <span class="fw-bold">#${payment.paymentId}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted">Date:</span>
                                        <span class="fw-bold">
                                            <fmt:formatDate value="${payment.paymentDate}" pattern="dd MMM yyyy, hh:mm a" />
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted">Payment Method:</span>
                                        <span class="fw-bold">${payment.paymentMethod}</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-muted">Reference Number:</span>
                                        <span class="fw-bold">${payment.referenceNumber}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="payment-card h-100">
                                    <h5 class="text-muted mb-4">Amount Details</h5>
                                    <div class="text-center mb-4">
                                        <span class="text-muted d-block">Total Amount</span>
                                        <span class="payment-amount">₹<fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2" /></span>
                                    </div>
                                    <div class="payment-details">
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Milk Supplied:</span>
                                            <span>${payment.quantity} Ltrs</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Rate per Liter:</span>
                                            <span>₹${payment.ratePerLiter}</span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Total Amount:</span>
                                            <span>₹<fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2" /></span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold">
                                            <span>Amount Paid:</span>
                                            <span class="text-success">₹<fmt:formatNumber value="${payment.amount}" type="number" minFractionDigits="2" /></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mt-4">
                            <div class="card-header bg-light">
                                <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Bank Details</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label text-muted">Account Holder Name</label>
                                            <p class="fw-bold">${supplier.firstName} ${supplier.lastName}</p>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label text-muted">Account Number</label>
                                            <p class="fw-bold">${supplier.bankAccountNumber}</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label text-muted">Bank Name</label>
                                            <p class="fw-bold">${supplier.bankName}</p>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label text-muted">IFSC Code</label>
                                            <p class="fw-bold">${supplier.ifscCode}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <a href="SupplierDashboard" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                            </a>
                            <div>
                                <button class="btn btn-primary me-2" onclick="window.print()">
                                    <i class="fas fa-print me-2"></i>Print Receipt
                                </button>
                                <button class="btn btn-success">
                                    <i class="fas fa-download me-2"></i>Download PDF
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

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
                    <div class="social-links">
                        <a href="#" class="text-white me-3"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="text-white"><i class="fab fa-linkedin-in"></i></a>
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

        // Print functionality
        function printReceipt() {
            window.print();
        }

        // Download as PDF functionality
        function downloadAsPDF() {
            // This would typically be implemented with a PDF generation library
            alert('PDF download functionality would be implemented here');
        }
    </script>
</body>

</html>
