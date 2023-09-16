package controller;


import Log.Log;
import com.restfb.types.User;
import database.DAOAccounts;
import model.Account;
import model.RestFB;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


/**
 * Servlet implementation class loginWithFacebook
 */
@WebServlet("/anime-main/loginWithFacebook")
public class loginWithFacebook extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginWithFacebook() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String name = null, email = null, id = null, picture = null;
        String ipClient = request.getRemoteAddr();
        Log log = new Log(0, -1, ipClient, "loginWithFacebook", null, 1);

        String code = request.getParameter("code");
        System.out.println(code);

        if (code == null || code.isEmpty()) {
            request.getRequestDispatcher("/anime-main/index.jsp").forward(request, response);
        } else {
            String accessToken = RestFB.getToken(code);
            User user = RestFB.getUserInfo(accessToken);
            id = user.getId();
            name = user.getName();
            email = user.getEmail();
            picture = user.getPicture().getUrl();
            Account account = null;

            DAOAccounts dao = new DAOAccounts();
            try {
                int idUser = dao.findIdUserAccount(id, 3);
                System.out.println(idUser);

                if (idUser != 0) {
                    account = dao.loginAccountSocialId(idUser, 3);
                    session.setAttribute("user", account);
                    session.setAttribute("isAdmin", account.isAdmin());
                    log.setUserId(account.getId());
                    log.setContent("Log in FB succes");
                    log.setLevel(log.INFO);
//					new JDBiConnector().insert(log);
                    response.sendRedirect("/anime-main/Index");

                } else {
                    dao.createAccountByFB(id, email, name, picture, name);
                    int idAccount = dao.findIdUserAccount(id, 3);
                    System.out.println(idAccount);

                    account = dao.loginAccountSocialId(idAccount, 3);

                    session.setAttribute("user", account);
                    session.setAttribute("isAdmin", account.isAdmin());
                    log.setContent("create account by FB and Log in succes");
                    log.setLevel(log.ALERT);
//					new JDBiConnector().insert(log);
                    request.getRequestDispatcher("/anime-main/index.jsp").forward(request, response);

                }

            } catch (Exception e) {
                e.printStackTrace();

            }


        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);

    }

}