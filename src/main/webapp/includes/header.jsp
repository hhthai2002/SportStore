<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    if (request.getSession().getAttribute("error") != null) {
        String s = (String) request.getSession().getAttribute("error");
%>
<script>alert('<%=s%>')</script>
<% }
    session.removeAttribute("error"); %>


<%
    if (request.getSession().getAttribute("tb") != null) {
        String s1 = (String) request.getSession().getAttribute("tb");
%>
<script>alert('<%=s1%>')</script>
<% }
    session.removeAttribute("tb"); %>
<div class="navbar">

    <div id="left-side-navbar">
        <form action="search">
            <input class="search-bar" type="text" id="searchinfo" name="searchinfo" placeholder="Search">
            <button type="submit" class="search-icon" role="button"><i class="fa fa-search" aria-hidden="true"></i>
            </button>
        </form>
    </div>


    <div class="main-logo" onclick="location.href='home.jsp';" style="cursor: pointer;">
        <h1>SPORT STORE</h1>
    </div>


    <div class="right-side-nav" id="">
        <a href="cart.jsp" style="text-decoration: none;"><span class="qtt">${cart_list.size()}</span><i
                class="fa fa-cart-plus" aria-hidden="true"></i> Cart</a>
        <% if (session.getAttribute("name") != null) { %>
            <a href="purchase.jsp" style="text-decoration: none;"><span class="qtt"></span><i
                        class="fa-solid fa-money-bill" aria-hidden="true"></i> Purchase</a>
        <% } %>
        <%
            if (session.getAttribute("name") == null) {
        %>

        <!--Trigger-->
        <a class="login-trigger" href="#" data-target="#login" data-toggle="modal">Login</a>

        <div id="login" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <div class="modal-content">
                    <div class="modal-body">
                        <button data-dismiss="modal" class="close">&times;</button>
                        <h5>Login</h5>
                        <form action="login" method="POST">
                            <input type="text" name="userName" id="userName" class="username form-control"
                                   placeholder="Username" required/>
                            <input type="password" name="password" id="password" class="password form-control"
                                   placeholder="password" required/>
                            <input class="btn login" type="submit" value="Login"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
        }
        else {
        %><a href="logout" style="text-decoration: none;"><i class="fa fa-sign-out icon" aria-hidden="true"></i> Logout</a>
        <%} %>
    </div>
</div>
