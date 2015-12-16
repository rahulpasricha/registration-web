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
		
		<link rel="stylesheet" href="resources/Gallery/css/blueimp-gallery.min.css" />
		<link rel="stylesheet" href="resources/Bootstrap-Image-Gallery/css/bootstrap-image-gallery.min.css" />
		
		<script src="resources/Gallery/js/jquery.blueimp-gallery.min.js"></script>
		<script src="resources/Bootstrap-Image-Gallery/js/bootstrap-image-gallery.min.js"></script>
		
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
			.blueimp-gallery .modal-dialog {
			    right: auto;
			    left: auto;
			    width: auto;
			    max-width: 1200px;
			}
			
			/* File upload button CSS */
			.fileUpload {
			    position: relative;
			    overflow: hidden;
			    margin: 10px;
			}
			.fileUpload input.browse {
			    position: absolute;
			    top: 0;
			    right: 0;
			    margin: 0;
			    padding: 0;
			    font-size: 20px;
			    cursor: pointer;
			    opacity: 0;
			    filter: alpha(opacity=0);
			}
			
        </style>
        
        <script>
			$(document).ready(function() {
				
				$.ajax({
					type: 'GET',
					url: 'getAllImages',
					cache: true,
					success: function(result) {
						$.each(result, function (index, value) {
							$('#links').append('<a href="' + value + '" title="Image 1" data-gallery><img src="' + value + '" alt="Image ' + (index + 1) + '" width="100" height="100"></a>');
						});
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
						$('#imageMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
					}							
			  	});
				
				$("#browseBtn").on('change', function() {
					$('#uploadFile').val(this.value);
				});
				
				$("#uploadButton").on("click", function(e) {
					e.preventDefault();
					$('#uploadImageMessageDiv').html('');
					var $btn = $(this).button('loading');
					var formData = new FormData($('#uploadForm')[0]);
					
					$.ajax({
					    url: "upload",
					    type: "POST",
					    dataType: 'text',
					    contentType: false,
					    data: formData,
					    processData: false,
					    success: function(response) {
					    	$('#uploadImageMessageDiv').append('<div class="alert alert-info" role="alert"><strong>Image uploaded successfully.</strong></div>');
					    	$btn.button('reset');
					    },
					    error: function(jqXHR, textStatus, errorThrown) {
					    	var errorFromServer;
							if(jqXHR.responseText !== ''){
								errorFromServer = jqXHR.responseText;
								if (errorFromServer.indexOf("<html>") >= 0) {
									errorFromServer = errorThrown;
								}
						    } else {
						    	errorFromServer = errorThrown;
						    }
							$('#uploadImageMessageDiv').append('<div class="alert alert-danger" role="alert">Failed : <strong>' + errorFromServer + '</strong></div>');
							$btn.button('reset');
					    }
					});
					
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
								<li><a href="resetpassword">Reset Password</a></li>
								<li class="active"><a href="gallery">Event Gallery</a></li>
						   </ul>
					</nav>
				</div>
			</header>
			
			
			<br><br>
			
			<!-- The Bootstrap Image Gallery lightbox, should be a child element of the document body -->
			<div id="blueimp-gallery" class="blueimp-gallery">
			    <!-- The container for the modal slides -->
			    <div class="slides"></div>
			    <!-- Controls for the borderless lightbox -->
			    <h3 class="title"></h3>
			    <a class="prev"></a>
			    <a class="next"></a>
			    <a class="close"></a>
			    <a class="play-pause"></a>
			    <ol class="indicator"></ol>
			    <!-- The modal dialog, which will be used to wrap the lightbox content -->
			    <div class="modal fade">
			        <div class="modal-dialog">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" aria-hidden="true">&times;</button>
			                    <h4 class="modal-title"></h4>
			                </div>
			                <div class="modal-body next"></div>
			                <div class="modal-footer">
			                    <button type="button" class="btn btn-default pull-left prev">
			                        <i class="glyphicon glyphicon-chevron-left"></i>
			                        Previous
			                    </button>
			                    <button type="button" class="btn btn-primary next">
			                        Next
			                        <i class="glyphicon glyphicon-chevron-right"></i>
			                    </button>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			
			<h1>Event Gallery</h1>
			
			<div id="links">
			    <!-- <a href="resources/gallery1.jpg" title="Image 1" data-gallery><img src="resources/gallery1.jpg" alt="Image 1" width="100" height="100"></a>
			    <a href="resources/gallery2.jpg" title="Image 2" data-gallery><img src="resources/gallery2.jpg" alt="Image 2" width="100" height="100"></a>
			    <a href="resources/gallery3.jpg" title="Image 3" data-gallery><img src="resources/gallery3.jpg" alt="Image 3" width="100" height="100"></a>-->
			</div>
			
			<hr>
			
		</div>
		
		<div class="container">
			<form id="uploadForm" class="form-inline">
				<div class="form-group">
					<input id="uploadFile" placeholder="Choose an image" disabled="disabled" class="form-control input-md" size="50"/>
					<div class="fileUpload btn btn-primary">
					    <span>Browse</span>
					    <input id="browseBtn" type="file" class="browse" name="myimage" id="imageid"/>
					</div>
					<button type="button" class="btn btn-success" id="uploadButton" data-loading-text="Uploading Image...">Upload</button>
				</div>
				<br><br>
				<div class="form-group" id="uploadImageMessageDiv"></div>
			</form>
		</div>
					
		<footer class="pull-right">
			<p style="margin-top: 20px;margin-right:20px;color: lightgrey;font-size:11px">&copy; Development Team</p>
		</footer>
    </body>
</html>