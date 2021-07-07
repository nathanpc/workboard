<!-- #include virtual="/_includes/base.asp" -->
<% SetArticleTitle Request.QueryString("name") %>
<!-- #include virtual="/_includes/templates/header.asp" -->

<div class="post" id="post123">
	<div class="content">
		<p>This is the content of a post.</p>
		<p><% ListServerVariables() %></p>
	</div>
	<div class="info">
		<p><a href="#post123"><%= Now() %></a></p>
	</div>
</div>

<hr>

<!-- New Post Editor -->
<!-- #include virtual="/_includes/templates/tinymce.asp" -->
<div class="post">
	<form method="post" action="/Workspace.asp" id="newpost" name="newpost">
		<input type="hidden" name="action" value="newpost" />
		<textarea id="tinymce" name="content" rows="30"
			style="width: 100%"></textarea>
		<br>
		<div class="send">
			<input type="submit" value="Submit" />
		</div>
	</form>
</div>

<!-- #include virtual="/_includes/templates/footer.asp" -->