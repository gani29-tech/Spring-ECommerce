<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>${product.name}</title>
    <style>
        body {
            font-family: 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #f0f4f8, #ffffff);
            margin: 0;
            padding: 40px;
            color: #333;
        }
        .product-container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
            display: flex;
            gap: 40px;
            align-items: flex-start;
            animation: fadeIn 0.9s ease-in-out;
        }
        .product-image {
            flex: 1;
            text-align: center;
        }
        .product-image img {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
            transition: transform 0.35s ease, box-shadow 0.35s ease;
            margin-bottom: 15px;
        }
        .product-image img:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .product-image .meta {
            font-size: 1.1rem;
            color: #444;
        }
        .product-image .meta strong {
            display: block;
            font-size: 1.2rem;
            margin-top: 5px;
            color: #222;
        }
        .product-details {
            flex: 1.2;
        }
        .message, .error {
            padding: 14px;
            margin-bottom: 18px;
            border-radius: 8px;
            font-weight: 500;
        }
        .message {
            background: #e6ffed;
            color: #1b7a3d;
            border: 1px solid #b2f5ea;
        }
        .error {
            background: #ffe6e6;
            color: #a12d2d;
            border: 1px solid #f5b2b2;
        }
        p {
            margin: 12px 0;
            font-size: 1.05rem;
            line-height: 1.6;
        }
        .price {
            font-size: 1.6rem;
            font-weight: bold;
            color: #007bff;
            margin-top: 20px;
        }
        .actions {
            margin-top: 25px;
        }
        .actions a {
            display: inline-block;
            margin: 10px 12px 0 0;
            padding: 14px 24px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1.05rem;
            transition: all 0.35s ease;
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }
        .actions a.add {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: #fff;
        }
        .actions a.add:hover {
            background: linear-gradient(135deg, #0056b3, #003d80);
            transform: translateY(-3px);
        }
        .actions a.buy {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: #fff;
        }
        .actions a.buy:hover {
            background: linear-gradient(135deg, #1e7e34, #145523);
            transform: translateY(-3px);
        }
        .actions a.back {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: #fff;
        }
        .actions a.back:hover {
            background: linear-gradient(135deg, #5a6268, #444b50);
            transform: translateY(-3px);
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(25px);}
            to {opacity: 1; transform: translateY(0);}
        }
        /* Responsive */
        @media (max-width: 768px) {
            .product-container {
                flex-direction: column;
                padding: 25px;
            }
            .product-image, .product-details {
                flex: unset;
                width: 100%;
            }
            .actions a {
                display: block;
                margin: 14px auto;
                width: 85%;
            }
        }
    </style>
</head>
<body>
    <div class="product-container">
        <div class="product-image">
            <c:if test="${not empty product.image}">
                <img src="${pageContext.request.contextPath}/uploads/${product.image}" alt="${product.name}" />
            </c:if>
            <div class="meta">
                <span><strong>${product.name}</strong></span>
                <span>Category: ${product.category}</span>
            </div>
        </div>
        <div class="product-details">
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <p><strong>About the Product:</strong> ${product.description}</p>
            <p class="price">Price: $${product.price}</p>

            <div class="actions">
            <c:if test="${user.role!='ROLE_ADMIN'}">
                <a href="${pageContext.request.contextPath}/cart/add/details/${product.id}" class="add">Add to Cart</a>
                <a href="${pageContext.request.contextPath}/cart/buynow/${product.id}" class="buy">Buy Now</a>
                <a href="${pageContext.request.contextPath}/cart/show" class="add">Go to cart</a>
            </c:if>
            <c:if test="${user.role=='ROLE_ADMIN'}">
                <a href="${pageContext.request.contextPath}/admin/update/${product.id}" class="buy">Update</a>
                <a href="${pageContext.request.contextPath}/admin/delete/${product.id}" onclick="return confirm('Are you sure?')" class="add">Delete</a>
            </c:if>
                <a href="${pageContext.request.contextPath}/product/list" class="back">Back to Products</a>
            </div>
        </div>
    </div>
</body>
</html>
