package controller;

import database.DAOCommentMovie;
import model.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CommentMovie", value = "/anime-main/CommentMovie")
public class CommentMovie extends HttpServlet  {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("user");
            request.setCharacterEncoding("UTF-8");
        if(user==null) {
            request.getRequestDispatcher("/anime-main/login.jsp").forward(request,response);
            return;
        }
            String content = request.getParameter("message");
            String idParent = request.getParameter("idParent");
            String idUserReply = request.getParameter("idUserReply");
            int idMovie = Integer.parseInt(request.getParameter("idMovie"));
            if(content!=null&&!content.trim().equals("")){
                DAOCommentMovie.Comment(user,idParent,idMovie,content,idUserReply);
            }
            response.sendRedirect(getServletContext().getContextPath()+("/anime-main/MovieDetail?idMovie="+idMovie));

    }
}
