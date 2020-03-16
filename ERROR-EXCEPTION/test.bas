Option Explicit

Using MsgBoxDoEvents

Dim f As wxFrame Ptr

Sub throwTest
	Throw "Exption from test function"
End Sub

Sub OnButtonClick(ByRef ev As wxCommandEvent)

	Try
		Call throwTest
	Catch msg As String
		Msgbox "Catched a exception: " + msg
	End Try

	Try
		Throw 100
	Catch msg As Integer
		Msgbox "Catched a exception: " + msg
	Catch msg As String
		Msgbox "Catched a exception: " + msg
	End Try
	
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "TryCatch Samples" )
	f.SetClientSize(wxSize(300,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
	Dim btnTest As New wxButton(p, 100, "Try Catch", wxPoint(100,20))
	btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )
    
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub

