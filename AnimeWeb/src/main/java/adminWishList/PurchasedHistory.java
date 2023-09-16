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
import model.PurchasedDetail;

@WebServlet(name = "PurchasedHistory", value = "/admin/PurchasedHistory")
public class PurchasedHistory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<PurchasedDetail> dataList = new ArrayList<>();
        DAORecharge daoRecharge = new DAORecharge();
        dataList = daoRecharge.getPurchases();
        System.out.println(dataList);
        request.setAttribute("data", dataList);
        request.getRequestDispatcher("/admin/WishList-list.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
