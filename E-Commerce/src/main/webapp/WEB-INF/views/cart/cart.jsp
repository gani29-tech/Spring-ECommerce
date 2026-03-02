<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        margin: 40px;
        background: linear-gradient(to right, #eef2f7, #f9fbfd);
        color: #333;
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 20px;
    }

    table {
        width: 90%;
        margin: 20px auto;
        border-collapse: collapse;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        background-color: white;
        border-radius: 12px;
        overflow: hidden;
    }

    th, td {
        padding: 14px 16px;
        text-align: center;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }

    th {
        background: linear-gradient(to right, #007bff, #0056b3);
        color: white;
        font-weight: 600;
    }

    tr:hover {
        background-color: #f4f8ff;
    }

    img.product-image {
        width: 120px;
        height: 120px;
        object-fit: contain;
        border-radius: 8px;
        background: #f8f9fa;
        padding: 5px;
    }

    button {
        background: linear-gradient(to right, #28a745, #20c997);
        color: white;
        border: none;
        padding: 8px 14px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        transition: 0.3s;
    }

    button:hover {
        background: linear-gradient(to right, #218838, #1e7e34);
    }

    form {
        margin: 0;
    }

    input[type="number"] {
        width: 65px;
        padding: 6px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        text-align: center;
    }

    .total-price {
        width: 90%;
        margin: 30px auto;
        font-size: 22px;
        font-weight: 700;
        text-align: right;
        color: #007bff;
    }

    .home-button {
        display: block;
        width: 120px;
        margin: 0 auto 20px auto;
        padding: 10px 0;
        text-align: center;
        background: linear-gradient(to right, #007bff, #0056b3);
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        transition: 0.3s;
    }

    .home-button:hover {
        background: linear-gradient(to right, #0056b3, #004494);
    }

    .alert {
        width: 90%;
        margin: 0 auto 20px auto;
        padding: 14px 18px;
        border-radius: 8px;
        font-weight: 500;
        text-align: center;
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

    .empty-cart {
        text-align: center;
        font-size: 18px;
        margin-top: 40px;
        color: #555;
    }
</style>

<a href="${pageContext.request.contextPath}/home" class="home-button">Home</a>

<h2>Your Cart</h2>

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
        <thead>
        <tr>
            <th>Product</th>
            <th>Image</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${cart.cartItems}">
            <tr>
                <td>${item.product.name}</td>
                <td>
                    <c:if test="${not empty item.product.image}">
                        <img src="${pageContext.request.contextPath}/uploads/${item.product.image}" alt="${item.product.name}" class="product-image"/>
                    </c:if>
                </td>
                <td>$${item.product.price}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/cart/update/${item.id}" method="post">
                        <input type="number" name="quantity" value="${item.quantity}" min="1" required />
                        <button type="submit">Update</button>
                    </form>
                </td>
                <td>$${item.product.price * item.quantity}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/cart/remove/${item.id}" method="post">
                        <button type="submit" style="background: linear-gradient(to right, #dc3545, #c82333);">Remove</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="total-price">
        Total Price: $${cart.totalPrice}
    </div>

    <form action="${pageContext.request.contextPath}/cart/checkout" style="text-align: center;">
        <button type="submit" style="width: 180px; font-size: 16px; padding: 10px; white-space: nowrap;">
            Proceed to Checkout
        </button>
    </form>
</c:if>

<c:if test="${empty cart.cartItems}">
    <div class="empty-cart">
        Your cart is empty.
    </div>
</c:if>