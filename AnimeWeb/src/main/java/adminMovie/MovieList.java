package adminMovie;

import Log.Log;
import database.DAOMovie;
import database.JDBiConnector;
import model.Account;
import model.Movie;
import org.jdbi.v3.core.Jdbi;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MovieList", value = "/admin/MovieList")
public class MovieList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> listMovie = DAOMovie.listMovieAdmin();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.INFO, user.getId(), ipClient, "MovieList", "Xem danh sách các phim", 1);
        JDBiConnector.insert(log);
        request.setAttribute("listMovie",listMovie);
        request.getRequestDispatcher("/admin/MovieList.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
