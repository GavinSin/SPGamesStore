<%@page import ="java.sql.*" import = "java.util.*" import = "main.*,servlet.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">

  <title>Online Gameshop</title>
  <meta name="description" content="SP Game Store">
  <meta name="author" content="Gavin & Liangce">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" 
  	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

</head>

<body class="bgimg">
	<!-- Header -->
	<div class="above-paper">
		<!-- Logo -->
		<h1>SP Game Store</h1>
		<!-- Search Container -->
		<div class="search-container">
			<form method="post" action="mainPage.jsp">
			  <input type="text" placeholder="Search.." name="search">
			  <button type="submit"><i class="fa fa-search"></i></button>
			</form>
		</div>
		<div id="userimg" class="userimg"></div>
		<div id="usermenu" class="usermenu">
		<!-- Log In/out Button -->
		<% 	String logout = (String)session.getAttribute("logout");
			UserInfo userinfo = (UserInfo)session.getAttribute("userinfo");
			String user = null;
			String usertype = null;
			String mail ="";
			String mobile="";
			String displayname="";
			String username="";
			if(userinfo!=null){
				user = userinfo.getUser();  //get username from session
			   	usertype = userinfo.getUserType();
				System.out.println(usertype);
				mail = userinfo.getMailAddress();
				mobile=userinfo.getMobileNumber();
				displayname=userinfo.getName();
			}
			
				
			if(user==null||user.equals("")){
				out.print("<button onclick=\"document.getElementById('id01').style.display='block'\" class='login-button' >Login</button>");
			}else{
				
				//user tag, with profile pic and username => hover will pop box, box displays user details, below have 2 <a>s, one for logout one for setting(like bilibili)						
						
				out.print("<button onclick=\"window.location.href='verifyUser?logout=Yes'\" class='login-button' >Logout</button>");
				out.print("<button onclick=\"document.getElementById('id03').style.display='block'\" class='login-button' >Edit Profile</button>");
				if(usertype.equals("admin")){
					//change to <a> then put inside box
					out.print("<button onclick=\"window.location.href='admin.jsp'\" class='login-button' >Admin</button>");
				}else{
					out.print("<button onclick=\"window.location.href='shoppingCart.jsp'\" class='login-button' >Cart</button>");
				}
			}
			
			
			
		%>
		</div>
	</div>
	
	<!-- White paper -->
	<div class="white-paper">
		<!-- Navigation Bar -->
		<div class="nav-bar nav-border nav-light-grey nav-center slideup">
			<!-- Loading all type of game genres and display it in navigation bar -->
		<% 
			ArrayList<Genre> genrelist	= new GenreListDB().existingGenre();
			for(int i=0;i<genrelist.size();i++){
				out.println("<a href='./mainPage.jsp?genre="+genrelist.get(i).getGenreid()+"' class='nav-bar-item nav-button'>"+genrelist.get(i).getGenreName()+" Game</a>");
			}
		
			ArrayList<Game> recent_game_list = new GameListDB().getRecentGame();
		%>
		</div>
		
		<!-- The Down-arrow that used to expand/collapse navigation bar -->
		<i class="fas fa-angle-down" id="expand-nav"></i>	
		
		<!-- Photo Gallery -->
		<div id="slider" class="ui-card-slider">
		<%  
			
			for(int i=0;i<recent_game_list.size();i++){
				out.println("<div class='slide' data-index='"+i+"' style='transition-duration: 300ms; transition-timing-function: ease;'>");
				out.println("<img onerror=\"this.onerror=null;this.src='./images/noimage.jpg';\" src='"+recent_game_list.get(i).getImageLocation()+"'>");
				out.println("</img>");
				out.println("</div>");
			}
			
			
		%>
		</div>
		<script>
			function gotogame(gameid){
				location.href="gameInfo.jsp?gameid="+gameid;
			}
		</script>
		<!-- Description of the famous games in photo gallery -->
		<div id="slider-description">
		<%	
			for(int i=0;i<recent_game_list.size();i++){
				out.println("<div class='slider-content-6' onmouseover=\"this.style.cursor='pointer'\" onclick=\"gotogame('"+recent_game_list.get(i).getGameid()+"')\" data-index='"
				+i+"' style='display: none;'>"+recent_game_list.get(i).getGameTitle()+"</div>");
		} %>
		</div>
		
		<%
				// Listening for search request
				String searchData = request.getParameter("search");
				// Listening for game genre request 
				String genreid = request.getParameter("genre");
						
				if ((searchData != null&&!searchData.equals("")) || (genreid != null&&!genreid.equals(""))){
					ArrayList<Game> search_result = new ArrayList<Game>();
					
					// User can search games through search request or game genre request, but not both together
					if (genreid != null&&!genreid.equals("")){
						
						// Retrive all games with the specific genre
						search_result= new GameListDB().genreGame(genreid);

					} else {
						// Retrieve all games based on search request
						search_result= new GameListDB().searchGame(("%"+searchData+"%"));
				
					}
					// Counter to count the number of result listed
					int counter = 0;
					
					// Print Result in a customized format
					for(;counter<search_result.size();counter++){
						out.println("<div class='game-column'>");
						out.println("	<div class='game-card' style='height:55vh;overflow:hidden;margin-bottom: 10px;'>");
						out.println("		<a href='./gameInfo.jsp?gameid="+search_result.get(counter).getGameid()+"'><h3>"+search_result.get(counter).getGameTitle()+"</h3></a>");
						out.println("		<img src='"+search_result.get(counter).getImageLocation()+"' onerror=\"this.src='./images/noimage.jpg'\" style='width:80%;height: 45%;'>");
						out.println("		<table style='font-size: 13px;text-align:left;'>");
						out.println("			<tr>");
						out.println("				<td>Company: "+search_result.get(counter).getCompany()+"</td>");
						out.println("				<td>Release Date: "+search_result.get(counter).getReleaseDate()+"</td>");
						out.println("			</tr>");
						out.println("			<tr>");
						out.println("				<td>Price: $"+search_result.get(counter).getPrice()+"</td>");
						out.println("				<td>Preowned: "+search_result.get(counter).getPreowned()+"</td>");
						out.println("			</tr>");
						out.println("		</table>");
						out.println("			<p>Description: "+search_result.get(counter).getDescription()+"</p>");
						out.println("	</div>");
						out.println("</div>");
					}
				/*		Hide the photo gallery		*/
					out.println("<script>");
					out.println("	document.getElementById('slider').style.display='none';");
					out.println("	document.getElementById('slider-description').style.display='none';");
					out.println("</script>");
					
					// If no result , inform the user
					if(counter == 0){
						out.println("<p style='display: block;width: auto;font-size: 5vw;text-align: center;'>No result found!</p>");
					}
				}
				
			
		%>
		
		<!-- Hidden Log In Page -->
		<div id="id01" class="modal">  
		  <form method="post" class="modal-content animate" action="verifyUser">
			<div class="imgcontainer">
			  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
			  <img src="https://i2.wp.com/community.apigee.com/themes/apigee/images/anonymous.png?ssl=1" alt="Avatar" class="avatar">
			</div>

			<div class="container" >
			  <p id='id01login-error' style="color:red;"></p>
			  <label for="uname">Username</label>
			  <input type="text" placeholder="Enter Username" name="uname" id="username" required>

			  <label for="psw">Password</label>
			  <input type="password" placeholder="Enter Password" name="psw" id="password" required>
			  <button type="submit" name="logintype" value="login">Login</button>
			  <input type="hidden" name="place" value="id01">
			</div>

			<div class="container">
			  <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
			  <button onclick="document.getElementById('id02').style.display='block';document.getElementById('id01').style.display='none'" class="cancelbtn" >Register</button>
			</div>
		  </form>
		</div>
		
		
		
	<!-- register page -->
		<div id="id02" class="modal">  
		  <form method="post" class="modal-content animate" action="verifyUser" onsubmit="return doublecheck();">
			<div class="imgcontainer">
			  <span onclick="document.getElementById('id02').style.display='none';document.getElementById('id01').style.display='block'" class="close" title="Close Modal">&times;</span>
			  <img src="https://i2.wp.com/community.apigee.com/themes/apigee/images/anonymous.png?ssl=1" alt="Avatar" class="avatar">
			</div>

			<div class="container">
			  <p id='id02login-error' style="color:red;"></p>
			  <label for="uusername">Username</label>
			  <input type="text" pattern="/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/" title="Please enter a proper Email" placeholder="Enter Email as your Username" name="uname" id="uusername" required>

			  <label for="newpassword">Password</label>
			  <input type="password" pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$" title="Your password length should be between 8-16 and must contain at least one number, small alphabet and capital alphabet. No special character." placeholder="Enter Password" name="psw" id="newpassword" required>
	
			  <label for="newrepassword">Re-enter Password</label>
			  <input type="password" placeholder="Enter Password one more time" id="newrepassword" required>
			  
			  
			  <label for="rrmobile">Mobile Number</label>
			  <input type="text" pattern="[0-9]{8}" title="8-digit Mobile Number" placeholder="Enter your Mobile Number" name="mobile" id="rrmoible" required>
			  
			  <label for="rrmail">Mailing Address</label>
			  <input type="text" pattern="{0,80}" title="Please enter your mailing address" placeholder="Enter nter your mailing address" name="mail" id="rrmail" required>
			  
			  <label for="rrdisplayname">Display Name</label>
			  <input type="text" pattern="{5,20}" title="Length between 5 to 20" placeholder="Enter your display name" name="name" id="rrdisplayname" required>
			  
			</div>

			<div class="container">
				<button type="submit" name="logintype" value="register">Register</button>
			</div>
		  </form>
		</div>
		
		
		<!-- edit profile page -->
		<div id="id03" class="modal" class="modal-content animate">  
			<div class="imgcontainer">
				<span onclick="document.getElementById('id03').style.display='none';" style="color: white;font-size: 4vw;margin-right: 25%;" class="close" title="Close Modal">&times;</span>
				<p></br></p>
			</div>
			<div class="container">
				<button type="button" style="width: 40vw;height: 7vh;margin-left: 35%;font-size: 2vw;" onclick="document.getElementById('id03.4').style.display='block';document.getElementById('id03').style.display='none'" class="cancelbtn">Edit User Info</button>
				<button type="button" style="width: 40vw;height: 7vh;margin-left: 35%;font-size: 2vw;" onclick="document.getElementById('id03.1').style.display='block';document.getElementById('id03').style.display='none'" class="cancelbtn">Edit Username</button>
				<button type="button" style="width: 40vw;height: 7vh;margin-left: 35%;font-size: 2vw;" onclick="document.getElementById('id03.2').style.display='block';document.getElementById('id03').style.display='none'" class="cancelbtn">Change Password</button>
				<button type="button" style="width: 40vw;height: 7vh;margin-left: 35%;font-size: 2vw;" onclick="document.getElementById('id03.3').style.display='block';document.getElementById('id03').style.display='none'" class="cancelbtn">Delete Me</button>
			</div>
		</div>
		<div id="id03.1" class="modal"> 
			 <!-- Edit Username -->
			<form method="post" action='updateUser' class="modal-content animate" style='text-align:center;' >
				<div class="imgcontainer">
				  <span onclick="document.getElementById('id03').style.display='block';document.getElementById('id03.1').style.display='none';"
				  class="close" title="Close Modal">&times;</span>
				 <p></br></p>
				</div>
				<div class="container">
					<p id='id03.1login-error' style="color:red;"></p>
					<label class='col-md-4 control-label' for='inputusername'>New Username</label>
					<input id='inputusername' value='<%=user %>' size='40' maxlength='50' pattern="/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/" title="Please enter a proper Email" name='inputusername' type='text' placeholder='Enter your new username' class='form-control input-md' required>
				
					<label class='col-md-4 control-label' for='checkpassword1'>Enter Password</label>
					<input size='40' maxlength='16' name='password' type='password' placeholder='Enter your password' class='form-control input-md' required>
					
				</div>
				<div class="container">
					<input type="hidden" name="place" value="id03.1">
					<button type="submit" style="margin-left: 0%" name="submit" value="Edit Username">Edit Username</button>
				</div>
				
			</form>
		</div>
		
		
		<!--Change password-->
		<div id="id03.2" class="modal"> 
			<form method="post" action='updateUser' class="modal-content animate" style='text-align:center;' onsubmit="return doublecheck('2');"> 
				<div class="imgcontainer">
				  <span onclick="document.getElementById('id03').style.display='block';document.getElementById('id03.2').style.display='none';" class="close" title="Close Modal">&times;</span>
				 <p></br></p>
				</div>
				
				 <div class="container">
				 	<p id='id03.2login-error' style="color:red;"></p>
					<label class='col-md-4 control-label' for='newpassword2'>New Password</label> 
					 <input size='40' maxlength='45' pattern="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}$" title="Your password length should be between 8-16 and must contain at least one number, small alphabet and capital alphabet. No special character." id='newpassword2' name='inputpassword' type='password' placeholder='Enter new password' class='form-control input-md' required> 
				
					 <label class='col-md-4 control-label' for='confirmpassword2'>Re-enter new Password</label> 
					 <input size='40' maxlength='45' id='confirmpassword2' type='password' placeholder='Confirm password' class='form-control input-md' required> 
				
					 <label class='col-md-4 control-label' for='checkpassword2'>Enter Password</label> 
					 <input size='40' maxlength='45' name='password' type='password' placeholder='Enter old password' class='form-control input-md' required> 
				
				</div> 
				<div class="container">
					<input type="hidden" name="place" value="id03.2"> 
				 	<button type="submit" style="margin-left: 0%" name="submit" value="Change Password">Change Password</button>
				</div>
				 
			 </form> 
	 	</div>
	
		<!-- Delete Me-->
		<div id="id03.3" class="modal"> 
			
			 <form method="post" action='updateUser' class="modal-content animate" style='text-align:center;'> 
				 <div class="imgcontainer">
				  <span onclick="document.getElementById('id03').style.display='block';document.getElementById('id03.3').style.display='none';" class="close" title="Close Modal">&times;</span>
				 <p></br></p>
				</div>
				 <div class="container">
				 	<p id='id03.3login-error' style="color:red;"></p>
					 <label class='col-md-4 control-label' for='checkpassword3'>Delete this user by confirming password</label> 
					 <input size='40' maxlength='45' name='password' type='password' placeholder='Enter password' class='form-control input-md' required> 
				</div>
				<div class="container">
					 <input type="hidden" name="place" value="id03.3">
					 <button type="submit" style="margin-left: 0%" name="submit" value="Delete Me">Delete Me</button>
				</div>
			 </form> 
		</div>
		
		<!-- edit user profile -->
		<div id="id03.4" class="modal">  
		  <form method="post" class="modal-content animate" action="updateUser" onsubmit="return doublecheck();">
			<div class="imgcontainer">
			  <span onclick="document.getElementById('id03.4').style.display='none';document.getElementById('id03').style.display='block';" class="close" title="Close Modal">&times;</span>
			 <p></br></p>
			</div>

			<div class="container">
			  <p id='id03.4login-error' style="color:red;"></p>
			  <label for="rmobile">Mobile Number</label>
			  <input type="text" pattern="[0-9]{8}" title="8-digit Mobile Number" value="<%=mobile%>" placeholder="Enter your Mobile Number" name="mobile" id="rmoible" required>
			  
			  <label for="rmail">Mailing Address</label>
			  <input type="text" pattern="{0,80}" title="Please enter your mailing address" value="<%=mail%>" placeholder="Enter nter your mailing address" name="mail" id="rmail" required>
			  
			  <label for="rdisplayname">Display Name</label>
			  <input type="text" pattern="{5,20}" title="Length between 5 to 20" value="<%=displayname%>"placeholder="Enter your display name" name="name" id="rdisplayname" required>
				
			  <label class='col-md-4 control-label' for='checkpassword2'>Enter Password</label> 
			  <input size='40' maxlength='45' name='password' type='password' placeholder='Enter old password' class='form-control input-md' required> 
			</div>

			<div class="container">
				<input type="hidden" name="place" value="id03.4">
				<button type="submit" name="submit" value="Edit Profile">Edit Profile</button>
			</div>
		  </form>
				
		 <script> 
		
		 function doublecheck(i){  
			 var elementid = "confirmpassword"+i; 
			 var newpw = "newpassword"+i; 
			 var ev = document.getElementById(elementid).value; 
			 var np = document.getElementById(newpw).value; 
			 if(ev==np){ 
			 	return true;
			 }else{
				 alert('Password entered do not match.');
				 return false;
			}
		} 
		 </script> 
	</div>
	
	<%
		// Display Error Page if Admin Login returns false
		String message = (String)session.getAttribute("msg");
		String place = (String)session.getAttribute("place");
		if(message!=null&&!message.equals("")){
			if (message.equals("code01")){
				out.println("<script>document.getElementById('"+place+"').style.display='block';"+
						"document.getElementById('"+place+"login-error').innerHTML='Authentication failed, please check your inputs.';</script>");
			
			}else if (message.equals("code03")){
				out.println("<script>document.getElementById('id02').style.display='block';"+
					"document.getElementById('register-error').innerHTML='Username already exist.';</script>");
			}else if(place!=null&&!place.equals("")){
				out.println("<script>document.getElementById('"+place+"').style.display='block';"+
						"document.getElementById('"+place+"login-error').innerHTML='"+message+"';</script>");
			}else{
				out.println("<script>alert('"+message+"');</script>");
			}
			session.removeAttribute("msg");
		}
	%>
	
	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous">
	</script>
	<!-- Expand/Collapse Navigation Bar -->
	<script type="text/javascript">
        $("#expand-nav").click(function () {
            if ($(".nav-bar").hasClass("slideup")){
                $(".nav-bar").removeClass("slideup").addClass("slidedown");
                $(".fa-angle-down").addClass("open");
            }
            else{
                $(".nav-bar").removeClass("slidedown").addClass("slideup");
                $(".fa-angle-down").removeClass("open");
            }
        });
    </script>
    <!-- Clickable div  -->
    <script type="text/javascript">
	    $(".game-card").click(function() {
	    	  window.location = $(this).find("a").attr("href"); 
	    	  return false;
	    });
	    
	    $('#usermenu').hide();
	    
	    $("#userimg").hover(function(){
	        $('#usermenu').show();
	    },function(){
	        $('#usermenu').hide();
	    });
	    $("#usermenu").hover(function(){
	        $('#usermenu').show();
	    },function(){
	        $('#usermenu').hide();
	    });
	    $("#usermenu").children().hover(function(){
	    	$(this).css("background-color", "white");
	    },function(){
	    	$(this).css("background-color", "darkgrey");
	    });
    </script>
 
	<!-- Photo Gallery -->
	<script src="./javascript/card-slider-min.js"></script>
	<script src="./javascript/auto-slider-additional.js"></script>
	
	<!-- other javascripts -->
	<script type="text/javascript">
		function doublecheck(){
			var elementid = "newpassword";
			var newpw = "newrepassword";
			var ev = document.getElementById(elementid).value;
			var np = document.getElementById(newpw).value;
			if(ev==np){
				return true;
			}else{
				alert('Password entered do not match.');
				return false;
			}
		}

	<%
		if(logout!=null&&logout.equals("Yes")&&(user==null||user.equals(""))){
			session.removeAttribute("logout");
			out.print("alert('You have successfully logged out.');");
		}
	%>
	
	</script>
</body>
</html>