package adminRole;

import Log.Log;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import socket.UserUpdateEndpoint;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
@WebServlet(name = "RemoveRole", value = "/admin/RemoveRole")
public class RemoveRole extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idRole = request.getParameter("idRole");
        List<String> userAffect = DAORoleAccount.getUserAffectUpdateRole(idRole);
        boolean isSuccess=DAORoleAccount.deleteRole(idRole);
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.DANGER, user.getId(), ipClient, "EditRole", "Xóa vai trò có id = "+idRole, 1);
        if(isSuccess){
            log.setContent(log.getContent()+" thành công");
            UserUpdateEndpoint.notifyUserUpdateRole(userAffect);
        }else{
            log.setContent(log.getContent()+" thất bại");
        }
        JDBiConnector.insert(log);
        response.sendRedirect(getServletContext().getContextPath()+"/admin/RolePage");
    }
}
