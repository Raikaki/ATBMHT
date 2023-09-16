package adminSupplier;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOSupplier;
import model.LocalDateTimeAdapter;
import model.Supplier;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "AddSupplier", value = "/admin/AddSupplier")
public class AddSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            response.setCharacterEncoding("UTF-8");
            String addName = request.getParameter("addName");
            String addDescription = request.getParameter("addDescription");
            String addPhone = request.getParameter("addPhone");
            String addAddress = request.getParameter("addAddress");
            Supplier newSupplier = DAOSupplier.addSupplier(addName,addDescription,addPhone,addAddress);
            Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
            JsonObject object = new JsonObject();
            object.addProperty("newSupplier",gson.toJson(newSupplier));
            response.getWriter().println(object);
    }
}
