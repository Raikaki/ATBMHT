package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Log.Log;
import com.google.common.collect.HashMultiset;
import com.google.common.collect.Multiset;
import database.DAOAccounts;
import database.JDBiConnector;
import model.Account;
import model.Encode;
import model.VerifyRecaptcha;
@WebServlet("/anime-main/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Encode encrypt = new Encode();
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("loginName");
		String password = request.getParameter("loginPassword");
		HttpSession session = request.getSession();
		Account user = null;
		String recaptcha = request.getParameter("g-recaptcha-response");
		boolean verify = VerifyRecaptcha.verify(recaptcha);
		String error="";
		String encryptPassword;
		Encode encode = new Encode();
		String direct = "/anime-main/login.jsp";
		Multiset<Integer> errorSet = (Multiset<Integer>) session.getAttribute("errorSet");
		if(errorSet==null) errorSet=HashMultiset.create();
		String ip =request.getRemoteAddr();
		Log log = new Log(Log.INFO,-1,ip,"login","",1);

		if(verify){
			encryptPassword = encode.toSHA1(password);
			user = DAOAccounts.Login(userName,encryptPassword);
			if(user!=null){
				if(user.getIsActive()==1){
					session.setAttribute("user",user);
					session.removeAttribute("");
					direct="/anime-main/Index";
					errorSet.remove(user.getId(),errorSet.count(user.getId()));
					session.setAttribute("errorSet",errorSet);
					log.setUserId(user.getId());
					log.setContent("Đăng nhập thành công");
					JDBiConnector.insert(log);
					response.sendRedirect(getServletContext().getContextPath()+direct);
					return;
				}else{
					log.setUserId(user.getId());
					log.setContent("đăng nhập với tài khoản đã bị khóa");
					error=("login.lockedAccount");
				}
			}else{
				int idUser = DAOAccounts.findIdByUserName(userName);
				if(idUser!=-1){
					errorSet.add(idUser);
					log.setUserId(idUser);
					int errorCount = errorSet.count(idUser);
					if(errorCount==5){
						DAOAccounts.blockAccount(idUser);

						log.setContent("Khóa tài khoản vì nhập sai quá nhiều");
						log.setLevel(Log.WARNING);
						error = ("Tài khoản của bạn đã bị khóa do nhập sai quá nhiều lần, vui lòng liên hệ quản trị viên để mở khóa");
					}else{
						log.setContent("Nhập sai mật khẩu");
						log.setLevel(Log.INFO);
						error =("Tài khoản đã nhập sai mật khẩu " + errorCount +" lần , đủ 5 lần sẽ bị khóa");
					}
				}else{
					error=("Tài khoản không tồn tại");
				}

			}
		}else{
			log.setContent("Lỗi captcha");
			log.setLevel(Log.INFO);
			error=("Lỗi captcha");
		}
		JDBiConnector.insert(log);
		request.setAttribute("errorLogin",error);
		session.setAttribute("errorSet",errorSet);
		request.setAttribute("usName",userName);
		request.getRequestDispatcher(direct).forward(request,response);

	}

}