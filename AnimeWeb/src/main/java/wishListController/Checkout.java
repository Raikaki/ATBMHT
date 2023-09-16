package wishListController;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOMovie;

import database.JDBiConnector;
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
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import database.DAORecharge;

@WebServlet(name = "checkout", value = "/anime-main/checkout")
public class Checkout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient = request.getRemoteAddr();
        String action = request.getParameter("action");
        Order order = (Order) session.getAttribute("order");
        DAORecharge daoRecharge = new DAORecharge();
        Log log = new Log(Log.INFO, -1, ipClient, "checkout", null, 1);
        HashMap<String, WishListDetail> wishlist = (HashMap<String, WishListDetail>) session.getAttribute("wishlist");
        DAOMovie daoMovie = new DAOMovie();
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        if (action == null) {
            session.removeAttribute("success");
            session.setAttribute("done", "done");
            response.sendRedirect(getServletContext().getContextPath() + "/anime-main/CheckoutIndex");
            return;
        }

        if (action.equals("back")) {
            session.removeAttribute("order");
            response.sendRedirect(getServletContext().getContextPath() + "/anime-main/wishList");
        }

        if (action.equals("checkout")) {
            if ((user.getBalance() - order.getTotalPrice()) >= 0) {
                for (Movie m : order.getSelectedMovies()) {
                    daoMovie.insertPurchasedMovie(user.getId(), m.getId(), m.getCalPrice());
                    wishlist.remove(String.valueOf(m.getId()));
                    session.setAttribute("wishlist", wishlist);
                    session.removeAttribute("order");
                }
                log.setUserId(user.getId());
                log.setContent("Thanh toán hàng hóa thành công");
                log.setLevel(Log.ALERT);
                new JDBiConnector().insert(log);
                user.setBalance((user.getBalance() - order.getTotalPrice()));
                DecimalFormat decimalFormat = new DecimalFormat("#,##0");
                user.setMoviesPurchased(order.getSelectedMovies());
                daoRecharge.updateBalance(user.getId(), user.getBalance());
                String balanceFluctuations = user.getBalanceFluctuations(order.getTotalPrice());
                daoRecharge.insertBalanceFluctuations(user.getId(), balanceFluctuations, "  mua phim.", 0);
                session.setAttribute("success", true);
                session.removeAttribute("done");
                response.sendRedirect(getServletContext().getContextPath() + "/anime-main/CheckoutIndex");
                return;
            } else {
                session.setAttribute("success", false);
                session.removeAttribute("done");
                log.setUserId(user.getId());
                log.setContent("Thanh toán hàng hóa thất bại");
                log.setLevel(Log.WARNING);
                new JDBiConnector().insert(log);
                response.sendRedirect(getServletContext().getContextPath() + "/anime-main/CheckoutIndex");

                return;
            }

        }

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
