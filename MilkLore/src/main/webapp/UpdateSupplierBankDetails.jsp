<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8" />
    <title>MilkLore | Update Bank Details</title>
    <link rel="shortcut icon" href="images/milklore-favicon.png" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
        crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="css/milklore-style.css" />
    <style>
        .milklore-bg {
            background: linear-gradient(135deg, #5d4037, #8d6e63);
            min-height: 100vh;
        }
        .form-container {
            background: rgba(255, 253, 231, 0.9);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        .btn-milklore {
            background: linear-gradient(90deg, #5d4037, #8d6e63);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-milklore:hover {
            background: linear-gradient(90deg, #3e2723, #5d4037);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .nav-link {
            color: #5d4037 !important;
            font-weight: 500;
        }
        .nav-link:hover {
            color: #3e2723 !important;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
    <nav class="navbar navbar-expand-lg fixed-top" style="background: linear-gradient(90deg, #d7ccc8, #efebe9)">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="images/milklore-logo.png" alt="MilkLore Logo" height="60" width="60" class="rounded-circle border border-light p-1 ms-3 me-2" />
                <span class="fw-bold" style="color: #5d4037;">MilkLore</span>
            </a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto me-3">
                    <li class="nav-item">
                        <a class="nav-link active" href="redirectToSupplierDashboard?email=${dto.email}">
                            <i class="fa-solid fa-gauge-high me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <c:choose>
                                <c:when test="${empty dto.profilePath}">
                                    <img src="images/default-profile.png" alt="Profile" class="rounded-circle" width="40" height="40" style="object-fit: cover; border: 2px solid #5d4037;">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/uploads/${dto.profilePath}'/>" alt="Profile" class="rounded-circle" width="40" height="40" style="object-fit: cover; border: 2px solid #5d4037;">
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                            <li><a class="dropdown-item text-danger" href="supplierLogout?email=${dto.email}">
                                <i class="fa-solid fa-right-from-bracket me-2"></i>Logout
                            </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="flex-grow-1 milklore-bg d-flex align-items-center py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="form-container p-4 p-md-5">
                        <h2 class="text-center mb-4" style="color: #5d4037;">
                            <i class="fa-solid fa-building-columns me-2"></i>Update Bank Details
                        </h2>

                        <form action="updateBankDetails" method="post" id="bankDetailsForm">
                            <input type="email" name="email" value="${dto.email}" hidden/>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="bankName" class="form-label">Bank Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="bankName" name="bankName" value="${bank.bankName}" placeholder="Enter Bank Name" required>
                                    <span class="form-text text-danger" id="bankNameError"></span>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="branchName" class="form-label">Branch Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="branchName" name="bankBranch" value="${bank.bankBranch}" placeholder="Enter Branch Name" required>
                                    <span class="form-text text-danger" id="branchNameError"></span>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="accountNumber" name="accountNumber"
                                           value="${bank.accountNumber}" placeholder="Enter Account Number" required pattern="\d{9,18}">
                                    <div class="form-text">Account number should be 9-18 digits.</div>
                                    <span class="form-text text-danger" id="accountNumberError"></span>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="confirmAccountNumber" class="form-label">Confirm Account Number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="confirmAccountNumber" placeholder="Confirm Account Number" required>
                                    <span class="form-text text-danger" id="confirmAccountNumberError"></span>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="IFSCCode" class="form-label">IFSC Code <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="IFSCCode" name="IFSCCode"
                                           value="${bank.IFSCCode}" placeholder="Enter IFSC Code" required pattern="^[A-Z]{4}0[A-Z0-9]{6}$">
                                    <div class="form-text">Format: 4 capital letters + 0 + 6 alphanumeric characters.</div>
                                    <span class="form-text text-danger" id="IFSCCodeError"></span>
                                </div>

                                <div class="col-md-6 mb-4">
                                    <label for="accountType" class="form-label">Account Type <span class="text-danger">*</span></label>
                                    <select class="form-select" id="accountType" name="accountType" required>
                                        <option value="" disabled selected>Select Account Type</option>
                                        <option value="Savings" ${bank.accountType == 'Savings' ? 'selected' : ''}>Savings</option>
                                        <option value="Current" ${bank.accountType == 'Current' ? 'selected' : ''}>Current</option>
                                        <option value="Salary" ${bank.accountType == 'Salary' ? 'selected' : ''}>Salary</option>
                                    </select>
                                    <span class="form-text text-danger" id="accountTypeError"></span>
                                </div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="redirectToSupplierDashboard?email=${dto.email}" class="btn btn-outline-secondary me-md-2">
                                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Dashboard
                                </a>
                                <button id="submitBtn" type="submit" class="btn btn-milklore text-white">
                                    <i class="fa-solid fa-floppy-disk me-1"></i> Save Bank Details
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="text-center text-lg-start py-3" style="background: linear-gradient(90deg, #5d4037, #8d6e63); color: #fffde7;">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5 class="text-uppercase mb-3">Contact Us</h5>
                    <p class="mb-1"><i class="fas fa-phone me-2"></i> +91 98765 43210</p>
                    <p class="mb-1"><i class="fas fa-envelope me-2"></i> info@milklore.com</p>
                    <p><i class="fas fa-map-marker-alt me-2"></i> 123 Dairy Farm Road, Bengaluru, Karnataka</p>
                </div>

                <div class="col-md-4 mb-3 text-center">
                    <h5 class="text-uppercase mb-3">Quick Links</h5>
                    <p class="mb-2"><a href="#" class="text-white text-decoration-none">About Us</a></p>
                    <p class="mb-2"><a href="#" class="text-white text-decoration-none">Our Products</a></p>
                    <p class="mb-2"><a href="#" class="text-white text-decoration-none">Contact</a></p>
                </div>

                <div class="col-md-4 mb-3 text-center text-md-end">
                    <h5 class="text-uppercase mb-3">Follow Us</h5>
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook-f fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-lg"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-lg"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin-in fa-lg"></i></a>
                </div>
            </div>

            <hr class="my-3" style="border-color: rgba(255,255,255,0.1);" />

            <div class="row">
                <div class="col-12 text-center">
                    <p class="mb-0">&copy; 2025 MilkLore. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <script src="js/update-supplier-bank-details.js"></script>
</body>
</html>
