<!-- #include virtual="/_includes/classes/post.class.asp" -->
<%
''' workspace.class.asp
''' A WorkBoard workspace abstraction class.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Class Workspace
	Private intID
	Private strName
	Private dtCreated
	
	' Object constructor.
	Private Sub Class_Initialize()
		ID = -1
		CreatedDate = Now()
	End Sub
	
	' Populates this class from a workspace ID.
	Public Sub PopulateFromID(intWorkspaceID)
		ID = intWorkspaceID
		' TODO: Get data from database.
	End Sub
	
	' Populates this class from a workspace name.
	Public Sub PopulateFromName(strWorkspaceName)
		Title = strWorkspaceName
		
		' Check for absent name.
		If Title = vbNullString Then
			ID = -1
			Exit Sub
		End If
		
		' TODO: Get data from database.
		ID = 0
	End Sub
	
	' Saves the data from this object to the database.
	Public Sub Commit()
		If Not Exists Then
			' TODO: Create the new entry in the database.
			ID = 123
		End If
		
		' TODO: Update the entry in the database.
	End Sub
	
	' Get posts for this workspace.
	Public Function GetPosts()
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
		
		GetPosts = a_objPosts
	End Function

	' Checks if this workspace exists.
	Public Function Exists()
		Exists = (ID >= 0)
	End Function
	
	Public Property Get ID()
		ID = intID
	End Property
	
	Private Property Let ID(pintID)
		intID = pintID
	End Property
	
	Public Property Get Title()
		Title = strName
	End Property
	
	Public Property Let Title(strTitle)
		strName = strTitle
	End Property
	
	Public Property Get CreatedDate()
		CreatedDate = dtCreated
	End Property
	
	Public Property Let CreatedDate(pdtCreated)
		dtCreated = pdtCreated
	End Property
End Class
%>
