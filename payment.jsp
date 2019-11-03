<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
	import="java.util.*,main.*"    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment details</title>
<link href="https://cdn.jotfor.ms/static/formCss.css?3.3.12235" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="https://cdn.jotfor.ms/css/styles/nova.css?3.3.12235">
<link type="text/css" rel="stylesheet" href="https://cdn.jotfor.ms/themes/CSS/566a91c2977cdfcd478b4567.css?themeRevisionID=5cf39fbd544a5401541a4081">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style type="text/css">
    .form-label-left{
        width:150px;
    }
    .form-line{
        padding-top:12px;
        padding-bottom:12px;
    }
    .form-label-right{
        width:150px;
    }
    body, html{
        margin:0;
        padding:0;
        background:#fff;
    }

    .form-all{
        margin:0px auto;
        padding-top:0px;
        width:690px;
        color:#555 !important;
        font-family:"Lucida Grande", "Lucida Sans Unicode", "Lucida Sans", Verdana, sans-serif;
        font-size:14px;
    }
    .form-radio-item label, .form-checkbox-item label, .form-grading-label, .form-header{
        color: false;
    }
    .form-all {
      font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Verdana, Tahoma, sans-serif, sans-serif;
    }
    .form-all .qq-upload-button,
    .form-all .form-submit-button,
    .form-all .form-submit-reset,
    .form-all .form-submit-print {
      font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Verdana, Tahoma, sans-serif, sans-serif;
    }
    .form-all .form-pagebreak-back-container,
    .form-all .form-pagebreak-next-container {
      font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Verdana, Tahoma, sans-serif, sans-serif;
    }
    .form-header-group {
      font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Verdana, Tahoma, sans-serif, sans-serif;
    }
    .form-label {
      font-family: 'Lucida Grande', 'Lucida Sans Unicode', 'Lucida Sans', Verdana, Tahoma, sans-serif, sans-serif;
    }
  
    .form-label.form-label-auto {
      
    display: inline-block;
    float: left;
    text-align: left;
  
    }
  
    .form-line {
      margin-top: 12px 36px 12px 36px px;
      margin-bottom: 12px 36px 12px 36px px;
    }
  
    .form-all {
      width: 590px;
    }
  
    .form-label-left,
    .form-label-right,
    .form-label-left.form-label-auto,
    .form-label-right.form-label-auto {
      width: 150px;
    }
  
    .form-all {
      font-size: 14pxpx
    }
    .form-all .qq-upload-button,
    .form-all .qq-upload-button,
    .form-all .form-submit-button,
    .form-all .form-submit-reset,
    .form-all .form-submit-print {
      font-size: 14pxpx
    }
    .form-all .form-pagebreak-back-container,
    .form-all .form-pagebreak-next-container {
      font-size: 14pxpx
    }
  
    .supernova .form-all, .form-all {
      background-color: ;
      border: 1px solid transparent;
    }
  
    .form-all {
      color: #555;
    }
    .form-header-group .form-header {
      color: #555;
    }
    .form-header-group .form-subHeader {
      color: #555;
    }
    .form-label-top,
    .form-label-left,
    .form-label-right,
    .form-html,
    .form-checkbox-item label,
    .form-radio-item label {
      color: #555;
    }
    .form-sub-label {
      color: #6f6f6f;
    }
  
    .supernova {
      background-color: undefined;
    }
    .supernova body {
      background: transparent;
    }
  
    .form-textbox,
    .form-textarea,
    .form-radio-other-input,
    .form-checkbox-other-input,
    .form-captcha input,
    .form-spinner input {
      background-color: undefined;
    }
  
    .supernova {
      background-image: none;
    }
    #stage {
      background-image: none;
    }
  
    .form-all {
      background-image: none;
    }
  
  .ie-8 .form-all:before { display: none; }
  .ie-8 {
    margin-top: auto;
    margin-top: initial;
  }
  
  /*PREFERENCES STYLE*//*__INSPECT_SEPERATOR__*/
    /* Injected CSS Code */

</style>
</head>
<body>
<form class="jotform-form" action="ShoppingCartServlet" method="post" name="form_92097849519474" id="92097849519474" accept-charset="utf-8" novalidate="true" _lpchecked="1">
  <input type="hidden" name="paymentForm" value="submit">
  <div role="main" class="form-all">
    <ul class="form-section page-section">
      <li id="cid_1" class="form-input-wide" data-type="control_head">
        <div class="form-header-group ">
          <div class="header-text httal htvam">
            <h1 id="header_1" class="form-header" data-component="header">
              Shopping Cart Payment Form
            </h1>
            <div id="subHeader_1" class="form-subHeader">
              Summary of shopping cart
            </div>
          </div>
        </div>
      </li>
      <li class="form-line" data-type="control_paypalpro" id="id_3">
        <label class="form-label form-label-top form-label-auto" id="label_3" for="input_3"> My Products </label>
		<div id="cid_3" class="form-input-wide">
          <div data-wrapper-react="true">
            <div data-wrapper-react="true">
              <input type="hidden" name="simple_fpc" data-payment_type="paypalpro" data-component="payment1" value="3">
              <input type="hidden" name="payment_total_checksum" id="payment_total_checksum" data-component="payment2">
              <div data-wrapper-react="true">
