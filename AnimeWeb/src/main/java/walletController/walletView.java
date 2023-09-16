package walletController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOMovie;

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

@WebServlet(name = "walletView", value = "/anime-main/walletView")
public class walletView extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("fail");
        Account user = (Account) session.getAttribute("user");
        DAORecharge daoRecharge = new DAORecharge();
        if (user == null) request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
        ArrayList<TransactionHistory> transactionHistory = (ArrayList<TransactionHistory>) session.getAttribute("history");

        if (transactionHistory == null) {
            transactionHistory = new ArrayList<>();
            session.setAttribute("history", transactionHistory);

        }
        if (user != null && transactionHistory != null) {
            List<TransactionHistory> history = daoRecharge.getBalanceFluctuations(user.getId());
            transactionHistory = new ArrayList<>(history);
            Collections.reverse(transactionHistory);

            session.setAttribute("history", transactionHistory);

        }


        request.getRequestDispatcher("/anime-main/rechargeView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
