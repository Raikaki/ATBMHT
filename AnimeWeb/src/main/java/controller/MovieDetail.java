package controller;

import database.DAOMovie;
import database.DAOCommentMovie;
import database.DAORate;
import model.Account;
import model.CommentMovie;
import model.Movie;

import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "MovieDetail", value = "/anime-main/MovieDetail")
public class MovieDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        Object langObject = session.getAttribute("LANG");
        String lang = langObject==null?"en_US":String.valueOf(langObject);


            boolean isFollow=false;
            int idMovie = Integer.parseInt(request.getParameter("idMovie"));

            Movie movie = DAOMovie.getMovieDetail(idMovie,lang);

            int limit = 5;
            List<CommentMovie> listComment = DAOCommentMovie.getCommentMovie(idMovie,0,limit,false,0);
            movie.setListComment(listComment);
            int rendered = listComment.size();
            int availableToRender = DAOCommentMovie.availableCommentToRender(idMovie,limit,false,0);
            request.setAttribute("movie",movie);
            request.setAttribute("rendered",rendered);
            request.setAttribute("availableToRender",availableToRender);

            if(user!= null){
                int rateOld=DAORate.getRate(user.getId(),idMovie);
                request.setAttribute("rate",rateOld);
                int purchasedId = DAOMovie.getDetailMoviePurchased(user.getId(), idMovie);
                request.setAttribute("purchasedId",purchasedId);
                isFollow=DAOMovie.getFollow(user.getId(),idMovie)!=0;

                request.setAttribute("checkFl",isFollow);


            }

            request.getRequestDispatcher("/anime-main/anime-detail.jsp").forward(request,response);




    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
