<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - E-Commerce</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4e73df, #1cc88a);
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
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        input, textarea {
            width: 100%;
            padding: 8px 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input:focus, textarea:focus {
            border-color: #4e73df;
            outline: none;
        }

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

        button:hover {
            background-color: #2e59d9;
        }

        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 14px;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .login-link {
            text-align: center;
            margin-top: 15px;
        }

        .login-link a {
            text-decoration: none;
            color: #4e73df;
            font-weight: bold;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Sign Up</h2>

    <!-- Display Error Message -->
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <!-- Display Success Message -->
    <c:if test="${not empty success}">
        <div class="message success">${success}</div>
    </c:if>

    <!-- Signup Form -->
    <form action="${pageContext.request.contextPath}/signup" method="post">
        <label>Username:</label>
        <input type="text" name="username" required autocomplete="username"/>

        <input type="hidden" name="role" value="ROLE_USER"/>

        <label>Password:</label>
        <input type="password" name="password" required autocomplete="new-password"/>

        <label>Email:</label>
        <input type="email" name="email" required autocomplete="email"/>

        <label>Phone:</label>
        <input type="tel" name="phone" required pattern="[0-9]{10}"
               title="Enter 10 digit phone number" autocomplete="tel"/>

        <label>Address:</label>
        <textarea name="address" rows="3" required autocomplete="street-address"></textarea>

        <button type="submit">Sign Up</button>
    </form>

    <div class="login-link">
        <p>Already have an account?
            <a href="${pageContext.request.contextPath}/login>">Login here</a>
        </p>
    </div>
</div>

</body>
</html>