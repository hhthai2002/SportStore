package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/signup")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String fn = request.getParameter("fname");
		String em = request.getParameter("emaill");
		String un = request.getParameter("userNamee");
		String pw = request.getParameter("passw");
		UserDAO dao = new UserDAO();
		boolean checkuser = dao.signUpUser(fn, em, un, pw);
		HttpSession session = request.getSession();
		if (checkuser) {
			session.setAttribute("tb", "Sign up successfully!");
			response.sendRedirect("home.jsp");
		} else {
			session.setAttribute("tb", "Username existed!");
			response.sendRedirect("home.jsp");
		}

	}

}
