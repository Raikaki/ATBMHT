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

import database.DAODashBoard;
import database.DAORecharge;
import model.ImportCoupon;
import model.PurchasedDetail;

@WebServlet(name = "ImportCoupons", value = "/admin/ImportCoupons")
public class ImportCoupons extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<ImportCoupon> importCoupons = new ArrayList<>();
        importCoupons = DAODashBoard.getListImportCoupons();
        System.out.println(importCoupons);
        request.setAttribute("importCoupons",importCoupons);

        request.getRequestDispatcher("/admin/importCoupons.jsp").forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
