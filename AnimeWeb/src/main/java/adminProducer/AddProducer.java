package adminProducer;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOProducer;
import model.LocalDateTimeAdapter;
import model.Producer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
@WebServlet(name = "AddProducer", value = "/admin/AddProducer")
public class AddProducer extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setCharacterEncoding("UTF-8");
            String addName = request.getParameter("addName");
            String addDescription = request.getParameter("addDescription");
            Producer newProducer = DAOProducer.addProducer(addName,addDescription);
            Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
            JsonObject object = new JsonObject();
            object.addProperty("newProducer",gson.toJson(newProducer));
            response.getWriter().println(object);
    }
}
