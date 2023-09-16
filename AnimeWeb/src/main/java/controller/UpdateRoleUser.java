package controller;

import database.DAOAccounts;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateRoleUser", value = "/anime-main/UpdateRoleUser")
public class UpdateRoleUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        user= DAOAccounts.findAccountById(user.getId());
        session.setAttribute("user",user);
    }
}
