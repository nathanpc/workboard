<!-- #include virtual="/_includes/base.asp" -->
<%
''' Workspace.asp
''' Page that displays everything related to a selected workspace.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Private variables.
Dim intWorkspaceID
Dim strWorkspaceName

' Get workspace ID and set the article title.
strWorkspaceName = Request.QueryString("name")
intWorkspaceID = GetWorkspaceIDFromName(strWorkspaceName)
SetArticleTitle strWorkspaceName

' Check if we are trying to operate on a workspace.
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
	If Request.Form("action") = "newws" Then
		' New workspace.
		strWorkspaceName = Request.Form("wsname")
		intWorkspaceID = GetWorkspaceIDFromName(strWorkspaceName)
		
		' Check if workspace with this name already exists.
		If IsWorkspaceIDValid(intWorkspaceID) Then
			Response.Status = "400 Bad Request"
			Response.Write "<h1>A workspace with this name (" & _
				strWorkspaceName & ") already exists.</h1>"
			Response.End
		End If
		
		' TODO: Create workspace in database.
		intWorkspaceID = 123
	ElseIf Request.Form("action") = "newpost" Then
	Else
		' Invalid action or no action field was supplied.
		Response.Status = "400 Bad Request"
		Response.End
	End If
End If

' Check if we actually have a workspace name to work with.
If strWorkspaceName = vbNullString Then
	' Display the proper error.
	Response.Status = "400 Bad Request"
	Response.End
End If
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