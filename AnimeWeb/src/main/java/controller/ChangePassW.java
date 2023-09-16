package controller;

import Log.Log;
import database.DAOAccounts;
import database.JDBiConnector;
import model.Account;
import model.Encode;
import services.Validation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@WebServlet("/anime-main/ChangePassW")
public class ChangePassW extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        String email = request.getParameter("email");
        String passW = request.getParameter("password");

        String emailCode = request.getParameter("emailCode");

        System.out.println(passW+email+emailCode);


        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = model.VerifyRecaptcha.verify(gRecaptchaResponse);

        String validateCode = (String) session.getAttribute("validateCode");
        Date dateSendmail = (Date) session.getAttribute("dateSendmail");
        String ipClient = request.getRemoteAddr();
        Log log = new Log(Log.INFO, -1, ipClient, "ChangePassW", null, 1);
        Account account = (Account) session.getAttribute("user");
        String errorMess = "";

        boolean isValidPassword;
        Date now;
        boolean isExpire;
        long timeDiff;
        String direct ;
        Validation validation = new Validation();
        JDBiConnector jdbiConnector = new JDBiConnector();
        try {
            if (verify) {

                if (passW.length() < 8 || passW.length() > 25) {
                    errorMess = "Mật khẩu phải từ 8 đến 25 ký tự";
                    log.setLevel(Log.ALERT);
                    log.setContent("Mật khẩu không hợp lệ");
                    direct = "/changepassword.jsp";


                }

                isValidPassword = validation.validatePassword(passW);
                System.out.println("validatepass"+isValidPassword);
                if (!isValidPassword) {
                    errorMess = "Mật khẩu phải bao gồm chữ hoa, chữ thường, ký tự đặc biệt, chữ số";
                    log.setLevel(Log.ALERT);
                    log.setContent("mật khẩu mới không hợp lệ");
                    direct = "/changepassword.jsp";


                } else {
                    now = new Date();
                    timeDiff = (now.getTime() - dateSendmail.getTime()) / (60 * 1000);
                    isExpire = timeDiff < 5;
                    if (!isExpire) {
                        errorMess = "Mã xác thực đã hết hạn";
                        log.setLevel(Log.ALERT);
                        log.setContent("Mã xác thực hết hạn");
                        direct = "/changepassword.jsp";


                    } else {
                        if (!emailCode.equalsIgnoreCase(validateCode)) {
                            errorMess = "Mã xác thực không hợp lệ";
                            log.setLevel(Log.WARNING);
                            log.setContent("Mã xác thực không hợp lệ");
                            direct = "/changepassword.jsp";


                        } else {
                            passW = new Encode().toSHA1(passW);
                            DAOAccounts daoAccounts = new DAOAccounts();
                            daoAccounts.changePassword(email, account.getId(), passW);

                            //dang ky thanh cong
                            log.setLevel(Log.INFO);
                            log.setContent("Đổi mật khẩu thành công");
                            direct = "/Index";


                        }
                    }
                }
            } else {
                errorMess = "Vui lòng xác nhận captcha";
                direct = "/changepassword.jsp";

            }
            request.setAttribute("errorSignup", errorMess);
            jdbiConnector.insert(log);
            request.getRequestDispatcher("/anime-main" + direct).forward(request, response);


        } catch (Exception e) {
            log.setLevel(Log.DANGER);
            log.setContent("Hệ thống lỗi đổi mật khẩu");
            jdbiConnector.insert(log);
            e.printStackTrace();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
