package controller;

import java.io.IOException;
import java.util.Date;


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
import services.Validation;


/**
 * Servlet implementation class Register
 */
@WebServlet("/anime-main/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();

		String email = request.getParameter("email");
		String userName = request.getParameter("userName");
		String fullName = request.getParameter("fullName");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean verify = model.VerifyRecaptcha.verify(gRecaptchaResponse);
		String validateCode = (String) session.getAttribute("validateCode");
		Date dateSendmail = (Date) session.getAttribute("dateSendmail");
		String emailCode =request.getParameter("emailCode");
		String ipClient = request.getRemoteAddr();
		Log log = new Log(Log.INFO, -1, ipClient, "RegisterServlet", null, 1);
		Account account;
		String errorMess = "";
		boolean isValidPassword;
		Date now;
		boolean isExpire;
		long timeDiff;
		Validation validation;

		try {
			if (verify) {
				if ( userName.trim().length() < 8) {
					errorMess = "Tên tài khoản không được để trống hoặc ít hơn 8 ký tự";
					log.setLevel(Log.ALERT);
					log.setContent("Tên tài khoản không hợp lệ");


				}
				if (password.trim().length() < 8 || password.trim().length() > 25) {
					errorMess = "Mật khẩu phải từ 8 đến 25 ký tự";
					log.setLevel(Log.ALERT);
					log.setContent("Mật khẩu không hợp lệ");



				}
				validation = new Validation();

				isValidPassword=validation.validatePassword(password);
				if(!isValidPassword) {
					errorMess = "Mật khẩu phải bao gồm chữ hoa, chữ thường, ký tự đặc biệt, chữ số";
					log.setLevel(Log.ALERT);
					log.setContent("Tên tài khoản không hợp lệ");



				}else {
					now = new Date();
					timeDiff =(now.getTime() - dateSendmail.getTime()) / (60 * 1000);
					isExpire = timeDiff<5;
					if(!isExpire) {
						errorMess = "Mã xác thực đã hết hạn";
						log.setLevel(Log.ALERT);
						log.setContent("Mã xác thực hết hạn");



					}else {
						if(!emailCode.equalsIgnoreCase(validateCode)) {
							errorMess = "Mã xác thực không hợp lệ";
							log.setLevel(Log.WARNING);
							log.setContent("Mã xác thực không hợp lệ");


						}else {
							account = DAOAccounts.findUserByUserNameandEmail(userName, email);
							if (account != null) {
								if (account.getEmail().equalsIgnoreCase(email)) {
									errorMess = "Email đã được đăng kí cho tài khoản khác";
									log.setLevel(Log.ALERT);
									log.setContent("Email đã tồn tại");



								} else {
									errorMess = "Tên tài khoản đã tồn tại";
									log.setLevel(Log.ALERT);
									log.setContent("Tài khoản đã tồn tại");



								}
							} else {
								int idUser =DAOAccounts.addBaseUser(userName, password, email,fullName,phoneNumber);
								//dang ky thanh cong
								log.setLevel(Log.INFO);
								log.setContent("Đăng kí thành công");
								log.setUserId(idUser);
								JDBiConnector.insert(log);
								response.sendRedirect(getServletContext().getContextPath()+"/anime-main/Index");
								return;
							}
						}
					}
				}

			} else {
				errorMess = "Vui lòng xác nhận captcha";


			}
			request.setAttribute("errorSignup", errorMess);
			JDBiConnector.insert(log);
			request.getRequestDispatcher("/anime-main"+"/signup.jsp").forward(request, response);


		} catch (Exception e) {
			log.setLevel(Log.DANGER);
			log.setContent("Hệ thống lỗi đăng ký");
			JDBiConnector.insert(log);
		}
	}

}