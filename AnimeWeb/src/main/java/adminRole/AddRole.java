package adminRole;

import Log.Log;
import database.DAOPermission;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import model.Permission;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "AddRole", value = "/admin/AddRole")
public class AddRole extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Permission> permissionList = DAOPermission.getUnablePermission();
        request.setAttribute("enablePermission",permissionList);
        request.getRequestDispatcher("/admin/AddRole.jsp").forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String nameRole = request.getParameter("nameRole");
            String[] idPermissions = request.getParameterValues("idPermission");
            if(idPermissions==null){
                idPermissions = new String[0];
            }
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        String ipClient =request.getRemoteAddr();
        Log log = new Log(Log.WARNING, user.getId(), ipClient, "AddRole", "Thêm vai trò mới", 1);
        boolean isSuccess = DAORoleAccount.addNewRole(nameRole,idPermissions);
            if(isSuccess){
                log.setContent(log.getContent()+" thành công");
                JDBiConnector.insert(log);
                response.sendRedirect(getServletContext().getContextPath()+"/admin/RolePage");
            }else{
                log.setContent(log.getContent()+" thất bại");
                JDBiConnector.insert(log);
                request.setAttribute("error","Tên vai trò đã tồn tại hoặc quyền không hợp lệ");
                request.getRequestDispatcher("/admin/AddRole.jsp").forward(request,response);
            }
    }
}
