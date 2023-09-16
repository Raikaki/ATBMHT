package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import Log.Log;
import database.DAOAccounts;
import database.JDBiConnector;
import model.Account;
import model.Constants;
import model.UserGoogleDto;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

@WebServlet(urlPatterns = { "/anime-main/login-google" })
public class LoginGoogleHandler extends HttpServlet {



	public static String getToken(String code) throws ClientProtocolException, IOException {
		// call api to get token
		String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
				.bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
						.add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
						.add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code)
						.add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
				.execute().returnContent().asString();

		JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
		String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
		return accessToken;
	}

	public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
		String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
		String response = Request.Get(link).execute().returnContent().asString();

		UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

		return googlePojo;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String code = request.getParameter("code");
		String accessToken = getToken(code);
		UserGoogleDto userGoogle = getUserInfo(accessToken);
		System.out.println(userGoogle);
		String idg = userGoogle.getId();
		String email = userGoogle.getEmail();
		String userName = userGoogle.getName();
		String img = userGoogle.getPicture();
		Account user = null;
		String phone = userGoogle.getPhone();
		String ipClient = request.getRemoteAddr();
		String error="";
		Log log = new Log(Log.INFO, -1, ipClient, "Login Google", null, 1);
		String direct = "/anime-main/Index";
		try {
			System.out.println(idg);
			System.out.println(userGoogle);
			int idUserGoogle;
			idUserGoogle = DAOAccounts.findIdSocialUser(idg,email);
			System.out.println(idUserGoogle);

			if (idUserGoogle == 0) {
				DAOAccounts.addGoogle(idg, email, userName, img, userName, phone);
				int idUser = DAOAccounts.findIdUserAccount(idg, 2);
				user = DAOAccounts.loginAccountSocialId(idUser, 2);
				if(user.getIsActive()==0){
					direct="/anime-main/login";
					error = "Tài khoản của bạn đã bị khóa";
					request.setAttribute("errorLogin",error);
					response.sendRedirect(getServletContext().getContextPath() +direct);

				}else {
					System.out.println(user);
					log.setUserId(user.getId());
					log.setContent("Register and login With Google");
					log.setLevel(Log.ALERT);
					System.out.println(user.getBalance());
					session.setAttribute("user", user);
					JDBiConnector.insert(log);
					direct = "/anime-main/Index";
					response.sendRedirect(getServletContext().getContextPath() + direct);
				}

			} else {
				user = DAOAccounts.loginAccountSocialId(idUserGoogle, 2);
				log.setUserId(user.getId());
				log.setContent("Login with Google Success");
				log.setLevel(Log.INFO);
				session.setAttribute("user", user);
				JDBiConnector.insert(log);
				direct="/anime-main/Index";

				response.sendRedirect(getServletContext().getContextPath() +direct);
			}

		} catch (SQLException e) {
			System.out.println("Loi sql");

			e.printStackTrace();

		}


	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

	@Override
	public String getServletInfo() {
		return "Short description";

	}
}
