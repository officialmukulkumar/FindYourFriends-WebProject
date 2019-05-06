<%

	String e = request.getParameter("email");
	db.DbConnection db = (db.DbConnection)session.getAttribute("db");
	if(db==null){
		db= new db.DbConnection();
		session.setAttribute("db",db);
	}
	
	byte[] photo = db.getUserPhoto(e);
	response.getOutputStream().write(photo);

%>