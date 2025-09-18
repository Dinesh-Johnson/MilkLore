<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Page Not Found</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
            background-color: #fdfdfd;
        }
        .error-container {
            text-align: center;
        }
        .error-code {
            font-size: 10rem;
            font-weight: bold;
            color: #2a9d8f;
        }
        .farm-img {
            max-width: 280px;
            margin-bottom: 20px;
        }
        .btn-home {
            margin-top: 20px;
            background-color: #2a9d8f;
            border: none;
            font-size: 1.2rem;
            padding: 10px 25px;
        }
        .btn-home:hover {
            background-color: #21867a;
        }
    </style>
</head>
<body>
<div class="error-container">
    <!-- You can replace with your own farm/milk related image -->
    <img src="https://cdn-icons-png.flaticon.com/512/1998/1998592.png" alt="Farm Cow" class="farm-img"/>

    <div class="error-code">404</div>
    <h2 class="mt-3">Oops! The page is lost in the pasture 🐄🌾</h2>
    <p class="text-muted">Looks like this page wandered off to the dairy farm.</p>
    <a href="<c:url value='/' />" class="btn btn-home text-white">Go Back to Home</a>
</div>
</body>
</html>
