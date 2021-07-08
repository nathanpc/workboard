<!-- #include virtual="/_includes/classes/post.class.asp" -->
<%
''' workboard.asp
''' Manages all of the operations with the WorkBoard database.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Gets all of the available workspaces.
Public Function GetWorkspaces()
	Dim a_strWorkspaces(2)
	
	' TODO: Get data from database.
	a_strWorkspaces(0) = "MintyCharger"
	a_strWorkspaces(1) = "HV PSU"
	a_strWorkspaces(2) = "Another thing"
	
	GetWorkspaces = a_strWorkspaces
End Function

' Gets the workspace ID from its name. -1 if one wasn't found.
Public Function GetWorkspaceIDFromName(strName)
	' Check for absent name.
	If strName = vbNullString Then
		GetWorkspaceIDFromName = -1
		Exit Function
	End If
	
	GetWorkspaceIDFromName = 0
End Function

' Get posts for a given workspace ID.
Public Function GetPostsByWorkspaceID(intWorkspaceID)
	Dim a_objPosts(1)
	
	' TODO: Get data from database.
	Set a_objPosts(0) = New Post
	a_objPosts(0).ID = 345
	a_objPosts(0).Content = "<p>Hello, <b>world</b>!</p>"
	a_objPosts(0).CreatedDate = Now()
	Set a_objPosts(1) = New Post
	a_objPosts(1).ID = 789
	a_objPosts(1).Content = "<p>Second Hello, <b>world</b>!</p>"
	a_objPosts(1).CreatedDate = Now()
	
	GetPostsByWorkspaceID = a_objPosts
End Function

' Checks if a workspace ID is actually valid.
Public Function IsWorkspaceIDValid(intID)
	IsWorkspaceIDValid = intID >= 0
End Function
%>
