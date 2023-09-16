package adminAccount;

import database.DAOAccounts;
import model.Account;
import model.AccountType;
import services.ImageUpload;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024, // Giới hạn tối thiểu là 1MB
		maxFileSize = 1024 * 1024 * 5, // Giới hạn kích thước mỗi file là 10MB
		maxRequestSize = 1024 * 1024 * 50 // Giới hạn kích thước request là 50MB
)
@WebServlet("/admin/UserAdd")
public class UserAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public UserAdd() {
        super();
     
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

				Account user = (Account) request.getSession().getAttribute("user");
				String error="";
				Part avatar = request.getPart("avatar");
				String fullName = request.getParameter("fullName");
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String userName =  request.getParameter("userName");
				String password = request.getParameter("password");
				Account account = DAOAccounts.findUserByUserNameandEmail(userName,email);
				if(account!=null){
					error="tên tài khoản hoặc email đã tồn tại";
				}else{
					String realPath =request.getServletContext().getRealPath("/");
					ImageUpload imgUpload = new ImageUpload();
					Date date = new Date();
					String addExtension = String.valueOf(date.getTime());
					boolean checkFileAvatar = avatar.getSize()>0 && ImageIO.read(avatar.getInputStream())!=null;
					int idUser =DAOAccounts.addBaseUser(userName,password,email,fullName,phone);
					String saveRootAvatar = checkFileAvatar?imgUpload.createSaveAvatarUserData(idUser, addExtension, imgUpload.getExtensionFile(avatar.getSubmittedFileName())):imgUpload.findImageUser(idUser, 1);
					if(checkFileAvatar) imgUpload.saveAvatarUser(avatar, idUser, realPath,addExtension);
					DAOAccounts.updateAvatarAccount(idUser,saveRootAvatar);

				}
			request.setAttribute("error",error);
			request.getRequestDispatcher("/admin/User-Add.jsp").forward(request,response);

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/admin/User-Add.jsp").forward(req,resp);
	}
}
