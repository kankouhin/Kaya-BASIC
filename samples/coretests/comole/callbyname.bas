Option Explicit

Using wxWidgets
Using ComObject

Dim f As wxFrame Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)

	Dim Xlb, Xls, Rng, xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xls = Xlb.WorkSheets(1)
	
 	Dim sName As String = "Name"

	MsgBox CallByName(xls, "Name")
	MsgBox CallByName(xls, sName)
	
	Rng = CallByName(xls, "Range")("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	Rng.Interior.ColorIndex = 36
	Rng.EntireColumn.Autofit

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
