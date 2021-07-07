<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%= PageTitle() %></title>
		
		<link rel="stylesheet" href="/assets/css/default.css">
	</head>
	<body>
		<!-- Header -->
		<div id="header">
				<h1>
					<a href="/" class="no-link-highlight">
						<img src="/assets/image/desktop.bmp"
							alt="<%= Application("ApplicationName") %>" />
					</a>
					<a href="<%= Request.ServerVariables("URL") %>">
						<%= ArticleTitle() %>
					</a>
				</h1>
		</div>

		<!-- Main Content Area -->
		<div id="main">