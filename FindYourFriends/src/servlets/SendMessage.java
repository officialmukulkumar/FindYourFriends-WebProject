package servlets;

import java.io.*;
import java.util.HashMap;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.util.HashMap;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import java.util.Properties;

@MultipartConfig
public class SendMessage extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String temail = request.getParameter("temail");
		try {
			HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
			if(UserDetails!=null) {
				String semail = (String)UserDetails.get("email");
				String message = request.getParameter("message");
				Part p = request.getPart("ufile");
				java.io.InputStream in;
				String fname;
				if(p!=null) {
					fname = p.getSubmittedFileName();
					in = p.getInputStream();
				}else {
					in=null;
					fname= null;
				}
				
				db.DbConnection db = (db.DbConnection)session.getAttribute("db");
				
				if(db==null){
					db= new db.DbConnection();
					session.setAttribute("db",db);
				}
				
				String m = db.sendMessage(semail, temail, message, fname, in);
				if(m.equalsIgnoreCase("Done")) {
					try {
					final String SEmail = "samrattechnologies01@gmail.com";
					final String SPass = "S@Tech123";
					final String REmail =temail;
					final String Sub ="Message Received | Find Your Friends";
					final String Body="Hii "+REmail+"<br>You have Received Message from "+semail+"<br><br><b>Login to check the Message </b><br>http://localhost:8585/FindYourFriends/home.jsp";
					//mail sendCode
					Properties props=new Properties();
			        props.put("mail.smtp.host","smtp.gmail.com");
			        props.put("mail.smtp.socketFactory.port","465");
			        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			        props.put("mail.smtp.auth","true");
			        props.put("mail.smtp.port","465");
			        Session ses=Session.getInstance(props,
			        new javax.mail.Authenticator() {
			            protected PasswordAuthentication getPasswordAuthentication(){
			                return new PasswordAuthentication(SEmail,SPass);
			            }
			        }
			        );
			        Message message1=new MimeMessage(ses);
			       	message1.setFrom(new InternetAddress(SEmail,"Samrat Technologies"));
			        message1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(REmail));
			        message1.setSubject(Sub);
			        message1.setContent(Body,"text/html" );
			        Transport.send(message1);
			        session.setAttribute("msg","Message Sent Successfully !");
					}catch(Exception ex) {
						session.setAttribute("msg","Message Sent Successfully  but get Connected to Internet !");
					}
					
					response.sendRedirect("talk.jsp?temail="+temail);
				}else {
					session.setAttribute("msg","Message Sending Failed !");
					response.sendRedirect("talk.jsp?temail="+temail);
				}
				
			}else {
				
				session.setAttribute("msg","Please Login First !");
				response.sendRedirect("home.jsp");	
			}		
		}catch(Exception ex) {
			session.setAttribute("msg",ex.getMessage());
			response.sendRedirect("talk.jsp?temail="+temail);
		}		
	}
}
