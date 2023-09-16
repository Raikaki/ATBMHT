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
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOAccounts;
import database.DAOMovie;
import database.DAORecharge;
import database.JDBiConnector;
import model.Account;
import model.Movie;
import model.PurchasedDetail;

@WebServlet(name = "removeTransactionHistory", value = "/admin/removeTransactionHistory")
public class removeTransactionHistory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String ipClient = request.getRemoteAddr();
        Account user = (Account) request.getSession().getAttribute("user");
        int id = Integer.parseInt(request.getParameter("id"));
        Log log = new Log(Log.DANGER, user.getId(), ipClient, "RemoveHistoryPurchased", null, 1);
        JDBiConnector jdBiConnector = new JDBiConnector();
        boolean isSuccess = DAORecharge.deleteTransactionHistory(id);
        System.out.println(isSuccess);
        if (isSuccess) {
            log.setContent("xóa lịch sử có id = " + id + "thành công");
            jdBiConnector.insert(log);
        } else {
            log.setContent("xóa lịch sử có id = " + id + "thất bại");
            jdBiConnector.insert(log);
        }
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess", isSuccess);
        response.getWriter().print(gson.toJson(object));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
