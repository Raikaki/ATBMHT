package controller;

import database.DAOKey;
import model.Account;
import model.Key;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "KeyDetail", value = "/anime-main/KeyDetail")
public class KeyDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("user");
        List<Key> keyList = DAOKey.accountKeyList(user.getId());
        request.setAttribute("keyList",keyList);
        request.getRequestDispatcher("/anime-main/keyDetail.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
