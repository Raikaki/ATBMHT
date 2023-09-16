package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOMovie;
import model.Account;
import model.LocalDateTimeAdapter;
import model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/anime-main/Index")
public class Index extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        String indexNumber = request.getParameter("index");
        int index = indexNumber == null ? 0 : Integer.parseInt(indexNumber);
        String param = request.getParameter("filter") == null ? "notDescDate" : request.getParameter("filter");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        int calcPage = DAOMovie.totalMovie() / 9;
        int totalMovie = DAOMovie.totalMovie() % 9 == 0 ? calcPage : calcPage + 1;

        if ((index >= totalMovie - 1 || index < 0 )&& totalMovie>0) {
            index = totalMovie - 1;
        }
        List<Movie> renderMovies = DAOMovie.renderMovie(index * 9, 9, param);
        List<Integer> purchasedIds = new ArrayList<>();
        if (user != null) {
            purchasedIds = DAOMovie.getDetailMoviePurchaseds(user.getId());
        }
        session.setAttribute("purchasedIds", purchasedIds);
        request.setAttribute("renderMovies", renderMovies);
        request.setAttribute("totalMovie", totalMovie);
        request.setAttribute("index", index);
        request.setAttribute("param", param);
        request.getSession().removeAttribute("order");

        request.getRequestDispatcher("/anime-main/index.jsp").forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       doGet(req,resp);
    }
}