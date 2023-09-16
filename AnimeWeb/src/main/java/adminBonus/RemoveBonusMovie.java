package adminBonus;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOBonus;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
@WebServlet(name = "RemoveBonusMovie", value = "/admin/RemoveBonusMovie")
public class RemoveBonusMovie extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idBonus = request.getParameter("idBonus");
        String idMovieBonus = request.getParameter("idMovieBonus");
        boolean isSuccess = DAOBonus.removeBonusMovie(idBonus,idMovieBonus);
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().print(gson.toJson(object));
    }
}
