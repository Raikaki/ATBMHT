package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import database.DAOMovie;
import model.Account;
import model.LocalDateTimeAdapter;
import model.Movie;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/anime-main/topView")
public class TopView extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        String action = request.getParameter("action");
        HttpSession session = request.getSession();



            if (action != null) {
                if (action.equals("topYear")) {
                    List<Movie> topViewYear = DAOMovie.getTopViewMovieYear();
                    session.setAttribute("topViewYear", topViewYear);
                    response.getWriter().println(gson.toJson(topViewYear));
                    return;
                }
                if (action.equals("topMonth")) {
                    List<Movie> topViewMonth = DAOMovie.getTopViewMovieMonth();
                    session.setAttribute("topViewMonth", topViewMonth);
                    response.getWriter().println(gson.toJson(topViewMonth));
                    return;
                }
                if (action.equals("topDay")) {
                    List<Movie> topViewDay = DAOMovie.getTopViewMovieDay();
                    session.setAttribute("topViewDay", topViewDay);
                    response.getWriter().println(gson.toJson(topViewDay));
                    return;
                }
            }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

}
