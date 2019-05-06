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
	<link rel="icon" href="img/mario.png" type="image/png">
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/forgetpassword.css" rel="stylesheet">
	<link href="datetimepicker/css/datetimepicker.min.css" rel="stylesheet"  />
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
					<li><div class="navbar-text"><p>Welcome: <%=UserDetails.get("name")%></p></div></li>
					<li><a href="profile.jsp">Home</a></li>
					<li><a href="Logout.jsp">Logout</a><li>
				</ul>			
			</div>
		</div>
	</nav><!-- end of navbar-->
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
				<div class="panel panel-default">
					<div class="panel-heading text-center">
						<h3>Edit Profile</h3>
					</div>
					<div class="panel-body">
						<div class="container">
							<div class="row">
							<form action="ChangePhoto"  method='post' enctype="multipart/form-data"  data-toggle="validator" class="form-horizontal">
								<div class="col-lg-2 col-lg-offset-1">
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
								<div class="col-lg-2">
									<div class="form-group">
									</br></br>
										<label for="changephoto" class="control-label">Change Photo:</label><br>
									</div>
								</div>
								<div class="col-lg-3">
									<div class="form-group">
									</br></br>
										<input type="file" name="photo" class="form-control" id="changephoto" required/>	
									</div>
								</div>
								<div class="col-lg-3 " >
								<div class="form-group">
									</br></br>
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>	
								</div>
								</form>
							</div>
						</div>
						<hr>
						<div class="container">
							<form action="UpdateProfile.jsp" method='post' data-toggle="validator" class="form-horizontal">
								<div class="form-group">
									<label for="email" class="col-lg-2 control-label">Email:</label>
									<div class="col-lg-5">
                                                                            <label class="form-control" id="email" ><%=UserDetails.get("email")%></label>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="phone" class="col-lg-2 control-label">Phone:</label>
									<div class="col-lg-5">
										<input type="text" name='phone' value="<%=UserDetails.get("phone")%>" class="form-control" pattern="^[_0-9]{1,}$" maxlength="10" minlength="10" id="phone" placeholder="<%=UserDetails.get("phone")%>"  required/>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="name" class="col-lg-2 control-label">Name:</label>
									<div class="col-lg-5">
										<input type="text" class="form-control" id="name" name="name" value="<%=UserDetails.get("name")%>" pattern="^[_A-Z a-z]{1,}$"  placeholder="<%=UserDetails.get("name")%>" required/>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="gender" class="col-lg-2 control-label">Gender:</label>
									<% 
										String gen = (String)UserDetails.get("gender");
										
									    if(gen.equalsIgnoreCase("male")){
									%>
									<div class="col-lg-5"> 
										<input type="radio" id="gender"name="gender" value="male" checked/>Male
										<input type="radio" id="gender"name="gender" value="female"/>Female
									</div>
									<% 
									    }else{
									%>
									<div class="col-lg-5"> 
										<input type="radio" id="gender"name="gender" value="male" />Male
										<input type="radio" id="gender"name="gender" value="female" checked/>Female
									</div>
									<% 
									    }
									%>
								</div><!--end form group-->
								<div class="form-group">
									<label for="dob" class="col-lg-2 control-label">Date of Birth:</label>
									<div class="col-lg-5">
                                                                            <input type="text" name="dob" class="form-control" id="dob" value='<%=UserDetails.get("dob")%>' placeholder="<%=UserDetails.get("dob")%>"/>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="state" class="col-lg-2 control-label">State:</label>
									<div class="col-lg-5">
										<label class="form-control"><%=UserDetails.get("state")%></label>
										<select class="form-control" name="state" class="form-control" id="listBox" onchange='selct_district(this.value)'>

										</select>
									</div>
											
								</div><!--end form group-->
								<div class="form-group">
									<label for="city" class="col-lg-2 control-label">City:</label>
									<div class="col-lg-5">
										<select name="city" class="form-control" id='secondlist'>
											<option><%=UserDetails.get("city")%></option>
										</select>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<label for="area" class="col-lg-2 control-label">Area:</label>
									<div class="col-lg-5">
										<input type="text" class="form-control" id="area" name="area" value='<%=UserDetails.get("area")%>'   placeholder="<%=UserDetails.get("area")%>"  required/>
									</div>
								</div><!--end form group-->
								<div class="form-group">
									<div class="col-lg-10 col-lg-offset-2">
										<button type="submit" class="btn btn-primary">Update Profile</button>
									</div>
								</div>
							</form>		
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
   	<script type="text/javascript" src="js/jquery-2.2.2.min.js" ></script>
    <script type="text/javascript" src="js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="js/script.js" ></script>
  <script type="text/javascript" src="js/validator.js" ></script>
<script type="text/javaScript" src='js/state.js' ></script>
<script type="text/javascript" src="datetimepicker/js/moment.min.js" ></script>
<script type="text/javascript" src="datetimepicker/js/datetimepicker.min.js" ></script>
	<script type="text/javascript">
    $(function () {
        $('#dob').datetimepicker({
        	format: 'DD/MM/YYYY',
                maxDate: new Date()
        });
    });
	</script>
  </body>
</html>
<% 
}else{
	session.setAttribute("msg","Please Login First !");
	response.sendRedirect("home.jsp");
}
%>