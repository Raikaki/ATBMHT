package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import database.DAOCommentMovie;
import model.CommentMovie;
import model.LocalDateTimeAdapter;


import javax.servlet.http.HttpServlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RenderCommentMovie", value = "/anime-main/RenderCommentMovie")
public class RenderCommentMovie extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        String type=request.getParameter("type");
        int rendered = Integer.parseInt(request.getParameter("rendered"));
        int idMovie = Integer.parseInt(request.getParameter("idMovie"));


        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        List<CommentMovie> listComment = new ArrayList<>();
        int newRendered=0;
        int enableRender=0;
        if(type.equalsIgnoreCase("root0")){
            listComment   =  DAOCommentMovie.getCommentMovie(idMovie,rendered,5,false,0);
            newRendered = rendered+listComment.size();
            enableRender  = DAOCommentMovie.availableCommentToRender(idMovie,newRendered,false,0);
        }if(type.equalsIgnoreCase("root1") || type.equalsIgnoreCase("root2")){
            int parentId = Integer.parseInt(request.getParameter("parentId"));
            listComment   =  DAOCommentMovie.getCommentMovie(idMovie,rendered,5,true,parentId);
            newRendered = rendered+listComment.size();
            enableRender  = DAOCommentMovie.availableCommentToRender(idMovie,newRendered,true,parentId);

        }
        JsonObject object = new JsonObject();
        JsonArray jsonArray = new JsonArray();
        jsonArray.add(gson.toJson(listComment));
        object.add("listComment",jsonArray);
        object.addProperty("rendered",newRendered);
        object.addProperty("enableRender",enableRender);
        String data = gson.toJson(object);
        response.getWriter().print(data);


    }
}
