package controller;

import database.DAOMovie;
import database.DAOCommentMovie;
import model.Account;
import model.ChapterMovie;
import model.CommentMovie;
import model.Movie;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "WatchingMovie", value = "/anime-main/WatchingMovie")
public class WatchingMovie extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMovie = request.getParameter("idMovie");

        HttpSession session = request.getSession();
        Movie nowMovie = (Movie) session.getAttribute("watchingMovie");
        String chapter = request.getParameter("chapter")==null?"1":request.getParameter("chapter");;
        Movie watchingMovie;
        ChapterMovie watchChapter = null;
        int limit = 5;
        int rendered;
        int availableToRender;
        List<CommentMovie> listComment;

        if(nowMovie!=null){
            if(!String.valueOf(nowMovie.getId()).equalsIgnoreCase(idMovie)&&idMovie!=null){
                watchingMovie= DAOMovie.watchingMovie(idMovie);
            }else{
                watchingMovie = DAOMovie.watchingMovie(String.valueOf(nowMovie.getId()));
            }


        }else{
            watchingMovie= DAOMovie.watchingMovie(idMovie);
        }
        if(watchingMovie.getType().getId()==2){
            Account user = (Account) session.getAttribute("user");
            if(user==null || (DAOMovie.getDetailMoviePurchased(user.getId(), watchingMovie.getId())==0)){
                response.sendRedirect(getServletContext().getContextPath()+"/anime-main/MovieDetail?idMovie="+idMovie);
                return;
            }
        }
        listComment = DAOCommentMovie.getCommentMovie(watchingMovie.getId(),0,limit,false,0);
        watchingMovie.setListComment(listComment);
        rendered= listComment.size();
        availableToRender = DAOCommentMovie.availableCommentToRender(watchingMovie.getId(),limit,false,0);
        request.setAttribute("rendered",rendered);
        request.setAttribute("availableToRender",availableToRender);
        session.setAttribute("watchingMovie",watchingMovie);
        if (chapter==null){
            chapter=watchingMovie.getFirstChapter();
        }
        request.setAttribute("movie",watchingMovie);
        request.setAttribute("chapter",chapter);
        int indexChapter = Integer.parseInt(chapter)-1;
        if(!(indexChapter<0 || indexChapter>=watchingMovie.getListChapter().size())){
            watchChapter=  watchingMovie.getListChapter().get(Integer.parseInt(chapter)-1);

        }else{

            watchChapter= new ChapterMovie();
        }

        request.setAttribute("watchChapter",watchChapter);

        request.getRequestDispatcher("/anime-main/anime-watching.jsp").forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}

