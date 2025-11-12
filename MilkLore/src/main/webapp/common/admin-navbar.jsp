<nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background: linear-gradient(135deg, #667eea, #764ba2);">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="toIndex">
            <img src="images/milklore.png" alt="Milklore Logo" height="40" class="me-2"/>
            <span>
                <strong>Milklore</strong><br/>
                <small style="opacity:0.8;">Tales and Taste of Tradition</small>
            </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="redirectToProductsPrice?email=${dto.email}"><i class="bi bi-tag me-2"></i>Products Price</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToCollectMilk?email=${dto.email}"><i class="bi bi-box me-2"></i>Collect Milk</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToAdminPaymentHistory?email=${dto.email}&page=1&size=10"><i class="bi bi-wallet2 me-2"></i>Payments</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToMilkSuppliersList?email=${dto.email}&page=1&size=10"><i class="bi bi-truck me-2"></i>Suppliers</a></li>
                <li class="nav-item"><a class="nav-link" href="redirectToGetCollectMilkList?email=${dto.email}"><i class="bi bi-droplet me-2"></i>Milk Records</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link position-relative" href="#" id="notificationDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-bell-fill"></i>
                        <c:if test="${unreadCount > 0}">
                            <span class="position-absolute top-0 start-100 translate-middle badge bg-danger">${unreadCount}</span>
                        </c:if>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown" style="width:350px;">
                        <jsp:include page="/WEB-INF/views/common/admin-notification-list.jsp"/>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" data-bs-toggle="dropdown">
                        <c:choose>
                            <c:when test="${empty dto.profilePath}">
                                <img src="images/dummy-profile.png" class="rounded-circle" width="40" height="40">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/uploads/${dto.profilePath}'/>" class="rounded-circle" width="40" height="40">
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#adminProfileModal"><i class="bi bi-person me-2"></i>Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="adminLogout?email=${dto.email}"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
