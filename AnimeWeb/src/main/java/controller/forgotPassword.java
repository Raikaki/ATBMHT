package controller;

import database.DAOAccounts;
import model.Account;
import model.Encode;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

@WebServlet(name = "forgotPassword", value = "/anime-main/forgotPassword")
public class forgotPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String name = request.getParameter("userName");
        request.removeAttribute("success");
        HttpSession session = request.getSession();
        session.removeAttribute("success");
        Date now;
        boolean isExpire;
        String error;
        long timeDiff;
        String emailCode = request.getParameter("emailCode");
        Account checkAccountExist;
        checkAccountExist = DAOAccounts.findUserByEmail(email);
        String action = request.getParameter("action");
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
        boolean verify = model.VerifyRecaptcha.verify(gRecaptchaResponse);
        if (action == null) {

            if (checkAccountExist != null) {
                String validateCode = Encode.generateNumber();
                DAOAccounts.updateResetToken(email, validateCode);
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Date dateSendmail;
                Session sessionMail = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("20130305@st.hcmuaf.edu.vn", "Linh@27092002");
                    }
                });
                MimeMessage message = new MimeMessage(sessionMail);
                try {

                    message.setFrom(new InternetAddress("20130305@st.hcmuaf.edu.vn", "Web phim"));
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));

                    message.setSubject("Quên mật khẩu", "UTF-8");
                    session.setAttribute("validateCode", validateCode);
                    message.setContent("Mã xác nhận tài khoản của bạn là " + validateCode, "text/plain; charset=UTF-8");
                    dateSendmail = new Date();
                    session.setAttribute("dateSendmail", dateSendmail);
                    Transport.send(message);
                    response.getWriter().print("Đã gửi thư, mã xác thực có hiệu lực trong 5 phút");
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }else{
                error = "Không tồn tại tài khoản";
                response.getWriter().print(error);
                return;
            }

        } else if (action.equalsIgnoreCase("verify")) {
            if (verify) {
                Date dateSendmail = (Date) session.getAttribute("dateSendmail");
                boolean isValid;

                isValid = DAOAccounts.isValidEmailWithToken(email, emailCode);
                now = new Date();
                timeDiff = (now.getTime() - dateSendmail.getTime()) / (60 * 1000);
                isExpire = timeDiff < 5;
                if (!isExpire) {
                    error = "Mã xác thực hết hạn";
                    DAOAccounts.deleteResetToken(email);
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("/anime-main/forgotPassword.jsp").forward(request, response);
                    return;
                }
                if (isValid) {
                    request.setAttribute("name",name);
                    request.setAttribute("email",email);
                    DAOAccounts.deleteResetToken(email);
                    request.getRequestDispatcher("/anime-main/updatePassword.jsp").forward(request, response);
                } else {
                    error = "Mã xác nhận không chính xác";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("/anime-main/forgotPassword.jsp").forward(request, response);
                }

            } else {
                error = "Vui lòng xác nhận captcha";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/anime-main/forgotPassword.jsp").forward(request, response);
                return;
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
