<!-- #include virtual="/_includes/base.asp" -->
<%
''' Workspace.asp
''' Page that displays everything related to a selected workspace.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Private variables.
Dim objWorkspace
Dim objPost

' Initialize workspace object.
Set objWorkspace = New Workspace

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
		
		' Populate the workspace object.
		objWorkspace.PopulateFromID Request.Form("workspaceid")
		
		' Populate the post object with request data and save to the database.
		objPost.Content = Request.Form("content")
		objPost.WorkspaceID = CInt(Request.Form("workspaceid"))
		objPost.CreatedDate = Now()
		objPost.Commit
		
		' Redirect to highlight the new post.
		Response.Redirect "/Workspace.asp?name=" & Server.URLEncode(objWorkspace.Title) & _
			"#post" & objPost.ID
	ElseIf Request.Form("action") = "editpost" Then
		' New post
		Set objPost = New Post
		
		' Check if the request was valid.
		If (Request.Form("content") = vbNullString) Or _	
				(Request.Form("postid") = vbNullString) Or _
				(Request.Form("workspaceid") = vbNullString) Then
			Response.Status = "400 Bad Request"
			Response.Write "<h1>No content or post ID or workspace ID for this " & _
				"new post was provided.</h1>"
			Response.End
		End If
		
		' Populate the workspace object.
		objWorkspace.PopulateFromID Request.Form("workspaceid")
		
		' Populate the post object with database and request data and save.
		objPost.PopulateFromID CInt(Request.Form("postid"))
		objPost.Content = Request.Form("content")
		objPost.Commit
		
		' Redirect to highlight the new post.
		Response.Redirect "/Workspace.asp?name=" & Server.URLEncode(objWorkspace.Title) & _
			"#post" & objPost.ID
	Else
		' Invalid action or no action field was supplied.
		Response.Status = "400 Bad Request"
		Response.End
	End If
	
	' Make sure we have a fully populated workspace object.
	If Not objWorkspace.Exists Then
		objWorkspace.PopulateFromID Request.Form("workspaceid")
	End If
Else
	Dim strWorkspaceName
	
	' Check if we need to delete a post.
	If Request.QueryString("delete") <> vbNullString Then
		Dim objDelPost
		
		' Get the post to be deleted.
		Set objDelPost = New Post
		objDelPost.PopulateFromID Request.QueryString("delete")
		
		' Actually delete the post and clean things up.
		objDelPost.Trash
		Set objDelPost = Nothing
		
		' Redirect to the page without the delete parameter.
		If Request.QueryString("name") = vbNullString Then
			Response.Redirect "/"
		Else
			Response.Redirect "/Workspace.asp?name=" & Request.QueryString("name")
		End If
	End If
	
	' Check if we actually have a workspace name to work with.
	If Request.QueryString("name") = vbNullString Then
		' Display the proper error.
		Response.Status = "400 Bad Request"
		Response.End
	End If
	
	' Sanitize the workspace name since IE doesn't like URL parameters and ID references.
	strWorkspaceName = Request.QueryString("name")
	If InStr(strWorkspaceName, "#post") > 0 Then
		strWorkspaceName = Left(strWorkspaceName, InStr(strWorkspaceName, "#post") - 1)
	End If
	
	' Populate the workspace object.
	objWorkspace.PopulateFromName strWorkspaceName
End If

' Set the article title.
SetArticleTitle objWorkspace.Title
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
							action="/Workspace.asp">
						<input type="hidden" name="action" value="editpost" />
						<input type="hidden" name="postid" value="<%= objPost.ID %>" />
						<input type="hidden" name="workspaceid" value="<%= objWorkspace.ID %>" />
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
						<a class="icon" href="<%= GetURLWithQueryString() & "&edit=" & objPost.ID %>">
							<img alt="Edit" src="/assets/image/pencil.bmp" />
						</a>
						<a class="icon" href="javascript:deletePost(<%= objPost.ID %>)">
							<img alt="Delete" src="/assets/image/trash.bmp" />
						</a>
					</p>
				<% End If %>
			</div>
		</div>
		
		<hr>
	<% Next %>
	
	<!-- New Post Editor -->
	<div class="post">
		<form method="post" action="/Workspace.asp" id="newpost"
				name="newpost">
			<input type="hidden" name="action" value="newpost" />
			<input type="hidden" name="workspaceid" value="<%= objWorkspace.ID %>" />
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