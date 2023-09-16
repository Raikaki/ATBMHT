package controller;

import com.google.gson.JsonObject;
import database.DAOCommentMovie;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "removeComment", value = "/anime-main/removeComment")
public class removeComment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idComment = request.getParameter("idComment");
        boolean isSuccess = DAOCommentMovie.removeComment(idComment);
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);
    }
}
