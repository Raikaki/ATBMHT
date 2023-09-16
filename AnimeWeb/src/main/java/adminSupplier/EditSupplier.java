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
@WebServlet(name = "EditSupplier", value = "/admin/EditSupplier")
public class EditSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String idSupplier = request.getParameter("idSupplier");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        Supplier updatedSupplier = DAOSupplier.editSupplier(idSupplier, name, description, phone, address);
        JsonObject object = new JsonObject();
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        object.addProperty("updatedSupplier", gson.toJson(updatedSupplier));
        response.getWriter().println(object);

    }
}