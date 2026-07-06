package com.fuhousefinder.configs;

import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

    private static final String EMAIL = readConfig("MAIL_USERNAME", "");
    private static final String PASSWORD = readConfig("MAIL_PASSWORD", "");
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    public void send(String to, String subject, String msg) {
        try {
            sendHtmlMessage(to, subject, msg);
        } catch (MessagingException e) {
            throw new IllegalStateException(
                    "Failed to send email. Set MAIL_USERNAME and MAIL_PASSWORD as environment variables or JVM system properties.",
                    e
            );
        }
    }

    public int generateRandomNumber() {
        Random random = new Random();
        return random.nextInt(900000) + 100000;
    }

    public void sendToVerify(String to, int verificationCode) {
        String htmlContent = "<h1>Verify your account</h1>"
                + "<p>Your verification code is: <strong>" + verificationCode + "</strong></p>"
                + "<p>Please enter this code to verify your account.</p>";

        try {
            sendHtmlMessage(to, "Account verification", htmlContent);
        } catch (MessagingException e) {
            throw new IllegalStateException(
                    "Failed to send verification email. Set MAIL_USERNAME and MAIL_PASSWORD as environment variables or JVM system properties.",
                    e
            );
        }
    }

    private void sendHtmlMessage(String to, String subject, String htmlContent) throws MessagingException {
        ensureConfigured();

        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, PASSWORD);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(EMAIL));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject, "utf-8");
        message.setContent(htmlContent, "text/html; charset=utf-8");
        Transport.send(message);
    }

    private void ensureConfigured() {
        if (EMAIL.isBlank() || PASSWORD.isBlank()) {
            throw new IllegalStateException(
                    "Mail credentials are missing. Set MAIL_USERNAME and MAIL_PASSWORD before sending mail."
            );
        }
    }

    private static String readConfig(String key, String fallback) {
        return EnvConfig.read(key, fallback);
    }
}
