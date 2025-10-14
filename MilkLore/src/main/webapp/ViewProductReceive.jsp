<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns:c="http://www.w3.org/1999/XSL/Transform" xmlns:fmt="">
<head>
    <meta charset="UTF-8">
    <title>Milk Collection Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container mt-4">
    <h2>Milk Collection Details</h2>

    <!-- Error or Info Messages -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <c:if test="${not empty infoMessage}">
        <div class="alert alert-info">${infoMessage}</div>
    </c:if>

    <!-- Milk Collection Table -->
    <c:choose>
        <c:when test="${not empty collectMilkList}">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                <tr>
                    <th>Date</th>
                    <th>Milk Type</th>
                    <th>Quantity (L)</th>
                    <th>Price (₹/L)</th>
                    <th>Total (₹)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="milk" items="${collectMilkList}">
                    <tr>
                        <td>${milk.collectedDate}</td>
                        <td>${milk.typeOfMilk}</td>
                        <td>${milk.price}</td>
                        <td>${milk.quantity}</td>
                        <td>${milk.totalAmount}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">No milk collection records found.</div>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
