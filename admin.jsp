<%@page import ="java.sql.*" import="main.*" import="java.util.ArrayList" %>
<%

UserInfo userinfo = (UserInfo)session.getAttribute("userinfo");
String user = null;  //get username from session
String usertype = null;
if(userinfo!=null){
	user = userinfo.getUser();  
	usertype = userinfo.getUserType();
}

if(user==null){
	out.print("<script>alert('You have already logged out');window.location.href='mainPage.jsp';</script>");
}else if(usertype==null||!usertype.equals("admin")){
	session.setAttribute("msg", "You do not have the permission to enter the admin page.");
	response.sendRedirect("mainPage.jsp");
}else{	
	String option = request.getParameter("op"); //option to decide what to edit
	String message = request.getParameter("msg"); //get any message needed to be displayed
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">

  <title>Online Gameshop</title>
  <meta name="description" content="Online Gameshop">
  <meta name="author" content="Gavin & Liangce">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="styles.css">
</head>
<body class="bgimg">
	<!-- Header -->
	<div class="above-paper">
		<!-- Logo -->
		<h1>Online Gameshop Admin</h1>
		<!-- Go back Button -->
		<button class="login-button" onclick="window.location.href='mainPage.jsp'">Go back</button>
	</div>
	
	
	<!-- White paper -->
	<div class="admincontainer">
	<%
		//OPTION FORMS
		out.print("<table id='adminop'>");
			    out.print("<tr><td><a href='./admin.jsp?op=1' class='adminoptions' id='op1'>Add Game</a></td>");
			    out.print("<td><a href='./admin.jsp?op=2' class='adminoptions' id='op2'>Edit Game</a></td>");
			    out.print("<td><a href='./admin.jsp?op=3' class='adminoptions' id='op3'>Edit Genre</a></td>");
			    out.print("<td><a href='./admin.jsp?op=4' class='adminoptions' id='op4'>Add Admin</a></td></tr></table>");
		
			
		if(option!=null){
			        //--------initialize variables-----------------//
			String id = request.getParameter("id"); //for choosing game id
			
			
			if(option.equals("1")||(option.equals("2")&&id!=null)){
			//----------------------Start of add game--------------------------------------
				String spacing ="&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp";
				
				out.println("<script>");
				out.println("function checked(){ ");
				out.println("var cb = document.getElementsByClassName('genrecheckbox');");
				out.println("for(var i=0;i<cb.length;i++){if(cb[i].checked){return true;}};alert('Please check at least one genre');return false;");
				out.println("};</script>");
				
				//initialize variables
				Boolean edit=false;
				ArrayList<Genre> checkgenre = new ArrayList<Genre>();
				String idgeter="";
				String[] displayvalue = new String[11];//for game display results
				for(int i=0;i<displayvalue.length;i++){ 
					displayvalue[i]="";
				}
				Game edit_game = new Game();
	
				//get number of genre
				if(id!=null&&edit_game.getGameInfo(id)){
			       		checkgenre = edit_game.getGenre();		       		
			       		
			       	//edit format					
			       		
					edit=true;
					displayvalue[0]= edit_game.getGameTitle();
					displayvalue[1]= edit_game.getCompany();
					displayvalue[2]= edit_game.getReleaseDate().substring(5,7); //month
					displayvalue[3]= edit_game.getReleaseDate().substring(8); //day
					displayvalue[4]= edit_game.getReleaseDate().substring(0,4); //year
					displayvalue[5]= edit_game.getPrice().substring(0,String.valueOf(edit_game.getPrice()).length()-3); //Dollar
		 			displayvalue[6]= edit_game.getPrice().substring(String.valueOf(edit_game.getPrice()).length()-2); //cent
		 			displayvalue[7]= edit_game.getImageLocation().substring(9); //image location
					displayvalue[8]= edit_game.getDescription();
					displayvalue[9]= edit_game.getPreowned();
					displayvalue[10]= String.valueOf(edit_game.getStock());
			       		
			}
		
		//for editing the game
			       		
		if(edit||option.equals("1")){
		
			out.println("<form method='post' action='./adminsubmit' class='form-inline' id='form' onsubmit='return checked();'>");
			
			out.println("<fieldset>");
			
			//game title
			out.println("<div class='form-group'>");
			out.println("<label class='col-md-4 control-label' for='inputgametitle'>Game Title</label>");
			out.println("<input id='inputgametitle'  value='"+ displayvalue[0] +"' size='40' maxlength='45' name='inputgametitle' type='text' placeholder='game title' class='form-control input-md' required>");
			
			//company
			out.println("<label class='col-md-4 control-label' for='inputcompany'>"+ spacing +"Company</label>");  
			out.println("<input id='inputcompany'  value='"+ displayvalue[1] +"' size='40' maxlength='45' name='inputcompany' type='text' placeholder='company of the game' class='form-control input-md' required");
			out.println("</div>");
			
			//genre
			// get all genre name and id
			ArrayList<Genre> allgenre = new GenreListDB().existingGenre();     
			        		
		       		out.println("<div class='form-group'>");
			out.println("<label class='col-md-4 control-label' for='checkboxes'>Genre</label>");
			for(int n=0;n<allgenre.size();n++){
				idgeter=String.valueOf(allgenre.get(n).getGenreid());
				for(int i =0;i<checkgenre.size();i++){
					if(checkgenre.get(i).getGenreid()==allgenre.get(n).getGenreid()){
						idgeter=idgeter+"' checked='checked";
					}
				}
				out.println("<label class='checkbox-inline' for='checkboxes-0'>");
				out.print("<input type='checkbox' class='genrecheckbox' name='inputgenre' value='"+ idgeter +"'>"+ allgenre.get(n).getGenreName()+"</label>");
			}
			out.println("</div>");
			
			//month
			out.println("<label class='col-md-4 control-label' for='inputmonth'>Release Month</label>");
			out.println("<select id='inputmonth' name='inputmonth' class='form-control' required>");
			String[][] monthvalues={{"01","Jan"},{"02","Feb"},{"03","Mar"},{"04","Apr"},{"05","May"},{"06","Jun"},{"07","Jul"},{"08","Aug"},{"09","Sep"},{"10","Oct"},{"11","Nov"},{"12","Dec"}};
			//auto select month when editing
			for(int i=0;i<12;i++){ 
				if(monthvalues[i][0].equals(displayvalue[2])){
					out.println("<option value='"+monthvalues[i][0]+"' selected='selected'>"+monthvalues[i][1]+"</option>");
				}else{
					out.println("<option value='"+monthvalues[i][0]+"'>"+monthvalues[i][1]+"</option>");
				}
			}
			out.println("</select>");
			
			//day
			out.println("<label class='col-md-4 control-label' for='inputday'>"+ spacing +"Release Day</label>");
			out.println("<select id='inputday' name='inputday' class='form-control' required>");
			String day;
			for(int i=1;i<=31;i++){
				day=String.valueOf(i);
				if(day.length()<2){
					day="0"+day;
				}
				if(day.equals(displayvalue[3])){
					day= day+"' selected='selected";
				}
				out.println("<option value='"+day+"'>"+i+"</option>");
			}
			out.println("</select>");
			
			//year
			out.println("<label class='col-md-4 control-label' for='inputyear'>"+ spacing +"Release Year</label>");
			out.println("<input id='inputyear' value='"+ displayvalue[4] +"' name='inputyear' maxlength='4' size='4' pattern='[0-9]{4}' title='YYYY' type='text' placeholder='YYYY' class='form-control input-md' required>");
			
			//stock
			out.println("<label class='col-md-4 control-label' for='inputstock'>"+ spacing +"Stock</label>");
			out.println("<input id='inputstock' value='"+ displayvalue[10] +"' name='inputstock' maxlength='6' size='6' pattern='[0-9]{1,6}' type='text' placeholder='stock' class='form-control input-md' required>");
			out.println("</div>");
			
			//price
			out.println("<div class='form-group'>");
			out.println("<label class='col-md-4 control-label' for='inputdollar'>Price</label>");  
			out.println("<input pattern='[0-9]{1,5}' value='"+ displayvalue[5] +"' maxlength='5' title='Please enter the price' id='inputdollar' name='inputdollar' type='text' placeholder='dollar' class='form-control input-md' required>");
			out.println("<label class='col-md-4 control-label' for='inputcent'>.</label>"); 
			out.println("<input pattern='[0-9]{2}'  value='"+ displayvalue[6] +"' maxlength='2' title='eg. 20' size='2' id='inputcent' name='inputcent' type='text' placeholder='cents' class='form-control input-md' required>");
			
			//imagelocation
			out.println("<label class='col-md-4 control-label' for='inputimagelocation'>"+ spacing +"Image Location(From the images folder)</label>");  
			out.println("<input name='inputimagelocation' class='form-control input-md' type='text' size='30' maxlength='50' value='"+ displayvalue[7] +"' placeholder='image name(without directory)'>");
			out.println("</div>");
			
			//description
			out.println("<div class='form-group'>");
			out.println("<label class='col-md-4 control-label' for='inputdescription'>Description</label>");
			out.println("<textarea class='form-control' rows='8' cols='50' maxlength='1000' id='inputdescription' name='inputdescription' placeholder='descriptions' required>");
			out.println(displayvalue[8]+"</textarea>");
			
			//preown
			String preownyes="";
			String preownno="";
			if(displayvalue[9].equals("")||displayvalue[9].equals("Yes")){
				preownyes="checked='checked'";
			}else{
				preownno="checked='checked'";
			}
			out.println("<label class='col-md-4 control-label' for='inputpreown'>"+ spacing +"Preowned</label>");
			out.println("<label class='radio-inline' for='inputpreown-0'>");
			out.println("<input type='radio' name='inputpreown' id='inputpreown-0' value='Yes' "+preownyes+">");
			out.println("Yes");
			out.println("</label> ");
			out.println("<label class='radio-inline' for='inputpreown-1'>");
			out.println("<input type='radio' name='inputpreown' id='inputpreown-1' value='No' "+preownno+">");
			out.println("No");
			out.println("</label>");
			out.println("</div>");
			
			//user
			out.print("<input type='hidden' name='u' value='"+ user +"' >");
			
			if(id!=null){
				out.print("<input type='hidden' name='id' value='"+ id +"'>");
			}
			
			
			//button
			out.println("<div class='form-group'>");
			out.println("<label class='col-md-4 control-label' for='sumbit'></label>");
			if(option.equals("1")){
				out.println("<input type='submit' id='sumbit' name='submit' value='Addgame'>");
			}else if(option.equals("2")){
				out.println("<input type='submit' id='sumbit' name='submit' value='Editgame'>");
			}
			out.println("<input type='button' id='return' name='return' onclick='back();' value='Return'>");
			out.println("</div>");
			
			out.println("</fieldset>");
			out.println("</form>");
			
			out.println("<script>");
			out.println("function back(){"); //go back function
			out.println("location.href='./admin.jsp';}");
			out.println("</script>");
			
			
			//display comments under the game
			if(id!=null){
				out.println("<h3 style='text-align:center;'> Comments in under this game. </h3>");
				out.println("<table class='editdisplay' style='overflow-wrap:break-word;' width='100%'>");
				out.println("<tr>");
				out.println("<th width='20%'>Nickname</th>");
				out.println("<th width='6%'>Rating</th>");
				out.println("<th width='15%'>Datetime</th>");
				out.println("<th>Comment</th>");
				out.println("<th width='7%'>Action</th>");
				out.println("</tr>");
				
				ArrayList<Comment> comment = new CommentDB().get(id);
		       			for(int i=0;i<comment.size();i++){
		       				out.println("<tr>");
		       				out.println("<td>"+comment.get(i).getDisplayname()+"</td>");
		       				out.println("<td>"+comment.get(i).getRating()+"</td>");
		       				out.println("<td>"+comment.get(i).getDate()+"</td>");
		       				out.println("<td class='desc'>"+comment.get(i).getContent()+"</td>");
		       				out.println("<td><button name='commentid' onclick=\"deletecomment('"+comment.get(i).getCommentId()+
		       				"','"+comment.get(i).getUsername()+"')\">Delete</button></td>");
					out.println("</tr>");
		       			}
				out.println("</table>");
				out.println("<script>");
				out.println("function deletecomment(commentid,username){");
				out.println("var ifok=confirm('Are you sure to delete this comment by '+username+'?');");
				out.println("if(ifok==true){");
				out.println("location.href=\"./adminsubmit?id="+id+"&submit=Delete Comment&cid=\"+commentid;}}");
				out.println("</script>");
			}
			       		}else{
			       			out.print("<p id='reminder'>game not found.</p>");
			       		}
			//--------------End of add game---------
			
			}else if(option.equals("2")&&(id==null)){
		
			//--------------Start of viewing game----------------------
		String search = request.getParameter("search");
		String stock = request.getParameter("stock");
		boolean isnumber = false;   // flag to verify is stock have number input
		if(stock!=null&&!stock.equals("")){
			isnumber = true;
			for(int i=0;i<stock.length();i++){ //make sure the input of stock is only number 
				if(!Character.isDigit(stock.charAt(i))){
					isnumber=false;
					break;
				}
			}
		}
		
		if(search==null||search.equals("")){
			search="%";
		}else{
			search="%"+search+"%";
		}
		//search game function
		out.println("<form method='post' style='text-align:center;'><input style='height:45px;font-size:25px' size='30' placeholder='Game Title' type='text' name='search'>");
		out.println("<input style='height:45px;font-size:25px' size='10' type='text' placeholder='Stock' name='stock'>");
		out.println("<input type='hidden' name='op' value='2'><input style='height:45px;font-size:20px;' type='submit' value='Search'></form>");				
		// get all gametitle and id
			        	out.println("<table class='editdisplay' width='100%'>");
			        	out.println("<tr>");
		       			out.println("<th width='20%'>Title</th><th width='18%'>Company</th><th width='12%'>Release</th><th width='34%'>Description</th><th width='6%'>Price</th><th width='5%'>Stock</th><th width='7%'>Action</th>");
		       			out.println("</tr>");
		       			ArrayList<Game> search_result;
		       			ArrayList<Game> search_deleted;
		       			if(isnumber){
		       				search_result = new GameListDB().searchGameStock(search,stock);
		       				search_deleted = new GameListDB().searchDeletedGameStock(search,stock);
		       			}else{
		       				search_result = new GameListDB().searchGame(search);
		       				search_deleted = new GameListDB().searchDeletedGame(search);
		       			}
			       		out.println("<tr><th colspan='7'>Existing games</th></tr>");
			       		for(int i = 0;i<search_result.size();i++){
			       			out.println("<tr>");
			       			out.println("<td><div class='maxheight'>"+search_result.get(i).getGameTitle()+"</div></td>");
			       			out.println("<td><div class='maxheight'>"+search_result.get(i).getCompany()+"</div></td>");
			       			out.println("<td>"+search_result.get(i).getReleaseDate()+"</td>");
			       			out.println("<td class='desc'><div class='maxheight'>"+search_result.get(i).getDescription()+"</div></td>");
			       			out.println("<td>"+search_result.get(i).getPrice()+"</td>");
			       			out.println("<td>"+search_result.get(i).getStock()+"</td>");
			       			out.println("<td><input type='button' onclick='chosen(" +search_result.get(i).getGameid()+");' value='   Edit   '>");
			       			out.println("<input type='button' onclick=\"deleted('"+search_result.get(i).getGameTitle()+"',"+search_result.get(i).getGameid()+");\" value=' Delete '>");
			       			out.println("</td></tr>");
			       		}
			       		
			       		//print deleted result
			       		out.println("<tr><th colspan='7'>Deleted games</th></tr>");
			       		for(int i = 0;i<search_deleted.size();i++){
			       			out.println("<tr>");
			       			out.println("<td><div class='maxheight'>"+search_deleted.get(i).getGameTitle()+"</div></td>");
			       			out.println("<td><div class='maxheight'>"+search_deleted.get(i).getCompany()+"</div></td>");
			       			out.println("<td>"+search_deleted.get(i).getReleaseDate()+"</td>");
			       			out.println("<td class='desc'><div class='maxheight'>"+search_deleted.get(i).getDescription()+"</div></td>");
			       			out.println("<td>"+search_deleted.get(i).getPrice()+"</td>");
			       			out.println("<td>"+search_result.get(i).getStock()+"</td>");
			       			out.println("<td><input type='button' onclick='chosen(" +search_deleted.get(i).getGameid()+");' value='   Edit   '>");
			       			out.println("<input type='button' onclick=\"restore("+search_deleted.get(i).getGameid()+");\" value='Restore'>");
			       			out.println("</td></tr>");
			       		}
			       		
			       		out.println("</table>");
			       		
			       		out.println("<script>");
			       		//select game function to do editing
			       		out.println("function chosen(gameid){"); 
		out.println("location.href=\"./admin.jsp?op=2&id=\"+gameid;}");
			       		
		//delete game function
		out.println("function deleted(gamename,gameid){"); 
		out.println("var ifdelete = confirm('Are you sure to delete this game ' + gamename+'?')");
		out.println("if(ifdelete){");
		out.println("location.href='./adminsubmit?submit=Deletegame&id='+gameid;}}");
		
		//restore game function
		out.println("function restore(gameid){"); 
		out.println("location.href='./adminsubmit?submit=Restoregame&id='+gameid;}");//check if genre still exist
			       		out.println("</script>");
			
			//--------------End of viewing game------------------------
		
			}else if(option.equals("3")){
		if(id!=null){
			//--------------Start of edit genre---------------------
			
			
			//id=0 when it is adding genre
			//Only edit name
			Genre genre = new Genre();
			Boolean genre_exist=genre.getGenreInfo(id);
			
			out.println("<form method='post' action='./adminsubmit' class='form-inline' style='text-align:center;' >");
			out.println("<fieldset>");
			
			//genrename
			out.println("<div class='form-group' >");
			out.println("<label class='col-md-4 control-label' for='inputgenrename' style='font-size:30px;'>Genre Name</label>");
			out.println("<input id='inputgenre' value='"+ genre.getGenreName()+
					"' size='40' maxlength='45' name='inputgenrename' type='text' placeholder='genre title'"+
					" style='font-size:30px; class='form-control input-md' required>");
			
			//user
			out.print("<input type='hidden' name='u' value='"+ user +"'>");
			
			
			if(genre_exist){ //submit option
				out.print("<input type='hidden' name='id' value='"+id+"' required>");
				out.println("<div><input type='submit' id='sumbit' name='submit' value='Editgenre'>");
			}else{
				out.println("<div><input type='submit' id='sumbit' name='submit' value='Addgenre'>");
			}
			out.println("<input type='button' id='return' name='return' onclick='back();' value='Return'>");
			out.println("</div>");
			
			out.println("</fieldset>");
			out.println("</form>");
			
			out.println("<script>");
			out.println("function back(){"); //go back function
			out.println("location.href='./admin.jsp';}");
			out.println("</script>");
			
			out.println("<h3 style='text-align:center;'> Games that are under this genre. </h3>");
			
			
			if(genre_exist){
			
				//Display games under the genre
				out.println("<table class='editdisplay' width='95%' style='margin: 20px 2%;'>");
			        	out.println("<tr>");
			        	out.println("<th width='20%'>Title</th><th width='18%'>Company</th><th width='12%'>Release</th><th width='34%'>Description</th><th width='6%'>Price</th><th width='5%'>Stock</th><th width='7%'>Action</th>");
		       			out.println("</tr>");
		       			ArrayList<Game> genregame = new GameListDB().genreGame(id);
			       		for(int i=0;i<genregame.size();i++){
			       			out.println("<tr>");
			       			out.println("<td><div class='maxheight'>"+genregame.get(i).getGameTitle()+"</div></td>");
			       			out.println("<td><div class='maxheight'>"+genregame.get(i).getCompany()+"</div></td>");
			       			out.println("<td>"+genregame.get(i).getReleaseDate()+"</td>");
			       			out.println("<td class='desc'><div class='maxheight'>"+genregame.get(i).getDescription()+"</div></td>");
			       			out.println("<td>"+genregame.get(i).getPrice()+"</td>");
			       			out.println("<td>"+genregame.get(i).getStock()+"</td>");
			       			out.println("</td></tr>");
			       		}
			       		out.println("</table>");
			}
							
			//--------------End of edit genre-----------------------
		}else{
			//--------------Start of view genre---------------------
			// get all genrename and id
			String ifdisable;
			out.println("<input style='margin: 5px 43%;width:140px;height:50px;font-size:30px;' type='button' onclick=\"chosen('0');\" value='   Add   '>");
		        	out.println("<table class='editdisplay' width='50%' id='genre'>");
		        	
		        	
			       			out.println("<th width='62%'>Genre Name</th><th width='25%'>No. of games</th><th width='13%'>Action</th></tr>");
			       
			       			ArrayList<Genre> genregamenumber = new GenreListDB().genreGameNumber("Yes");
		       		out.println("<tr><th colspan='3'>Existing genres</th></tr>");
		       		for(int i=0;i<genregamenumber.size();i++){
		       			out.println("<tr>");
		       			out.println("<td><div class='maxheight'>"+genregamenumber.get(i).getGenreName()+"</div></td>");
		       			out.println("<td>"+genregamenumber.get(i).getGameNumber()+"</td>");
		       			out.println("<td><input type='button' onclick=\"chosen(" +genregamenumber.get(i).getGenreid()+");\" value='   Edit   '>");
		       			if(genregamenumber.get(i).getGameNumber()>0){
		       				ifdisable="disabled='disabled'";
		       			}else{
		       				ifdisable="";
		       			}
		       			out.println("<input type='button' "+ifdisable+" onclick=\"deleted('"+genregamenumber.get(i).getGenreName()+
		       					"',"+genregamenumber.get(i).getGenreid()+");\"  value=' Delete '>");
		       			out.println("</td></tr>");
		       		}
		       		genregamenumber = new GenreListDB().genreGameNumber("No");
		       		
		       		out.println("<tr><th colspan='3'>Deleted genres</th></tr>");
		       		for(int i=0;i<genregamenumber.size();i++){
		       			out.println("<tr>");
		       			out.println("<td><div class='maxheight'>"+genregamenumber.get(i).getGenreName()+"</div></td>");
		       			out.println("<td>"+genregamenumber.get(i).getGameNumber()+"</td>");
		       			out.println("<td><input type='button' onclick=\"chosen(" +genregamenumber.get(i).getGenreid()+");\" value='   Edit   '>");
		       			out.println("<input type='button'  onclick=\"restore('"
		       				+genregamenumber.get(i).getGenreid()+"');\" value='Restore'>");
		       			out.println("</td></tr>");
		       		}
		       		out.println("</table>");
		       		out.println("<script>");
		       		
		       		//select genre function to do editing
		       		out.println("function chosen(genreid){"); 
			out.println("location.href=\"./admin.jsp?op=3&id=\"+genreid;}");
		       		
			//delete genre function
			out.println("function deleted(genrename,genreid){"); 
			out.println("var ifdelete = confirm('Are you sure to delete this genre ' + genrename+'?')"); 
			out.println("if(ifdelete){");
			out.println("location.href='./adminsubmit?submit=Deletegenre&id='+genreid;}}");
			
			//restore genre function
			out.println("function restore(genreid){"); 
			out.println("location.href='./adminsubmit?submit=Restoregenre&id='+genreid;}");
		       		out.println("</script>");
		
		       		
		       		//--------------End of view genre---------------------
		}
			
			}else if(option.equals("4")){
			//--------------Start of edit admin----------------------
		String alert=request.getParameter("alert");
		
		//Add Admin
		out.println("<form method='post' action='./adminsubmit' class='form-inline' style='text-align:center;' onsubmit=\"return doublecheck('4');\">");
		out.println("<fieldset>");
		out.println("<div class='form-group'>");
		out.println("<label class='col-md-4 control-label' for='newusername'>New Admin Username</label>");
		out.println("<input size='40' maxlength='50' pattern='/^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$/' title='Please enter a proper Email' placeholder='Enter Email as your Username' name='newusername' id='newusername' type='text' placeholder='Enter old password' class='form-control input-md' required>");
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<label class='col-md-4 control-label' for='newpassword4'>Enter Password</label>");
		out.println("<input size='40' maxlength='16' pattern='^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$' title='Your password length should be between 8-16 and must contain at least one number, small alphabet and capital alphabet. No special character.' name='newpassword' id='newpassword4' type='password' placeholder='Enter password' class='form-control input-md' required>");
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<label class='col-md-4 control-label' for='confirmpassword4'>Re-Enter Password</label>");
		out.println("<input size='40' maxlength='16' type='password' id='confirmpassword4' placeholder='Confirm password' class='form-control input-md' required>");
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<label class='col-md-4 control-label' for='mobile'>Mobile number</label>");
		out.println("<input size='40' maxlength='8' type='text' id='mobile' name='mobile' pattern='[0-9]{8}' title='enter your 8-digit phone number' placeholder='Phone number' class='form-control input-md' required>");
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<label for='mail'>Mailing Address</label>");
		out.println("<input type='text' size='80' pattern='{0,80}' title='Please enter your mailing address' placeholder='Enter nter your mailing address' name='mail' id='mail' required>");	 
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<label for='displayname'>Display Name</label>");
		out.println("<input type='text' size='20' pattern='{5,20}' title='Length between 5 to 20' placeholder='Enter your display name' name='name' id='displayname' required>");
		out.println("</div>");
		out.println("<div class='form-group'>");
		out.println("<input type='submit' name='submit' value='Add Admin'>");
		out.println("</div>");
		out.println("</fieldset>");
		out.println("</form>");
		
		//check function
		out.print("<script>");
		
		out.println("function doublecheck(i){"); 
		out.println("var elementid = \"confirmpassword\"+i;");
		out.println("var newpw = \"newpassword\"+i;");
		out.println("var ev = document.getElementById(elementid).value;");
		out.println("var np = document.getElementById(newpw).value;");
		out.println("if(ev==np){");
		out.println("return true;}else{alert('Password entered do not match.');return false;}}");
		out.print("</script>");
		
		if(alert!=null&&alert.equals("pwd")){
			out.print("<script>alert('Wrong password entered');</script>");
		}
			       		
			
			//--------------End of edit admin-----------------------
			}else{
		out.print("<p id='reminder'>Welcome to the admin page.</br>Please do your admin work!</p>");
			}
			
			//------------------style setting to indicate option-----------------------
			out.println("<script>");
			out.println("document.getElementById('op"+option+"').style.color='black';");
			out.println("document.getElementById('op"+option+"').style.backgroundColor='white';");
			out.println("document.getElementById('op"+option+"').style.borderColor='white';");
			out.println("</script>");
			}else{
		if(message!=null){
			out.print("<p id='reminder'>"+message+"</p>");
		}else{
			out.print("<p id='reminder'>Welcome "+user+"!</p>");
		}
			}
		}
	%>
	</div>
</html>