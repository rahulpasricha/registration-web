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
        <link rel="stylesheet" type="text/css" href="resources/animate.css" />
        <link rel="icon" href="<c:url value="resources/favicon.ico"/>" type="image/x-icon" />
		<link rel="shortcut icon" href="<c:url value="resources/favicon.ico"/>" type="image/x-icon" />
		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!--[if lt IE 9]>
		  <script type='text/javascript' src="resources/respondjs/html5shiv.min.js"></script>
		  <script type='text/javascript' src="resources/respondjs/respond.min.js"></script>
		<![endif]-->
		
		<link rel='stylesheet' type='text/css' href='resources/respondjs/normalize.css' />
        <style type="text/css">
            div.jQBracket .team div.label {font-family: Arial;font-size: 10px;font-weight: bold;color:black;margin-top: 4px;margin-left: 6px;width: auto;}
            div.jQBracket .team {width: 110px;}
            .navbar-default {margin-bottom:0;background:#ffcc00;z-index:2;border-bottom: 0 none #d40511;box-shadow: 0 0 2px #d40511;}
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
			#imageDiv {
				margin-left:-30px;
			}
			.label-default {
			    background-color: #CDCEC6;
			    color: black;
			}
			.navbar > .container .navbar-brand, .navbar > .container-fluid .navbar-brand {
			    margin-left: -20px;
			    margin-top: -3px;
			}
			
			/* Carousel Styles */
			.carousel-control.left,
			.carousel-control.right {
				opacity: 0.5;
				filter: alpha(opacity=50);
				background-image: none;
				background-repeat: no-repeat;
				text-shadow: none;
				z-index: 1
			}
			
			.carousel-control {
			    width: 0;
			    z-index: 1
			}
			
			.carousel-indicators .active {
			    background-color: #D40511;
			    opacity:0.5;
			}
			
			.carousel-control.left span:hover,
			.carousel-control.right span:hover {
				opacity: .7;
			}
			
			.carousel-control .glyphicon-chevron-right, .carousel-control .icon-next {
			    margin-right: 4px;
			}
			
			.carousel-control .glyphicon-chevron-left, .carousel-control .icon-prev {
			    margin-left: 4px;
			}
			
			/* Carousel Header Styles */
			.header-text {
			    position: absolute;
			    top: 87%;
			    left: 74%;
			}
			
			.btn-min-block {
			    min-width: 250px;
			    line-height: 26px;
			    font-size: 21px;
			    opacity: 1;
			    -webkit-animation-duration: 1s;
			    -webkit-animation-delay: 1s;
			    -webkit-animation-iteration-count: 1;
			    
			    -ms-animation-duration: 1s;
			    -ms-animation-delay: 1;
			    -ms-animation-iteration-count: 1;
			    
			    -moz-animation-duration: 1s;
			    -moz-animation-delay: 1s;
			    -moz-animation-iteration-count: 1;
			}
			
        </style>
        
        <script>
			$(document).ready(function() {
				
					$('.carousel').carousel({
					  interval: 5000
					});
					
					$('.btn-min-block').addClass('animated bounceIn');
					
					//Handles menu drop down
					$('.dropdown-menu').find('form').click(function (e) {
						e.stopPropagation();
					});
					
					$.ajax({
						type: 'GET',
						url: 'getAllFoosballUsers.fd',
						contentType: 'application/json; charset=utf-8',
						dataType: 'json',
						success: function(result) {
							$('#playerMessageDiv').html('');
							var tableHtml = '<table class="table table-bordered table-striped table-hover"><th>Members</th><th>Department</th><th>NINJA TEAM</th><th>RSVP</th></tr></thead><tbody>';
							 $.each(result, function (index, value) {
								 tableHtml += '<tr><td>' + value.firstName + ' ' + value.lastName + '</td>';
								 tableHtml += '<td>' + value.department + '</td>';
								 tableHtml += '<td>' + '  ' + '</td>';
								 tableHtml += '<td>' + ' ' + '</td>';
								 tableHtml += '</tr>';
							 });
							 tableHtml += '</tbody></table>';
							 $(tableHtml).appendTo($('#listOfPlayers'));
							 
							 $('#playerMessageDiv').append('<div class="alert alert-info" role="alert"><strong>'+ result.length 
									 +' user(s) have registered.</strong> Click here to register <a href="signup">Register<a></div>');
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
							$('#playerMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
						}							
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
								<li class="active"><a href="home">Home</a></li>
								<li><a href="signup">Registration</a></li>
								<li><a href="resetpassword">Reset Password</a></li>
						   </ul>
					</nav>
				</div>
			</header>
			
			<div id="carousel-example" class="carousel slide" data-ride="carousel">
			  <ol class="carousel-indicators">
			    <li data-target="#carousel-example" data-slide-to="0" class="active"></li>
			    <li data-target="#carousel-example" data-slide-to="1"></li>
			    <li data-target="#carousel-example" data-slide-to="2"></li>
			    <li data-target="#carousel-example" data-slide-to="3"></li>
			    <li data-target="#carousel-example" data-slide-to="4"></li>
			    <li data-target="#carousel-example" data-slide-to="5"></li>
			    <li data-target="#carousel-example" data-slide-to="6"></li>
			    <li data-target="#carousel-example" data-slide-to="7"></li>
			    <li data-target="#carousel-example" data-slide-to="8"></li>
			    <li data-target="#carousel-example" data-slide-to="9"></li>
			    <li data-target="#carousel-example" data-slide-to="10"></li>
			    <li data-target="#carousel-example" data-slide-to="11"></li>
			    <li data-target="#carousel-example" data-slide-to="12"></li>
			    <li data-target="#carousel-example" data-slide-to="13"></li>
			  </ol>
			
			  <div class="carousel-inner">
			    <div class="item active">
			      <img src="resources/3.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			    <div class="item">
			      <img src="resources/2.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			    <div class="item">
			      <img src="resources/1.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/4.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/5.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/6.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/7.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/8.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/9.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/10.jpg" style="opacity:0.6;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/11.jpg" style="opacity:0.7;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/12.jpg" style="opacity:0.7;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			     <div class="item">
			      <img src="resources/13.jpg" style="opacity:0.7;"/>
			      <div class="header-text hidden-xs">
                        <div class="col-md-12 text-center">
                            <div class=""><a class="btn btn-danger btn-md btn-min-block" href="signup">Register Now !!!</a></div>
                        </div>
                   </div>
			    </div>
			  </div>
			
			  <a class="left carousel-control" href="#carousel-example" data-slide="prev">
			    <span class="glyphicon glyphicon-chevron-left"></span>
			  </a>
			  <a class="right carousel-control" href="#carousel-example" data-slide="next">
			    <span class="glyphicon glyphicon-chevron-right"></span>
			  </a>
			</div>
			
		</div>
		<br><br>
		<hr>
		<br><br>
        <div class="container well">
            <div class="row">
				<div class="col-sm-10 col-xs-offset-1">
					<div class="row">
						<h2><span class="label label-danger">Registered Members</span></h2>
					</div>
					<br>
					<div class="row" id="listOfPlayers">
					</div>
					<div class="row" id="playerMessageDiv">
					</div>
				</div>
			</div>
        </div>		
		<footer class="pull-right">
			<p style="margin-top: 20px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>