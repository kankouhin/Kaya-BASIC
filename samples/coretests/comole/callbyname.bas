Option Explicit
Option Console

Sub Main

	DIM Xlb As ComObject, Xls AS ComObject, Rng AS ComObject,xlapp AS ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xls = Xlb.WorkSheets(1)
	
	dim sName as string
	sName = "Name"

	msgbox CallByName(xls, "Name")
	msgbox CallByName(xls, sName)
	
	Rng = CallByName(xls, "Range")("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	Rng.Interior.ColorIndex = 36
	Rng.EntireColumn.Autofit

	xlapp.DisplayAlerts = FALSE
	msgbox "click to continue..."

	xlapp.quit

End Sub