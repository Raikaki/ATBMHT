package adminMovie;

import Log.Log;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import database.DAOMovie;
import database.JDBiConnector;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveMovie", value = "/admin/RemoveMovie")
public class RemoveMovie extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idMovie = request.getParameter("idMovie");
        boolean isSuccess = DAOMovie.removeMovie(idMovie);
        Gson gson = new Gson();
        JsonObject object = new JsonObject();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.DANGER, user.getId(), ipClient, "RemoveMovie", "Xóa bộ phim có id =" +idMovie, 1);
        JDBiConnector.insert(log);
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().print(gson.toJson(object));
    }
}