<%
	ArrayList<String> formattedSummary = (ArrayList<String>) session.getAttribute("formattedSummary");
    UserInfo userinfo = (UserInfo)session.getAttribute("userinfo");
    session.removeAttribute("formattedSummary");
    
    if(userinfo == null){
    	session.setAttribute("msg", "Your session has expired!");
    	response.sendRedirect("mainPage.jsp");
    }
    
	if(formattedSummary != null){
		double total = 0.0;
		for ( String eachProduct : formattedSummary){
			// Unit Testing:
			// System.out.println(eachProduct);
			String[] productInfo = eachProduct.replace(" $", "-").split("-");
			
			String gametitle = productInfo[0];
			Double price = Double.valueOf(productInfo[1]);
			
			out.println("<span class='form-product-item hover-product-item'>");
            out.println("<div data-wrapper-react='true' class='form-product-item-detail'><label for='input_3_1001' class='form-product-container'>");
            out.println("<span data-wrapper-react='true'><span class='form-product-name' id='product-name-input_3_1001'>" + gametitle + "</span><span class='form-product-details'>");
            out.println("<b><span data-wrapper-react='true'><span id='input_3_1001_price'>&nbsp;&nbsp;&nbsp;&nbsp; $" + String.format("%.2f", price) + "</span></span></b>");
            out.println("</span></span></label></div></span><br>");
            
            total += price;
			
		}
		 	out.println("<span class='form-payment-total'><b><span id='total-text'>Total");
           	out.println("</span>&nbsp;<span class='form-payment-price'>");
            out.println("<span data-wrapper-react='true'>");
            out.println("$<span id='payment_total'>" + String.format("%.2f",total) + "</span>");
            out.println("</span></span></b></span>");
	
%>
			</div>
              <hr>
            </div>
            <table class="form-address-table payment-form-table" style="border:0" cellpadding="4" cellspacing="0">
              <tbody>
                <tr>
                  <th colspan="2" style="text-align:left">
                    Payment Method
                  </th>
                </tr>
                <tr>
                  <td valign="top" style="min-width:50px;vertical-align:top" rowspan="2">
                    <input type="radio" class="paymentTypeRadios" id="input_3_paymentType_credit" name="q3_myProducts3[paymentType]" value="credit">
                    <label for="input_3_paymentType_credit">
                      <div style="display:inline-block;padding-right:4px">
                        <img src="https://cdn.jotfor.ms/images/blank.gif" class="paypalpro_img paypalpro_visa" style="display:inline-block;vertical-align:middle">
                        <img src="https://cdn.jotfor.ms/images/blank.gif" class="paypalpro_img paypalpro_mc" style="display:inline-block;vertical-align:middle">
                        <img src="https://cdn.jotfor.ms/images/blank.gif" class="paypalpro_img paypalpro_amex" style="display:inline-block;vertical-align:middle">
                        <img src="https://cdn.jotfor.ms/images/blank.gif" class="paypalpro_img paypalpro_dc" style="display:inline-block;vertical-align:middle">
                      </div>
                    </label>
                  </td>
                  <td align="left" valign="top" style="padding-bottom:2px !important;text-align:left;vertical-align:top">
                    <input type="radio" class="paymentTypeRadios" id="input_3_paymentType_express" name="q3_myProducts3[paymentType]" checked="" value="express">
                    <label for="input_3_paymentType_express"> <img style="vertical-align:middle" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/pp-acceptance-small.png"> </label>
                  </td>
                </tr>
              </tbody>
            </table>
            <table style="border: 0px; display: none;" id="creditCardTable" class="form-address-table payment-form-table" cellpadding="0" cellspacing="0">
              <tbody>
                <tr>
                  <th colspan="2" style="text-align:left;margin-top:20px;display:table" id="ccTitle3">
                    Credit Card
                  </th>
                </tr>
                <tr>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_firstName" id="sublabel_cc_firstName" style="min-height:13px;margin:0 0 3px 0"> First Name </label>
                      <input type="text" id="input_3_cc_firstName" name="q3_myProducts3[cc_firstName]" class="form-textbox cc_firstName" size="20" value="" data-component="cc_firstName">
                    </span>
                  </td>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_lastName" id="sublabel_cc_lastName" style="min-height:13px;margin:0 0 3px 0"> Last Name </label>
                      <input type="text" id="input_3_cc_lastName" name="q3_myProducts3[cc_lastName]" class="form-textbox cc_lastName" size="20" value="" data-component="cc_lastName">
                    </span>
                  </td>
                </tr>
                <tr>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_number" id="sublabel_cc_number" style="min-height:13px;margin:0 0 3px 0"> Credit Card Number </label>
                      <input type="number" id="input_3_cc_number" name="q3_myProducts3[cc_number]" class="form-textbox cc_number" autocomplete="off" size="20" value="" data-component="cc_number">
                    </span>
                  </td>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_ccv" id="sublabel_cc_ccv" style="min-height:13px;margin:0 0 3px 0"> Security Code </label>
                      <input type="number" id="input_3_cc_ccv" name="q3_myProducts3[cc_ccv]" class="form-textbox cc_ccv" autocomplete="off" style="width:52px" value="" data-component="cc_ccv">
                    </span>
                  </td>
                </tr>
                <tr>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_exp_month" id="sublabel_cc_exp_month" style="min-height:13px;margin:0 0 3px 0"> Expiration Month </label>
                      <select class="form-dropdown cc_exp_month" name="q3_myProducts3[cc_exp_month]" id="input_3_cc_exp_month" data-component="cc_exp_month">
                        <option>  </option>
                        <option value="January"> January </option>
                        <option value="February"> February </option>
                        <option value="March"> March </option>
                        <option value="April"> April </option>
                        <option value="May"> May </option>
                        <option value="June"> June </option>
                        <option value="July"> July </option>
                        <option value="August"> August </option>
                        <option value="September"> September </option>
                        <option value="October"> October </option>
                        <option value="November"> November </option>
                        <option value="December"> December </option>
                      </select>
                    </span>
                  </td>
                  <td width="50%">
                    <span class="form-sub-label-container" style="vertical-align:top">
                      <label class="form-sub-label" for="input_3_cc_exp_year" id="sublabel_cc_exp_year" style="min-height:13px;margin:0 0 3px 0"> Expiration Year </label>
                      <select class="form-dropdown cc_exp_year" name="q3_myProducts3[cc_exp_year]" id="input_3_cc_exp_year" data-component="cc_exp_year">
                        <option>  </option>
                        <option value="2019"> 2019 </option>
                        <option value="2020"> 2020 </option>
                        <option value="2021"> 2021 </option>
                        <option value="2022"> 2022 </option>
                        <option value="2023"> 2023 </option>
                        <option value="2024"> 2024 </option>
                        <option value="2025"> 2025 </option>
                        <option value="2026"> 2026 </option>
                        <option value="2027"> 2027 </option>
                        <option value="2028"> 2028 </option>
                      </select>
                    </span>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </li>
      <li class="form-line" data-type="control_fullname" id="id_4">
        <label class="form-label form-label-top form-label-auto" id="label_4" for="first_4"> Display Name </label>
        <div id="cid_4" class="form-input-wide">
          <div data-wrapper-react="true">
            <span class="form-sub-label-container" style="vertical-align:top"><%=userinfo.getName()%></span>
          </div>
        </div>
      </li>
      <li class="form-line" data-type="control_email" id="id_5">
        <label class="form-label form-label-top form-label-auto" id="label_5" for="input_5"> E-mail </label>
        <div id="cid_5" class="form-input-wide"><%=userinfo.getUser()%></div>
      </li>
      <li class="form-line" data-type="control_address" id="id_6">
        <label class="form-label form-label-top form-label-auto" id="label_6" for="input_6undefined"> Contact Number </label>
        <div id="cid_6" class="form-input-wide"><%=userinfo.getMobileNumber()%></div>
        
      </li>
      <li class="form-line" data-type="control_address" id="id_7">
        <label class="form-label form-label-top form-label-auto" id="label_7" for="input_6undefined"> Shipping Address </label>
        <div id="cid_7" class="form-input-wide"><%=userinfo.getMailAddress()%></div>
      </li>
      <li class="form-line" data-type="control_button" id="id_2">
        <div id="cid_2" class="form-input-wide">
          <div style="margin-left:156px" class="form-buttons-wrapper">
            <button id="input_2" type="submit" class="form-submit-button" data-component="button">
              Submit
            </button>
          </div>
        </div>
      </li>
      <li style="display:none">
        Should be Empty:
        <input type="text" name="website" value="">
      </li>
    </ul>
  </div>
  </div>
</form>
<script>
$("#input_3_paymentType_credit").click(function(){
	$("#creditCardTable").css("display","block");
});
$("#input_3_paymentType_express").click(function(){
	$("#creditCardTable").css("display","none");
});

</script>

<%
} else if(userinfo != null) {
		session.setAttribute("error", 404);
		session.setAttribute("errorinfo", "Check Out session had ended! Try Again!");
		response.sendRedirect("shoppingCart.jsp");
}
%>

</body>
</html>