<%@page import= "java.util.HashSet"%>
<%@page import="java.util.HashMap"%>
<% 
	HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
	if(UserDetails != null){
		HashSet allUserDetails = (HashSet)session.getAttribute("allUserDetails");
		String s = (String)session.getAttribute("state");
		String c = (String)session.getAttribute("city");
		String a = (String)session.getAttribute("area");
		StringBuffer sb=new  StringBuffer("");
		if(a.length()!=0){
			sb.append("/"+a);
		}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FindYourFriends</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/talk.css" rel="stylesheet">
	<link rel="icon" href="img/mario.png" type="image/png">
  
  </head>
 
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="profile.jsp">FindYourFriends</a>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div class="navbar-text"><p>Welcome: <%= UserDetails.get("name") %></p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="panel panel-default text center">
			<div class="panel-heading text-center">
				<h3>Search Results for: <%=s%>/<%=c%><%=sb%></h3>
			</div>
		</div>
	</div>
	</br>
	</br>
		<div class="container">
			<section>
			<% 
				java.util.Iterator i = allUserDetails.iterator();
				while(i.hasNext()){
					java.util.HashMap ud = (java.util.HashMap)i.next();
			%>
			<div class="row">
				<div class="col-lg-3">
					<% 
							db.DbConnection db = (db.DbConnection)session.getAttribute("db");
							if(db==null){
								db= new db.DbConnection();
								session.setAttribute("db",db);
							}
							byte[] photo =
								db.getUserPhoto((String)UserDetails.get("email"));
							if(photo.length != 0){
						%>
							<img src = 'GetPhoto.jsp?email=<%=ud.get("email")%>'  width="130" height="150">
							
						<% 
							}else{
						%>
							<img src="img/xyz.jpg" width="130" height="150">
						<%
							}
						%>
				</div>
				<div class="col-lg-7">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey"><%=ud.get("name")%></font></label><br>
							<label for="name" class="control-label">Email:<font color="grey"><%=ud.get("email")%></font></label><br>
							<label for="gender" class="control-label">Gender: <font color="grey"><%=ud.get("gender")%></font></label><br>
							<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=ud.get("dob")%></font></label><br>
							<label for="phone" class="control-label">Phone: <font color="grey"><%=ud.get("phone")%></font></label><br>										
						
						</div>
				</div>				
				<form action="talk.jsp" class="form-horizontal">
					<div class="col-lg-2">
						<div class="form-group">
						</br>
						</br>
							<input type="hidden" name="temail" value="<%=ud.get("email")%>"/>
							<button type="search" class="btn btn-primary">Talk</button>
						</div>
					</div>
				</form>
			</div>
			<hr>
			<% 
				}
			%>
		</div>
		</section>
	</div>
	</br>
	<!--footer-->
	<div class="navbar navbar-inverse navbar-fixed-bottom">
		<div class="container">
			<div class="navbar-text pull-left">
				<h4>Developed by: Mukul Samrat & Mentor: Mr. Rahul Chauhan, Director, INCAPP INFOTECH PVT LTD. </h4>
			</div>
	
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
<% 
}else{
	session.setAttribute("msg","Please Login First !");
	response.sendRedirect("home.jsp");
}
%>