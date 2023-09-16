package adminRole;

import Log.Log;
import com.google.gson.JsonObject;
import database.DAOPermission;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import model.Permission;
import model.Role;
import socket.UserUpdateEndpoint;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
@WebServlet(name = "EditRole", value = "/admin/EditRole")
public class EditRole extends HttpServlet {
    private String idRole;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        idRole = req.getParameter("idRole");
        Role role = DAORoleAccount.getRoleById(idRole);
        List<Permission> permissionList = DAOPermission.getUnablePermissionToEdit(idRole);
        req.setAttribute("enablePermission",permissionList);
        req.setAttribute("role",role);
        req.getRequestDispatcher("/admin/EditRole.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        idRole = request.getParameter("idRole");
        String[] idPermissions = request.getParameterValues("idPermission[]");
        if(idPermissions==null){
            idPermissions = new String[0];
        }
        List<String> userAffect = DAORoleAccount.getUserAffectUpdateRole(idRole);
        boolean isSuccess = DAORoleAccount.updateRolePermission(idRole,idPermissions);
        JsonObject object = new JsonObject();
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.WARNING, user.getId(), ipClient, "EditRole", "Chỉnh sửa vai trò có id = "+idRole+" có những quyền hạn "+ Arrays.toString(idPermissions), 1);
        if(isSuccess){
            log.setContent(log.getContent()+" thành công");
            UserUpdateEndpoint.notifyUserUpdateRole(userAffect);
        }else{
            log.setContent(log.getContent()+" thất bại");
        }
        JDBiConnector.insert(log);
        object.addProperty("isSuccess",isSuccess);
        response.getWriter().println(object);
    }
}
