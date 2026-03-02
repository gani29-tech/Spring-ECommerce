<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details - Techouts Ecommerce</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e3f2fd, #fce4ec);
            padding: 30px;
            margin: 0;
        }

        .container {
            background: #ffffff;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            max-width: 1000px;
            margin: auto;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            font-size: 22px;
            font-weight: 700;
            color: #2c3e50;
        }

        .home-btn {
            background: linear-gradient(to right, #2c3e50, #1a252f);
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }

        .home-btn:hover {
            opacity: 0.9;
        }

        h2 {
            margin-top: 25px;
            color: #34495e;
        }

        p {
            margin: 8px 0;
            font-size: 15px;
        }

        strong {
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        th {
            background: linear-gradient(to right, #2c3e50, #34495e);
            color: white;
        }

        tr:nth-child(even) {
            background: #f4f6f8;
        }

        img {
            width: 70px;
            height: 70px;
            object-fit: contain;
            border-radius: 8px;
            background: #f8f9fa;
            padding: 5px;
        }

        .total {
            text-align: right;
            margin-top: 25px;
            font-size: 22px;
            font-weight: 700;
            color: #27ae60;
        }

        .btn-cancel {
            display: inline-block;
            margin-top: 25px;
            background: linear-gradient(to right, #c0392b, #e74c3c);
            color: white;
            padding: 8px 18px;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.3s;
        }

        .btn-cancel:hover {
            opacity: 0.9;
        }

        .status-placed {
            color: #27ae60;
            font-weight: 700;
        }

        .status-cancelled {
            color: #c0392b;
            font-weight: 700;
        }

        .alert {
            padding: 14px 18px;
            border-radius: 8px;
            margin-top: 20px;
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
    <div class="top-bar">
        <div class="brand">Techouts Ecommerce</div>
        <a href="${pageContext.request.contextPath}/order/list" class="home-btn">Back to Orders</a>
    </div>

    <h2>Order #${order.id} Details</h2>

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

    <p><strong>Order Date:</strong> ${order.orderDate}</p>
    <p><strong>Payment Type:</strong> ${order.paymentType}</p>
    <p><strong>Status:</strong>
        <c:choose>
            <c:when test="${order.status == 'PLACED'}">
                <span class="status-placed">${order.status}</span>
            </c:when>
            <c:when test="${order.status == 'CANCELLED'}">
                <span class="status-cancelled">${order.status}</span>
            </c:when>
            <c:otherwise>
                ${order.status}
            </c:otherwise>
        </c:choose>
    </p>
    <p><strong>Shipping Address:</strong> ${order.address}, ${order.city}, ${order.state} - ${order.pincode}</p>

    <table>
        <tr>
            <th>Image</th>
            <th>Product</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Subtotal</th>
        </tr>
        <c:forEach var="item" items="${order.orderItems}">
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/uploads/${item.product.image}" alt="${item.product.name}"/>
                </td>
                <td>${item.product.name}</td>
                <td>${item.quantity}</td>
                <td>$${item.product.price}</td>
                <td>$${item.quantity * item.product.price}</td>
            </tr>
        </c:forEach>
    </table>

    <div class="total">
        Total Amount: $${order.totalAmount}
    </div>

    <c:if test="${order.status == 'PLACED'}">
        <a href="${pageContext.request.contextPath}/order/cancel/details/${order.id}" class="btn-cancel">Cancel Order</a>
    </c:if>

</div>

</body>
</html>