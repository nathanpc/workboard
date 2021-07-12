<%
''' base.asp
''' The base module that every page should include. This contains a bunch of
''' auxiliary functions that are used throughout the application.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Option Explicit

' ADO constant definitions.
Public Const adParamInput = 1
Public Const adInteger = 3
Public Const adDBTimeStamp = 135
Public Const adVarChar = 200

' Private variables.
Private m_strArticleTitle

' Opens a connection with the database.
Public Function OpenDatabaseConnection()
	Dim objConn
	
	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.ConnectionString = Application("ConnectionString")
	objConn.Open
	
	Set OpenDatabaseConnection = objConn
End Function

' Counts the number of records in an ADO RecordSet.
Public Function CountRowsInRecordSet(adoRecordSet)
	Dim intCount
	intCount = 0
	
	' Go through RecordSet.
	While Not adoRecordSet.EOF
		intCount = intCount + 1
		adoRecordSet.MoveNext
	Wend
	
	' Rewind RecordSet pointer and return results.
	adoRecordSet.MoveFirst
	CountRowsInRecordSet = intCount
End Function

' Sets the article title for a page.
Public Sub SetArticleTitle(strTitle)
	m_strArticleTitle = strTitle
End Sub

' Gets the title of the current article.
Public Function ArticleTitle()
	' Check if we don't have an article title set.
	If m_strArticleTitle = vbNullString Then
		ArticleTitle = Application("ApplicationName")
		Exit Function
	End If
	
	' Use the set article title.
	ArticleTitle = m_strArticleTitle
End Function

' Builds the page title string.
Public Function PageTitle()
	PageTitle = Application("ApplicationName")
	
	' Check if we are in an article.
	If ArticleTitle() <> PageTitle Then
		PageTitle = ArticleTitle() & " - " & PageTitle
	End If
End Function

' Gets the current requested URL with its query string.
Public Function GetURLWithQueryString()
	' Get the base URL.
	GetURLWithQueryString = Request.ServerVariables("URL")
	
	' Get the query string if we have any.
	If Request.ServerVariables("QUERY_STRING") <> vbNullString Then
		GetURLWithQueryString = GetURLWithQueryString & "?" & _
			Request.ServerVariables("QUERY_STRING")
	End If
End Function

' Displays a list of the request server variables.
Public Sub ListServerVariables()
	Dim strKey
	
	' List request variables.
	Response.Write "<ul>"
	For Each strKey In Request.ServerVariables
		Response.Write "<li>" & strKey & " = " & _
			Request.ServerVariables(strKey) & "</li>"
	Next
	Response.Write "</ul>"
End Sub
%>

<!-- #include virtual="/_includes/workboard.asp" -->
