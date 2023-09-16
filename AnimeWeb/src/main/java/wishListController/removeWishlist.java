package wishListController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOMovie;
import model.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "wishListAction", value = "/anime-main/removeWishlist")
public class removeWishlist extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String action = request.getParameter("action");
        Order order = (Order) session.getAttribute("order");

        double totalPrice = 0;
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        if (user == null) {
            request.getRequestDispatcher("/anime-main/login.jsp").forward(request, response);
            return;
        }
        HashMap<String, WishListDetail> wishlist = (HashMap<String, WishListDetail>) session.getAttribute("wishlist");
        WishListDetail list = (WishListDetail) session.getAttribute("list");
        List<Movie> added = new ArrayList<>();
        if (action == null) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(wishlist));
            out.flush();
            return;
        }
        if (wishlist == null) {
            wishlist = new HashMap<>();
            session.setAttribute("wishlist", wishlist);
        }
        if (action.equals("remove") && order != null) {
            String idm = request.getParameter("idm");
            wishlist.remove(idm);
            JsonObject jsonResponse = new JsonObject();
            List<String> selectedMovieNames;
            if (order != null) {
                order.removeMovie(new DAOMovie().getMoviebyId(Integer.parseInt(idm)));
                System.out.println(order.getSelectedMovies().size());
                List<Movie> movieList = new ArrayList<>(order.getSelectedMovies());
                for (Movie m : movieList) {
                    if (m.getId() == Integer.parseInt(idm)) {
                        order.removeMovie(m);
                        order.removeName(m.getName());
                        order.setTotalPrice(order.getTotalPrice() - m.getCalPrice());
                        session.setAttribute("order", order);
                    }
                }

                totalPrice = order.getTotalPrice();
                selectedMovieNames = order.getSelectedMovieNames();
                jsonResponse.addProperty("totalPrice", totalPrice);
                jsonResponse.add("selectedMovieNames", gson.toJsonTree(selectedMovieNames));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(jsonResponse));
                return;
            }
            totalPrice = order.getTotalPrice();
            jsonResponse.addProperty("totalPrice", totalPrice);
            session.setAttribute("wishlist", wishlist);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(wishlist));
            out.flush();

        } else if (action.equals("removeAll")) {

            JsonObject jsonResponse = new JsonObject();
            Map<String, WishListDetail> map = new HashMap<>(wishlist);
            for (Map.Entry<String, WishListDetail> entry : map.entrySet()) {
                for (Movie m : entry.getValue().getWishList()) {
                    wishlist.remove(String.valueOf(m.getId()));
                }
            }
            jsonResponse.addProperty("totalPrice", totalPrice);
            session.setAttribute("wishlist", wishlist);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(wishlist));
            out.flush();
            return;

        } else {
            String idm = request.getParameter("idm");
            wishlist.remove(idm);
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("totalPrice", totalPrice);
            session.setAttribute("wishlist", wishlist);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(wishlist));
            out.flush();
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
