package controller;

import dao.ProductDAO;
import entity.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

@WebServlet("/buyItem")
public class BuyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Get existing session, don't create a new one
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("home.jsp"); // Redirect to login page if user is not logged in
            return;
        }

        String userId = (String) session.getAttribute("idd"); // Get user ID from session

        // Check if the user ID is valid
        if (userId == null || userId.isEmpty()) {
            resp.sendRedirect("home.jsp"); // Redirect to login page if user ID is not found
            return;
        }

        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            ProductDAO productDAO = new ProductDAO();
            boolean purchaseSuccessful = productDAO.insertPurchase(Integer.parseInt(userId), productId, quantity);
            if (purchaseSuccessful) {
                // Remove purchased item from cart
                ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart-list");
                if (cartList != null) {
                    cartList.removeIf(cart -> cart.getShoesID() == productId);
                }
                resp.sendRedirect("purchase.jsp"); // Redirect to purchase after successful purchase
            }
            else {
                resp.sendRedirect("cart.jsp?error=purchase_failed"); // Redirect to cart with error message if purchase fails
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendRedirect("cart.jsp?error=invalid_parameters"); // Redirect to cart with error message if invalid parameters occur
        }
    }

}

