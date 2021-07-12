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
		Dim objConn
		Dim objCommand
		Dim objRecordSet
	
		' Establish connection to the database and set things up.
		Set objConn = OpenDatabaseConnection
		Set objCommand = Server.CreateObject("ADODB.Command")
		objCommand.ActiveConnection = objConn
		
		' Prepate the statement and execute it.
		objCommand.CommandText = "SELECT * FROM workspaces WHERE workspace_id = ?"
		objCommand.Parameters.Append objCommand.CreateParameter("workspace_id", _
			adInteger, adParamInput, , intWorkspaceID)
		Set objRecordSet = objCommand.Execute
		
		If Not objRecordSet.EOF Then
			' Got something!
			ID = intWorkspaceID
			Title = objRecordSet("name")
			CreatedDate = objRecordSet("dt")
		Else
			' Well, looks like this ID doesn't exist.
			ID = -1
		End If
		
		' Clean up.
		objRecordSet.Close
		Set objRecordSet = Nothing
		Set objCommand = Nothing
		objConn.Close
	End Sub
	
	' Populates this class from a workspace name.
	Public Sub PopulateFromName(strWorkspaceName)
		Dim objConn
		Dim objCommand
		Dim objRecordSet
		
		' Check for absent name.
		Title = strWorkspaceName
		If Title = vbNullString Then
			ID = -1
			Exit Sub
		End If
	
		' Establish connection to the database and set things up.
		Set objConn = OpenDatabaseConnection
		Set objCommand = Server.CreateObject("ADODB.Command")
		objCommand.ActiveConnection = objConn
		
		' Prepate the statement and execute it.
		objCommand.CommandText = "SELECT * FROM workspaces WHERE name = ?"
		objCommand.Parameters.Append objCommand.CreateParameter("name", adVarChar, _
			adParamInput, 50, Title)
		Set objRecordSet = objCommand.Execute
		
		' Names are unique so we can just check for a single record.
		If Not objRecordSet.EOF Then
			' Got something!
			ID = objRecordSet("workspace_id")
			CreatedDate = objRecordSet("dt")
		Else
			' Well, looks like this name doesn't exist.
			ID = -1
		End If
		
		' Clean up.
		objRecordSet.Close
		Set objRecordSet = Nothing
		Set objCommand = Nothing
		objConn.Close
	End Sub
	
	' Saves the data from this object to the database.
	Public Sub Commit()
		Dim objConn
		Dim objCommand
		Dim objRecordSet
	
		' Establish connection to the database and set things up.
		Set objConn = OpenDatabaseConnection
		Set objCommand = Server.CreateObject("ADODB.Command")
		objCommand.ActiveConnection = objConn
		
		' Check if we are creating a new entry.
		If Not Exists Then
			' Create the new entry in the database.
			objCommand.CommandText = "INSERT INTO workspaces (name, dt) " & _
				"VALUES (?, ?)"
		Else
			' Update an entry in the database.
			objCommand.CommandText = "UPDATE workspaces SET name = ?, dt = ? " & _
				"WHERE workspace_id = ?"
			objCommand.Parameters.Append objCommand.CreateParameter("workspace_id", _
				adInteger, adParamInput, , ID)
		End If
		
		' Append common parameters and execute the statement.
		objCommand.Parameters.Append objCommand.CreateParameter("name", adVarChar, _
			adParamInput, 50, Title)
		objCommand.Parameters.Append objCommand.CreateParameter("dt", _
			adDBTimeStamp, adParamInput, , CreatedDate)
		objCommand.Execute
		
		' Get the inserted ID in case of a new entry.
		If Not Exists Then
			Set objRecordSet = objConn.Execute("SELECT @@IDENTITY")
			If Not objRecordSet.EOF Then
				ID = objRecordSet(0)
			End If
			
			' Clean up.
			objRecordSet.Close
			Set objRecordSet = Nothing
		End If
	
		' Clean up.
		Set objCommand = Nothing
		objConn.Close
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
