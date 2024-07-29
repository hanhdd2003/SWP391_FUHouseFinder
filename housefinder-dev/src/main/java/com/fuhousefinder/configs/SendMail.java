package com.fuhousefinder.configs;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

public class SendMail {

    private static final String EMAIL = "fuhousefinder@gmail.com";
    private static final String PASSWORD = "ybhceondiyqplzdr";

    public void send(String to, String sub,
            String msg) {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.stmp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }

        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject(sub,"utf-8");
            message.setContent(msg, "text/html; charset=utf-8");
            Transport.send(message);
        } catch (MessagingException e) {
        }

    }

    public int generateRandomNumber() {
        Random random = new Random();
        return random.nextInt(900000) + 100000;
    }

    public void sendToVerify(String to, int verificationCode) {
        // HTML content của email
        String htmlContent = "<h1>Xác minh tài khoản</h1>"
                + "<p>Mã xác minh của bạn là: <strong>" + verificationCode + "</strong></p>"
                + "<p>Vui lòng nhập mã này để xác minh tài khoản của bạn.</p>";

        // Cấu hình properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo session
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });

        try {
            // Tạo MimeMessage
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Xác minh tài khoản","utf-8");

            // Thiết lập nội dung HTML cho email với mã hóa UTF-8
            message.setContent(htmlContent, "text/html; charset=utf-8");

            // Gửi email
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
            
        }
    }

    public static void main(String[] args) {
        SendMail send = new SendMail();
        send.sendToVerify("hanhngulao66@gmail.com", 13243576);
    }
}
