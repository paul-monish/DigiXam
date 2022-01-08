package com.IMAP.required;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.model.NewPasswordModel;

public class SendMail {
	Session session;
	final String fromEmail = "digixamofficial@gmail.com";
	final String password = "wtvmyyfmgmaqcigb";
	public SendMail() {
		Properties p = new Properties();
		p.setProperty("mail.smtp.host", "smtp.gmail.com");
		p.setProperty("mail.smtp.port", "587");
		p.setProperty("mail.smtp.auth", "true");
		p.setProperty("mail.smtp.starttls.enable", "true");
		p.put("gmail.smtp.socketFactory.port", "587");
		p.put("gmail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		session = Session.getInstance(p, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});
	}
	public boolean otpMail(ForgotPasswordModel fpm) throws AddressException, MessagingException, UnsupportedEncodingException
	{
		boolean test = false;
		String toMail = fpm.getEmail();
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
		String otp=fpm.getOtp(); 
		message.setSubject("Password Recovery Code");
		message.setText("We received a request to reset your digiXam login password. Please validate the OTP on digiXam's authentication confirmation page.\r\n"
				+ "Your One Time Password is " + otp);
		Transport.send(message);
		test= true;
		return test;
	}
	public boolean passwordChangedMail(NewPasswordModel npm) throws AddressException, MessagingException, UnsupportedEncodingException
	{
		boolean test = false;
		String toMail = npm.getEmail();
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail, "DigiXam"));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
		String np=npm.getPassword(); 
		message.setSubject("New Password");
		message.setText("Your DigiXam's password has been changed.\r\n"
				+ "Your New Password is " + np);
		Transport.send(message);
		test= true;
		return test;
	}
}