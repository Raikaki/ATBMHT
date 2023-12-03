package controller;

import database.DAOBills;
import model.Account;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Bill", value = "/anime-main/Bill")
public class Bill extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("user");
        List<model.Bill> accountBills = DAOBills.getAccountBills(user.getId());
        request.setAttribute("bills",accountBills);
        request.getRequestDispatcher("/anime-main/bill.jsp").forward(request,response);
    }
}
