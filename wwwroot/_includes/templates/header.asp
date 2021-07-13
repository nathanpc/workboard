<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><%= PageTitle() %></title>
		<meta name="author" content="Nathan Campos">
		<meta name="description"
			content="A bulletin board system for brainstorming your personal projects">
		
		<link rel="icon" href="/favicon.ico">
		<link rel="stylesheet" href="/assets/css/default.css">
		<script type="text/javascript" src="/assets/js/default.js"></script>
	</head>
	<body>
		<!-- Header -->
		<div id="header">
				<h1>
					<a href="/" class="no-link-highlight">
						<img src="/assets/image/desktop.bmp"
							alt="<%= Application("ApplicationName") %>" />
					</a>
					<a href="<%= GetURLWithQueryString() %>">
						<%= ArticleTitle() %>
					</a>
				</h1>
		</div>

		<!-- Main Content Area -->
		<div id="main">