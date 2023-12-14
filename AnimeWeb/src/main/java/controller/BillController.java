package controller;

import database.DAOAccounts;
import database.DAOBills;
import model.Account;
import model.Bill;
import model.Bill_detail;
import model.Movie;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Bill", value = "/anime-main/Bill")
public class BillController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movieList = new ArrayList<>();
        HttpSession session = request.getSession();
        session.removeAttribute("fail");
        Account user = (Account) session.getAttribute("user");
        if (user == null) {
            request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
            return;
        } else {

            List<model.Bill> accountBills = DAOBills.getAccountBills(user.getId());



            request.getSession().setAttribute("bills", accountBills);
            request.getRequestDispatcher("/anime-main/bill.jsp").forward(request, response);
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
