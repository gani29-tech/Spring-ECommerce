<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product - E-Commerce</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4e73df, #1cc88a);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 450px;
        }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        label { font-weight: bold; display: block; margin-top: 12px; }
        input[type="text"], input[type="number"], textarea, input[type="file"] {
            width: 100%; padding: 8px 10px; margin-top: 5px;
            border-radius: 5px; border: 1px solid #ccc; font-size: 14px;
        }
        input:focus, textarea:focus { border-color: #4e73df; outline: none; }
        textarea { resize: none; }

        .field-error { color: #d9534f; font-size: 13px; margin-bottom: 8px; }
        .global-error, .custom-error, .success {
            padding: 8px; border-radius: 5px; margin-bottom: 10px; text-align: center;
        }
        .global-error, .custom-error { background-color: #f8d7da; color: #721c24; }
        .success { background-color: #d4edda; color: #155724; }

        button {
            width: 100%; padding: 10px; margin-top: 15px;
            background-color: #1cc88a; color: white; border: none; border-radius: 5px;
            font-size: 16px; cursor: pointer; transition: 0.3s;
        }
        button:hover { background-color: #17a673; }

        img { margin-top: 5px; border-radius: 5px; border: 1px solid #ccc; }

        .back-link { text-align: center; margin-top: 15px; }
        .back-link a { text-decoration: none; color: #4e73df; font-weight: bold; }
        .back-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h2>Update Product</h2>

    <form:errors path="*" cssClass="global-error"/>
    <c:if test="${not empty error}"><div class="custom-error">${error}</div></c:if>
    <c:if test="${not empty success}"><div class="success">${success}</div></c:if>

    <form:form method="POST"
               action="${pageContext.request.contextPath}/admin/update"
               modelAttribute="product"
               enctype="multipart/form-data">

        <form:hidden path="id"/>

        <label>Name:</label>
        <form:input path="name"/>
        <form:errors path="name" cssClass="field-error"/>

        <label>Description:</label>
        <form:textarea path="description" rows="4"/>
        <form:errors path="description" cssClass="field-error"/>

        <label>Price:</label>
        <form:input path="price" type="number" step="0.01"/>
        <form:errors path="price" cssClass="field-error"/>

        <label>Category:</label>
        <form:input path="category"/>
        <form:errors path="category" cssClass="field-error"/>

        <label>Current Image:</label>
        <c:if test="${not empty product.image}">
            <img src="${pageContext.request.contextPath}/uploads/${product.image}" width="150"/>
        </c:if>

        <label>Change Image:</label>
        <input type="file" name="imageFile"/>

        <button type="submit">Update Product</button>
    </form:form>

    <div class="back-link">
        <p><a href="${pageContext.request.contextPath}/product/list">Back to List</a></p>
    </div>
</div>
</body>
</html>