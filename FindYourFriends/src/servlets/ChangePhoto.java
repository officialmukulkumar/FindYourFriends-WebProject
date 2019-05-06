package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.util.*;

import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import java.util.Properties;

@MultipartConfig

public class ChangePhoto extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = null;
		try {
			session = request.getSession();
			HashMap UserDetails = (HashMap) session.getAttribute("UserDetails");
			if (UserDetails != null) {
				Part p = request.getPart("photo");
				java.io.InputStream is;
				if (p != null) {
					is = p.getInputStream();
				} else {
					is = null;
				}

				db.DbConnection db = (db.DbConnection) session.getAttribute("db");

				if (db == null) {
					db = new db.DbConnection();
					session.setAttribute("db", db);
				}

				String s = db.changePhoto((String) UserDetails.get("email"), is);
				if (s.equalsIgnoreCase("Error")) {
					session.setAttribute("msg", "Photo Updation Failed !");
					response.sendRedirect("editprofile.jsp");
				} else if (s.equalsIgnoreCase("Done")) {
					try {
					final String SEmail = "samrattechnologies01@gmail.com";
					final String SPass = "S@Tech123";
					final String REmail = (String) UserDetails.get("email");
					final String Sub = "Profile Picture Updated | Find Your Friends";
					final String Body = "Hii " + REmail + "<br>You have Sucessfully Updated Your Profile Picture";
					// mail sendCode
					Properties props = new Properties();
					props.put("mail.smtp.host", "smtp.gmail.com");
					props.put("mail.smtp.socketFactory.port", "465");
					props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", "465");
					Session ses = Session.getInstance(props, new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(SEmail, SPass);
						}
					});
					Message message1 = new MimeMessage(ses);
					message1.setFrom(new InternetAddress(SEmail, "Samrat Technologies"));
					message1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(REmail));
					message1.setSubject(Sub);
					message1.setContent(Body, "text/html");
					Transport.send(message1);

					session.setAttribute("msg", "Photo Updated Successfully !");
					}catch(Exception ex) {
						session.setAttribute("msg","Photo Updated Successfully but get Connected to Internet !");
					}
					response.sendRedirect("profile.jsp");
				}
			} else {
				session.setAttribute("msg", "Please Login First !");
				response.sendRedirect("home.jsp");
			}

		} catch (Exception ex) {
			session.setAttribute("msg", ex.getMessage());
			response.sendRedirect("editprofile.jsp");
		}
	}

}
