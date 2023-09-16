package adminBonus;

import com.google.gson.JsonObject;
import database.DAOBonus;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "HideBonus", value = "/admin/HideBonus")
public class HideBonus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                String idBonus = request.getParameter("idBonus");
                boolean isSuccess = DAOBonus.hideBonus(idBonus);

                JsonObject object = new JsonObject();
                object.addProperty("isSuccess",isSuccess);
                response.getWriter().println(object);
    }
}
