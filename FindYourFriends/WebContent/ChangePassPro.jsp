<%@page import = "java.util.HashMap" %>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<% 
	HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
	if(UserDetails !=null){
		String op = request.getParameter("oldpassword");
		String np = request.getParameter("newpassword");
		String cp = request.getParameter("confirmpassword");
		if(np.equals(cp)){
			db.DbConnection db = (db.DbConnection)session.getAttribute("db");
			if(db==null){
				db= new db.DbConnection();
				session.setAttribute("db",db);
			}
			String s = db.changePass(np,(String)UserDetails.get("email"), op);
			if(s.equals("Done")){
				try{
				final String SEmail = "samrattechnologies01@gmail.com";
				final String SPass = "S@Tech123";
				final String REmail =(String)UserDetails.get("email");
				final String Sub ="Password Updated | Find Your Friends";
				final String Body="Hii "+REmail+"<br>You have Sucessfully Changed Your Password.<br><br>If You have not Requested for this Password Report us @ "+SEmail;
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
		        Message message=new MimeMessage(ses);
		       	message.setFrom(new InternetAddress(SEmail,"Samrat Technologies"));
		        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(REmail));
		        message.setSubject(Sub);
		        message.setContent(Body,"text/html" );
		        Transport.send(message);
				session.setAttribute("msg","Password Updated !");
				}catch(Exception ex) {
					session.setAttribute("msg","Password Updated  but get Connected to Internet !");
				}
				response.sendRedirect("profile.jsp");
				
			}else{
				session.setAttribute("msg","Password Updation Failed !");
				response.sendRedirect("changepassword.jsp");
			}		
		}else{
			session.setAttribute("msg","New Password Mismatched !");
			response.sendRedirect("changepassword.jsp");
		}
	}else{
		session.setAttribute("msg","Please Login First !");
		response.sendRedirect("home.jsp");
	}
%>