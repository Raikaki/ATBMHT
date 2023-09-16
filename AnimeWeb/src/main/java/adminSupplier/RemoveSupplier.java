package adminSupplier;

import com.google.gson.JsonObject;
import database.DAOSupplier;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
@WebServlet(name = "RemoveSupplier", value = "/admin/RemoveSupplier")
public class RemoveSupplier extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idSupplier = request.getParameter("idSupplier");
        boolean  isSuccess= DAOSupplier.removeSupplier(idSupplier);
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);
    }
}
