Option Explicit

Using MsgBoxDoEvents

Sub Main

	Dim Xlb As ComObject, Xls As ComObject, xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	
	For each Xls in Xlb.WorkSheets
		Dim s As String = Xls.Name
		MsgBox s
	Next
	
	For each Xls2 As comobject in Xlb.WorkSheets
		Dim s As String = Xls2.Name
		MsgBox s
	Next

	xlapp.DisplayAlerts = FALSE
	Msgbox "Click to continue..."

	xlapp.quit

End Sub