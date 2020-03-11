Option Explicit

Using MsgBoxDoEvents

Dim f As wxFrame Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)

	Dim Xlb, Xls, xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	
	For each Xls in Xlb.WorkSheets
		MsgBox Xls.Name
	Next
	
	For each Xls2 As comobject in Xlb.WorkSheets
		MsgBox Xls2.Name
	Next

	xlapp.DisplayAlerts = FALSE
	xlapp.Quit

End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "ComOle Samples" )
	f.SetClientSize(wxSize(300,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
    Dim btnTest As New wxButton(p, 100, "Test", wxPoint(100,20))
    btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )
    
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub