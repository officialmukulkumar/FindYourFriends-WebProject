<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>

<% 
	String e = request.getParameter("email");
	db.DbConnection db = (db.DbConnection)session.getAttribute("db");
	
	if(db==null){
		db= new db.DbConnection();
		session.setAttribute("db",db);
	}
	
	String pass = db.getPassByEmail(e);
	
	if(pass!=null){
		try{
		final String SEmail = "samrattechnologies01@gmail.com";
		final String SPass = "S@Tech123";
		final String REmail =e;
		final String Sub ="Login Password | Find Your Friends";
		final String Body="Hii "+e+"<br>Yours Password is: "+pass+"<br><br>If You have not Requested for this Password Report us @ "+SEmail;
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
        //message.setFrom("Samrat Technologies");
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(REmail));
        message.setSubject(Sub);
        message.setContent(Body,"text/html" );
        Transport.send(message);
        session.setAttribute("msg","Your Password have been Sent to Your Email Address !");
        response.sendRedirect("home.jsp");
		}catch(Exception ex){
			session.setAttribute("msg","Connect to Internet !");
	        response.sendRedirect("forgetpassword.jsp");
		}
	}else{
		session.setAttribute("msg","E-mail Id Not Registered !");
        response.sendRedirect("forgetpassword.jsp");
	}
%>