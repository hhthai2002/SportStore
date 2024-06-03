<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="entity.Cart" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    DecimalFormat dcf = new DecimalFormat("#.##");
    request.setAttribute("dcf", dcf);

    // Get the user ID from the session as a String
    String userIdStr = (String) session.getAttribute("idd");

    // Check if the user ID exists
    if (userIdStr != null) {
        ArrayList<Cart> cartProduct = null;
        ProductDAO pDao = new ProductDAO();

        // Get the list of products purchased by the user from the database
        cartProduct = pDao.getProductsPurchasedByUser(userIdStr);

        // Calculate the total price of the products purchased
        double total = pDao.getTotalPriceOfProductsPurchasedByUser(userIdStr);
        request.setAttribute("total", total);
        request.setAttribute("cart_lists", cartProduct);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase</title>
    <!-- Add your CSS and JavaScript links here -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        * {
            box-sizing: border-box;
        }

        /* Button used to open the contact form - fixed at the bottom of the page */
        .open-button {
            background-color: #555;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            opacity: 0.8;
            position: fixed;
            bottom: 23px;
            right: 28px;
            width: 280px;
        }

        /* The popup form - hidden by default */
        .form-popup {
            display: none;
            position: fixed;
            bottom: 0;
            right: 15px;
            border: 3px solid #f1f1f1;
            z-index: 9;
        }

        /* Add styles to the form container */
        .form-container {
            max-width: 300px;
            padding: 10px;
            background-color: white;
        }

        /* Full-width input fields */
        .form-container input[type=text], .form-container input[type=password] {
            width: 100%;
            padding: 15px;
            margin: 5px 0 22px 0;
            border: none;
            background: #f1f1f1;
        }

        /* When the inputs get focus, do something */
        .form-container input[type=text]:focus, .form-container input[type=password]:focus {
            background-color: #ddd;
            outline: none;
        }

        /* Set a style for the submit/login button */
        .form-container .btn {
            background-color: #04AA6D;
            color: white;
            padding: 16px 20px;
            border: none;
            cursor: pointer;
            width: 100%;
            margin-bottom: 10px;
            opacity: 0.8;
        }

        /* Add a red background color to the cancel button */
        .form-container .cancel {
            background-color: red;
        }

        /* Add some hover effects to buttons */
        .form-container .btn:hover, .open-button:hover {
            opacity: 1;
        }
    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* Make the image fully responsive */
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
    </style>
    <style type="text/css">
        .table tbody td {
            vertical-align: middle;
        }

        .btn-incre, .btn-decre {
            box-shadow: none;
            font-size: 25px;
        }
    </style>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<%
    response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
%>

<jsp:include page="includes/header.jsp"/>

<hr>

<div class="container">
    <div class="d-flex py-3"><h3>Total Price: $ ${(total>0)?dcf.format(total):0} </h3></div>
    <table class="table table-light">
        <thead>
        <tr>
            <th scope="col">Name</th>
            <th scope="col">Price</th>
            <th scope="col">Quantity</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<Cart> cartList = (ArrayList<Cart>) request.getAttribute("cart_lists");
            if (cartList != null) {
                for (Cart c : cartList) {
        %>
        <tr>
            <td><%= c.getShoesName() %>
            </td>
            <td>$ <%= dcf.format(c.getPrice()) %>
            </td>
            <td><%= c.getQuantity() %>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<jsp:include page="includes/footer.jsp"/>

</body>
</html>
