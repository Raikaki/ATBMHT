package adminSupplier;

import com.google.gson.JsonObject;
import database.DAOSupplier;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
@WebServlet(name = "HideSupplier", value = "/admin/HideSupplier")
public class HideSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                String idSupplier = request.getParameter("idSupplier");
                boolean isSuccess = DAOSupplier.hideSupplier(idSupplier);
                JsonObject object = new JsonObject();
                object.addProperty("isSuccess",isSuccess);
                response.getWriter().println(object);
    }
}
