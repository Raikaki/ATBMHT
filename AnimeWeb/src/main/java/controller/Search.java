package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOMovie;
import model.LocalDateTimeAdapter;
import model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/anime-main/SearchByName")
public class Search extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String view = request.getParameter("viewall");

            String searchBox = request.getParameter("searchBox");

            if (view == null) {
                List<Movie> movieList = new DAOMovie().searchMovie(searchBox);


                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                        .create();
                String jsonString = gson.toJson(movieList);


                response.setCharacterEncoding("UTF-8");
                response.getWriter().println(jsonString);
            } else {
                List<Movie> movieList = new DAOMovie().searchMovie(view);

                request.setAttribute("renderMovies", movieList);
                System.out.println("seach" + view);

                System.out.println(movieList);

                request.getRequestDispatcher("/anime-main/search-result.jsp").forward(request, response);
            }

        } catch (Exception e) {
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
        doGet(request, response);
    }
}
