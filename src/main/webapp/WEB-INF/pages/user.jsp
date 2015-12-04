<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
			.alert-info {
				color: #6C6D71;
				background-color: #FFFD9C;
				border-color: #F1E157;
			}
			a#logout {
			    font-size: 12px;
			    line-height: 1.5;
			    border-radius: 3px;
			    color: #fff;
			    background-color: #337ab7;
			    border-color: #2e6da4;
			    display: inline-block;
			    padding: 6px 12px;
			    margin-bottom: 0;
			    font-size: 14px;
			    font-weight: 400;
			    line-height: 1.42857143;
			    text-align: center;
			    white-space: nowrap;
			    vertical-align: middle;
			    -ms-touch-action: manipulation;
			    touch-action: manipulation;
			    cursor: pointer;
			    -webkit-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			    background-image: none;
			    border: 1px solid transparent;
			    border-radius: 4px;
			    margin-right: 8px;
			}
			a#logout:hover {
			    color: #fff;
			    background-color: #286090;
			    border-color: #204d74;
			}
			#welcomeUser {
				margin-top: 15px;
			    font-size: 20px;
			    margin-right: 10px;
			}
			.navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
			    margin-left: -20px;
			    margin-top: -3px;
			}
        </style>
        <script>var loggedInUser = '<sec:authentication property="principal.username" />'</script>
        <script>
								
			function getRsvpStatus(username) {
				$.ajax({
					type: 'GET',
					url: 'getRsvpStatus/' + username ,
					cache: false,
					success: function(result) {
						$("#currentRsvpStatus").html(result);
					}							
			  	});
			};
			
			function getNinjaStatus(username) {
				$.ajax({
					type: 'GET',
					url: 'getNinjaStatus/' + username ,
					cache: false,
					success: function(result) {
						$("#currentNinjaStatus").html(result);
					}							
			  	});
			};
			
			function getPresentExchangeStatus(username) {
				$.ajax({
					type: 'GET',
					url: 'getPresentExchangeStatus/' + username ,
					cache: false,
					success: function(result) {
						//setTimeout(function() {
							$("#currentPresentExchangeStatus").html(result);
						//}, 1000);
					}							
			  	});
			};
		
			$(document).ready(function() {
				
				//Handles menu drop down
				$('.dropdown-menu').find('form').click(function (e) {
					e.stopPropagation();
				});
				
				$('#rsvpInButton').on('click', function(e) {
					e.preventDefault();
					$('#updateRsvpStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updateRsvpStatus/' + loggedInUser + '/' + 'true',
						dataType: 'json',												
						success: function(result) {
							$('#updateRsvpStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>RSVP status updated successfully.</strong></div>');
							getRsvpStatus(loggedInUser);
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
							$('#updateRsvpStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				$('#rsvpOutButton').on('click', function(e) {
					e.preventDefault();
					$('#updateRsvpStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updateRsvpStatus/' + loggedInUser + '/' + 'false',
						dataType: 'json',												
						success: function(result) {
							$('#updateRsvpStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>RSVP status updated successfully.</strong></div>');
							getRsvpStatus(loggedInUser);
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
							$('#updateRsvpStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				$('#ninjaInButton').on('click', function(e) {
					e.preventDefault();
					$('#updateNinjaStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updateNinjaStatus/' + loggedInUser + '/' + 'true',
						dataType: 'json',												
						success: function(result) {
							$('#updateNinjaStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>NINJA status updated successfully.</strong></div>');
							getNinjaStatus(loggedInUser);
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
							$('#updateNinjaStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				
				$('#ninjaOutButton').on('click', function(e) {
					e.preventDefault();
					$('#updateNinjaStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updateNinjaStatus/' + loggedInUser + '/' + 'false',
						dataType: 'json',												
						success: function(result) {
							$('#updateNinjaStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>NINJA status updated successfully.</strong></div>');
							getNinjaStatus(loggedInUser);
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
							$('#updateNinjaStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				$('#presentExchangeInButton').on('click', function(e) {
					e.preventDefault();
					$('#updatePresentExchangeStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updatePresentExchangeStatus/' + loggedInUser + '/' + 'true',
						dataType: 'json',												
						success: function(result) {
							$('#updatePresentExchangeStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Present Exchange status updated successfully.</strong></div>');
							getPresentExchangeStatus(loggedInUser);
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
							$('#updatePresentExchangeStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				
				$('#presentExchangeOutButton').on('click', function(e) {
					e.preventDefault();
					$('#updatePresentExchangeStatusMessageDiv').html('');
					var $btn = $(this).button('loading');
					
					$.ajax ({
						type: 'POST',
						contentType: 'application/json; charset=utf-8',
						url: 'updatePresentExchangeStatus/' + loggedInUser + '/' + 'false',
						dataType: 'json',												
						success: function(result) {
							$('#updatePresentExchangeStatusMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Present Exchange status updated successfully.</strong></div>');
							getPresentExchangeStatus(loggedInUser);
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
							$('#updatePresentExchangeStatusMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
						}						
					});	
					
				});
				
				$(function() {
					getRsvpStatus(loggedInUser);
					getNinjaStatus(loggedInUser);
					getPresentExchangeStatus(loggedInUser);
				});
				
			});
			
		</script>
    </head>
    <body>		
		<div class="container">
	    	<header class="navbar navbar-default bs-docs-nav navbar-static-top" role="banner"> 
				<div class="container-fluid">
		               <div class="navbar-header">
		                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
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
								<li></li>
							</ul>
							<ul class="nav navbar-nav pull-right" style="margin-top:4px;">
								<li><h4 id="welcomeUser"><small>Welcome <strong><sec:authentication property="principal.username" /></strong></small></h4></li>
								<li>&nbsp;&nbsp;&nbsp;</li>
								<li><a href="<c:url value="j_spring_security_logout" />" class="btn btn-primary btn-sm" id="logout" style="margin-top:7px;">Logout</a>
							</ul>
					</nav>
				</div>
			</header>
		</div>
		<br>
        <div class="container">	
			<div class="row">
				<div class="col-sm-4 col-xs-offset-1">
					<div class="row">
						<h3>RSVP for the Christmas Party</h3>
					</div>
					<br>
					<div class="row">
						<h3><small>Your current RSVP status is &nbsp;&nbsp;</small><span class="label label-info" id="currentRsvpStatus"></span></h3>
						<h3><small>Use the following buttons to update your RSVP status</small><span class="label label-default" id="currentRsvpStatus"></span></h3>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><button id="rsvpInButton" type="submit" value="IN" class="btn btn-success btn-block btn-lg" data-loading-text="Updating...">IN</button></div>
							<div class="col-xs-12 col-md-6"><button id="rsvpOutButton" type="submit" value="OUT" class="btn btn-danger btn-block btn-lg" data-loading-text="Updating...">OUT</button></div>
						</div>
						<br>
						<div class="form-group" id="updateRsvpStatusMessageDiv">
							
						</div>						
					</div>
				</div>
				<div class="col-sm-5 col-xs-offset-1">
					<div class="row">
						<h3>NINJA status</h3>
					</div>
					<br>
					<div class="row">
						<h3><small>Your current NINJA status is &nbsp;&nbsp;</small><span class="label label-info" id="currentNinjaStatus"></span></h3>
						<h3><small>Use IN button if you want to participate in the NINJA game</small><span class="label label-default" id="currentNinjaStatus"></span></h3>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><button id="ninjaInButton" type="submit" value="IN" class="btn btn-success btn-block btn-lg" data-loading-text="Updating...">IN</button></div>
							<div class="col-xs-12 col-md-6"><button id="ninjaOutButton" type="submit" value="OUT" class="btn btn-danger btn-block btn-lg" data-loading-text="Updating...">OUT</button></div>
						</div>
						<br>
						<div class="form-group" id="updateNinjaStatusMessageDiv">
							
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4 col-xs-offset-1">
					<div class="row">
						<h3>Present Exchange Initiative</h3>
					</div>
					<br>
					<div class="row">
						<h3><small>Your current status is &nbsp;&nbsp;</small><span class="label label-info" id="currentPresentExchangeStatus"></span></h3>
						<h3><small>Use the following buttons to tell us if you are intereseted in the present exchange initiative</small><span class="label label-default" id="currentPresentExchangeStatus"></span></h3>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><button id="presentExchangeInButton" type="submit" value="IN" class="btn btn-success btn-block btn-lg" data-loading-text="Updating...">IN</button></div>
							<div class="col-xs-12 col-md-6"><button id="presentExchangeOutButton" type="submit" value="OUT" class="btn btn-danger btn-block btn-lg" data-loading-text="Updating...">OUT</button></div>
						</div>
						<br>
						<div class="form-group" id="updatePresentExchangeStatusMessageDiv">
							
						</div>						
					</div>
				</div>
			</div>
			<hr>
        </div>
		<footer class="pull-right">
			<p style="margin-top: 4px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>