<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Milklore | Update Profile</title>
    <link rel="shortcut icon" href="images/logo.png" type="image/x-icon">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
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
            background-color: #f5f7fa;
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

        .profile-form {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0,0,0,0.1);
            padding: 2.5rem;
            margin: 2rem 0;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(74, 111, 165, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(74, 111, 165, 0.3);
        }

        .profile-img-container {
            width: 150px;
            height: 150px;
            margin: 0 auto 1.5rem;
            position: relative;
            cursor: pointer;
        }

        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .profile-img-edit {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: var(--primary-color);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .profile-img-container:hover .profile-img-edit {
            opacity: 1;
        }

        .profile-img-container:hover .profile-img {
            transform: scale(1.05);
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .required-field::after {
            content: " *";
            color: var(--accent-color);
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="images/logo.png" alt="Milklore" height="40" class="me-2">
            <span class="fw-bold">Milklore</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="redirectToSupplierDashboard?email=${dto.email}">
                        <i class="fas fa-tachometer-alt me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item dropdown ms-lg-2">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="images/default-avatar.png" class="rounded-circle me-2" width="32" height="32" style="object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="rounded-circle me-2" width="32" height="32" style="object-fit: cover;">
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

<!-- Main Content -->
<div class="container" style="margin-top: 100px; margin-bottom: 50px;">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Update Profile</h2>
                <a href="redirectToSupplierDashboard?email=${dto.email}" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>

            <div class="profile-form">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <form action="updateSupplierProfile" method="post" enctype="multipart/form-data" id="profileForm">
                    <!-- Profile Picture Upload -->
                    <div class="text-center mb-4">
                        <div class="profile-img-container">
                            <c:choose>
                                <c:when test="${empty dto.profilePath}">
                                    <img src="images/default-avatar.png" id="profileImage" class="profile-img" alt="Profile">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/uploads/${dto.profilePath}'/>" id="profileImage" class="profile-img" alt="Profile">
                                </c:otherwise>
                            </c:choose>
                            <div class="profile-img-edit">
                                <i class="fas fa-camera"></i>
                            </div>
                            <input type="file" class="d-none" id="profilePicture" name="profilePicture" accept="image/*">
                        </div>
                        <small class="text-muted">Click on the image to change your profile picture</small>
                    </div>

                    <!-- Form Fields -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName" class="form-label required-field">First Name</label>
                            <input type="text" class="form-control" id="firstName" name="firstName"
                                   value="${dto.firstName}" required>
                            <div class="invalid-feedback" id="firstNameError"></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName" class="form-label required-field">Last Name</label>
                            <input type="text" class="form-control" id="lastName" name="lastName"
                                   value="${dto.lastName}" required>
                            <div class="invalid-feedback" id="lastNameError"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email"
                               value="${dto.email}" readonly>
                    </div>

                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber"
                               value="${dto.phoneNumber}" readonly>
                    </div>

                    <div class="mb-4">
                        <label for="address" class="form-label required-field">Address</label>
                        <textarea class="form-control" id="address" name="address" rows="3"
                                  required>${dto.address}</textarea>
                        <div class="invalid-feedback" id="addressError"></div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-save me-2"></i>Update Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                <p class="mb-0">&copy; 2025 Milklore. All rights reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <a href="#" class="text-white me-3 text-decoration-none">Privacy Policy</a>
                <a href="#" class="text-white me-3 text-decoration-none">Terms of Service</a>
                <a href="#" class="text-white text-decoration-none">Contact Us</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Profile image preview
    document.addEventListener('DOMContentLoaded', function() {
        const profileImgContainer = document.querySelector('.profile-img-container');
        const profileImg = document.getElementById('profileImage');
        const fileInput = document.getElementById('profilePicture');

        profileImgContainer.addEventListener('click', function() {
            fileInput.click();
        });

        fileInput.addEventListener('change', function(e) {
            if (fileInput.files && fileInput.files[0]) {
                const reader = new FileReader();

                reader.onload = function(e) {
                    profileImg.src = e.target.result;
                }

                reader.readAsDataURL(fileInput.files[0]);
            }
        });

        // Form validation
        const form = document.getElementById('profileForm');

        form.addEventListener('submit', function(event) {
            let isValid = true;

            // Reset previous error states
            document.querySelectorAll('.is-invalid').forEach(el => el.classList.remove('is-invalid'));

            // Validate first name
            const firstName = document.getElementById('firstName');
            if (!firstName.value.trim()) {
                document.getElementById('firstNameError').textContent = 'First name is required';
                firstName.classList.add('is-invalid');
                isValid = false;
            }

            // Validate last name
            const lastName = document.getElementById('lastName');
            if (!lastName.value.trim()) {
                document.getElementById('lastNameError').textContent = 'Last name is required';
                lastName.classList.add('is-invalid');
                isValid = false;
            }

            // Validate address
            const address = document.getElementById('address');
            if (!address.value.trim()) {
                document.getElementById('addressError').textContent = 'Address is required';
                address.classList.add('is-invalid');
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault();
                event.stopPropagation();
            }
        }, false);
    });
</script>
<script src="js/supplier-dashboard.js"></script>
</body>
</html>