package adminLog;

import Log.Log;
import database.DAOLog;
import database.JDBiConnector;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveLog", value = "/admin/RemoveLog")
public class RemoveLog extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        Log log = new Log( Log.DANGER,user.getId(),request.getRemoteAddr(),"RemoveLog", "Xóa 500 log cũ nhất",1);
        boolean isSuccess = DAOLog.remove500Log();
        if(isSuccess){
            log.setContent(log.getContent()+" thành công");
        }else{
            log.setContent(log.getContent()+" thất bại");
        }
        JDBiConnector.insert(log);
        response.sendRedirect(getServletContext().getContextPath()+"/admin/LogList");
    }
}
