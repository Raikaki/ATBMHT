package adminAccount;

import Log.Log;
import com.google.gson.JsonObject;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import socket.UserUpdateEndpoint;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveUserRole", value = "/admin/RemoveUserRole")
public class RemoveUserRole extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String roleId = request.getParameter("roleId");
        boolean isSuccess = DAORoleAccount.removeRoleUser(userId,roleId);
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ip = request.getRemoteAddr();
        Log log= new Log(Log.DANGER,user.getId(),ip,"RemoveUserRole","",1);
        if(isSuccess){
            log.setContent("Xóa vai trò có id "+roleId +" cho user có id "+ userId+" thành công");
        }else{
            log.setContent("Xóa vai trò có id "+roleId +" cho user có id "+ userId+" thất bại");

        }
        JDBiConnector.insert(log);
        JsonObject object = new JsonObject();
        object.addProperty("isSuccess",isSuccess);
        UserUpdateEndpoint.notifyUserUpdate(Integer.parseInt(userId),"update");
        response.getWriter().println(object);
    }
}
