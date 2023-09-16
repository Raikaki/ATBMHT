package walletController;


import model.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.*;

import database.DAORecharge;

@WebServlet(name = "recharge", value = "/anime-main/recharge")
public class recharge extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("fail");
        Account user = (Account) session.getAttribute("user");
        DAORecharge daoRecharge = new DAORecharge();
        if (user == null) {
            request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("recharge.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
