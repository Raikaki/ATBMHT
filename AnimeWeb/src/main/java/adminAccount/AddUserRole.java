package adminAccount;

import Log.Log;
import com.google.gson.JsonObject;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import socket.UserUpdateEndpoint;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/AddUserRole")
public class AddUserRole extends HttpServlet {
    public AddUserRole() {
        super();

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ip = request.getRemoteAddr();
        Log log = new Log(Log.ALERT, user.getId(), ip, "AddUserRole", "", 1);
        String userId = request.getParameter("userId");
        String roleId = request.getParameter("roleId");
        boolean isSuccess = DAORoleAccount.addRoleUser(userId, roleId);
        if (isSuccess) {
            log.setContent("Thêm vai trò có id là " + roleId + " cho user có id là" + userId + " thành công");

        } else {
            log.setContent("Thêm vai trò có id là " + roleId + " cho user có id là" + userId + " thất bại");
        }
        JDBiConnector.insert(log);
        JsonObject object = new JsonObject();
        UserUpdateEndpoint.notifyUserUpdate(Integer.parseInt(userId), "update");
        object.addProperty("isSuccess", isSuccess);
        response.getWriter().println(object);
    }
}
