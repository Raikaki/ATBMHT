package controller;

import database.DAOMovie;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpView", value = "/anime-main/UpView")
public class UpView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMovie = request.getParameter("idMovie");
        HttpSession session = request.getSession();
        Account user = (Account)session.getAttribute("user");
        String idAccount = user==null?"null":String.valueOf(user.getId());
        DAOMovie.updateView(idAccount,idMovie);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
