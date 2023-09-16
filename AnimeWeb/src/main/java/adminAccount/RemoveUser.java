package adminAccount;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Log.Log;
import database.DAOAccounts;
import database.JDBiConnector;
import model.Account;
import org.jdbi.v3.core.Jdbi;
import socket.UserUpdateEndpoint;

@WebServlet("/admin/RemoveUser")
public class RemoveUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public RemoveUser() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		String ip = request.getRemoteAddr();
		Log log= new Log(Log.DANGER,user.getId(),ip,"RemoveUser","",1);
		int idUser = Integer.parseInt(request.getParameter("idUser"));
		boolean check = DAOAccounts.removeUserbyId(idUser);

		if(check) {
			log.setContent("xóa user có id = "+idUser +"thành công");

		}else{
			log.setContent("xóa user có id = "+idUser +"thất bại");
		}
		JDBiConnector.insert(log);
		UserUpdateEndpoint.notifyUserUpdate(idUser,"logOut");
		response.sendRedirect(getServletContext().getContextPath()+"/admin/UserList");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
