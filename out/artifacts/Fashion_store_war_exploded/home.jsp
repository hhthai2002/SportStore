<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList, entity.*" %>
    <%@ page import="dao.ProductDAO" %>
 <%
 ProductDAO dao = new ProductDAO();
	ArrayList<Shoes> list = new ArrayList<Shoes>();
	list = dao.allShoes();
 %>
 <%
 ProductDAO pd = new ProductDAO();
 ArrayList<Shoes> products = pd.allShoes();
 ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
 if (cart_list != null) {
 	request.setAttribute("cart_list", cart_list);
 }
 %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

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
  margin-bottom:10px;
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
.btn:hover {
	color: white;
	background: orange;
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
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/home.css">
	<link rel="stylesheet" href="css/login.css">
</head>
<body>
<%
    	response.setHeader("Cache-control", "no-cache, no-store, must-revalidate");
  		response.setHeader("Pragma","no-cache");
  		response.setHeader("Expires","0");
    %>
 <jsp:include page="includes/header.jsp"/>
<hr>


  <!------------------------------ Carousel slider  ----------------------------- -->
<div id="carousel-top-homepage">
<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
    <li data-target="#demo" data-slide-to="3"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="images/carousel/c1.jpg" alt="shoes1" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="images/carousel/c2.jpg" alt="shoes2" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="images/carousel/c3.jpg" alt="shoes3" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="images/carousel/c4.jpg" alt="shoes4" width="1100" height="500">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>
<hr>
 </div>


  <!------------------------------ Display all products  ----------------------------- -->

<div class="main">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h3 style="color: pink;font-family: 'Times New Roman', Times, Baskerville, Georgia, serif;font-weight: bold;">Top sellers</h3>
			</div>
			<br>
			<br>
			<br>
			
			
			<%
			int count = 0;
				for (Shoes s: list) { %>
				
				<div class="col-md-3">
				 	<div class="item-preview">
						<img src="<%=s.getCover()%>" alt="">
				 	</div>
					<h4 style="color: grey;"><%=s.getShoesName()%></h4>
				 	<h6>$<%=s.getPrice()%></h6>
				 	<a class="btn" href="CartServlet?productID=<%=s.getShoesID()%>">Add to Cart</a>
				</div>

				
				<%
				count++;}
			%>
		
		</div>
	</div>
</div>


  <!------------------------------ Footer  ----------------------------- -->
<div class="footer-f">	
		<div class="textCenter">	
			<a href="mailto:dsadsadsadasasd@gmail.com">Contact via email</a>				
			<p>Address: 10 dsa District, DNC</p>
				<h5>&copy; Copyright 2022. fds.VN</h5>
		</div>						
</div>


 <jsp:include page="includes/footer.jsp"/>


</body>
</html>