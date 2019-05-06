package servlets;

import java.io.*;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

/**
 * Servlet implementation class Register
 */
@MultipartConfig
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
			try {
				String email = request.getParameter("email");
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				String gender = request.getParameter("gender");
				String d = request.getParameter("dob");
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
				java.util.Date dt = sdf.parse(d);
				java.sql.Date dob = new java.sql.Date(dt.getTime());
				String state = request.getParameter("state");
				String city = request.getParameter("city");
				String area = request.getParameter("area");
				String pass = request.getParameter("password");
				Part p = request.getPart("photo");
				java.io.InputStream in;
				
				if(p!=null) {
					in=p.getInputStream();
				}else {
					in = null;
					
				}
				
				db.DbConnection db = (db.DbConnection)session.getAttribute("db");
				
				if(db==null){
					db= new db.DbConnection();
					session.setAttribute("db",db);
				}
				
				String m = db.insertUser(email, pass, name, phone, gender, dob, state, city, area, in);
				
				if(m.equalsIgnoreCase("Done")) {
					java.util.HashMap UserDetails = new java.util.HashMap();
					UserDetails.put("email",email);
					UserDetails.put("name",name);
					UserDetails.put("phone",phone);
					UserDetails.put("gender",gender);
					UserDetails.put("dob",dob);
					UserDetails.put("state",state);
					UserDetails.put("city",city);
					UserDetails.put("area",area);
					session.setAttribute("UserDetails",UserDetails);
					try {
					final String SEmail = "samrattechnologies01@gmail.com";
					final String SPass = "S@Tech123";
					final String REmail =email;
					final String Sub ="Registered Sucessfully | Find Your Friends";
					final String Body="Hii "+REmail+"<br>You have Sucessfully Registered !";
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
					}catch(Exception ex) {
						session.setAttribute("msg","You Registered Sucessfully but get Connected to Internet !");
					}
			        
			        response.sendRedirect("profile.jsp");
					
				}else if(m.equalsIgnoreCase("Already")) {
					session.setAttribute("msg","Email ID Already Registered");
					response.sendRedirect("home.jsp");
				}else {
					
					session.setAttribute("msg","Registration Failed");
					response.sendRedirect("home.jsp");
				}
				
			}catch(Exception ex) {
				session.setAttribute("msg",ex.getMessage());
				response.sendRedirect("home.jsp");
			}
		
		
		
	}

}
