<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Techouts E-Commerce</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(to bottom, #f0f4ff, #d9e6ff); color: #333; display: flex; flex-direction: column; min-height: 100vh; }

        header { background-color: #6c7ae0; color: white; padding: 20px 30px; display: flex; justify-content: space-between; align-items: center; border-radius: 0 0 12px 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        header .brand { font-size: 26px; font-weight: bold; }
        header .links a { text-decoration: none; color: white; margin-left: 15px; padding: 8px 15px; border-radius: 6px; background-color: #28a745; font-weight: 600; transition: 0.3s; }
        header .links a:hover { background-color: #19692c; transform: scale(1.05); }

        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; flex: 1; }
        h2 { text-align: center; margin-bottom: 20px; color: #2c3e50; font-size: 28px; }

        /* Flash message */
        .message { padding: 10px 15px; margin-bottom: 20px; border-radius: 6px; text-align: center; font-weight: 600; }
        .success { background-color: #d4edda; color: #155724; }
        .error { background-color: #f8d7da; color: #721c24; }

        /* Product Grid */
        .products { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; }
        @media (max-width: 1024px) { .products { grid-template-columns: repeat(3, 1fr); } }
        @media (max-width: 768px) { .products { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 480px) { .products { grid-template-columns: 1fr; } }

        .product-card { background: #fff; border-radius: 16px; padding: 20px; text-align: center; box-shadow: 0 8px 20px rgba(0,0,0,0.08); cursor: pointer; transition: transform 0.3s, box-shadow 0.3s; }
        .product-card:hover { transform: translateY(-8px); box-shadow: 0 12px 25px rgba(0,0,0,0.15); }
        .product-card img { width: 100%; height: 160px; object-fit: contain; margin-bottom: 15px; border-radius: 12px; }
        .product-card h3 { font-size: 20px; color: #2c3e50; margin: 10px 0 8px; }
        .product-card p { font-size: 15px; color: #555; margin: 5px 0; }

        .actions { margin-top: 12px; display: flex; justify-content: center; gap: 8px; pointer-events: auto; }
        .actions a { text-decoration: none; padding: 8px 14px; border-radius: 8px; font-size: 14px; transition: 0.3s; color: white; }
        .actions a[href*="/cart/add"] { background-color: #27ae60; }
        .actions a[href*="/cart/buynow"] { background-color: #e67e22; }
        .actions a[href*="/cart/add"]:hover { background-color: #219150; }
        .actions a[href*="/cart/buynow"]:hover { background-color: #d35400; }

        .no-products { text-align: center; font-size: 18px; color: #555; margin-top: 50px; }

        footer { background-color: #2c3e50; color: #ecf0f1; padding: 20px 40px; text-align: center; border-radius: 12px 12px 0 0; margin-top: 40px; }
        footer a { color: #6c7ae0; text-decoration: none; margin: 0 10px; }
        footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<header>
    <div class="brand">Techouts E-Commerce</div>
    <div class="links">
        <c:choose>
            <c:when test="${not empty user}">
                <a href="${pageContext.request.contextPath}/cart/show">Cart</a>
                <a href="${pageContext.request.contextPath}/product/list">Products</a>
                <a href="${pageContext.request.contextPath}/order/list">Orders</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="login">Login</a>
                <a href="signup">Sign Up</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<div class="container">
    <!-- Flash message from session -->
    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <h2>Products</h2>

    <c:if test="${not empty products}">
        <div class="products">
            <c:forEach var="product" items="${products}">
                <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product/details/${product.id}'">
                    <c:if test="${not empty product.image}">
                        <img src="${pageContext.request.contextPath}/uploads/${product.image}" alt="${product.name}" />
                    </c:if>
                    <h3>${product.name}</h3>
                    <p>Category: ${product.category}</p>
                    <p>Price: $${product.price}</p>
                    <div class="actions">
                        <a href="${pageContext.request.contextPath}/cart/add/${product.id}">Add to Cart</a>
                        <a href="${pageContext.request.contextPath}/cart/buynow/${product.id}">Buy Now</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty products}">
        <div class="no-products">
            <p>Products are currently unavailable.</p>
        </div>
    </c:if>
</div>

<footer>
    &copy; 2026 Techouts E-Commerce. All rights reserved.
    <br/>
</footer>

</body>
</html>