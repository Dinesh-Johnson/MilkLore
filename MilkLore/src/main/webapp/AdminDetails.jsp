<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Profile - Milklore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link href="css/milklore-theme.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    <link href="css/adminSuccess.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet"/>
    <link href="css/adminSuccess.css" rel="stylesheet"/>

</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
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
                        <a class="nav-link" href="index.jsp"><i class="bi bi-house-door me-1"></i> Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="bi bi-box-seam me-1"></i> Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="bi bi-info-circle me-1"></i> About</a>
                    </li>
                    <li class="nav-item dropdown ms-2">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown"
                           role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="rounded-circle bg-white d-flex align-items-center justify-content-center"
                                 style="width: 36px; height: 36px;">
                                <i class="bi bi-person-fill text-primary"></i>
                            </div>
                            <span class="ms-2 d-none d-lg-inline">Admin</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="logout.jsp"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="profile-card p-4 p-md-5 mb-4">
                        <div class="d-flex align-items-center mb-4">
                            <div class="profile-icon">
                                ${dto.adminName.charAt(0)}
                            </div>
                            <div>
                                <h2 class="mb-1">${dto.adminName}</h2>
                                <span class="badge bg-primary bg-gradient">Administrator</span>
                            </div>
                        </div>

                        <hr class="my-4">

                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Email Address</label>
                                    <div class="form-control bg-light">${dto.email}</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Mobile Number</label>
                                    <div class="form-control bg-light">${dto.mobileNumber}</div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="mb-3">
                                    <label class="form-label">Account Type</label>
                                    <div class="form-control bg-light">Administrator</div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                <i class="bi bi-pencil-square me-2"></i>Edit Profile
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h5>Milklore</h5>
                    <p class="small">Tales and Taste of Tradition. Bringing you the finest dairy products with a touch of heritage.</p>
                </div>
                <div class="col-lg-2 col-md-6 mb-4 mb-lg-0">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#">Home</a></li>
                        <li class="mb-2"><a href="#">Products</a></li>
                        <li class="mb-2"><a href="#">About Us</a></li>
                        <li><a href="#">Contact</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
                    <h6>Contact Us</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><i class="bi bi-geo-alt-fill me-2"></i> 123 Dairy St, Milkland</li>
                        <li class="mb-2"><i class="bi bi-telephone-fill me-2"></i> +1 234 567 890</li>
                        <li><i class="bi bi-envelope-fill me-2"></i> info@milklore.com</li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h6>Follow Us</h6>
                    <div class="d-flex gap-3">
                        <a href="#" class="text-white"><i class="bi bi-facebook fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-twitter-x fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram fs-5"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-linkedin fs-5"></i></a>
                    </div>
                </div>
            </div>
            <hr class="my-4" style="border-color: rgba(255,255,255,0.1);">
            <div class="text-center small">
                &copy; ${pageContext.response.locale == null ? '2024' : ''} Milklore. All rights reserved.
            </div>
        </div>
    </footer>

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="updateProfile" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="adminName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="adminName" name="adminName" value="${dto.adminName}" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${dto.email}" required>
                        </div>
                        <div class="mb-3">
                            <label for="mobileNumber" class="form-label">Mobile Number</label>
                            <input type="tel" class="form-control" id="mobileNumber" name="mobileNumber" value="${dto.mobileNumber}" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enable tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Theme switcher functionality
        const themeToggle = document.getElementById('themeToggle');
        if (themeToggle) {
            themeToggle.addEventListener('change', function() {
                if (this.checked) {
                    document.documentElement.setAttribute('data-bs-theme', 'dark');
                    localStorage.setItem('theme', 'dark');
                } else {
                    document.documentElement.setAttribute('data-bs-theme', 'light');
                    localStorage.setItem('theme', 'light');
                }
            });

            // Check for saved user preference, if any, on load
            const currentTheme = localStorage.getItem('theme') || 'light';
            if (currentTheme === 'dark') {
                document.documentElement.setAttribute('data-bs-theme', 'dark');
                themeToggle.checked = true;
            }
        }
    </script>
</body>
</html>
