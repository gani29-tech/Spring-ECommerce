<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Techouts E-Commerce</title>
    <style>
        /* Reset & Base */
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(to bottom, #f0f4ff, #d9e6ff); color: #333; display: flex; flex-direction: column; min-height: 100vh; }

        /* Header */
        header { background-color: #ffffff; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-radius: 0 0 12px 12px; }
        header .brand { font-weight: 700; font-size: 24px; color: #6c7ae0; }
        header .welcome { font-weight: 600; font-size: 16px; color: #2c3e50; }
        header .welcome a { font-size: 14px; margin-left: 10px; padding: 4px 10px; border-radius: 6px; background-color: #6c7ae0; color: white; text-decoration: none; transition: 0.3s; }
        header .welcome a:hover { background-color: #34495e; }
        header .user-links a { color: #2c3e50; text-decoration: none; margin-left: 10px; padding: 6px 12px; border-radius: 6px; transition: 0.3s; background-color: #f9f9f9; border: 1px solid #ddd; }
        header .user-links a:hover { background-color: #2c3e50; color: white; }

        /* Layout */
        .container { display: flex; max-width: 1700px; margin: 40px auto; gap: 20px; flex: 1; }
        .categories { width: 220px; background-color: #ffffff; padding: 20px; border-radius: 12px; box-shadow: 0 6px 15px rgba(0,0,0,0.08); }
        .categories h3 { margin-bottom: 15px; color: #2c3e50; font-size: 22px; border-bottom: 1px solid #ddd; padding-bottom: 8px; }
        .categories a { display: block; padding: 10px 12px; margin-bottom: 8px; text-decoration: none; border-radius: 6px; background-color: #6c7ae0; color: #fff; font-weight: 500; transition: 0.3s; }
        .categories a.active, .categories a:hover { background-color: #34495e; }

        .product-section { flex: 1; }
        h2 { text-align: left; margin-bottom: 25px; color: #2c3e50; font-size: 28px; }

        /* Flash Messages */
        .flash-message { text-align: center; padding: 12px 15px; margin-bottom: 20px; border-radius: 8px; font-weight: 600; max-width: 800px; margin-left: auto; margin-right: auto; }
        .flash-success { background-color: #d4edda; color: #155724; }
        .flash-error { background-color: #f8d7da; color: #721c24; }
        .flash-info { background-color: #d1ecf1; color: #0c5460; }

        /* Product Grid */
        .product-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; }
        @media (max-width: 1024px) { .product-grid { grid-template-columns: repeat(3, 1fr); } }
        @media (max-width: 768px) { .product-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 480px) { .container { flex-direction: column; } .product-grid { grid-template-columns: 1fr; } }

        /* Product Card */
        .product-card { background-color: #ffffff; border-radius: 16px; padding: 20px; text-align: center; box-shadow: 0 8px 20px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; cursor: pointer; }
        .product-card:hover { transform: translateY(-8px); box-shadow: 0 12px 25px rgba(0,0,0,0.15); }
        .product-card img { max-width: 100%; height: 160px; object-fit: contain; margin-bottom: 15px; border-radius: 12px; }
        .product-card h3 { margin: 10px 0 8px; font-size: 20px; color: #2c3e50; }
        .product-card p { margin: 5px 0; color: #555; font-size: 15px; }

        /* Action Buttons */
        .actions { margin-top: 12px; display: flex; justify-content: center; flex-wrap: wrap; gap: 8px; pointer-events: auto; }
        .actions a { text-decoration: none; display: inline-block; padding: 8px 14px; font-size: 14px; border-radius: 8px; transition: 0.3s; }
        .actions a[href*="/cart/add"] { background-color: #27ae60; color: white; }
        .actions a[href*="/cart/buynow"] { background-color: #e67e22; color: white; }
        .actions a.admin { background-color: #e74c3c; color: white; }
        .actions a[href*="/cart/add"]:hover { background-color: #219150; }
        .actions a[href*="/cart/buynow"]:hover { background-color: #d35400; }
        .actions a.admin:hover { background-color: #c0392b; }

        /* No products */
        p.no-products { text-align: center; font-size: 16px; color: #555; margin-top: 40px; }

        /* Footer */
        footer { background-color: #2c3e50; color: #ecf0f1; padding: 20px 40px; text-align: center; border-radius: 12px 12px 0 0; margin-top: 40px; }
        footer a { color: #6c7ae0; text-decoration: none; margin: 0 10px; }
        footer a:hover { text-decoration: underline; }

        @media (max-width: 600px) { header { flex-direction: column; align-items: flex-start; gap: 10px; } .product-card img { height: 140px; } }
    </style>
</head>
<body>

<header>
    <div class="brand">Techouts E-Commerce</div>
    <div class="welcome">
        Welcome, ${user.username}
        <a href="${pageContext.request.contextPath}/user/update">Update Profile</a>
    </div>
    <div class="user-links">
        <c:if test="${user.role=='ROLE_ADMIN'}">
         <a href="${pageContext.request.contextPath}/admin/add" class="admin">Add Product</a>
         </c:if>
        <c:if test="${user.role!='ROLE_ADMIN'}">
            <a href="${pageContext.request.contextPath}/cart/show">Cart</a>
            <a href="${pageContext.request.contextPath}/order/list">Orders</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</header>

<div class="container">

    <div class="categories">
        <h3>Categories</h3>
        <c:forEach var="cat" items="${categories}">
            <a href="${pageContext.request.contextPath}/home?category=${cat}"
               class="${selectedCategory == cat ? 'active' : ''}">${cat}</a>
        </c:forEach>
        <a href="${pageContext.request.contextPath}/home?category=All"
           class="${selectedCategory == 'All' ? 'active' : ''}">All</a>
    </div>

    <div class="product-section">
        <c:if test="${not empty message}">
            <div class="flash-message flash-info">${message}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="flash-message flash-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="flash-message flash-error">${error}</div>
        </c:if>

        <h2>Products</h2>
        <c:choose>
            <c:when test="${not empty products}">
                <div class="product-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product/details/${product.id}'">
                            <c:if test="${not empty product.image}">
                                <img src="${pageContext.request.contextPath}/uploads/${product.image}" alt="${product.name}"/>
                            </c:if>
                            <h3>${product.name}</h3>
                            <p>Category: ${product.category}</p>
                            <p>Price: $${product.price}</p>
                            <div class="actions">
                                <c:if test="${user.role!='ROLE_ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/cart/add/${product.id}?category=${selectedCategory}">Add to Cart</a>
                                    <a href="${pageContext.request.contextPath}/cart/buynow/${product.id}">Buy Now</a>
                                </c:if>
                                <c:if test="${user.role=='ROLE_ADMIN'}">
                                    <a href="${pageContext.request.contextPath}/admin/update/${product.id}" class="admin">Update</a>
                                    <a href="${pageContext.request.contextPath}/admin/delete/${product.id}" onclick="return confirm('Are you sure?')" class="admin">Delete</a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="no-products">No products available.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer>
    &copy; 2026 Techouts E-Commerce. All rights reserved.
</footer>

</body>
</html>