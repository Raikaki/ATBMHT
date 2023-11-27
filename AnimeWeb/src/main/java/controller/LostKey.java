package controller;

import com.google.gson.JsonObject;
import database.DAOKey;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LostKey", value = "/anime-main/LostKey")
public class LostKey extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("user");
        boolean isSuccess = DAOKey.disableAllOldKey(user.getId());
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);

    }
}
