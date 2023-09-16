package controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DAOAccounts;
import model.Account;
import model.Encode;

/**
 * Servlet implementation class ValidateRegister
 */
@WebServlet("/anime-main/ValidateRegister")
public class ValidateRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String email = request.getParameter("email");
		String userName = request.getParameter("userName");
		String error;
		Account account =DAOAccounts.findUserByUserNameandEmail(userName, email);
		if (account != null) {
			if (account.getEmail().equalsIgnoreCase(email)) {
				error = "Email đã được đăng kí cho tài khoản khác";

			} else {
				error = "Tên tài khoản đã tồn tại";

			}
			response.getWriter().print(error);
			return;
		}
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");


		HttpSession session = request.getSession();
		Date dateSendmail;
		String validateCode =Encode.generateNumber();
		Session sessionMail = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("20130305@st.hcmuaf.edu.vn", "Linh@27092002");
			}
		});
		MimeMessage message = new MimeMessage(sessionMail);
		try {

			message.setFrom(new InternetAddress("20130305@st.hcmuaf.edu.vn", "Web phim"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

			message.setSubject("Kích hoạt tài khoản","UTF-8");
			session.setAttribute("regisName",userName);
			session.setAttribute("validateCode", validateCode);
			message.setContent("Mã kích hoạt tài khoản của bạn là "+validateCode, "text/plain; charset=UTF-8");
			dateSendmail = new Date();
			session.setAttribute("dateSendmail", dateSendmail);
			Transport.send(message);
			response.getWriter().print("Đã gửi thư, mã xác thực có hiệu lực trong 5 phút");
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
