package controller;

import database.DAOMovie;
import model.Account;
import model.Movie;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/anime-main/genre")
public class genre extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String idGenre = request.getParameter("genre");
        String indexNumber = request.getParameter("index");
        int index = indexNumber == null ? 0 : Integer.parseInt(indexNumber);
        String param = request.getParameter("filter") == null ? "notDescDate" : request.getParameter("filter");
        String type = request.getParameter("type") == null ? "all" : request.getParameter("type");
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        boolean isAtoZ = Boolean.parseBoolean(request.getParameter("isAtoZ"));
        boolean isDescPrice = Boolean.parseBoolean(request.getParameter("isDescPrice"));
        boolean isDescDate = Boolean.parseBoolean(request.getParameter("isDescDate"));

        DAOMovie daoMovie = new DAOMovie();
        String genreDescription = DAOMovie.getGenre(idGenre);
        int calcPage = DAOMovie.totalMovieFindGenre(idGenre) / 9;
        int totalMovie = DAOMovie.totalMovieFindGenre(idGenre) % 9 == 0 ? calcPage : calcPage + 1;
        if ((index >= totalMovie - 1 || index < 0 )&& totalMovie>0) {
            index = totalMovie - 1;
        }
        List<Movie> renderMoviesGenre = DAOMovie.renderMovieFindGenre(index * 9, 9, param,type, idGenre);
        List<Integer> purchasedIds = new ArrayList<>();
        if (user != null) {
            purchasedIds = DAOMovie.getDetailMoviePurchaseds(user.getId());
        }
        System.out.println(renderMoviesGenre);
        session.setAttribute("purchasedIds", purchasedIds);
        request.setAttribute("renderMoviesGenre", renderMoviesGenre);
        request.setAttribute("genreDescription", genreDescription);
        request.setAttribute("idGenre", idGenre);
        request.setAttribute("totalMovie", totalMovie);
        request.setAttribute("index", index);
        request.setAttribute("param", param);
        request.setAttribute("type", type);
        System.out.println(type);
        request.getSession().removeAttribute("order");
        request.getRequestDispatcher("/anime-main/categories.jsp").forward(request, response);

    }

}
