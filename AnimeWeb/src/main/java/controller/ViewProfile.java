package controller;

import database.DAOAccounts;
import model.Account;
import Log.Log;
import services.ImageUpload;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.servlet.http.Part;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;


@WebServlet("/anime-main/ViewProfile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 50, // Kích thước tối đa cho phép của các phần multipart (ví dụ: 5MB)
        maxRequestSize = 1024 * 1024 * 100) // Kích thước tối đa cho phép của yêu cầu multipart (ví dụ: 10MB)
public class ViewProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");
        Part file = request.getPart("files");
        String fullName = request.getParameter("name");
        String phone = request.getParameter("phone");


        if (user != null) {

            Account ac = DAOAccounts.findAccountById(user.getId());

            String ipClient = request.getRemoteAddr();

            Log log = new Log(Log.ALERT, user.getId(), ipClient, "editaccount", null, 1);
            String realPath = request.getServletContext().getRealPath("/");
            Date date = new Date();
            String addExtension = String.valueOf(date.getTime());
            ImageUpload imgUpload = new ImageUpload();
            boolean checkFileAvatar = file.getSize()>0&&file.getContentType()!=null && file.getContentType().startsWith("image/");
            String saveRootAvatar = checkFileAvatar?imgUpload.createSaveAvatarUserData(user.getId(), addExtension, imgUpload.getExtensionFile(file.getSubmittedFileName())):imgUpload.findImageUser(user.getId(), ac.getType().getId());
            if(checkFileAvatar) imgUpload.saveAvatarUser(file, user.getId(), realPath,addExtension);
            boolean check = DAOAccounts.editUser(fullName, user.getEmail(), phone, saveRootAvatar, user.getId());
            log.setContent("Chỉnh sửa thông tin user có id = " + user.getId() + "thất bại");
            if (check) {
                log.setContent("Chỉnh sửa thông tin user có id = " + user.getId() + "thành công");
                user=DAOAccounts.findAccountById(user.getId());
                session.setAttribute("user",user);
                response.sendRedirect(getServletContext().getContextPath()+"/anime-main/Index");
            } else {
                response.sendRedirect("/anime-main/login.jsp");
            }
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);

    }
}
