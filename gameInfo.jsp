<%@page 
import ="java.util.ArrayList"
import ="java.util.List"
import ="java.text.*"
import ="main.*"
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<style>

</style>
</head>
<body>
<%
	// Listening for gameid
	
	String gameid = request.getParameter("gameid");
	if(gameid == null){
		gameid = (String) request.getAttribute("gameId");
	}
	UserInfo userinfo = (UserInfo)session.getAttribute("userinfo");
	String user =null;
	if(userinfo!=null){
		user = userinfo.getUser();
	}
	
	
	if ( gameid != null ){
		// Retrieve a game based on gameid request
		Game game = new Game();
		if(!game.getGameInfo(gameid)){ //game does not exist
			session.setAttribute("msg","Game does not exist.");
			response.sendRedirect("mainPage.jsp");
		};
		
		// Retrieve comments of a game
		ArrayList<Comment> comment = new CommentDB().get(gameid);
		
		//if the user goes to the review page instead of description
		String ifreview=request.getParameter("review");
		String review="";
		String description="active";
		if(ifreview!=null&&ifreview.equals("new")){
			review="active";
			description="";
		}
%>

<div class="maincontent">
        	<div class="container">
        		<div class="row">
        			<div class="col-lg-12 col-12">
        				<div class="wn__single__product">
        					<div class="row">
        						<div class="col-lg-6 col-12">
        							<% out.println("<img src='"+game.getImageLocation()+"' onerror=\"this.src='./images/noimage.jpg'\" style='    max-width: -webkit-fill-available;'>"); %>
								</div>
        						<div class="col-lg-6 col-12">
        							<div class="product__info__main">
        							<%
        								out.println("<h1>"+game.getGameTitle()+"</h1>");
        							%>
        								<!-- 
        									<h1>Full Game Title</h1> 
        								-->
        								<div class="product-info-stock-sku d-flex flex-column">
        									<%
        										if (game.getPreowned().equals("Yes")){
        											out.println("<p class='genre_row' >Game Type :<span> Preowned </span></p>");
        										} else {
        											out.println("<p class='genre_row' >Game Type :<span> New </span></p>");
        										}out.print("<div class='genre_row' ><p>Game Genre :</p>");
										
        										for(int i=0;i<game.getGenre().size();i++){
													
        											out.println("<button class='genre_tags genre_column'"+
        											" onclick='location.href=\"./mainPage.jsp?genre="+
        											game.getGenre().get(i).getGenreid()+"\"'>" + 
        											game.getGenre().get(i).getGenreName()+
        											" Game</button>");
        										}
        										out.println("</div>");
        									%>
        									<!-- 
        									Output Example : 
        									<p>Game Type :<span> Preowned / New </span></p>
        									<p>Game ID :<span> 1 </span></p>
        									 -->
        								</div>

        								<div class="price-box">
        									<%
        									out.println("<span> $"+ game.getPrice() +" </span>");
        									%>
        									<!--
        									Output Example: 
        									<span>$52.00</span>
        									 -->
        								</div>
        								 
        								<div class="box-tocart d-flex">
        									<span>Quantity</span>
        									<%

        						    	    // Disabled the button if quantity is 0
        						    	    String ifdisable ="";
        									
        									if(game.getStock()==0 || userinfo==null ||userinfo.getUserType().equals("admin")){
        										ifdisable = "disabled='disabled' style='background-color:lightgrey;border-color:lightgrey;'";
        									}
        									
        									%>						
       											<!-- <button class="tocart" type="submit" title="Add to Cart"  style="text-align:center;">Add to Cart</button>-->
       											<form action="ShoppingCartServlet" onsubmit="return checked();" method="post">
       												<input type='hidden' id='username' name="addedEach" value='<%=user%>'>
        											<input id="qty" class="input-text qty" name="addedEach" min="1" max="<%=game.getStock()%>" value="1" title="Quantity" type="number">
       												<input type='hidden' id='gameid' name='addedEach' value='<%=game.getGameid()%>'>
       												<input id='addtocartbtn' type='submit' name='addtoCart' <%=ifdisable%> value='Add To Cart'>
       											</form>
        									</div>

        								</div>
        								<%out.print("<div><p style='color:grey;'>Stock: "+ game.getStock()+"</p></div>");%>
        								<div class="product-addto-links clearfix">
        									<a class="wishlist" onClick="style='background-color:#e59285;border-color: #e59285;background-position: 100% center;'"></a>
        									<a class="compare" onClick="window.location.reload();" ></a>
        									<a class="email" onClick="copytoClipboard()"></a>
        									<input style="display:none;" type="text" id="officialemail" value="admin_gamestore@gmail.com">
        								</div>
        								
        							</div>
        						</div>
        					</div>
        				</div>
        				<button type="button" class="close" aria-label="Close" onclick="location.href='./mainPage.jsp'">
  							<span aria-hidden="true">&times;</span>
						</button>
        				<div class="product__info__detailed">
							<div class="pro_details_nav nav justify-content-start" role="tablist">
	                            <a class="nav-item nav-link <%=description %>" id="nav1" data-toggle="tab" href="#nav-details" role="tab" aria-selected="true">Description</a>
	                            <a class="nav-item nav-link <%=review %>" id="nav2" data-toggle="tab" href="#nav-review" role="tab" aria-selected="false">Reviews</a>
	                        </div>
	                        <div class="tab__container">
	                        	<!-- Start Single Tab Content -->
	                        	<div class="pro__tab_label tab-pane fade <%=description %> show in" id="nav-details" role="tabpanel">
									<div class="description__attribute">
										<%
										out.println("<p> "+ game.getDescription() +" </p>");
										out.println("<ul>");
										out.println("	<li> Game Company : "+ game.getCompany() +" </li>");
										out.println("	<li> Game Release Date : "+ game.getReleaseDate() +" </li>");
										out.println("</ul>");
									
										%>
										<!-- 
										Output Example:
										<p>CrossFire is an online tactical first-person shooter for Microsoft Windows developed by Smilegate Entertainment.
										 CROSSFIRE is one of the most played online FPS games worldwide, with over 8 million concurrent users 
										 and 650 million registered players.</p>
										<ul>
											<li>Game Company : SmileGate</li>
											<li>Game Release Date : 2007-05-03</li>
										</ul>
										-->
									</div>
	                        	</div>
	                        	<!-- End Single Tab Content -->
	                        	<!-- Start Single Tab Content -->
	                        	<div class="pro__tab_label tab-pane fade <%=review %> show in" id="nav-review" role="tabpanel">
									<div class="review__attribute">
										<h1>Customer Reviews</h1>
										<!-- Begin -->
									<%
									for(int i=0; i<comment.size();i++){
											out.print("<div class='review__ratings__type d-flex flex-column'>");
											out.print("	<div class='review-field-rating d-flex flex-row'>");
											out.print("		<span>Rating</span>");
											out.print("			<ul class='rating d-flex flex-row'>");
											
											// Print the stars of the rating
											int loop_5 = 0;
											while (loop_5 < 5){
												if (loop_5 >= comment.get(i).getRating()){
													// If the rating is 3, the last two star will have their color turned 'off'
													out.println("<li class='off'><i class='zmdi zmdi-star'></i></li>");
												} else {
													// By default , the star will have color orange
													out.println("<li class=''><i class='zmdi zmdi-star'></i></li>");
												}
												loop_5++;
											}
											
											out.print("			</ul>");
											out.print("		</div>");
											out.print("		<div class='review-content'>");
											
											// the comment body
											out.print("		<div class='comment_body'>");
											out.print("<p> "+comment.get(i).getContent()+" </p>");
											/*
											Output Example:
											<p> This is really good! Both the game play and graphic is on top notch! 
											However, it will be better if there is a story line, 
											as I would like to feel more involved! </p>
											*/
											out.print("		</div>");
											
											// user info that comment
											out.print("<div class='comment_details'>");
											out.println("	<ul>");
											out.println("	<li><i class='fa fa-clock-o'></i> "+comment.get(i).getDate().substring(10)+" </li>");
											out.println("	<li><i class='fa fa-calendar'></i> "+comment.get(i).getDate().substring(0,10)+" </li>");
											out.println("	<li><i class='fa fa-pencil'></i> <span class='user'> "+comment.get(i).getDisplayname()+" </span> </li>");
											out.println("	</ul>");
											/*
											Output Example:
											<ul>
												<li><i class="fa fa-clock-o"></i> 13:94</li>
												<li><i class="fa fa-calendar"></i> 04/01/2015</li>
												<li><i class="fa fa-pencil"></i> <span class="user">John Smith</span></li>
											</ul>
											*/
											out.print("</div>");
											out.print("</div>");
											out.print("</div>");
											
										}
									
									%>
										<!-- End -->
									</div>
									<div class="review-fieldset">
										<h2>You're reviewing:</h2>
										<%
										out.println("<h3> "+ game.getGameTitle() +" </h3>");
										%>
										<!--
										Output Example: 
										<h3>Full Game Title</h3>
										-->
										<form class="review_form_field" action="commentUpload" method="post" onsubmit="return check()">

										<input id="nickname_field" type="hidden" value="<%out.print(user);%>" name="uname">
											<div class="review_form_rating d-flex">
												<span>Rating</span>
												<!-- Rating Stars Box -->
												  <div class='rating-stars text-center'>
												    <ul id='stars'>
												      <li class='star' title='Poor' data-value='1'>
												        <i class='fa fa-star fa-fw'></i>
												      </li>
												      <li class='star' title='Fair' data-value='2'>
												        <i class='fa fa-star fa-fwr'></i>
												      </li>
												      <li class='star' title='Good' data-value='3'>
												        <i class='fa fa-star fa-fw'></i>
												      </li>
												      <li class='star' title='Excellent' data-value='4'>
												        <i class='fa fa-star fa-fw'></i>
												      </li>
												      <li class='star' title='WOW!!!' data-value='5'>
												        <i class='fa fa-star fa-fw'></i>
												      </li>
												    </ul>
												  </div>
											</div>
											<input type='hidden' id='rate' name='input_rating' value='-1' required>
											<input type='hidden'  name='game_id' value='<%= gameid %>' required>
											<div class="input__box">
												<span>Comment</span>
												<textarea name="input_review" maxlength="1000" required></textarea>
											</div>
										<%
										if(userinfo!=null&&!userinfo.getUserType().equals("admin")){
											ifdisable="";
										}
											%>
										
											<div class="review-form-actions">
												<button type="submit" <%=ifdisable%>>Submit Review</button>
											</div>
										</form>
																				
										<%
										// Listening for form variables
										
										
										
																
										%>
									</div>
	                        	</div>
	                        	<!-- End Single Tab Content -->
	                        </div>
        				</div>
							
        			</div>
        			
        		</div>
        	</div>
        <script>
			function check(){
				<% 
				String checkuser = (String)session.getAttribute("user"); //because the session might expire when the review is entered
				if(user==null||user.equals("")){
					out.print("alert('You have to log in first before writting a review.');return false;");
				}else{
					out.print("var rate = document.getElementById('rate');");
					out.print("if(rate.value==-1){");
					out.print("alert('Please rate this game');return false;");
					out.print("}else{");
					out.print("	return true;");
					out.print("}");
				}
				%>
			}
										
			function checked(){
				<%
					if(user==null||user.equals("")){
					out.println("	alert('You have to log in first before adding to cart.');");
					}else{
					out.println("	confirmation = confirm('Confirm adding to cart');");
					out.println("	if (confirmation){");
					out.println("		return true;");
					out.println("	}");
					}
					out.println("return false");
				%>
			}
		</script>
		<script>
			// Toggle between description and review pages
			$("#nav2").click(function(){
			  $("#nav-details").removeClass("active");
			  $("#nav-review").addClass("active");
			});
			$("#nav1").click(function(){
			  $("#nav-review").removeClass("active");
			  $("#nav-details").addClass("active");
			});
			
			// JQuery that makes rating system works
			$(document).ready(function(){
				  
				  /* 1. Visualizing things on Hover - See next part for action on click */
				  $('#stars li').on('mouseover', function(){
    				var onStar = parseInt($(this).data('value'), 10); // The star currently mouse on
				   
					// Now highlight all the stars that's not after the current hovered star
					$(this).parent().children('li.star').each(function(e){
					  if (e < onStar) {
						$(this).addClass('hover');
					  }
					  else {
						$(this).removeClass('hover');
					  }
					});
					
				  }).on('mouseout', function(){
					$(this).parent().children('li.star').each(function(e){
					  $(this).removeClass('hover');
					});
				  });
				  
				  
				  /* 2. Action to perform on click */
				  $('#stars li').on('click', function(){
					var onStar = parseInt($(this).data('value'), 10); // The star currently selected
					var stars = $(this).parent().children('li.star');
					
					for (i = 0; i < stars.length; i++) {
					  $(stars[i]).removeClass('selected');
					}
					
					for (i = 0; i < onStar; i++) {
					  $(stars[i]).addClass('selected');
					}
					
					var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
					var ratinginput = document.getElementById('rate');
					ratinginput.value=ratingValue;
					  
					console.log(ratingValue);
					  
					});
				  
			});
			
			// Function that copy admin email address to clipboard
			function copytoClipboard() {
				  /* Initialise admin_email and textarea */
				  var admin_email = "admin_gamestore@gmail.com";
				  var temp_textarea = document.getElementById("officialemail");
				  temp_textarea.style.display="block";
				  
				  /* Select the textarea */
				  temp_textarea.select();

				  /* Copy the text inside the variable */
				  document.execCommand("copy");
				  temp_textarea.style.display="none";
				  
				  /* Alert the copied text */
				  alert("Copied admin's email address: " + temp_textarea.value);
				}
		</script>
<%
}else{ //when there is no game id
	response.sendRedirect("mainPage.jsp");
}
%>

</body>
</html>
