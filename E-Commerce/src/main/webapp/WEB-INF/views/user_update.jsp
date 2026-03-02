<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile - E-Commerce</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(to right, #f6c23e, #4e73df);
               display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .container { background: #ffffff; padding: 30px 40px; border-radius: 10px; box-shadow: 0 8px 20px rgba(0,0,0,0.2); width: 400px; }
        h2 { text-align: center; margin-bottom: 20px; color: #333; }
        label { font-weight: bold; margin-top: 10px; display: block; }
        input, textarea { width: 100%; padding: 8px 10px; margin-top: 5px; margin-bottom: 15px; border-radius: 5px; border: 1px solid #ccc; font-size: 14px; }
        input:focus, textarea:focus { border-color: #4e73df; outline: none; }
        textarea { resize: none; }
        button { width: 100%; padding: 10px; background-color: #1cc88a; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; transition: 0.3s; }
        button:hover { background-color: #17a673; }
        .back-link { text-align: center; margin-top: 15px; }
        .back-link a { text-decoration: none; color: #4e73df; font-weight: bold; }
        .back-link a:hover { text-decoration: underline; }
        .message { text-align: center; padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Profile</h2>

    <!-- Success Message -->
    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/user/update" method="post">
        <input type="hidden" name="id" value="${user.id}"/>
        <input type="hidden" name="password" value="${user.password}"/>

        <label>Username:</label>
        <input type="text" name="username" value="${user.username}" required/>

        <label>Email:</label>
        <input type="email" name="email" value="${user.email}" required/>

        <label>Phone:</label>
        <input type="text" name="phone" value="${user.phone}" required/>

        <label>Address:</label>
        <textarea name="address" rows="3" required>${user.address}</textarea>

        <button type="submit">Update</button>
    </form>

    <div class="back-link">
        <p><a href="<c:url value='/home'/>">Back to Home</a></p>
    </div>
</div>

</body>
</html>