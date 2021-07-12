<!-- #include virtual="/_includes/classes/workspace.class.asp" -->
<%
''' workboard.asp
''' Manages all of the operations with the WorkBoard database.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

' Gets all of the available workspaces.
Public Function GetWorkspaces()
	Dim objConn
	Dim objRecordSet
	Dim idxWorkspace
	Dim a_objWorkspaces()
	
	' Establish connection to the database.
	Set objConn = OpenDatabaseConnection
	
	' Query the database.
	idxWorkspace = 0
	Set objRecordSet = objConn.Execute("SELECT workspace_id FROM workspaces " & _
		"ORDER BY name ASC")
	ReDim Preserve a_objWorkspaces(objRecordSet.RecordCount - 1)
	While Not objRecordSet.EOF
		Set a_objWorkspaces(idxWorkspace) = New Workspace
		a_objWorkspaces(idxWorkspace).PopulateFromID(objRecordSet("workspace_id"))
		
		idxWorkspace = idxWorkspace + 1
		objRecordSet.MoveNext
	Wend
	
	' Clean up.
	objRecordSet.Close
	Set objRecordSet = Nothing
	objConn.Close
	
	' Send the array back.
	GetWorkspaces = a_objWorkspaces
End Function
%>
