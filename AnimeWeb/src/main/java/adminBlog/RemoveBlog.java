package adminBlog;

import Log.Log;
import database.DAOBlog;
import database.JDBiConnector;
import model.Account;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/RemoveBlog")
public class RemoveBlog extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idBlog = Integer.parseInt(request.getParameter("idBlog"));
        boolean check= new DAOBlog().updateStatusBlog(idBlog);
        Account user = (Account) request.getSession().getAttribute("user");
        String ipClient = request.getRemoteAddr();
        Log log = new Log(Log.DANGER, user.getId(), ipClient, "RemoveBlog", null, 1);
        if(check == true){
            log.setContent("user " + user.getId() + " đã xóa blog thành công");
            JDBiConnector.insert(log);
        }else{

            log.setContent("user " + user.getId() + " đã xóa blog thất bại");
            JDBiConnector.insert(log);
        }
        response.sendRedirect(getServletContext().getContextPath()+"/admin/BlogList");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
