Option Explicit

Dim f As wxFrame Ptr

Sub CreateJSONArray(ByRef root As wxJSONValue, numItems As Integer  )
	// items are in this format:
	//
	//	"index" : <number>,
	//	"name" : "item number <number>,
	//	"float" : <float>,
	//	"description" : "this is a description of the item"
	For i As Integer = 0 To numItems
		root.Item(i).Item( "index" ) = i
		Dim s As wxString
		s.Printf( "item number %d", i )
		root.Item(i).Item( "name" )  = s
		root.Item(i).Item( "float" ) = i
		root.Item(i).Item( "description" ) = "this is a description of the item"
	Next
End Sub

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	Dim root As wxJSONValue
	
	Call CreateJSONArray( root, 100 )
	
	Dim jsonText As wxString
	Dim writer As wxJSONWriter
	writer.Write( root, jsonText )

	Msgbox jsonText
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "Json Sample" )
	f.SetClientSize(wxSize(300,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
	Dim btnTest As New wxButton(p, 100, "test", wxPoint(100,20))
	btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )
    
	f.Show(TRUE)
End Sub

