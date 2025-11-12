<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" data-bs-theme="light" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milk Product Receiver - Milklore</title>
    <link rel="icon" type="image/png" href="images/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link href="css/_variables.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <style>
        body { background-color: #f8f9fc; color: #333; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; min-height: 100vh; display: flex; flex-direction: column; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 0.15rem 1.75rem rgba(58,59,69,0.15); padding: 0.8rem 0; }
        .navbar-brand { font-weight: 700; color: white !important; }
        .nav-link { color: rgba(255, 255, 255, 0.9) !important; font-weight: 500; transition: all 0.3s ease; }
        .nav-link:hover { color: white !important; transform: translateY(-1px); }
        .nav-link.active { font-weight: 600; color: white !important; }
        .footer { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 2.5rem 0 1.5rem; margin-top: auto; }
    </style>
</head>
<body>

<!-- ✅ Navbar -->
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
                <li class="nav-item"><a class="nav-link" href="redirectToAdminSuccess?email=${dto.email}"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToAdminPaymentHistory?email=${dto.email}&page=1&size=10"><i class="fa-solid fa-money-bill-transfer me-2"></i>Payment History</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToCollectMilk?email=${dto.email}"><i class="fa-solid fa-box me-2"></i>Manage Products</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToProductsPrice?email=${dto.email}"><i class="fa-solid fa-tag me-2"></i>Products Price</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToMilkSuppliersList?email=${dto.email}&page=1&size=10"><i class="fa-solid fa-bottle-droplet me-2"></i>Milk Suppliers</a></li>
                <li class="nav-item"><a class="nav-link active" href="redirectToGetCollectMilkList?email=${dto.email}"><i class="fa-solid fa-glass-water-droplet me-2"></i>Milk Collect List</a></li>
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
                    <ul class="dropdown-menu dropdown-menu-end shadow">
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#adminProfileModal"><i class="bi bi-person-circle me-2"></i>View Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="adminLogout?email=${dto.email}"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- ✅ Main Section -->
<main class="flex-grow-2" style="margin-top: 80px;">
    <div class="container py-4">
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <h2 class="mb-4"><i class="fa-solid fa-glass-water-droplet me-2"></i>Milk Product Receiver</h2>
                <div class="alert alert-info mb-4">
                    <strong>Tip:</strong> Enter the <b>supplier's phone number first</b>. If registered, details will auto-fill.
                </div>

                <!-- ✅ Success / Error Alerts -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- ✅ Collect Milk Form -->
                <form action="addCollectMilk" method="post" id="collectMilkForm" class="row g-3">
                    <input type="email" name="email" hidden value="${dto.email}">

                    <div class="col-lg-4 col-md-6">
                        <label for="phone" class="form-label">Phone Number</label>
                        <div class="input-group">
                            <input type="tel" class="form-control" id="phone" placeholder="Enter phone number" name="phoneNumber" required>
                            <button class="btn btn-outline-secondary" type="button" id="startScanBtn"><i class="fa fa-qrcode"></i> Scan QR</button>
                        </div>
                        <span id="phoneError" class="text-danger small"></span>
                        <div id="qrScannerContainer" class="mt-3" style="display:none;">
                            <div id="reader" style="width:100%; height:260px; border:1px solid #ccc; border-radius:8px;"></div>
                            <button type="button" class="btn btn-danger btn-sm mt-2" id="stopScanBtn">Stop Scanning</button>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" placeholder="Enter name" readonly>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter email" readonly>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <label for="typeOfMilk" class="form-label">Type of Milk</label>
                        <select class="form-select" id="typeOfMilk" name="typeOfMilk" required>
                            <option value="">Select milk type</option>
                        </select>
                        <div id="typeOfMilkError" class="text-danger small"></div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <label for="quantity" class="form-label">Quantity (litres)</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="0.01" step="0.01" required>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <label for="price" class="form-label">Price (per litre)</label>
                        <input type="number" class="form-control" id="price" name="price" readonly>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <label for="totalAmount" class="form-label">Total Amount</label>
                        <input type="number" class="form-control" id="totalAmount" name="totalAmount" readonly>
                    </div>

                    <div class="col-12 text-end mt-3">
                        <button class="btn btn-primary px-4" type="submit">
                            <i class="fas fa-save me-2"></i>Collect Milk
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<!-- ✅ QR Result Modal -->
<div class="modal fade" id="qrResultModal" tabindex="-1" aria-labelledby="qrResultModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-success">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fa-solid fa-qrcode me-2"></i>QR Code Scanned</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p><strong>ID:</strong> <span id="qrId"></span></p>
                <p><strong>Email:</strong> <span id="qrEmail"></span></p>
                <p><strong>Phone:</strong> <span id="qrPhone"></span></p>
                <button type="button" class="btn btn-success mt-3" id="fillFormBtn" data-bs-dismiss="modal">
                    <i class="fa-solid fa-check me-1"></i>Fill Form
                </button>
            </div>
        </div>
    </div>
</div>

<!-- ✅ Footer -->
<footer class="footer mt-auto">
    <div class="container text-center">
        <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
    </div>
</footer>

<!-- ✅ QR Scanner Library (stable working version) -->
<script src="https://unpkg.com/html5-qrcode@2.3.8/html5-qrcode.min.js"></script>

<!-- ✅ Dependencies -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- ✅ Your custom logic -->
<script src="js/milk-product-receiver.js" defer></script>

</body>
</html>
