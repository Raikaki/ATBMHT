package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOBonus;
import database.DAOMovie;
import model.Account;
import model.LocalDateTimeAdapter;
import model.Movie;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Bonus", value = "/anime-main/Bonus")
public class Bonus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            String indexNumber = request.getParameter("index");
            int index = indexNumber == null ? 0 : Integer.parseInt(indexNumber);
            String param = request.getParameter("filter") == null ? "isAtoZ" : request.getParameter("filter");
            String idBonus = request.getParameter("idBonus");
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            int calcPage = DAOBonus.getBonusMovie(idBonus).size() / 9;
            int totalMovie = DAOBonus.getBonusMovie(idBonus).size() % 9 == 0 ? calcPage : calcPage + 1;
            if ((index >= totalMovie - 1 || index < 0 )&& totalMovie>0) {
                index = totalMovie - 1;
            }
            List<Movie> renderMovies = DAOMovie.renderBonusMovie(index * 9, 9, param,idBonus);
            List<Integer> purchasedIds = new ArrayList<>();
            if (user != null) {
                purchasedIds = DAOMovie.getDetailMoviePurchaseds(user.getId());
            }
            session.setAttribute("purchasedIds", purchasedIds);
            request.setAttribute("renderMovies", renderMovies);
            request.setAttribute("totalMovie", totalMovie);
            request.setAttribute("index", index);
            request.setAttribute("idBonus",idBonus);
            request.setAttribute("param", param);
            request.getSession().removeAttribute("order");

            request.getRequestDispatcher("/anime-main/bonus.jsp").forward(request, response);
        } catch (Exception e) {
            response.getWriter().println("<img class=\"rsImg\" src=\"/AnimeWeb/error.png"+"\">");

        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
