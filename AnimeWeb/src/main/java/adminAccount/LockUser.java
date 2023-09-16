package adminAccount;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import Log.Log;
import database.DAOAccounts;
import database.JDBiConnector;
import model.Account;
import security.PermissionValidate;
import socket.UserUpdateEndpoint;

@WebServlet("/admin/LockUser")
public class LockUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public LockUser() {
		super();

	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int idUser = Integer.parseInt(request.getParameter("idUser"));
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		String ip = request.getRemoteAddr();
		Log log= new Log(Log.ALERT,user.getId(),ip,"LockUser","",1);
		boolean check = DAOAccounts.blockAccount(idUser);
		
		Gson gson = new Gson();
		JsonArray array1 = new JsonArray();
		array1.add(gson.toJson(check));
		JsonArray array2 = new JsonArray();
		JsonObject object = new JsonObject();

		if (check) {
			array2.add(gson.toJson(Account.getIsActiveDescription(Account.LOCK)));
			log.setContent("Khóa tài khoản user có id :" + idUser + "thành công");

		}else{
			log.setContent("Khóa tài khoản user có id :" + idUser + "thất bại");
		}
		UserUpdateEndpoint.notifyUserUpdate(idUser,"logOut");//gui thong bao den client
		JDBiConnector.insert(log);
		object.add("isSuccess", array1);
		object.add("newData", array2);
		response.getWriter().print(gson.toJson(object));
		response.getWriter().flush();


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
