Option Explicit

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
		Print s
	Next
	
	For each Xls2 As comobject in Xlb.WorkSheets
		Dim s As String = Xls2.Name
		Print s
	Next

	xlapp.DisplayAlerts = FALSE
	Sleep 5

	xlapp.quit

End Sub