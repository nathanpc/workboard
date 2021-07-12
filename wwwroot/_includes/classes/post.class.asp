<%
''' post.class.asp
''' A WorkBoard post abstraction class.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Class Post
	Private intID
	Private strContent
	Private dtCreated
	Private intWorkspaceID
	
	' Object constructor.
	Private Sub Class_Initialize()
		ID = -1
		CreatedDate = Now()
		WorkspaceID = Null
	End Sub
	
	' Populates this class from a Post ID.
	Public Sub PopulateFromID(intPostID)
		Dim objConn
		Dim objCommand
		Dim objRecordSet
	
		' Establish connection to the database and set things up.
		Set objConn = OpenDatabaseConnection
		Set objCommand = Server.CreateObject("ADODB.Command")
		objCommand.ActiveConnection = objConn
		
		' Prepate the statement and execute it.
		objCommand.CommandText = "SELECT * FROM posts WHERE post_id = ?"
		objCommand.Parameters.Append objCommand.CreateParameter("post_id", _
			adInteger, adParamInput, , intPostID)
		Set objRecordSet = objCommand.Execute
		
		If Not objRecordSet.EOF Then
			' Got something!
			ID = intPostID
			Content = objRecordSet("content")
			CreatedDate = objRecordSet("dt")
			WorkspaceID = objRecordSet("workspace_id")
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
			objCommand.CommandText = "INSERT INTO posts (content, dt, " & _
				"workspace_id) VALUES (?, ?, ?)"
		Else
			' Update an entry in the database.
			objCommand.CommandText = "UPDATE posts SET content = ?, dt = ?, " & _
				"workspace_id = ? WHERE post_id = ?"
			objCommand.Parameters.Append objCommand.CreateParameter("post_id", _
				adInteger, adParamInput, , ID)
		End If
		
		' Append common parameters and execute the statement.
		objCommand.Parameters.Append objCommand.CreateParameter("content", _
			adLongVarChar, adParamInput, Len(Content), Content)
		objCommand.Parameters.Append objCommand.CreateParameter("dt", _
			adDBTimeStamp, adParamInput, , CreatedDate)
		objCommand.Parameters.Append objCommand.CreateParameter("workspace_id", _
			adInteger, adParamInput, , WorkspaceID)
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

	' Checks if this workspace exists.
	Public Function Exists()
		Exists = (ID >= 0)
	End Function
	
	Public Property Get ID()
		ID = intID
	End Property
	
	Public Property Let ID(pintID)
		intID = pintID
	End Property
	
	Public Property Get Content()
		Content = strContent
	End Property
	
	Public Property Let Content(pstrContent)
		strContent = pstrContent
	End Property
	
	Public Property Get CreatedDate()
		CreatedDate = dtCreated
	End Property
	
	Public Property Let CreatedDate(pdtCreated)
		dtCreated = pdtCreated
	End Property
	
	Public Property Get WorkspaceID()
		WorkspaceID = intWorkspaceID
	End Property
	
	Public Property Let WorkspaceID(pintWorkspaceID)
		intWorkspaceID = pintWorkspaceID
	End Property
End Class
%>
