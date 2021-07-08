<!-- #include virtual="/_includes/base.asp" -->
<%
''' Workspace.asp
''' Page that displays everything related to a selected workspace.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Private variables.
Dim intWorkspaceID
Dim strWorkspaceName

' Check if we actually have a workspace name to work with.
strWorkspaceName = Request.QueryString("name")
If strWorkspaceName = vbNullString Then
	' Display the proper error.
	Response.Status = "400 Bad Request"
	Response.End
End If

' Get workspace ID and set the article title.
intWorkspaceID = GetWorkspaceIDFromName(strWorkspaceName)
SetArticleTitle strWorkspaceName
%>

<!-- #include virtual="/_includes/templates/header.asp" -->

<% If Not IsWorkspaceIDValid(intWorkspaceID) Then %>
	<!-- Workspace wasn't found. -->
	<% Response.Status = "404 Not Found" %>
	<p>I was <b>unable to find any workspace with this name</b>, so I'm assuming
	this workspace hasn't been created yet, but you can create it if you so
	desire.</p>
	
	<p>
		<form method="post" action="/Workspace.asp" id="newws" name="newws">
			<input type="hidden" name="action" value="newws" />
			<label for="wsname">New Workspace:</label>
			<input type="text" id="wsname" name="wsname"
				value="<%= strWorkspaceName %>" />
			<input type="submit" value="Submit" />
		</form>
	</p>
<% Else %>
	<!-- Posts -->
	<% Dim objPost %>
	<% For Each objPost In GetPostsByWorkspaceID(intWorkspaceID) %>
		<!-- Post #<%= objPost.ID %> -->
		<div class="post" id="post<%= objPost.ID %>">
			<div class="content">
				<%= objPost.Content %>
			</div>
			<div class="info">
				<p>
					<a href="#post<%= objPost.ID %>">
						<%= objPost.CreatedDate %>
					</a>
				</p>
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
<% End If %>

<!-- #include virtual="/_includes/templates/footer.asp" -->