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
@WebServlet(name = "EditProducer", value = "/admin/EditProducer")
public class EditProducer extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String idProducer = request.getParameter("idProducer");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        Producer updatedProducer = DAOProducer.editProducer(idProducer, name, description);
        JsonObject object = new JsonObject();
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        object.addProperty("updatedProducer", gson.toJson(updatedProducer));
        response.getWriter().println(object);

    }
}