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
		
		String state = request.getParameter("state");
		//String userState = (String)UserDetails.get("state");
		
		if(!state.equalsIgnoreCase("SELECT STATE")){
		
		String e = (String)UserDetails.get("email");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String gender = request.getParameter("gender");
		
		String d = request.getParameter("dob");
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
		java.util.Date dt = sdf.parse(d);
		java.sql.Date dob = new java.sql.Date(dt.getTime());
		
		String city = request.getParameter("city");
		String area = request.getParameter("area");
		
		db.DbConnection db = (db.DbConnection)session.getAttribute("db");
		
		if(db==null){
			db= new db.DbConnection();
			session.setAttribute("db",db);
		}
		
		String s = db.updateProfile(e,name,phone,gender,dob,state,city,area);
		if(s.equalsIgnoreCase("Error")) {
			session.setAttribute("msg","Profile Updation Failed !");
			response.sendRedirect("editprofile.jsp");
		}else if(s.equalsIgnoreCase("Done")) {
			
			UserDetails = db.getUserByEmail(e);
			session.setAttribute("UserDetails",UserDetails);
			
			
			try{
			final String SEmail = "samrattechnologies01@gmail.com";
			final String SPass = "S@Tech123";
			final String REmail =e;
			final String Sub ="Profile Updated | Find Your Friends";
			final String Body="Hii "+e+"<br>Your Profile Have Been Sucessfully Updated.<br><br>If You have not Requested for this Password Report us @ "+SEmail;
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
	        session.setAttribute("msg","Profile Updated Successfully !");
			}catch(Exception ex) {
				session.setAttribute("msg","Profile Updated Successfully but get Connected to Internet !");
			}
			response.sendRedirect("profile.jsp");
		}	
		
		}else{
			session.setAttribute("msg","Choose State!");
			response.sendRedirect("editprofile.jsp");
		}
	}else{
		
		session.setAttribute("msg","Please Login First !");
		response.sendRedirect("home.jsp");
	}
%>