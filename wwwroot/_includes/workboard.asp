<!-- #include virtual="/_includes/classes/workspace.class.asp" -->
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
%>
