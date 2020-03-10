Option Explicit

Using MsgBoxDoEvents

Sub Main

	Dim Xlb As ComObject, Xls As ComObject, Rng As ComObject,xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xls = Xlb.WorkSheets(1)
	
	Dim sName As String
	sName = "Name"

	Dim s As String = CallByName(xls, "Name")
	Msgbox s
	s = CallByName(xls, sName)
	Msgbox s
	
	Rng = CallByName(xls, "Range")("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	Rng.Interior.ColorIndex = 36
	Rng.EntireColumn.Autofit

	xlapp.DisplayAlerts = FALSE
	Sleep 5

	xlapp.quit

End Sub