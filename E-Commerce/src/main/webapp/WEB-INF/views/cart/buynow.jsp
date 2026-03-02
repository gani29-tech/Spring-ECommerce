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
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
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
            background: #2c3e50;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }

        .home-btn:hover {
            background: #1a252f;
        }

        h2 {
            margin-top: 20px;
            color: #34495e;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        th {
            background: #2c3e50;
            color: white;
        }

        tr:nth-child(even) {
            background: #f4f6f8;
        }

        img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
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
            padding: 12px 28px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 25px;
            font-size: 16px;
            transition: 0.3s;
        }

        .btn-confirm:hover {
            background: linear-gradient(to right, #1e8449, #239b56);
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

    <c:if test="${not empty orderItem}">

        <table>
            <tr>
                <th>Image</th>
                <th>Product</th>
                <th>Price</th>
            </tr>

            <tr>
                <td>
                    <c:if test="${not empty orderItem.image}">
                        <img src="${pageContext.request.contextPath}/uploads/${orderItem.image}"
                             alt="${orderItem.name}"/>
                    </c:if>
                </td>
                <td>${orderItem.name}</td>
                <td>$${orderItem.price}</td>
            </tr>
        </table>

        <div class="total-box">
            Total Amount: $${orderItem.price}
        </div>

        <form action="${pageContext.request.contextPath}/cart/buynow" method="post">

            <input type="hidden" name="productId" value="${orderItem.id}" />

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

    <c:if test="${empty orderItem}">
        <div class="empty-cart">
            No item selected for checkout.
        </div>
    </c:if>

</div>

</body>
</html>