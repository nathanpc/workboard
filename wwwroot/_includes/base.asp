<%
''' base.asp
''' The base module that every page should include. This contains a bunch of
''' auxiliary functions that are used throughout the application.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Option Explicit

' Private variables.
Private m_strArticleTitle

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
