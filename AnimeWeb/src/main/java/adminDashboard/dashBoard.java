package adminDashboard;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAODashBoard;
import database.DAOMovie;
import database.DAORecharge;
import model.Account;
import model.LocalDateTimeAdapter;
import model.Movie;
import model.PurchasedDetail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet(name = "dashBoard", value = "/admin/dashBoard")
public class dashBoard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("user");
        System.out.println(account);
        int totalAccount;
        totalAccount = DAODashBoard.calculateTotalActiveUsers();
        int totalMovie;
        totalMovie = DAODashBoard.totalMovie();
        int blockAccount;
        blockAccount = DAODashBoard.blockAccount();
        int totalMoviePurchase;
        totalMoviePurchase = DAODashBoard.totalMoviePurchase();
        List<Movie> topPurchasedList;
        topPurchasedList = DAODashBoard.getTopPurchasedMovies();
        double totalCost = DAORecharge.calculateTotalImportCost();
        double totalRevenue = DAORecharge.calculateTotalRevenue();
        double profit = totalRevenue - totalCost;
        List<Movie> topPurchasedListYear;
        topPurchasedListYear = DAODashBoard.getTopPurchasedMoviesYear();

        List<Movie> topNotPurchasedList;
        topNotPurchasedList = DAODashBoard.getTopNotPurchasedMovies();
        request.setAttribute("profit", profit);
        request.getSession().setAttribute("user", account);
        request.setAttribute("totalAccount", totalAccount);
        request.setAttribute("totalMovie", totalMovie);
        request.setAttribute("blockAccount", blockAccount);
        request.setAttribute("totalMoviePurchase", totalMoviePurchase);
        request.setAttribute("topPurchasedList", topPurchasedList);
        request.setAttribute("topPurchasedListYear", topPurchasedListYear);
        request.setAttribute("topNotPurchasedList", topNotPurchasedList);
        System.out.println(topPurchasedList.size());
        request.getRequestDispatcher("/admin/Index.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
