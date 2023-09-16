package controller;

import Log.Log;
import database.DAOAccounts;
import model.Account;
import model.Encode;
import services.Validation;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

@WebServlet(name = "updatePassword", value = "/anime-main/updatePassword")
public class updatePassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String re_password = request.getParameter("re_password");
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        String error;
        boolean success = true;
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = model.VerifyRecaptcha.verify(gRecaptchaResponse);
        boolean isValidPassword;
        if (verify) {
            Validation validation = new Validation();
            String direct = "/anime-main/login.jsp";
            isValidPassword = validation.validatePassword(password);
            if (isValidPassword) {
                if (password.trim().length() < 8 || password.trim().length() > 25) {
                    error = "Mật khẩu phải từ 8 đến 25 ký tự";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);
                    return;
                }
                if (password.equalsIgnoreCase(re_password)) {
                    String pass = new Encode().toSHA1(password);
                    DAOAccounts.updatePassword(email, pass);
                    DAOAccounts.deleteResetToken(email);
                    request.setAttribute("success", success);
                    request.setAttribute("password", pass);
                    request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);


                } else {
                    error = "Mật khẩu nhập lại không chính xác";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);
                    return;
                }
            } else {
                error = "Mật khẩu phải bao gồm chữ hoa, chữ thường, ký tự đặc biệt, chữ số";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);
                return;
            }

        } else {
            error = "Vui lòng xác nhận captcha";
            request.setAttribute("error", error);
            request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);
            return;
        }


    }
}
