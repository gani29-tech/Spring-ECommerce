<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Techouts Ecommerce</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 30px;
            background: linear-gradient(to right, #e3f2fd, #fce4ec);
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: #ffffff;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
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
        }

        th {
            background: linear-gradient(to right, #2c3e50, #34495e);
            color: white;
        }

        tr:nth-child(even) {
            background: #f4f6f8;
        }

        .section {
            margin-top: 35px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 6px;
            color: #2c3e50;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #dcdcdc;
            font-size: 14px;
            transition: 0.2s;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52,152,219,0.15);
        }

        textarea {
            resize: none;
        }

        .total-box {
            text-align: right;
            font-size: 22px;
            font-weight: 700;
            margin-top: 25px;
            color: #27ae60;
        }

        .btn-confirm {
            background: linear-gradient(to right, #27ae60, #2ecc71);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 25px;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn-confirm:hover {
            opacity: 0.9;
        }

        .empty-cart {
            text-align: center;
            font-size: 18px;
            margin-top: 40px;
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

    <h2>Checkout</h2>

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

    <c:if test="${not empty cart.cartItems}">

        <table>
            <tr>
                <th>Product</th>
                <th>Image</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>

            <c:set var="total" value="0" />
            <c:forEach var="item" items="${cart.cartItems}">
                <tr>
                    <td>${item.product.name}</td>
                    <td>
                        <c:if test="${not empty item.product.image}">
                            <img src="${pageContext.request.contextPath}/uploads/${item.product.image}"
                                 alt="${item.product.name}"
                                 style="width: 80px; height: 80px; object-fit: contain; border-radius: 8px;"/>
                        </c:if>
                    </td>
                    <td>${item.quantity}</td>
                    <td>$${item.product.price}</td>
                    <td>$${item.quantity * item.product.price}</td>
                </tr>
                <c:set var="total" value="${total + (item.quantity * item.product.price)}" />
            </c:forEach>
        </table>

        <div class="total-box">
            Total Amount: $${total}
        </div>

        <form action="${pageContext.request.contextPath}/cart/checkout" method="post">

            <div class="section">
                <h3>Shipping Address</h3>

                <div class="form-group">
                    <label>Full Address</label>
                    <textarea name="address" rows="3" required></textarea>
                </div>

                <div class="form-group">
                    <label>City</label>
                    <input type="text" name="city" required/>
                </div>

                <div class="form-group">
                    <label>State</label>
                    <input type="text" name="state" required/>
                </div>

                <div class="form-group">
                    <label>Pincode</label>
                    <input type="text" name="pincode" required/>
                </div>
            </div>

            <div class="section">
                <h3>Payment Method</h3>

                <div class="form-group">
                    <select name="paymentType" required>
                        <option value="">-- Select Payment Type --</option>
                        <option value="COD">Cash On Delivery</option>
                        <option value="UPI">UPI</option>
                        <option value="CARD">Credit / Debit Card</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-confirm">Confirm Order</button>

        </form>

    </c:if>

    <c:if test="${empty cart.cartItems}">
        <div class="empty-cart">
            Your cart is empty. Please add products before checking out.
        </div>
    </c:if>

</div>

</body>
</html>