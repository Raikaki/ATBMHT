package adminRole;

import Log.Log;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import model.Role;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "RolePage", value = "/admin/RolePage")
public class RolePage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Role> listRole = DAORoleAccount.getListRole();
        request.setAttribute("listRole",listRole);
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.ALERT, user.getId(), ipClient, "RolePage", "Xem danh sách tất cả quyền hạn", 1);
        JDBiConnector.insert(log);
        request.getRequestDispatcher("/admin/RoleManager.jsp").forward(request,response);
    }

}
