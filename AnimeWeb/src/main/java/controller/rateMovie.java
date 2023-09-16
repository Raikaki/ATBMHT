package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DAORate;
import model.Account;


@WebServlet("/anime-main/rateMovie")
public class rateMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		if(user==null) {
			response.sendRedirect(getServletContext().getContextPath() +"/anime-main/login.jsp");
		}else {
			int score =Integer.parseInt(request.getParameter("scoreMovie"));
			int idMovie = Integer.parseInt(request.getParameter("id"));
			int rateOld=DAORate.getRate(user.getId(),idMovie);

			if(rateOld!=0){
				DAORate.updateVote(user.getId(),idMovie,score);
			}else{
				DAORate.voteMovie(user.getId(),idMovie,score);
			}

			response.sendRedirect(getServletContext().getContextPath()+"/anime-main/MovieDetail"+"?idMovie="+idMovie);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
