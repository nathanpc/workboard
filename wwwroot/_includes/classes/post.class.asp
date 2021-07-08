<%
''' post.class.asp
''' A WorkBoard post abstraction class.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Class Post
	Private intID
	Private strContent
	Private dtCreated
	
	' Populates this class from a Post ID.
	Public Sub PopulateFromID(intPostID)
		ID = intPostID
		' TODO: Get data from database.
	End Sub
	
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
End Class
%>
