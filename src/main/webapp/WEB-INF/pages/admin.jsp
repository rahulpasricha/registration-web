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
			.progress-bar-info {
				background-color: #F3DA75;
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
			.col-sm-3 {
			    margin-right: 50px;
			}
			form {
			    margin-left: -15px;
			}
			.navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
			    margin-left: -20px;
			    margin-top: -3px;
			}
        </style>
        <script>var loggedInUser = '<sec:authentication property="principal.username" />'</script>
    </head>
    <body>
		<!-- <div class="container-fluid">
			 <header class="navbar navbar-default bs-docs-nav navbar-static-top" role="banner"> 
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#"><img src="resources/dhl_logo.png">
						</a>
					</div>
					<div class="collapse navbar-collapse" role="navigation">
						<ul class="nav navbar-nav">
							<li></li>
						</ul>
						<ul class="nav navbar-nav pull-right" style="margin-top:4px;">
							<li><h4 id="welcomeUser"><small>Welcome <strong><sec:authentication property="principal.username" /></strong></small></h4></li>
							<li>&nbsp;&nbsp;&nbsp;</li>
							<li><a href="<c:url value="j_spring_security_logout" />" class="btn btn-primary btn-sm" id="logout" style="margin-top:7px;">Logout</a>
						</ul>
					</div>            
			</header>
		</div>-->
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
				 <div class="col-lg-10 col-xs-offset-1">
						<div class="row">
							<h2><span class="label label-info">Tournament Progress - Admin View</span>
								<div id="updateProgressBar" class="progress" style="width:250px;margin-top: 24px;margin-bottom: -17px;">
								  <div class="progress-bar progress-bar-info progress-bar-striped active" role="progressbar" style="width: 100%">
									<span style="font-weight:bold;color:rgba(212, 5, 17, 0.61);">Updating Bracket...</span>
								  </div>
								</div>
							</h2>
						</div>
						<br>
						<div class="row">
							<div id="minimal">
								<script>
									$(document).ready(function() {
										
										//Handles menu drop down
										$('.dropdown-menu').find('form').click(function (e) {
											e.stopPropagation();
										});
										
										$('#updateProgressBar').hide(); 
										
										$.ajax({
											type: 'GET',
											url: 'getfoosball.html',
											contentType: 'application/json; charset=utf-8',
											dataType: 'json',
											success: function(result) {
												var container = $('#minimal');
												container.bracket({
													init: result,
													save: saveFn,
													userData: 'postfoosball.html'
												});
											},error:function(jqXHR, textStatus, errorThrown){
												$('#minimal').append('<div class="alert alert-danger" role="alert" style="width:470px;">' +
														'<Strong>Failed to the load tournament bracket.' +
														'</strong> Contact the site admins.</div>');
											}								
										});
										
										/* 
										 * Called whenever bracket is modified
										 *
										 * data:     changed bracket object in format given to init
										 * postUrl: optional data given when bracket is created.
										 */
										function saveFn(data, postUrl) {
											$('#updateProgressBar').show();
											$.ajax({
												type: 'POST',
												url: postUrl,
												contentType: 'application/json; charset=utf-8',
												dataType: 'json',
												data: $.toJSON(data),
												success: function(result) {
													var container = $('#minimal');
													container.bracket({
														init: result,
														save: saveFn,
														userData: 'postfoosball.html'
													});
													$('#updateProgressBar').hide();
												} ,error:function(jqXHR, textStatus, errorThrown){
													$('#updateProgressBar').hide();
												}												
											});
										 }
										
										 $('#startRegistrationButton, #stopRegistrationButton').on('click', function(e) {
											 $('#registrationMessageDiv').html('');
											 e.preventDefault(); 
											 $.ajax({
													type: 'POST',
													url: 'updateflag/ALLOW_CREATE_USER/' + e.target.name,
													contentType: 'application/json; charset=utf-8',
													dataType: 'json',
													success: function(result) {
														$('#registrationMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Updated!!!</strong></div>');
													},error:function(jqXHR, textStatus, errorThrown) {
														$('#registrationMessageDiv').append('<div class="alert alert-danger" role="alert"><strong>Error : ' + errorThrown + ' </strong></div>');
													}											
												});
										 });
										 
										 $('#startPlayerRatingButton, #stopPlayerRatingButton').on('click', function(e) {
											 $('#ratingsMessageDiv').html('');
											 e.preventDefault(); 
											 $.ajax({
													type: 'POST',
													url: 'updateflag/ALLOW_RATINGS_UPDATE/' + e.target.name,
													contentType: 'application/json; charset=utf-8',
													dataType: 'json',
													success: function(result) {
														$('#ratingsMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Updated!!!</strong></div>');
													},error:function(jqXHR, textStatus, errorThrown) {
														$('#ratingsMessageDiv').append('<div class="alert alert-danger" role="alert"><strong>Error : ' + errorThrown + ' </strong></div>');
													}											
												});
										 });
										 
										 $('#startTeamNameUpdatesButton, #stopTeamNameUpdatesButton').on('click', function(e) {
											 $('#teamMessageDiv').html('');
											 e.preventDefault(); 
											 $.ajax({
													type: 'POST',
													url: 'updateflag/ALLOW_TEAM_UPDATE/' + e.target.name,
													contentType: 'application/json; charset=utf-8',
													dataType: 'json',
													success: function(result) {
														$('#teamMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Updated!!!</strong></div>');
													},error:function(jqXHR, textStatus, errorThrown) {
														$('#teamMessageDiv').append('<div class="alert alert-danger" role="alert"><strong>Error : ' + errorThrown + ' </strong></div>');
													}											
												});
										 });
										 
										 $('#buildTeamButton').on('click', function(e) {
											 e.preventDefault(); 
											 $('#buildTeamMessageDiv').html('');
											 var $btn = $(this).button('loading');
											 $.ajax({
													type: 'POST',
													url: 'buildteam',
													contentType: 'application/json; charset=utf-8',
													dataType: 'json',
													success: function(result) {
														setTimeout(function() {
															$btn.button('reset');
															$('#buildTeamMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Updated!!!</strong></div>');
														}, 30000);
													},error:function(jqXHR, textStatus, errorThrown) {
														$btn.button('reset');
														$('#buildTeamMessageDiv').append('<div class="alert alert-danger" role="alert"><strong>Error : ' + errorThrown + ' </strong></div>');
													}											
												});
										 });
										 
										 $("#buildTeamButton").prop("disabled", true);
										 
									});
								</script>
							</div>
						</div>
					</div>	
			</div>
			<hr>
			<div class="row">	
				<div class="col-sm-3 col-xs-offset-1">
					<div class="row">
						<h2><span class="label label-info">User Registration</span></h2>
					</div>
					<br>
					<form role="form">
						<h4><small>Use this section to start/stop new user registration. (enables/disables 'Create User button' on the sign up screen)</small></h4>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><input id="startRegistrationButton" type="submit" name="TRUE" value="Start" class="btn btn-success btn-lg btn-block"></div>
							<div class="col-xs-12 col-md-6"><input id="stopRegistrationButton" type="submit" name="FALSE" value="Stop" class="btn btn-success btn-lg btn-block"></div>
						</div>
					</form>	
					<br>
					<div class="row" id="registrationMessageDiv">
						
					</div>				
				</div>
				<div class="col-sm-3">
					<div class="row">
						<h2><span class="label label-info">Rating other players</span></h2>
					</div>
					<br>
					<form role="form">
						<h4><small>Use this section to start/stop player ratings (enables/disables 'Rate Players' button on the user screen)</small></h4>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><input id="startPlayerRatingButton" type="submit" name="TRUE" value="Start" class="btn btn-success btn-lg btn-block"></div>
							<div class="col-xs-12 col-md-6"><input id="stopPlayerRatingButton" type="submit" name="FALSE" value="Stop" class="btn btn-success btn-lg btn-block"></div>
						</div>
					</form>
					<br>
					<div class="row" id="ratingsMessageDiv">
						
					</div>		
				</div>
				<div class="col-sm-3">
					<div class="row">
						<h2><span class="label label-info">Team name update</span></h2>
					</div>
					<br>
					<form role="form">
						<h4><small>Use this section to start/stop team name updates (enables/disables 'Update Team Name' button on the user screen)</small></h4>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><input id="startTeamNameUpdatesButton" type="submit" name="TRUE" value="Start" class="btn btn-success btn-lg btn-block"></div>
							<div class="col-xs-12 col-md-6"><input id="stopTeamNameUpdatesButton" type="submit" name="FALSE" value="Stop" class="btn btn-success btn-lg btn-block"></div>
						</div>
					</form>
					<br>
					<div class="row" id="teamMessageDiv">
						
					</div>				
				</div>
			</div>
			<hr>
			<div class="row">	
				<div class="col-sm-3 col-xs-offset-1">
					<div class="row">
						<h2><span class="label label-info">Build Teams</span></h2>
					</div>
					<br>
					<form role="form">
						<h4><small>Use this section to trigger team selection</small></h4>
						<br>
						<div class="row">
							<div class="col-xs-12 col-md-6"><button id="buildTeamButton" type="submit" class="btn btn-success btn-lg btn-block" data-loading-text="Drawing...   ">Draw Teams</button></div>
						</div>
					</form>
					<br>
					<div class="row" id="buildTeamMessageDiv">
						
					</div>
				</div>
			</div>
        </div>
		<hr>
		<footer class="pull-right">
			<p style="margin-top: 4px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>