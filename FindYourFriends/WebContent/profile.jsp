<%@page import="java.util.HashMap" %>
<% 
HashMap UserDetails = (HashMap)session.getAttribute("UserDetails");
if(UserDetails !=null){
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FindYourFriends</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/custom.css" rel="stylesheet">
	<link rel="icon" href="img/mario.png" type="image/png">
	<script language="Javascript" src="js/jquery.js"></script>
	<script type="text/JavaScript" src='js/state.js'></script>
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
					<li><div class="navbar-text"><p>Welcome: <%=UserDetails.get("name")%> </p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav>
	</br>
	</br>
			<% 
				String m = (String)session.getAttribute("msg");
				if(m!=null){
			%>
				<div class="panel">
					<div class="panel-body bg-danger text-center">
						<%=m %>
					</div>
				</div>
			<% 
				session.setAttribute("msg",null);
				}
			%>	
		<div class="container">
			<section>
			<div class="row">
				<div class="col-lg-6">
					<div class="col-lg-4">
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
							<img src = 'GetPhoto.jsp?email=<%=UserDetails.get("email")%>'  width="130" height="150">
							
						<% 
							}else{
						%>
							<img src="img/xyz.jpg" width="130" height="150">
						<%
							}
						%>
					</div>
					<div class="col-lg-6">
						<div class="form-group">
							<label for="email" class="control-label">Name: <font color="grey"><%=UserDetails.get("name")%></font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="name" class="control-label">Email:<font color="grey"><%=UserDetails.get("email")%></font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="gender" class="control-label">Gender: <font color="grey"><%=UserDetails.get("gender")%></font></label>
						</div><!--end form group-->
						<div class="form-group">
							<label for="dob" class="control-label">Date of Birth: <font color="grey"><%=UserDetails.get("dob")%></font></label>
						</div>
						</div><!--end form group-->
						<div class="col-lg-10 form-group">
							<label for="state" class="control-label">Address: <font color="grey"><%=UserDetails.get("area")%>, <%=UserDetails.get("city")%>, <%=UserDetails.get("state")%></font></label>
						</div><!--end form group-->
						<div class="form-group">
							<div class="col-lg-10 form-group">
								<a href="editprofile.jsp" class="btn btn-primary">Edit Profile</a>
                                <a href="changepassword.jsp" class="btn btn-primary">Change Password</a>
															
							</div>		
						</div>
					</div>
				<div class="col-lg-6">
					<div class="panel panel-default">
						<div class="panel-heading text-center">
							<h3>Search People</h3>
						</div>
						<div class="panel-body">
							<form action="PeopleSearchPro.jsp" class="form-horizontal">
								<div class="form-group">
									<label for="state" class="col-lg-3 control-label">State:</label>
									<div class="col-lg-9">
										<select name="state" class="form-control" id="listBox" onchange='selct_district(this.value)'>
											
										</select>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="city" class="col-lg-3 control-label">City:</label>
										<div class="col-lg-9">
											<select name="city" class="form-control" id='secondlist'>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="area" class="col-lg-3 control-label">Area:</label>
									<div class="col-lg-9">
										
										<input type="text" name="area" class="form-control" id="area" placeholder="Enter your Area" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-10 col-lg-offset-3">
										<button type="search" class="btn btn-primary" >Search</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
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