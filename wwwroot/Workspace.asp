<!-- #include virtual="/_includes/base.asp" -->
<%
''' Workspace.asp
''' Page that displays everything related to a selected workspace.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Dim intWorkspaceID
intWorkspaceID = GetWorkspaceIDFromName(Request.QueryString("name"))

SetArticleTitle Request.QueryString("name")

' TODO: Detect if we actually have a workspace.
%>

<!-- #include virtual="/_includes/templates/header.asp" -->

<!-- Posts -->
<% Dim objPost %>
<% For Each objPost In GetPostsByWorkspaceID(intWorkspaceID) %>
	<div class="post" id="post<%= objPost.ID %>">
		<div class="content">
			<%= objPost.Content %>
		</div>
		<div class="info">
			<p><a href="#post<%= objPost.ID %>"><%= objPost.CreatedDate %></a></p>
		</div>
	</div>
	
	<hr>
<% Next %>

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