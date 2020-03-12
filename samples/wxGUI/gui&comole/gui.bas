Option Explicit

Dim f As wxFrame Ptr
Dim listctrl As wxListCtrl Ptr

Sub LoadDataFromExcel
	
	Dim xlApp, xb, xls As ComObject
	Dim path As String
	
	path = wxGetCwd()
	path += "\data.xlsx"
	
	xlApp.CreateObject("Excel.Application")
	Set xb = xlApp.WorkBooks.Open( path )
	Set xls = xb.WorkSheets(1)
	
	For i As Integer = 1 To 4
		Dim s As String = xls.Cells(1, i).Value
		listctrl.InsertColumn( i - 1, s )
	Next
	
	For r As Integer = 2 To 5
		Dim s As String = xls.Cells(r, 1).Value
		listctrl.InsertItem( r - 2 , s )
		For c As Integer = 2 To 4
			s = xls.Cells(r, c).Value
			listctrl.SetItem( r - 2, c - 1, s )
		Next
	Next
	
	xb.Close
	xlApp.Quit
End Sub

Sub Main
	Dim strTitle As String = "listctrl"
	f = New wxFrame( NULL, wxID_ANY, strTitle )
	listctrl = New wxListCtrl( f, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxLC_REPORT )
	
	Call LoadDataFromExcel
	
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub