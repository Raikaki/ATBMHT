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

@WebServlet(name = "ViewBillDetails", value = "/anime-main/ViewBillDetails")
public class ViewBillDetails extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movieList = new ArrayList<>();
        HttpSession session = request.getSession();
        session.removeAttribute("fail");

        String id = request.getParameter("billId");

        Bill bill = DAOBills.getBillById(Integer.parseInt(id));
        System.out.println(bill);
        List<Bill_detail> billDetails = new ArrayList<>();

        billDetails = DAOBills.getBillDetailsByBillId(bill.getId());
        System.out.println(billDetails);
        for (Bill_detail b : billDetails
        ) {
            movieList.add(b.getMovie());
        }
        boolean verify;
        try {
            verify = DAOBills.verifySignatureBill(bill, bill.getPublicKey());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
            System.out.println(bill.getTotalPrice());
        System.out.println(verify);
        request.setAttribute("verify", verify);
        request.setAttribute("bill_movies", movieList);
        request.setAttribute("bill_detail", bill);
        request.getRequestDispatcher("/anime-main/bills_detail.jsp").forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
