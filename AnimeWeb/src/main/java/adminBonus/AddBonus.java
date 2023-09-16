package adminBonus;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOBonus;
import model.Bonus;
import model.LocalDateTimeAdapter;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
@WebServlet(name = "AddBonus", value = "/admin/AddBonus")
public class AddBonus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String addDescription = request.getParameter("addDescription");
        String addDayBegin = request.getParameter("addDayBegin");
        String addDayEnd = request.getParameter("addDayEnd");
        String addPercent = request.getParameter("addPercent");
        Bonus insertedBonus = DAOBonus.addBonus(addDescription,addDayBegin,addDayEnd,addPercent);
        if(insertedBonus!=null){
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                    .create();
            JsonObject object = new JsonObject();
            object.addProperty("newBonus",gson.toJson(insertedBonus));
            response.getWriter().println(object);
        }else{
            response.sendError(500);
        }

    }
}
