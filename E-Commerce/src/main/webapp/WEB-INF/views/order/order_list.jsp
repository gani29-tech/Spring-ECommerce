<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - Techouts Ecommerce</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f3e5f5, #e8f5e9);
            padding: 30px;
            margin: 0;
        }

        .container {
            background: white;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            max-width: 1100px;
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
            vertical-align: middle;
            word-break: keep-all;
        }

        th {
            background: linear-gradient(to right, #2c3e50, #34495e);
            color: white;
        }

        tr:nth-child(even) {
            background: #f4f6f8;
        }

        .btn-view, .btn-cancel {
            padding: 7px 16px;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.3s;
            display: inline-block;
            white-space: nowrap;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-view {
            background: linear-gradient(to right, #2980b9, #3498db);
            color: white;
        }

        .btn-view:hover {
            opacity: 0.9;
        }

        .btn-cancel {
            background: linear-gradient(to right, #c0392b, #e74c3c);
            color: white;
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

        .no-orders {
            text-align: center;
            margin-top: 40px;
            font-size: 18px;
            color: #555;
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
        <a href="${pageContext.request.contextPath}/home" class="home-btn">Home</a>
    </div>

    <h2>My Orders</h2>

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

    <c:choose>
        <c:when test="${not empty orders}">
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Total Amount</th>
                    <th>Status</th>
                    <th>Shipping Address</th>
                    <th>Details</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.orderDate}</td>
                        <td>$${order.totalAmount}</td>
                        <td>
                            <c:choose>
                                <c:when test="${fn:toUpperCase(fn:trim(order.status)) == 'PLACED'}">
                                    <span class="status-placed">${order.status}</span>
                                </c:when>
                                <c:when test="${fn:toUpperCase(fn:trim(order.status)) == 'CANCELLED'}">
                                    <span class="status-cancelled">${order.status}</span>
                                </c:when>
                                <c:otherwise>
                                    ${order.status}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            ${order.address}, ${order.city}, ${order.state} - ${order.pincode}
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/order/details/${order.id}" class="btn-view">
                                View
                            </a>
                        </td>
                        <td>
                            <c:if test="${fn:toUpperCase(fn:trim(order.status)) == 'PLACED'}">
                                <a href="${pageContext.request.contextPath}/order/cancel/${order.id}" class="btn-cancel">
                                    Cancel Order
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <div class="no-orders">You have no orders yet.</div>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>