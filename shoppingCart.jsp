<!-- this page includes shoppingCart and transaction history. history will be displayed by date and by clicking each transaction,
the transaction details will be displayed using the format of shopping cart -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
import ="cart.*,java.util.*,main.*,java.sql.*" 
pageEncoding="ISO-8859-1"%>
<% 
//if the user goes to the review page instead of description
String ifreview=request.getParameter("review");
String review="";
String description="active";
UserInfo userinfo = (UserInfo)session.getAttribute("userinfo");

if(userinfo==null){
	session.setAttribute("msg", "Session expired, please log in again.");
	response.sendRedirect("mainPage.jsp");
}else if(userinfo!=null && !userinfo.getUserType().equals("user")){
	session.setAttribute("msg", "You are not user.");
	response.sendRedirect("mainPage.jsp");
}
if(ifreview!=null&&ifreview.equals("new")){
	review="active";
	description="";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<title>Shopping Cart</title>
</head>
<body>
<div class="product__info__detailed cart_list">
	<button type="button" class="closebtn_cart" onclick="window.location='mainPage.jsp';" aria-label="Close Button for Shopping Cart">&times;</button>
	<div class="pro_details_nav nav justify-content-start" role="tablist">
		<a class="nav-item nav-link cart_menu <%=description%>" id="nav1" data-toggle="tab" href="#nav-details" role="tab" aria-selected="true">Shopping Cart</a>
		<a class="nav-item nav-link cart_menu <%=review%>" id="nav2" data-toggle="tab" href="#nav-review" role="tab" aria-selected="false">Purchasing History</a>
	</div>
	<div class="tab__container">
	<!-- Start of Shopping cart form -->
	<div class="pro__tab_label tab-pane fade <%=description%> show in" id="nav-details" role="tabpanel">
<!-- Each item got an individual purchase button and box for quantity and delete button -->
<form action="ShoppingCartServlet" onsubmit="return checked();" method="post">
<div class='cart_container'>
	<h2 style="text-align: center;font-weight: bold;"> Shopping Cart </h2>
	
<%
		    		// Session cart contains items that user added to cart
		    		ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
		    		String btnDisabled = "";
		    		
			    	// Listening for any error message
			    	Integer error = (Integer) session.getAttribute("error");
			    	session.removeAttribute("error");
		    	    if(error != null){
		    	    	String error_info = (String)session.getAttribute("errorinfo");
		    	    	session.removeAttribute("error_info");
		    	    	if (error == 404){
		    	    		out.println("<div class='alert'>");
		    	    		out.println("	<span class='closebtn' onclick=\"this.parentElement.style.display='none';\">&times;</span>");
		    	    		if( error_info != null){
		    	    			out.println("	Error in " + error_info);
		    	    		} else {
		    	    			out.println("	Error occured! ");
		    	    		}
		    	    		out.println("</div>");
		    	    	}
		    	    }
		    	    
		    	 // Listening for any successfull message
		    	    Integer success = (Integer) session.getAttribute("success");
		    		session.removeAttribute("success");
		    	    if(success != null){
		    	    	String success_info = (String)session.getAttribute("successinfo");
		    	    	session.removeAttribute("successinfo");
		    	    	if (success == 100){
		    	    		out.println("<div class='alert' style='background-color:#006400'>");
		    	    		out.println("	<span class='closebtn' onclick=\"this.parentElement.style.display='none';\">&times;</span>");
		    	    		if( success_info != null){
		    	    			out.println("	Successfully " + success_info);
		    	    		} else {
		    	    			out.println("	Successfully Operation! ");
		    	    		}
		    	    		out.println("</div>");
		    	    	}
		    	    }
	    	    
		    		if (cart != null && cart.size() != 0 ){
		    			
		    			// Print the header of the shopping cart
						out.println("<div class='cart_header'>");
						out.println("	<p class='cart_product'>Product</p>");
						out.println("	<p class='cart_price'>Price</p>");
						out.println("	<p class='cart_quantity'>Quantity</p>");
						out.println("	<p class='cart_total'>Total</p>");
						out.println("</div>");
						
		    			ArrayList<Game> gameList = new ArrayList<Game>();
		    			ArrayList<Integer> quantityList = new ArrayList<Integer>();
		    			double totalPrice = 0.0;
		    			int index = 0;
		    			
		    			for (Item eachItem: cart){
		    				Game newGame = new Game();
		    				if(newGame.getGameInfo(eachItem.getGameid())){
		    					gameList.add(newGame);
		    					quantityList.add(eachItem.getQuantity());
		    				}
		    			} // End of for loop
		    			
		    			for (Game eachGame: gameList){
				    	    index++;
			    	    	out.println("<div class='item_container'>");
			    	    	
			    	    	// Item Image
				    	    out.println("<div class='item_image'>");
				    	    
				    	    //out.println("<label class='col-md-4 control-label' for='checkboxes'>Genre</label>");
				    	    out.println("		<label class='checkbox-inline' for='checkboxes-0'>");
				    	    out.print("				<input type='checkbox' id='checkboxes-0' class='item_checkbox' name='gameId' value='"+ eachGame.getGameid() +"'>"+"</label>");
				    	    out.println("	<img alt='item_image' src='" + eachGame.getImageLocation() + "' onerror=\"this.src='./images/noimage.jpg'\" style='max-width: 200px; max-height: 150px; width: 80%;display:inline-block;'>");
							out.println("</div>");
							
				    	    // Item Information in pleasing way
				    	    out.println("<div class='item_info'>");
				    	    out.println("	<p class='item_name'>");
				    	    out.println("		<a href='gameInfo.jsp?gameid=" + eachGame.getGameid() + "'>" + eachGame.getGameTitle() + "</a>");
				    	    out.println("	</p>");
				    	    out.println("	<p class='item_name'>");
				    	    out.println("	</p>");
				    	    out.println("	<div class='item_details'>");
				    	    out.println("		<p class='game_type'>");
				    	    out.println("			<b>Preowned: </b>" + eachGame.getPreowned() );
				    	    out.println("		</p>");
				    	    out.println("		<p class='game_genre'>");
				    	    out.print("			<b>Game Genre: </b>");
				    	    
				    	    for(int i =0; i<eachGame.getGenre().size();i++){
				    	    	// If it is the last genre name, don't print the ','
				    	    	if (i == eachGame.getGenre().size()-1){
				    	    		out.println(eachGame.getGenre().get(i).getGenreName());
				    	    	} else {
				    	    		out.print(eachGame.getGenre().get(i).getGenreName()+ ", ");
				    	    	}
				    	    }
				    	    
				    	    out.println("		</p>");
				    	    out.println("	</div>");
				    	    // Remove Item Button
				    	    //out.println("	<form action='itemManage' onsubmit=\"return removeItem(" + index + ")\" method='post'>");
				    	    out.println("	<input class='deleteLock' type='hidden' name='deleteEach_lock' value='"+ eachGame.getGameid() +"'>");
				    	    out.println("	<input id='" + eachGame.getGameid() + "' class='removebtn' type='button' name='submit_button' value='REMOVE' style='background: #9cc448;border: 1px solid #9cc448;color: #fff;font-weight: 600;width: 104px;height: 30px;padding: 0;font-size: 12px;line-height: 1em;margin-top: 5px;'>");
				    	    //out.println("	</form>");
				    	    out.println("</div>");
				    	    
				    	    // Item Price
				    	    out.println("<div class='item_price'>");
				    	    double unitPrice = Double.parseDouble(eachGame.getPrice());
				    	    out.println("	<span class='item_money' value='" + unitPrice + "'> $" + String.format("%.2f",unitPrice) + "</span>");
				    	    out.println("</div>");
				    	    
				    	    // Item Quantity
				    	    out.println("<div class='item_quantity'>");
				    	    out.println("	<div class='quantity_box'>");
				    	    out.print("			<span class='quantity_down'><i class='fa fa-minus' aria-hidden='true'></i></span>");
				    	    
				    	    Map<String, String> received_quantity = (Map<String, String>)session.getAttribute("updateQuantity");
				    	    int quantity = quantityList.get(gameList.indexOf(eachGame));
				    	    //eachGame.getGameid()
				    	    String key = String.valueOf(eachGame.getGameid());
				    	    // Check if session received quantity exist, then check if there is any record based on gameid [ORDER IMPORTANT] 
				    	    if(received_quantity != null){
				    	    	if(received_quantity.get(key) != null){
					    	    	// Retrieve the quantity based on gameid from dictionary session 
					    	    	quantity = Integer.parseInt(received_quantity.get(key));
					    	    }
				    	    }
				    	    
				    	    out.print("			<input id='" + eachGame.getGameid() + "' name='updates[]' value='" + quantity + "' class='quantity_input' type='text'> ");
				    	    //out.print("			<input id='" + index + "' name='updates[]' value='" + quantity + "' class='quantity_input' type='hidden'> ");
				    	    out.println("		<span class='quantity_up'><i class='fa fa-plus' aria-hidden='true'></i></span>");
				    	    //out.println("		<form action='itemManage' method='post'>");
				    	    out.println("		<input type='hidden' name='updateEach' class='quantity_update' value='" + String.valueOf(eachGame.getGameid()) + '_' + String.valueOf(quantity) + "'>");
				    	    //out.println(" 		<input type='submit' name='submit_button' value='UPDATE' style='background: #9cc448;border: 1px solid #9cc448;color: #fff;font-weight: 600;width: 104px;height: 30px;padding: 0;font-size: 12px;line-height: 1em;margin-top: 5px;'>");
				    	    //out.println("		</form>");
				    	    out.println("	</div>");	 
				    	    out.println("</div>");
				    	    
				    	    /*
				    	    Sample Item Quantity
				    	    <form action="itemManage" method="post">
				    	    	<input type="hidden" name="update" value="2_1">
								<input type="submit" name="submit_button" value="UPDATE" style="background: #9cc448;border: 1px solid #9cc448;color: #fff;font-weight: 600;width: 104px;height: 30px;padding: 0;font-size: 12px;line-height: 1em;margin-top: 5px;">
							</form>
				    		*/
				    		
				    	    // Item Total
				    	    // Reload to show correct value
				    	    out.println("<div class='item_total'>");
				    	    double unitTotal = quantity * unitPrice;
				    	    out.println("	<span class='item_money' value='" + unitTotal + "'> $" + String.format("%.2f", unitTotal) + "</span>");
							out.println("</div>");
				    	    
				    	    // End of Item Container
				    	    out.println("</div>");
				    	    
				    	    totalPrice += unitTotal;
		    				} // End of for loop statement
		    			String strTotalPrice = String.format("%.2f", totalPrice);
%>
		<div class="item_container" style="height: 4vh;">
			<div style="line-height: 0vh;width: max-content;float: left;font-size: large;">
	    		 Total Price :
	    	</div>
			<div>
				<span class="item_money" value="<%=totalPrice%>" style="line-height: 0vh;width: max-content;float: right;font-size: large;margin-right: 1.5vw;"> $<%=strTotalPrice%></span>
			</div>
		</div>

<%
	  		} else {  // End of if statement 
		   		out.println("<h3 style='text-align:center;'>Shopping Cart is empty !</h3>");
		   		btnDisabled = "disabled='disabled'";
		   	}
%>
<!-- End of the cart container -->
</div>

<!-- Checkout and SaveCart Button -->
<div class="cart_container" style="text-align: center;">
	<input id='savebtn' type='submit' name='saveCart' value='Save Cart' <%=btnDisabled%> style="background: #9cc448;border: 1px solid #9cc448;color: #fff;font-weight: 600;width: 104px;height: 30px;padding: 0;font-size: 12px;line-height: 1em;margin-top: 5px;">
	<input id='purchasebtn' type='submit' name='purchaseCart' value='Check Out' <%=btnDisabled%> style="background: orange;border: 1px solid orange;color: #fff;font-weight: 600;width: 104px;height: 30px;padding: 0;font-size: 12px;line-height: 1em;margin: 2vw;">
</div>
</form>
</div>
<!-- End of Shopping cart form -->

<!-- Start of purchasing history form -->
	<div class="pro__tab_label tab-pane fade <%=review%> show in" id="nav-review" role="tabpanel">
		<div class='cart_container'>
			<h2 style="text-align: center;font-weight: bold;"> Purchasing History </h2>
			<div class="cart_header">
				<p class="cart_product">Product</p>
				<p class="cart_price">Price</p>
				<p class="cart_quantity">Quantity</p>
				<p class="cart_total">Total</p>
			</div>
<%
	if(userinfo!=null){
		String username = userinfo.getUser();
		PurchaseHistoryDB db = new PurchaseHistoryDB();
		ArrayList<PurchaseHistory> purchasedList = db.getPurchaseHistory(username);
		
// 		// Unit Testing:
// 		System.out.println(username);
		for (PurchaseHistory eachPurchased : purchasedList) {
		    
		    double transactionTotal = 0.00;
			ArrayList<Item> itemList = eachPurchased.getGame();
			// Print transaction id and date time
			out.println("<div style='box-shadow: 3px 3px 5px 0px rgba(0,0,0,0.75);padding-left: 1vw;padding-top: 1vw;'>");
			out.println("<p style=\"display:inline-block;\"><b>Transaction ID: </b>" + eachPurchased.getTransactionID() + 
					"</p><p class='game_type' style=\"display:inline-block;\"><b>&nbsp;&nbsp;&nbsp;&nbsp;Date Time: </b>" + eachPurchased.getDate() + "</p>");
			
			for (Item eachItem: itemList){
				Game newGame = new Game();
				String gameid = eachItem.getGameid();
				if(newGame.getGameInfo(gameid)){	
				
					out.println("<div class='item_container'>");
			    	
		   	    	// Item Image
		    	    out.println("<div class='item_image'>");
		    	    out.println("	<img alt='item_image' src='" + newGame.getImageLocation() + "' onerror=\"this.src='./images/noimage.jpg'\" style='max-width: 200px; max-height: 150px; width: 80%;display:inline-block;'>");
					out.println("</div>");
					
					// Item Information in pleasing way
		    	    out.println("<div class='item_info'>");
		    	    out.println("	<p class='item_name'>");
		    	    out.println("		<a href='gameInfo.jsp?gameid=" + gameid + "'>" + newGame.getGameTitle() + "</a>");
		    	    out.println("	</p>");
		    	    out.println("	<p class='item_name'>");
		    	    out.println("	</p>");
		    	    out.println("	<div class='item_details'>");
		    	    out.println("		<p class='game_type'>");
		    	    out.println("			<b>Preowned: </b>" + newGame.getPreowned() );
		    	    out.println("		</p>");
		    	    out.println("		<p class='game_genre'>");
		    	    out.print("			<b>Game Genre: </b>");
		    	    
		    	    for(int i =0; i<newGame.getGenre().size();i++){
		    	    	// If it is the last genre name, don't print the ','
		    	    	if (i == newGame.getGenre().size()-1){
		    	    		out.println(newGame.getGenre().get(i).getGenreName());
		    	    	} else {
		    	    		out.print(newGame.getGenre().get(i).getGenreName()+ ", ");
		    	    	}
		    	    }
		    	    
		    	    out.println("		</p>");
		    	    
		    	    out.println("	</div>");
		    	    out.println("</div>");
		    	    
		    	    // Item Price
		    	    out.println("<div class='item_price'>");
		    	    double unitPrice = Double.parseDouble(newGame.getPrice());
		    	    out.println("	<span class='item_money'> $" + String.format("%.2f",unitPrice) + "</span>");
		    	    out.println("</div>");
		    	    
		    	    // Item Quantity
		    	    int quantity = eachItem.getQuantity();
		    	    out.println("<div class='item_quantity history_quantity'>");
		    	    out.println("	<span class='item_money'>" + quantity + "</span>");
		    	    out.println("</div>");
		    	    
		    	 	// Item Total
		    	    // Reload to show correct value
		    	    out.println("<div class='item_total'>");
		    	    double unitTotal = quantity * unitPrice;
		    	    out.println("	<span class='item_money' value='" + unitTotal + "'> $" + String.format("%.2f",unitTotal) + "</span>");
					out.println("</div>");
					
					transactionTotal += unitTotal;
				} // End of getGameInfo if statement
				
			%>
		</div> <!-- End of item container -->
<%
			} // End of each Item for loop statement
			out.println("<p style=\"display:inline-block;\"><b>Transaction Total: </b> $" + String.format("%.2f",transactionTotal) + "</p>");
			out.println("</div>");
		} //  End of each Purchased for loop statement
	} // End of null check for userinfo statement
%>
	</div> <!-- End of cart container -->
	<!-- End of purchasing history form -->
</div>
</div>
<!-- Functional +/- button that change the value in quantity box -->
<!-- Functional remove button that set quantity to 0 in quantity box -->
<!-- Functional check box that allows user select items he want -->
<script type="text/javascript">

	var confirmation = false;

	$(document).on('focusout', '.quantity_input', function() {
		var N = $(this).val();
		if ( ( isNaN(parseFloat( N )) && !isFinite( N ) ) || parseInt( N ) == 0 || N == '' ) {
			$(this).val(1);
		}
		else if ( parseInt( N ) < 0 ) {
			$(this).val( parseInt( N ) - parseInt( N )*2 );
		}
		else {
			$(this).val( parseInt( N ) );
		};
	});
	
	// N is the quantity shows in the input box, while N2 is the quantity shows in hidden input box
	// N2 contains quantity value that submit to itemManage servlet 
	$(document).on('click', '.quantity_up', function() {
		var N = $(this).parent().find('.quantity_input');
		var N2 = $(this).parent().find('.quantity_update');

		if ( !isNaN( parseFloat( N.val() ) ) && isFinite( N.val() ) && !N.attr('disabled') ) {
			var Nval_A = N2.val().split("_");
			
			var Nval_p = Nval_A[0];
			var Nval = parseInt(Nval_A[1]);
			var newNval = Nval+1;
			N.val( parseInt( N.val() ) + 1 );
			N2.val( Nval_p + '_' + newNval );
		}
		else {
			N.val(1);
			N2.val(Nval_p + "_1");
		};
	});
	
	$(document).on('click', '.quantity_down', function() {
		var N = $(this).parent().find('.quantity_input');
		var N2 = $(this).parent().find('.quantity_update');
		if ( !isNaN( parseFloat( N.val() ) ) && isFinite( N.val() ) && ( N.val() > 1 ) && !N.attr('disabled') ) {
			var Nval_A = N2.val().split("_");
			
			var Nval_p = Nval_A[0];
			var Nval = parseInt(Nval_A[1]);
			var newNval = Nval-1;
			N.val( parseInt( N.val() ) - 1 );
			N2.val( Nval_p + '_' + newNval );
		}
		else {
			N.val(1);
			N2.val(Nval_p + "_1");
		};
	});
	
	$(document).on('click','.removebtn', function(){
		confirmation = confirm('Confirm remove the game ?');
		console.log(confirmation);
		
		// if confirm, continue
		if(confirmation){
			console.log("ID:" + this.id);
			var array_input = document.getElementsByClassName('quantity_input');
			// Unit Testing:
			/* var array_update = document.getElementsByClassName('quantity_update');
			console.log(array_input);
			console.log(array_update); */
			$(this).parent().parent().find("#checkboxes-0").prop("checked", true);
			
			// Change the quantity value to 0
			for (var i=0; i< array_input.length; i++){
				if ((array_input[i].id)==(this.id)){
					$(array_input[i]).parent().find('.quantity_input').val(this.id + "_0");
					$(array_input[i]).parent().find('.quantity_update').val(this.id + "_0");
					// Change the item container display to none
					$(array_input[i]).parent().parent().parent().removeAttr("style").hide();
					console.log("successful");
				}
			}
		}
	});
	
	$(document).on('click','#purchasebtn', function(){
		confirmation = confirm('Confirm to checkout ?');
	});
	
	$(document).on('click','#savebtn', function(){
		confirmation = confirm('Confirm to save cart ?');
	});
	
	function checked(){
		if(confirmation){
			var cb = document.getElementsByClassName('item_checkbox');
			for(var i=0;i<cb.length;i++){
				if(cb[i].checked){
					return true;
				}
			};
			alert('Please check at least one item');
			return false;	
		}
		return false;
	};
	
	// If quantity is 0, hide the item container
	var array_input = document.getElementsByClassName('quantity_input');
	for (var i=0; i< array_input.length; i++){
		if (array_input[i].value.substr(-1) == 0){
			$(array_input[i]).parent().parent().parent().removeAttr("style").hide();
		}
	}
	
	// Toggle between description and review pages
	$("#nav2").click(function(){
	  $("#nav-details").removeClass("active");
	  $("#nav-review").addClass("active");
	  $(this).addClass("active");
	  $("#nav1").removeClass("active");
	});
	$("#nav1").click(function(){
	  $("#nav-review").removeClass("active");
	  $("#nav-details").addClass("active");
	  $(this).addClass("active");
	  $("#nav2").removeClass("active");
	});
	
</script>
</body>
</html>