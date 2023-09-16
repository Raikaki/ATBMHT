package controller;


import database.DAOMovie;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ListFollow", value = "/anime-main/ListFollow")
public class ListFollow extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user != null) {
            user.setMoviesFollow(new DAOMovie().getMoviesFollow(user.getId()));
            request.setAttribute("user", user);
            System.out.println(user.getMoviesFollow());
        }
        request.getRequestDispatcher("/anime-main/follow.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}