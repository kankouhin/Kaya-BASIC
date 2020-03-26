Option Explicit

Using MsgBoxDoEvents
Dim f As wxFrame Ptr

Function getExpresion( texto As String, Exp As String ) As String
	Dim result As String
	Dim expresion As wxRegEx ( exp, wxRE_ADVANCED Or wxRE_ICASE )
	
	If  expresion.IsValid() Then      
		If  expresion.Matches( texto ) Then	
		    result = expresion.GetMatch( texto, 1 )
		End If 
	End If 
	
	Return result
End Function 

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	Dim htmldata As String = "<link rel=\"stylesheet\" href=\"/load.php\"/>"
	Dim ret As String
	
	ret = getExpresion( htmldata, "(?w)href=\"([^\"]*)" )
	MsgBox ret
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "RegEx Sample" )
	f.SetClientSize(wxSize(300,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
	Dim btnTest As New wxButton(p, 100, "test", wxPoint(100,20))
	btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	f.Show(TRUE)
End Sub

