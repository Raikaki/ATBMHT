package controller;

import model.Encode;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

@WebServlet("/anime-main/ValidateChangePassW")
public class ValidateChangePassW extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "*"); // Tắt xác minh chứng chỉ

// Thêm chứng chỉ SSL/TLS vào KeyStore (tuỳ chọn)
// System.setProperty("javax.net.ssl.trustStore", "/path/to/your/keystore");

        HttpSession session = request.getSession();
        Date dateSendmail;
        String validateCode = Encode.generateNumber();

        Session sessionMail = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("20130305@st.hcmuaf.edu.vn", "Linh@27092002");
            }
        });

        MimeMessage message = new MimeMessage(sessionMail);
        try {
            message.setFrom(new InternetAddress("20130305@st.hcmuaf.edu.vn", "Web anime"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Đổi mật khẩu tài khoản", "UTF-8");

            session.setAttribute("validateCode", validateCode);
            String content = "Mã đổi mật khẩu mới của tài khoản của bạn là " + validateCode;
            message.setContent(content, "text/plain; charset=UTF-8");

            dateSendmail = new Date();
            session.setAttribute("dateSendmail", dateSendmail);

            Transport.send(message);
            response.getWriter().print("Đã gửi thư, mã xác thực có hiệu lực trong 5 phút");
        } catch (MessagingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
