package adminMovie;

import database.DAOMovie;
import model.Genre;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "GenreList", value = "/admin/GenreList")
public class GenreList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Genre> genres = DAOMovie.listGenreHeader();
        request.setAttribute("genres",genres);
        request.getRequestDispatcher("/admin/GenreList.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
