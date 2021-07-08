<%
''' post.class.asp
''' A WorkBoard post abstraction class.
'''
''' Author: Nathan Campos <nathan@innoveworkshop.com>

Class Post
	Private intID
	Private strContent
	Private dtCreated
	
	' Object constructor.
	Private Sub Class_Initialize()
		ID = -1
		CreatedDate = Now()
	End Sub
	
	' Populates this class from a Post ID.
	Public Sub PopulateFromID(intPostID)
		ID = intPostID
		' TODO: Get data from database.
	End Sub
	
	' Saves the data from this object to the database.
	Public Sub Commit()
		If Not Exists Then
			' TODO: Create the new entry in the database.
			ID = 123
		End If
		
		' TODO: Update the entry in the database.
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
End Class
%>
