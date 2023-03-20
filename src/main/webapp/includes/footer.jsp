<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%if (session.getAttribute("name")==null){
	%>  

<div class="form-popup" id="loginForm">
  <form action="LoginServlet" class="form-container">
    <%--@declare id="fullname"--%><%--@declare id="password"--%><h1>Sign in</h1>

	<label for="fullname"><b>User name</b></label>
    <input type="text" placeholder="What can we call you?" name="fullname" required>

    <label for="password"><b>Password</b></label>
    <input type="password" name="password" required>

    <button type="submit" class="btn">Enter</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
  </form>
</div>


<button class="open-button" onclick="openForm()">Sign up</button>

<div class="form-popup" id="myForm">
  <form action="signup" method="POST" class="form-container">
    <h1>Register</h1>

	<label for="fname"><b>Name</b></label>
    <input type="text" id="fname" placeholder="What can we call you?" name="fname" required>

    <label for="emaill"><b>Email</b></label>
    <input type="text" id="emaill" name="emaill" placeholder="Enter Email" required>

    <label for="userNamee"><b>Username</b></label>
    <input type="text" id="userNamee" name="userNamee" placeholder="Usernamee" required>
    
    <label for="passw"><b>Password</b></label>
    <input type="password" id="passw" name="passw" placeholder="Enter Password" required>

    <button type="submit" class="btn">Submit</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
  </form>
</div>


<script>
function openForm() {
  document.getElementById("myForm").style.display = "block";
}

function closeForm() {
  document.getElementById("myForm").style.display = "none";
}
</script>

<%} %>