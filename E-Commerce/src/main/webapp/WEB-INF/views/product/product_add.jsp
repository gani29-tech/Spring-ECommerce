<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Product - E-Commerce</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
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
            padding: 35px 40px;
            border-radius: 16px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.08);
            width: 450px;
            text-align: center;
        }
        h2 {
            margin-bottom: 25px;
            color: #333;
        }
        label {
            font-weight: 600;
            display: block;
            margin-top: 15px;
            text-align: left;
        }
        input[type="text"],
        input[type="number"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        textarea {
            resize: none;
        }
        input:focus, textarea:focus {
            border-color: #4e73df;
            outline: none;
        }
        .field-error {
            color: #d9534f;
            font-size: 13px;
            margin-top: 5px;
            text-align: left;
        }
        .global-error {
            background-color: #fdecea;
            color: #c0392b;
            padding: 10px 12px;
            border-radius: 6px;
            margin-bottom: 12px;
            font-weight: 600;
        }
        .custom-error {
            background-color: #fdecea;
            color: #c0392b;
            padding: 10px 12px;
            border-radius: 6px;
            margin-bottom: 12px;
            font-weight: 600;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 10px 12px;
            border-radius: 6px;
            margin-bottom: 12px;
            font-weight: 600;
        }
        button {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background-color: #1cc88a;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background-color: #17a673;
        }
        .back-link {
            margin-top: 18px;
        }
        .back-link a {
            text-decoration: none;
            color: #4e73df;
            font-weight: 600;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New Product</h2>

    <form:errors path="*" cssClass="global-error"/>

    <c:if test="${not empty error}">
        <div class="custom-error">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success">${success}</div>
    </c:if>

    <form:form method="POST"
               action="${pageContext.request.contextPath}/admin/add"
               modelAttribute="product"
               enctype="multipart/form-data">

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

        <label>Image:</label>
        <input type="file" name="imageFile"/>

        <button type="submit">Add Product</button>
    </form:form>

    <div class="back-link">
        <p><a href="${pageContext.request.contextPath}/product/list">Back to Product List</a></p>
    </div>
</div>

</body>
</html>