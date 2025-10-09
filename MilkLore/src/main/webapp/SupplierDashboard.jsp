<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Dashboard - Milklore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #1cc88a;
            --dark-color: #5a5c69;
        }

        body {
            background-color: #f8f9fc;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Gradient Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 0.8rem 0;
        }

        .navbar-brand {
            font-weight: 700;
            color: white !important;
        }

        .navbar-brand img {
            filter: none;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link:focus {
            color: white !important;
            transform: translateY(-1px);
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
            border: none;
            transition: all 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.15);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .card-primary { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .card-success { background: linear-gradient(135deg, #1cc88a, #20c997); color: white; }
        .card-warning { background: linear-gradient(135deg, #f6c23e, #ffa500); color: white; }
        .card-info { background: linear-gradient(135deg, #36b9cc, #17a2b8); color: white; }

        .metric-value {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .metric-label {
            font-size: 0.9rem;
            opacity: 0.8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Profile Section */
        .profile-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            border-radius: 1rem 1rem 0 0;
            text-align: center;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 1rem;
        }

        .profile-body {
            background: white;
            padding: 2rem;
            border-radius: 0 0 1rem 1rem;
        }

        /* Tables */
        .table-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.1);
            overflow: hidden;
        }

        .table th {
            background-color: #f8f9fc;
            border-bottom: 2px solid #e3e6f0;
            font-weight: 600;
            color: #5a5c69;
            padding: 1rem;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid #e3e6f0;
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }

        .btn-success {
            background: linear-gradient(135deg, #1cc88a 0%, #20c997 100%);
            border: none;
        }

        .btn-warning {
            background: linear-gradient(135deg, #f6c23e 0%, #ffa500 100%);
            border: none;
        }

        /* Footer */
        .footer {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0 2rem;
            margin-top: 3rem;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .dashboard-card {
                padding: 1.5rem;
            }

            .metric-value {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="toIndex">
                <img src="images/milklore.png" alt="Milklore Logo" height="60" class="me-2"/>
                <span class="d-flex flex-column">
                    <span style="font-weight: 700; font-size: 1.4rem; line-height: 1.2;">Milklore</span>
                    <span style="font-size: 0.8rem; opacity: 0.9; font-weight: 400;">Tales and Taste of Tradition</span>
                </span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="toIndex"><i class="bi bi-house-door me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i>
                            <span>Profile</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>My Profile</a></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i>Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container" style="margin-top: 100px; padding: 2rem 0;">
        <!-- Welcome Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="dashboard-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="mb-1">Welcome back, Supplier!</h2>
                            <p class="text-muted mb-0">Here's what's happening with your dairy business today.</p>
                        </div>
                        <div class="profile-avatar">
                            <i class="bi bi-person-fill"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Metrics -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="dashboard-card text-center">
                    <div class="card-icon card-primary mx-auto">
                        <i class="bi bi-droplet"></i>
                    </div>
                    <div class="metric-value">2,450</div>
                    <div class="metric-label">Liters Supplied</div>
                    <small class="text-success"><i class="bi bi-arrow-up"></i> +12% from last month</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="dashboard-card text-center">
                    <div class="card-icon card-success mx-auto">
                        <i class="bi bi-currency-rupee"></i>
                    </div>
                    <div class="metric-value">₹45,230</div>
                    <div class="metric-label">Revenue</div>
                    <small class="text-success"><i class="bi bi-arrow-up"></i> +8% from last month</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="dashboard-card text-center">
                    <div class="card-icon card-warning mx-auto">
                        <i class="bi bi-truck"></i>
                    </div>
                    <div class="metric-value">156</div>
                    <div class="metric-label">Deliveries</div>
                    <small class="text-muted">This month</small>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="dashboard-card text-center">
                    <div class="card-icon card-info mx-auto">
                        <i class="bi bi-graph-up"></i>
                    </div>
                    <div class="metric-value">4.8</div>
                    <div class="metric-label">Rating</div>
                    <small class="text-success"><i class="bi bi-star-fill"></i> Excellent</small>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Profile Information -->
            <div class="col-lg-6 mb-4">
                <div class="table-card">
                    <div class="profile-header">
                        <h4 class="mb-0"><i class="bi bi-person me-2"></i>Profile Information</h4>
                    </div>
                    <div class="profile-body">
                        <div class="row g-3">
                            <div class="col-sm-4">
                                <label class="text-muted">Name:</label>
                                <div class="fw-semibold">John Doe</div>
                            </div>
                            <div class="col-sm-4">
                                <label class="text-muted">Email:</label>
                                <div class="fw-semibold">john.doe@supplier.com</div>
                            </div>
                            <div class="col-sm-4">
                                <label class="text-muted">Phone:</label>
                                <div class="fw-semibold">+91 98765 43210</div>
                            </div>
                            <div class="col-sm-6">
                                <label class="text-muted">Address:</label>
                                <div class="fw-semibold">123 Dairy Farm Road, Village</div>
                            </div>
                            <div class="col-sm-6">
                                <label class="text-muted">Milk Type:</label>
                                <div class="fw-semibold">Cow Milk, Buffalo Milk</div>
                            </div>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-primary btn-sm">
                                <i class="bi bi-pencil me-1"></i>Edit Profile
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Orders -->
            <div class="col-lg-6 mb-4">
                <div class="table-card">
                    <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                        <h5 class="mb-0"><i class="bi bi-receipt me-2"></i>Recent Orders</h5>
                        <a href="#" class="btn btn-primary btn-sm">View All</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Date</th>
                                    <th>Quantity</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#ORD001</td>
                                    <td>2024-01-15</td>
                                    <td>50L</td>
                                    <td><span class="badge bg-success">Delivered</span></td>
                                </tr>
                                <tr>
                                    <td>#ORD002</td>
                                    <td>2024-01-14</td>
                                    <td>30L</td>
                                    <td><span class="badge bg-warning">Pending</span></td>
                                </tr>
                                <tr>
                                    <td>#ORD003</td>
                                    <td>2024-01-13</td>
                                    <td>75L</td>
                                    <td><span class="badge bg-success">Delivered</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Product Management -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="table-card">
                    <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                        <h5 class="mb-0"><i class="bi bi-box-seam me-2"></i>Milk Products</h5>
                        <button class="btn btn-primary">
                            <i class="bi bi-plus-circle me-1"></i>Add Product
                        </button>
                    </div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead>
                                <tr>
                                    <th>Product Name</th>
                                    <th>Type</th>
                                    <th>Price/Liter</th>
                                    <th>Available</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Fresh Cow Milk</td>
                                    <td>Cow Milk</td>
                                    <td>₹60</td>
                                    <td><span class="badge bg-success">In Stock</span></td>
                                    <td>
                                        <button class="btn btn-warning btn-sm me-1">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Buffalo Milk</td>
                                    <td>Buffalo Milk</td>
                                    <td>₹70</td>
                                    <td><span class="badge bg-success">In Stock</span></td>
                                    <td>
                                        <button class="btn btn-warning btn-sm me-1">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-danger btn-sm">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row">
            <div class="col-12">
                <div class="dashboard-card">
                    <h4 class="mb-3"><i class="bi bi-lightning me-2"></i>Quick Actions</h4>
                    <div class="row g-3">
                        <div class="col-md-3">
                            <button class="btn btn-outline-primary w-100 p-3">
                                <i class="bi bi-plus-circle fs-4 mb-2"></i>
                                <div>Add New Product</div>
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-success w-100 p-3">
                                <i class="bi bi-graph-up fs-4 mb-2"></i>
                                <div>View Analytics</div>
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-warning w-100 p-3">
                                <i class="bi bi-chat-dots fs-4 mb-2"></i>
                                <div>Customer Support</div>
                            </button>
                        </div>
                        <div class="col-md-3">
                            <button class="btn btn-outline-info w-100 p-3">
                                <i class="bi bi-gear fs-4 mb-2"></i>
                                <div>Settings</div>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5>Milklore</h5>
                    <p class="text-white-50">Tales and Taste of Tradition. Bringing you the finest dairy products with a touch of heritage.</p>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="toIndex">Home</a></li>
                        <li class="mb-2"><a href="#">Dashboard</a></li>
                        <li class="mb-2"><a href="#">Profile</a></li>
                        <li><a href="#">Support</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5>Supplier Portal</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#">Product Management</a></li>
                        <li class="mb-2"><a href="#">Order Tracking</a></li>
                        <li class="mb-2"><a href="#">Payment History</a></li>
                        <li><a href="#">Analytics</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h5>Support</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2">
                            <i class="bi bi-envelope-fill me-2"></i>
                            <a href="mailto:supplier@milklore.coop">supplier@milklore.coop</a>
                        </li>
                        <li class="mb-2">
                            <i class="bi bi-telephone-fill me-2"></i>
                            <a href="tel:+914412345678">+91 44 1234 5678</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="row mt-4">
                <div class="col-12 text-center">
                    <p class="mb-0">&copy; ${pageContext.response.locale == null ? '2024' : ''} Milklore. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <a href="#" class="btn btn-primary btn-lg position-fixed bottom-0 end-0 m-4 rounded-circle shadow"
       id="back-to-top" style="width: 50px; height: 50px; display: none; z-index: 99;">
        <i class="bi bi-arrow-up"></i>
    </a>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Scripts -->
    <script>
        // Back to top button
        const backToTopButton = document.getElementById('back-to-top');

        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopButton.style.display = 'flex';
                backToTopButton.style.alignItems = 'center';
                backToTopButton.style.justifyContent = 'center';
            } else {
                backToTopButton.style.display = 'none';
            }
        });

        backToTopButton.addEventListener('click', (e) => {
            e.preventDefault();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    </script>
</body>
</html>
