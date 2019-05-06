
<%
	String e = request.getParameter("email");
	String p = request.getParameter("password");
	db.DbConnection db = (db.DbConnection)session.getAttribute("db");
	
	if(db==null){
		db= new db.DbConnection();
		session.setAttribute("db",db);
	}

	java.util.HashMap UserDetails=db.checkLogin(e, p);
	if(UserDetails!=null){
		session.setAttribute("UserDetails",UserDetails);
		response.sendRedirect("profile.jsp");
	}else{
		session.setAttribute("msg","Invalid Id or Password");
		response.sendRedirect("home.jsp");
	}
%>