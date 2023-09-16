package adminWishList;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DAORecharge;
import model.TransactionHistory;

@WebServlet(name = "TransactionHistorys", value = "/admin/TransactionHistory")
public class TransactionHistorys extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<TransactionHistory> transactionHistoryList = new ArrayList<>();

        transactionHistoryList = DAORecharge.getAllBalanceFluctuations();
        System.out.println(transactionHistoryList);
        request.setAttribute("transactionHistoryList", transactionHistoryList);
        request.getRequestDispatcher("/admin/transactionHistory.jsp").forward(request,response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
