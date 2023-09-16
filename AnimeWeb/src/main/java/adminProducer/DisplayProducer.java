package adminProducer;

import com.google.gson.JsonObject;
import database.DAOProducer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "DisplayProducer", value = "/admin/DisplayProducer")
public class DisplayProducer extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProducer = request.getParameter("idProducer");
        boolean isSuccess = DAOProducer.displayProducer(idProducer);
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);
    }
}
