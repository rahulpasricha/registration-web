<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta content="text/html;charset=utf-8" http-equiv="Content-Type">
		<meta content="utf-8" http-equiv="encoding">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
		<meta http-equiv="Pragma" content="no-cache" />
        <title>User Registration</title>
        <script type="text/javascript" src="resources/jquery-1.10.2.js"></script>		
        <script type="text/javascript" src="resources/jquery-ui-1.8.16.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="resources/jquery-ui-1.8.16.custom.css">
        <script type="text/javascript" src="resources/jquery-bracket-master/dist/jquery.bracket.min.js"></script>
        <script type="text/javascript" src="resources/jquery.json-2.2.min.js"></script>
        <link href="resources/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="resources/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>	
        <link rel="stylesheet" href="resources/font-awesome-4.4.0/css/font-awesome.min.css" />
        <link rel="stylesheet" type="text/css" href="resources/jquery-bracket-master/dist/jquery.bracket.min.css" />
        <link rel="icon" href="<c:url value="resources/favicon.ico"/>" type="image/x-icon" />
		<link rel="shortcut icon" href="<c:url value="resources/favicon.ico"/>" type="image/x-icon" />
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script type='text/javascript' src="resources/respondjs/html5shiv.min.js"></script>
		  <script type='text/javascript' src="resources/respondjs/respond.min.js"></script>
		<![endif]-->
		
		<link rel='stylesheet' type='text/css' href='resources/respondjs/normalize.css' />
        <style type="text/css">
            div.jQBracket .team div.label {font-family: Arial;font-size: 10px;font-weight: bold;color:black;margin-top: 4px;margin-left: 6px;}
            div.jQBracket .team {width: 110px;}
            .navbar-default {margin-bottom:0;background:#ffcc00;z-index:2000;border-bottom: 0 none #d40511;box-shadow: 0 0 2px #d40511;}
			.navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
				margin-left: 12px;
				margin-top: -3px;
			}
			.navbar-default .navbar-nav > li > a {
				color: #D40511;
				font-weight: bold;
			}
			.navbar-default .navbar-nav > li > a:hover {
				color: rgba(212, 5, 17, 0.66);
				font-weight: bold;
			}			
			.navbar-default .navbar-nav > .active > a , .navbar-default .navbar-nav > .active > a:focus, .navbar-default .navbar-nav > .active > a:hover {
				color: #FFCC00;
				background-color: rgba(212, 5, 17, 0.66);
				font-weight: bold;
			}
			.navbar-default .navbar-nav>.open>a, .navbar-default .navbar-nav>.open>a:focus, .navbar-default .navbar-nav>.open>a:hover {
				color: #FFCC00;
				background-color: rgba(212, 5, 17, 0.66);
				font-weight: bold;
			}
			#login-nav input { margin-bottom: 15px;}
			ul.nav.navbar-nav {
				margin-left: 34px;
			}
			.navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
			    margin-left: -20px;
			    margin-top: -3px;
			}
        </style>
		<script type="text/javascript">
			$(document).ready(function() {
				
				/*$.ajax({
					type: 'GET',
					url: 'getFlagToAllowCreateUser',
					success: function(result) {
						$("#createUserButton").prop("disabled", ("TRUE" == result) ? false : true);
					}
				});*/
				
				$.ajax({
					 url:"getTeamMasterdata"
					,type: "GET"
					,success:function(actionResult){
						 var optionData = "<option value=' ' selected='selected'>";
						 $.each(actionResult, function (index, value) {
							 optionData = optionData + "<option value=" + value + ">" + value + "</option>";
						 });
						 $(optionData).appendTo($('#department'));
					},error:function(jqXHR, textStatus, errorThrown){
						
					}
				});
			
				$('.createuser').hide();
				$("#username").focus();
				
				$('#createUserButton').on('click', function(e) {
					e.preventDefault();
					var $btn = $(this).button('loading');
					
					$('.createuser').show();
					
					$('#messageDiv').html('');
					var username = $("#username").val().trim();
					var password = $("#password").val().trim();
					var firstname = $('#firstName').val().trim();
					var lastname = $('#lastName').val().trim();
					var department = $('#department').val();
					
					var errorMessage;
					if (username == '') {
						errorMessage = '<div class="alert alert-danger" role="alert"><strong>Please enter a username</strong></div>';
						$("#username").focus();
					} else if (password == '') {
						errorMessage = '<div class="alert alert-danger" role="alert"><strong>Please enter a password</strong></div>';
						$("#password").focus();
					} else if (firstname == '') {
						errorMessage = '<div class="alert alert-danger" role="alert"><strong>Please enter your first name</strong></div>';
						$('#firstName').focus();
					} else if (lastname == '') {
						errorMessage = '<div class="alert alert-danger" role="alert"><strong>Please enter your last name</strong></div>';
						$('#lastName').focus();
					} else if (department == ' ') {
						errorMessage = '<div class="alert alert-danger" role="alert"><strong>Please select a department</strong></div>';
						$('#department').focus();
						$('#messageDiv').append(errorMessage);
						$btn.button('reset');
						return;
					}
					$('#messageDiv').append(errorMessage);
					
					if (username && password && firstname && lastname && department) {
						var formArray = $('#loginForm').serializeArray();
						var formJson = '{ "username": "' + username + '", "password": "' + password + '", "firstName": "' + firstname + '", "lastName" : "' + lastname + '" , "department": "' + department + '" }';
						$.ajax ({
							type: 'POST',
							contentType: 'application/json; charset=utf-8',
							data: formJson,
							url: 'createFoosballUser.fd',
							dataType: 'json',												
							success: function(result) {
								$("#username").val('');
								$("#password").val('');
								$('#firstName').val('');
								$('#lastName').val('');
								$('#department').val('');
								$('#messageDiv').append('<div class="alert alert-success" role="alert">User Created Successfully. Please remember your username : <strong>' + result.username + '</strong></div>');
								$btn.button('reset');
							},error:function(jqXHR, textStatus, errorThrown){
								var errorFromServer;
								if(jqXHR.responseText !== ''){
									errorFromServer = jqXHR.responseText;
									if (errorFromServer.indexOf("<html>") >= 0) {
										errorFromServer = errorThrown;
									}
							    } else {
							    	errorFromServer = errorThrown;
							    }
								$('#messageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
								$btn.button('reset');
							}			
						});
					} else {
						$btn.button('reset');	
					}
					
					return false;
				});
				
				$('#signInButton').on('click', function() {
					$('.createuser').hide();
				});
				
				$('.createuser').change(function() {
					$('#messageDiv').html('');
				});
				
			});
		</script>
    </head>
    <body>
		<div class="container">
	    	<header class="navbar navbar-default bs-docs-nav navbar-static-top" role="banner"> 
				<div class="container-fluid">
		               <div class="navbar-header">
		                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".bs-navbar-collapse">
		                    <span class="sr-only">Toggle navigation</span>
		                    <span class="icon-bar"></span>
		                    <span class="icon-bar"></span>
		                    <span class="icon-bar"></span>
		                    </button>
		                    <a class="navbar-brand" href="#"><img src="resources/mistletoe.png"></a>
		                    <a class="navbar-brand" href="#"><img src="resources/dhl_logo.png"></a>
		                </div>
		           <nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
							<ul class="nav navbar-nav">
								<li><a href="home">Home</a></li>
								<li class="active"><a href="signup">Sign In</a></li>
								<li><a href="resetpassword">Reset Password</a></li>
						   </ul>
					</nav>
				</div>
			</header>
		</div>
		<br>
        <div class="container">		
            <div class="row">
				<div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
					<form class="form" role="form" accept-charset="UTF-8" id="loginForm" action="<c:url value='/j_spring_security_check' />" method='POST'>
						<h3>Sign In / Register </h3>
						<hr>
						<div class="form-group">
							<input type="username" name="username" id="username" class="form-control input-lg" placeholder="Username" required>
						</div>
						<div class="form-group">
							<input type="password" name="password" id="password" class="form-control input-lg" placeholder="Password" required>
						</div>
						<div class="form-group">
							<input type="text" name="firstName" id="firstName" class="form-control input-lg createuser" placeholder="First Name">
						</div>
						<div class="form-group">
							<input type="text" name="lastName" id="lastName" class="form-control input-lg createuser" placeholder="Last Name">
						</div>
						<div class="form-group">
							<select id="department" name="department" class="form-control input-lg createuser"></select>
						</div>
						<div class="row">
							<div class="col-xs-12 col-md-6"><input id="signInButton" type="submit" name="signIn" value="Sign In" class="btn btn-success btn-block btn-lg"></div>
							<div class="col-xs-12 col-md-6"><button id="createUserButton" name="createUser" value="Create User" class="btn btn-primary btn-block btn-lg" data-loading-text="Registering...">Register</button></div>
						</div>
						<br>
						<div class="form-group" id="messageDiv">
							<c:if test="${not empty error}">
								<div class="alert alert-danger" role="alert">Failed : <strong>${error}</strong></div>
							</c:if>
							<c:if test="${not empty logout}">
								<div class="alert alert-info" role="alert">Logged out successfully!!!</div>
							</c:if>
						</div>
						<hr>
						<div class="form-group">
						    <div class="form-group pull-right">
								<a href="resetpassword">Forgot Password?</a>
							</div>
						</div>
						</form>
						</div>
						</div>
        </div>
		<footer class="pull-right">
			<p style="margin-top: 4px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>