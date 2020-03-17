Option Explicit

Using MsgBoxDoEvents

Dim f As wxFrame Ptr

Sub CreateJSONArray(ByRef root As wxJSONValue, numItems As Integer  )
	// items are in this format:
	//
	//	"index" : <number>,
	//	"name" : "item number <number>,
	//	"float" : <float>,
	//	"description" : "this is a description of the item"
	
	For i As Integer = 0 To numItems
		root.Item(i).Item(_T("index")) = i
		Dim s As wxString
		s.Printf( _T("item number %d"), i )
		root.Item(i).Item(_T("name"))  = s
		root.Item(i).Item(_T("float")) = i
		root.Item(i).Item(_T("description")) = _T("this is a description of the item")
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
    
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub

