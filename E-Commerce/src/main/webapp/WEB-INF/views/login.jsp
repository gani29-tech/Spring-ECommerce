<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - E-Commerce</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #36b9cc, #4e73df);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 350px;
        }

        h2 { text-align: center; margin-bottom: 20px; color: #333; }

        label { font-weight: bold; margin-top: 10px; display: block; }

        input {
            width: 100%;
            padding: 8px 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input:focus { border-color: #4e73df; outline: none; }

        button {
            width: 100%;
            padding: 10px;
            background-color: #4e73df;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover { background-color: #2e59d9; }

        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 14px;
            text-align: center;
            animation: fadeOut 5s forwards;
        }

        .error { background-color: #f8d7da; color: #721c24; }
        .success { background-color: #d4edda; color: #155724; }

        @keyframes fadeOut { 0% { opacity: 1; } 80% { opacity: 1; } 100% { opacity: 0; display: none; } }

        .signup-link { text-align: center; margin-top: 15px; }
        .signup-link a { text-decoration: none; color: #4e73df; font-weight: bold; }
        .signup-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <c:if test="${not empty param.error}">
        <div class="message error">Invalid username or password.</div>
    </c:if>

    <c:if test="${not empty param.logout}">
        <div class="message success">Logged out successfully.</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <label>Username:</label>
        <input type="text" name="username" required autofocus />

        <label>Password:</label>
        <input type="password" name="password" required />

        <button type="submit">Login</button>
    </form>

    <div class="signup-link">
        <p>Don't have an account?
            <a href="<c:url value='/signup'/>">Sign Up here</a>
        </p>
    </div>
</div>

</body>
</html>