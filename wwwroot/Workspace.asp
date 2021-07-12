<!-- #include virtual="/_includes/base.asp" -->
<%
''' Workspace.asp
''' Page that displays everything related to a selected workspace.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Private variables.
Dim objWorkspace
Dim objPost

' Initialize workspace object and set the article title.
Set objWorkspace = New Workspace
objWorkspace.PopulateFromName Request.QueryString("name")
SetArticleTitle objWorkspace.Title

' Check if we are trying to operate on a workspace.
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
	If Request.Form("action") = "newws" Then
		' New workspace.
		objWorkspace.PopulateFromName Request.Form("wsname")
		
		' Check if workspace with this name already exists.
		If objWorkspace.Exists Then
			Response.Status = "400 Bad Request"
			Response.Write "<h1>A workspace with this name (" & _
				objWorkspace.Title & ") already exists.</h1>"
			Response.End
		End If
		
		' Create new workspace.
		objWorkspace.CreatedDate = Now()
		objWorkspace.Commit
	ElseIf Request.Form("action") = "newpost" Then
		' New post
		Set objPost = New Post
		
		' Check if the request was valid.
		If (Request.Form("content") = vbNullString) Or _	
				(Request.Form("workspaceid") = vbNullString) Then
			Response.Status = "400 Bad Request"
			Response.Write "<h1>No content or workspace ID for this new post " & _
				"was provided.</h1>"
			Response.End
		End If
		
		' Populate the post object with request data and save to the database.
		objPost.Content = Request.Form("content")
		objPost.WorkspaceID = CInt(Request.Form("workspaceid"))
		objPost.CreatedDate = Now()
		objPost.Commit
	ElseIf Request.Form("action") = "editpost" Then
		' New post
		Set objPost = New Post
		
		' Check if the request was valid.
		If (Request.Form("content") = vbNullString) Or _	
				(Request.Form("postid") = vbNullString) Then
			Response.Status = "400 Bad Request"
			Response.Write "<h1>No content or post ID for this new post was" & _
				"provided.</h1>"
			Response.End
		End If
		
		' Populate the post object with database and request data and save.
		objPost.PopulateFromID(CInt(Request.Form("postid")))
		objPost.Content = Request.Form("content")
		objPost.Commit
	Else
		' Invalid action or no action field was supplied.
		Response.Status = "400 Bad Request"
		Response.End
	End If
Else
	' Check if we actually have a workspace name to work with.
	If Request.QueryString("name") = vbNullString Then
		' Display the proper error.
		Response.Status = "400 Bad Request"
		Response.End
	End If
End If
%>

<!-- #include virtual="/_includes/templates/header.asp" -->

<% If Not objWorkspace.Exists Then %>
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
				value="<%= objWorkspace.Title %>" />
			<input type="submit" value="Submit" />
		</form>
	</p>
<% Else %>
	<!-- TinyMCE WYSIWYG Editor -->
	<!-- #include virtual="/_includes/templates/tinymce.asp" -->
	
	<!-- Posts -->
	<% For Each objPost In objWorkspace.GetPosts() %>
		<% Dim blnEditable %>
		<% blnEditable = (objPost.ID = CInt(Request.QueryString("edit"))) %>
		
		<!-- Post #<%= objPost.ID %> -->
		<div class="post" id="post<%= objPost.ID %>">
			<div class="content">
				<% If Not blnEditable Then %>
					<%= objPost.Content %>
				<% Else %>
					<!-- Post Editor -->
					<form method="post" id="editpost" name="editpost"
							action="/Workspace.asp?name=<%= Server.URLEncode(objWorkspace.Title) %>">
						<input type="hidden" name="action" value="editpost" />
						<input type="hidden" name="postid" value="<%= objPost.ID %>" />
						<textarea id="tinymce" name="content" rows="30"
							style="width: 100%"><%= objPost.Content %></textarea>
						<br>
						<div class="send">
							<input type="submit" value="Submit" />
						</div>
					</form>
				<% End If %>
			</div>
			<div class="info">
				<% If Not blnEditable Then %>
					<p>
						<a href="#post<%= objPost.ID %>">
							<%= objPost.CreatedDate %>
						</a>
						<a href="<%= GetURLWithQueryString() & "&edit=" & objPost.ID %>">
							<img class="edit" src="/assets/image/pencil.ico" />
						</a>
					</p>
				<% End If %>
			</div>
		</div>
		
		<hr>
	<% Next %>
	
	<!-- New Post Editor -->
	<div class="post">
		<form method="post" action="<%= GetURLWithQueryString() %>" id="newpost"
				name="newpost">
			<input type="hidden" name="action" value="newpost" />
			<input type="hidden" name="workspaceid"
				value="<%= objWorkspace.ID %>" />
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