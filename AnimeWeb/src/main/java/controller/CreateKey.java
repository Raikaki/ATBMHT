package controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import database.DAOKey;
import model.Account;
import model.Key;
import model.LocalDateTimeAdapter;
import security.DSA;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.Properties;

@WebServlet(name = "CreateKey", value = "/anime-main/CreateKey")
public class CreateKey extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Account user = (Account) request.getSession().getAttribute("user");
        DSA dsa = new DSA();
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        try {
            dsa.generateKey();
            JsonObject object = new JsonObject();
            String publicKey = dsa.publicKeyToBase64();
            String privateKey = dsa.privateKeyToBase64();
            Key createdKey = DAOKey.addKey(user.getId(),user.getUserName(),publicKey);
            if(createdKey!=null){
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                Session sessionMail = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("20130305@st.hcmuaf.edu.vn", "Linh@27092002");
                    }
                });
                MimeMessage message = new MimeMessage(sessionMail);
                message.setFrom(new InternetAddress("20130305@st.hcmuaf.edu.vn", "Web phim"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
                message.setSubject("Cấp privateKey cho chữ ký điện tử", "UTF-8");

                MimeBodyPart messageBodyPart = new MimeBodyPart();
                messageBodyPart.setText("Đây là file private key mới của bạn", "UTF-8");


                Path tempFilePath = Files.createTempFile("tempFile", ".txt");
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(tempFilePath.toFile()))) {
                    writer.write(privateKey);
                }


                MimeBodyPart attachmentPart = new MimeBodyPart();
                DataSource source = new FileDataSource(tempFilePath.toFile());
                attachmentPart.setDataHandler(new DataHandler(source));
                attachmentPart.setFileName("PrivateKey.txt");


                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(messageBodyPart);
                multipart.addBodyPart(attachmentPart);


                message.setContent(multipart);


                Transport.send(message);


                Files.delete(tempFilePath);

                object.addProperty("key",gson.toJson(createdKey));
                response.getWriter().println(object);
            }
        } catch (Exception e){
            e.printStackTrace();
        }

    }
}
