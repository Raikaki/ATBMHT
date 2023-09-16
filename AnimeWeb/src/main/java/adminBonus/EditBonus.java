package adminBonus;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOBonus;
import model.Bonus;
import model.LocalDateTimeAdapter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
@WebServlet(name = "EditBonus", value = "/admin/EditBonus")
public class EditBonus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String idBonus = request.getParameter("idBonus");
        String dayBegin =request.getParameter("dayBegin");
        String dayEnd =request.getParameter("dayEnd");
        String percent = request.getParameter("percent");
        String description = request.getParameter("description");
        boolean isSuccess = DAOBonus.editBonus(idBonus,description,dayBegin,dayEnd,percent);
        Bonus updateBonus;
        if(isSuccess){
            updateBonus=DAOBonus.findBonusById(idBonus);
            JsonObject object = new JsonObject();
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                    .create();
            object.addProperty("updatedBonus", gson.toJson(updateBonus));
            response.getWriter().println(object);

        }else{
            response.sendError(500);
        }
    }
}