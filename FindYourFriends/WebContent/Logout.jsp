<%@page import="java.util.HashMap" %>

<%
	HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
	if(UserDetails !=null){
		session.invalidate();
		response.sendRedirect("home.jsp");
	}else{
		
		session.setAttribute("msg","Please Login First !");
		response.sendRedirect("home.jsp");
		
	}

%>