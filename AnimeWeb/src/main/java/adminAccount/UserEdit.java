package adminAccount;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import Log.Log;
import database.DAOAccounts;
import database.DAORoleAccount;
import database.JDBiConnector;
import model.Account;
import services.ImageUpload;

@MultipartConfig(
		fileSizeThreshold = 1024 * 1024, // Giới hạn tối thiểu là 1MB
		maxFileSize = 1024 * 1024 * 5, // Giới hạn kích thước mỗi file là 10MB
		maxRequestSize = 1024 * 1024 * 50 // Giới hạn kích thước request là 50MB
)
@WebServlet("/admin/UserEdit")
public class UserEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UserEdit() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Account user = (Account) request.getSession().getAttribute("user");
		int idUser = Integer.parseInt(request.getParameter("idUser"));
		Account account = DAOAccounts.findAccountById(idUser);
		String ipClient = request.getRemoteAddr();
		Log log = new Log(Log.INFO, user.getId(), ipClient, "User edit", null, 1);
		JDBiConnector jdBiConnector = new JDBiConnector();
		request.setAttribute("account", account);
		request.setAttribute("listUnableRole", DAORoleAccount.getUnableAddRoles(String.valueOf(account.getId())));
		log.setContent("Truy cập chỉnh sửa thông tin user có id = "+idUser);
		jdBiConnector.insert(log);
		request.getRequestDispatcher("/admin/User-Edit.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		Part file = request.getPart("imageUser");
		String fullName = request.getParameter("fullName");
		String email = request.getParameter("email");
		String phoneNumber = request.getParameter("phoneNumber");
		int idUser = Integer.parseInt(request.getParameter("idUser"));
		int typeId = Integer.parseInt(request.getParameter("typeId"));
		String realPath =request.getServletContext().getRealPath("/");
		ImageUpload imgUpload = new ImageUpload();
		Date date = new Date();
		String addExtension = String.valueOf(date.getTime());
		HttpSession session = request.getSession();
		Account user = (Account) session.getAttribute("user");
		String ip = request.getRemoteAddr();
		Log log= new Log(Log.ALERT,user.getId(),ip,"UserEdit","",1);
		boolean checkFileAvatar = file.getSize()>0&&file.getContentType()!=null && file.getContentType().startsWith("image/");
		String saveRootAvatar = checkFileAvatar?imgUpload.createSaveAvatarUserData(idUser, addExtension, imgUpload.getExtensionFile(file.getSubmittedFileName())):imgUpload.findImageUser(idUser, typeId);
		if(checkFileAvatar) imgUpload.saveAvatarUser(file, idUser, realPath,addExtension);
		boolean check = DAOAccounts.editUser(fullName, email, phoneNumber, saveRootAvatar, idUser);
		log.setContent("Chỉnh sửa thông tin user có id = "+idUser +"thất bại");
		if(check) {
			log.setContent("Chỉnh sửa thông tin user có id = "+idUser +"thành công");
		}
		JDBiConnector.insert(log);
		request.setAttribute("idUser", idUser);
		doGet(request, response);

	}

}
