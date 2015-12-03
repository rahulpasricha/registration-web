<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page session="true"%>
<!DOCTYPE html>
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
				
				$('.resetpassword').change(function() {
					$('#messageDiv').html('');
				});
				
				$("#resetForm").submit(function( event ) {
					
					event.preventDefault();
					
					$('#messageDiv').html('');
					var username = $( "#username" ).val();
					var password = $( "#newPassword" ).val();
					
					var formArray = $('#resetForm').serializeArray();
					var formJson = '{ "username": "' + username + '", "password": "' + password + '" }';
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						data: formJson,
						url: 'resetPassword.fd',
						dataType: 'json',												
						success: function(result) {
							$('#messageDiv').append('<div class="alert alert-info" role="alert"><strong>Password Updated Successfully.</strong></div>');
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
						}						
					});					
					event.preventDefault();
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
								<li><a href="signup">Sign In</a></li>
								<li class="active"><a href="resetpassword">Reset Password</a></li>
						   </ul>
					</nav>
				</div>
			</header>
		</div>
		<br>
        <div class="container">		
            <div class="row">
				<div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
					<form role="form" id="resetForm">
						<h3>Reset Password</h3>
						<hr>
						<div class="form-group">
							<input type="username" name="username" id="username" class="form-control input-lg resetpassword" placeholder="Username" required>
						</div>
						<div class="form-group">
							<input type="password" name="newPassword" id="newPassword" class="form-control input-lg resetpassword" placeholder="New Password" required>
						</div>
						<div class="row">
							<div class="col-xs-12 col-md-6"><input id="resetPasswordButton" type="submit" value="Reset Password" class="btn btn-primary btn-block btn-lg"></div>
							<div class="col-xs-12 col-md-6"><a href="signup" class="btn btn-success btn-block btn-lg">Go Back & Sign In</a></div>
						</div>
						<br>
						<div class="form-group" id="messageDiv">
							
						</div>						
						<hr>
					</form>
				</div>
			</div>			
        </div>
		<footer class="pull-right">
			<p style="margin-top: 4px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>