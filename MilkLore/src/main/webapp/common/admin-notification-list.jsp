<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${empty notifications}">
        <li class="list-group-item text-muted text-center py-3">
            No new notifications
        </li>
    </c:when>
    <c:otherwise>
        <c:forEach var="n" items="${notifications}">
            <li class="list-group-item d-flex justify-content-between align-items-start">
                <div>
                    <i class="bi bi-bell me-2 text-primary"></i> ${n.message}
                </div>
                <small class="text-muted">${n.createdAt}</small>
            </li>
        </c:forEach>
    </c:otherwise>
</c:choose>
