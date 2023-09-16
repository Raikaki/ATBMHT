package adminLog;

import Log.Log;
import database.DAOLog;
import database.JDBiConnector;
import model.Account;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogList", value = "/admin/LogList")
public class LogList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        Log log = new Log( Log.ALERT,user.getId(),request.getRemoteAddr(),"LogList", "Xem danh sách log",1);
        JDBiConnector.insert(log);
        request.setAttribute("logList", DAOLog.logList());
        request.getRequestDispatcher("/admin/Log.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
