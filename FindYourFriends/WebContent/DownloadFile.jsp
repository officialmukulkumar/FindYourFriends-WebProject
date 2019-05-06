<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap" %>
<% 
	HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
	if(UserDetails !=null){
		String p = request.getParameter("pid");
		db.DbConnection db = (db.DbConnection)session.getAttribute("db");
		if(db==null){
			db= new db.DbConnection();
			session.setAttribute("db",db);
		}
		int pid = Integer.parseInt(p);
		ArrayList fileData = db.getFile(pid);
		if(fileData !=null){
			response.setContentType("APPLICATION/OCTET-STREAM");   
	        response.setHeader("Content-Disposition","attachment; filename="+fileData.get(0)); 
	        response.getOutputStream().write((byte[])fileData.get(1));	
		}else{
			session.setAttribute("msg","File Doesnot Exists Anymore!");
			response.sendRedirect("profile.jsp");	
		}
	}else{
		session.setAttribute("msg","Please Login First !");
		response.sendRedirect("home.jsp");
	}
%>