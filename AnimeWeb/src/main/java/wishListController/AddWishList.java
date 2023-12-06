package wishListController;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOBills;
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
import java.util.*;

@WebServlet(name = "AddWishList", value = "/anime-main/AddWishList")
public class AddWishList extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setCharacterEncoding("UTF-8");

            HttpSession session = request.getSession();
            Object langObject = session.getAttribute("LANG");
            String lang = langObject == null ? "en_US" : String.valueOf(langObject);
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
            if (action.equals("checkout") && order == null) {
                session.setAttribute("fail", true);
                request.getRequestDispatcher("/anime-main/wish-list.jsp").forward(request, response);
                return;
            }
            if (action.equals("checkout") && (wishlist.isEmpty() || order.getSelectedMovies().isEmpty())) {
                session.setAttribute("fail", true);
                request.getRequestDispatcher("/anime-main/wish-list.jsp").forward(request, response);
                return;
            }
            if (action.equals("checkout") && order != null && !order.getSelectedMovies().isEmpty()) {
                session.removeAttribute("fail");
                Calendar calendar = Calendar.getInstance();
                user = (Account) session.getAttribute("user");
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1;
                int day = calendar.get(Calendar.DAY_OF_MONTH);
                totalPrice = order.getTotalPrice();

                System.out.println(day);
                List<String> selectedMovies;
                selectedMovies = order.getSelectedMovieNames();
                Random random = new Random();
                int number = random.nextInt(90000000) + 10000000;
                String nameCus = user.getFullName();
                System.out.println(nameCus);
                List<Movie> movieList = order.getSelectedMovies();



                session.setAttribute("nameCus", nameCus);
                session.setAttribute("number", number);
                session.setAttribute("day", day);
                session.setAttribute("month", month);
                session.setAttribute("year", year);
                session.setAttribute("order", order);
                session.setAttribute("selectedMovies", selectedMovies);
                response.sendRedirect(getServletContext().getContextPath() + "/anime-main/checkout");
            }
            if (action.equals("checkoutAll")) {
                order = new Order();
                session.setAttribute("order", order);
                session.removeAttribute("success");
                session.setAttribute("done", "done");
                session.removeAttribute("fail");
                Calendar calendar = Calendar.getInstance();
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1;
                int day = calendar.get(Calendar.DAY_OF_MONTH);
                user = (Account) session.getAttribute("user");
                for (Map.Entry<String, WishListDetail> entry : wishlist.entrySet()) {
                    List<Movie> listValue = entry.getValue().getWishList();
                    for (Movie m : listValue) {
                        order.addMovie(m);
                    }
                }
                totalPrice = order.getTotalPrice();

                System.out.println(day);
                List<String> selectedMovies;
                selectedMovies = order.getSelectedMovieNames();
                Random random = new Random();
                int number = random.nextInt(90000000) + 10000000;
                String nameCus = user.getFullName();
                System.out.println(nameCus);
                session.setAttribute("nameCus", nameCus);
                session.setAttribute("number", number);
                session.setAttribute("day", day);
                session.setAttribute("month", month);
                session.setAttribute("year", year);
                session.setAttribute("order", order);
                session.setAttribute("selectedMovies", selectedMovies);
                response.sendRedirect(getServletContext().getContextPath() + "/anime-main/checkout");
                return;
            }
            if (action.equals("add")) {
                int idMovie = Integer.parseInt(request.getParameter("idMovie"));
                DAOMovie daoMovie = new DAOMovie();
                Movie movieAdd = DAOMovie.getMovieDetail(idMovie, lang);
                list = wishlist.get(String.valueOf(movieAdd.getId()));
                if (list == null) {
                    list = new WishListDetail();
                    list.setWishList(new ArrayList<>());
                    wishlist.put(String.valueOf(movieAdd.getId()), list);
                    added.add(movieAdd);
                }
                List<Movie> listM = list.getWishList();
                if (list != null) {
                    for (Movie m : listM) {
                        if (m.getId() == movieAdd.getId()) {
                            response.setContentType("application/json");
                            PrintWriter out = response.getWriter();
                            out.print(gson.toJson(wishlist));
                            out.flush();
                            return;
                        }
                    }
                }
                list.addMoive(movieAdd);

                wishlist.put(String.valueOf(movieAdd.getId()), list);
                System.out.println(wishlist.get(String.valueOf(movieAdd.getId())));
                session.setAttribute("wishlist", wishlist);
                session.setAttribute("added", added);
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print(gson.toJson(wishlist));
                out.flush();
            }
        } catch (Exception e) {
            response.getWriter().print(e.getMessage());
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}



