<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
            margin: 0;
            background: linear-gradient(to right, #e8f5e9, #e3f2fd);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.08);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .success-message {
            color: #27ae60;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .order-details {
            font-size: 16px;
            margin-top: 20px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
        }

        .order-details p {
            margin: 8px 0;
            font-weight: 500;
        }

        .buttons {
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            margin: 8px;
            padding: 10px 22px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-home {
            background: linear-gradient(to right, #2980b9, #3498db);
        }

        .btn-orders {
            background: linear-gradient(to right, #2c3e50, #34495e);
        }

        .btn:hover {
            opacity: 0.9;
        }

        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-success {
            background-color: #eafaf1;
            color: #1e8449;
            border: 1px solid #2ecc71;
        }

        .alert-error {
            background-color: #fdecea;
            color: #c0392b;
            border: 1px solid #e74c3c;
        }
    </style>
</head>
<body>

<div class="container">

    <c:if test="${not empty message}">
        <div class="alert alert-success">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>

    <div class="success-message">
        Thank you! Your order has been placed successfully.
    </div>

    <c:if test="${not empty order}">
        <div class="order-details">
            <p>Order ID: ${order.id}</p>
            <p>Order Date: ${order.orderDate}</p>
            <p>Total Amount: $${order.totalAmount}</p>
        </div>
    </c:if>

    <div class="buttons">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-home">
            Continue Shopping
        </a>
        <a href="${pageContext.request.contextPath}/order/list" class="btn btn-orders">
            Go to Orders
        </a>
    </div>

</div>

</body>
</html>