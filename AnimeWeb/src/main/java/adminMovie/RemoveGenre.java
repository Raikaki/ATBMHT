package adminMovie;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOMovie;


import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveGenre", value = "/admin/RemoveGenre")
public class RemoveGenre extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idGenre = request.getParameter("idGenre");
        boolean isSuccess =DAOMovie.removeGenre(idGenre);
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(gson.toJson(object));
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doGet(request,response);
    }
}
