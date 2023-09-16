package adminMovie;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOMovie;
import model.Genre;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
@WebServlet(name = "SettingGenre", value = "/admin/SettingGenre")
public class SettingGenre extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idGenre = request.getParameter("idGenre");
        String genreDescription = request.getParameter("genreDescription");
        Genre genre = DAOMovie.settingGenre(idGenre,genreDescription);
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        object.addProperty("genre",gson.toJson(genre));
        response.getWriter().println(gson.toJson(object));
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
