package adminAccount;

import java.io.IOException;
import java.util.List;
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

@WebServlet("/admin/UserList")
public class UserList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserList() {
        super();

    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		String ipClient =request.getRemoteAddr();
		Log log = new Log(Log.INFO, user.getId(), ipClient, "UserList Servlet", "Lấy danh sách các tài khoản", 1);
		List<Account> listAccount = DAOAccounts.getListAccount();
		request.setAttribute("listAccount", listAccount);
		JDBiConnector.insert(log);
		request.getRequestDispatcher("/admin/User-List.jsp").forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
