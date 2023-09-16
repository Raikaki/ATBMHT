package adminAccount;

import Log.Log;
import com.google.gson.JsonObject;
import database.DAOPermission;
import database.JDBiConnector;
import model.Account;
import socket.UserUpdateEndpoint;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "SettingUserPermission", value = "/admin/SettingUserPermission")
public class SettingUserPermission extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String roleId = request.getParameter("roleId");
        String[] selectedPermission = request.getParameterValues("perms[]");
        if(selectedPermission==null){
            selectedPermission = new String[0];
        }
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ip = request.getRemoteAddr();
        Log log= new Log(Log.WARNING,user.getId(),ip,"SettingUserPermission","",1);
        boolean isSuccess = DAOPermission.settingUserPermission(userId,roleId,selectedPermission);
        if(isSuccess){
            log.setContent("Chỉnh sửa vai trò của user có id là "+userId +" thành "+ Arrays.toString(selectedPermission) +" thành công");
        }else{
            log.setContent("Chỉnh sửa vai trò của user có id là "+userId +" thành "+ Arrays.toString(selectedPermission) +" thất bại");
        }
        JDBiConnector.insert(log);
        JsonObject object = new JsonObject();
        UserUpdateEndpoint.notifyUserUpdate(Integer.parseInt(userId),"update");
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);
    }
}
