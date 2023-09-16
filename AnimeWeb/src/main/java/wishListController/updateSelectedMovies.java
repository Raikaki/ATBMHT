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
import java.time.LocalDateTime;
import java.util.List;
import java.util.HashMap;


@WebServlet(name = "updateSelectedMovies", value = "/anime-main/updateSelectedMovies")
public class updateSelectedMovies extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Order order = (Order) session.getAttribute("order");
        if (order == null) {
            order = new Order();
            session.setAttribute("order", order);
        }
        HashMap<String, WishListDetail> wishlist = (HashMap<String, WishListDetail>) session.getAttribute("wishlist");
        WishListDetail list = (WishListDetail) session.getAttribute("list");
        JsonObject jsonResponse = new JsonObject();
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        double totalPrice = 0;
        List<String> selectedMovieNames;
        String[] selectedMovies = request.getParameterValues("selectedMovies");
        if (selectedMovies != null && selectedMovies.length > 0) {
            order = (Order) session.getAttribute("order");
            for (String id : selectedMovies) {

                Movie movieAdd = DAOMovie.getMoviebyId(Integer.parseInt(id));
                for (Movie m : order.getSelectedMovies()) {
                    if (Integer.parseInt(id) == m.getId()) {
                        order.removeMovie(m);
                        order.setTotalPrice(order.getTotalPrice() - m.getCalPrice());
                        totalPrice = order.getTotalPrice();
                        order.removeName(m.getName());
                        selectedMovieNames = order.getSelectedMovieNames();
                        jsonResponse.addProperty("totalPrice", totalPrice);
                        jsonResponse.add("selectedMovieNames", gson.toJsonTree(selectedMovieNames));
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(gson.toJson(jsonResponse));
                        return;
                    }

                }

                order.addMovie(movieAdd);
            }

        }
        session.setAttribute("order",order);
        selectedMovieNames = order.getSelectedMovieNames();
        totalPrice = order.getTotalPrice();
        jsonResponse.addProperty("totalPrice", totalPrice);
        jsonResponse.add("selectedMovieNames", gson.toJsonTree(selectedMovieNames));
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(jsonResponse));

    }
}
