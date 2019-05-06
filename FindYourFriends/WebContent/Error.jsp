<%@page import="java.util.HashMap"%>
<%@page  isErrorPage="true" %>
<%
    HashMap UserDetails=(HashMap)session.getAttribute("UserDetails");
    if(UserDetails!=null){ 
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/forgetpassword.css" rel="stylesheet">
	<title>FindYourFriends</title>
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
	</nav><!-- end of navbar-->
		<div class="container">
			<section>
			
				
					<div class="panel panel-default">
						<div class="panel-heading text-center">
							<h3>Exception Aaya Re!!</h3>
						</div>
						<div class="panel-body">
						
                                                    <p><%=exception%></p>
                                                   
						</br>
						</br>
                                                <form action="profile.jsp" >
								
                                                <div class="form-group">
                                                        <div class="col-lg-10 col-lg-offset-5">
                                                                <button type="submit" class="btn btn-primary">Home</button>
                                                        </div>
                                                </div><!--end form group-->
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
				<h4>Developed by: Mukul Samrat & Mentor: Mr.Rahul Chauhan, Director, INCAPP INFOTECH PVT LTD. </h4>
			</div>
	
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-2.2.2.min.js"></script>
    <script src="js/validator.js"></script>
  </body>
</html>
<%
}else{
 %>
<html lang="en">
<head>
<meta charset="utf-8" >
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta name="viewport" content="width=device-width, initial-scale=1" >
<title>FindYourFriends</title>
<link href="css/bootstrap.min.css" rel="stylesheet" />
<link href="css/custom.css" rel="stylesheet" />	
<link href="datetimepicker/css/datetimepicker.min.css" rel="stylesheet"  />
<link rel="icon" href="img/mario.png" type="image/png">
</head>
 
  <body data-spy="scroll" data-target="#my-navbar">
	<nav class="navbar navbar-inverse navbar-fixed-top" id="my-navbar">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a href="home.jsp" class="navbar-brand">FindYourFriends</a>
			</div><!--end header-->
		</div><!--end container-->
	</nav><!--end navbar-->
		<div class="container">
			<section>
			
				
					<div class="panel panel-default">
						<div class="panel-heading text-center">
							<h3>Exception Aaya Re!!</h3>
						</div>
						<div class="panel-body">
                                                    <p><%=exception%></p>
						</br>
						</br>
                                                <form action="home.jsp" >
								
                                                <div class="form-group">
                                                        <div class="col-lg-10 col-lg-offset-5">
                                                                <button type="submit" class="btn btn-primary">Home</button>
                                                        </div>
                                                </div><!--end form group-->
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
				<h4>Developed by: Mukul Samrat & Mentor: Mr.Rahul Chauhan, Director, INCAPP INFOTECH PVT LTD. </h4>
			</div>
	
		</div>
	</div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/jquery-2.2.2.min.js"></script>
    <script src="js/validator.js"></script>
  </body>
</html>
<%
}
%>