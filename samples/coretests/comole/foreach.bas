Option Explicit
Option Console

Sub Main

	DIM Xlb As ComObject, Xls AS ComObject, xlapp AS ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	Xlb.WorkSheets.Add
	
	for each Xls in Xlb.WorkSheets
		msgbox Xls.Name
	next
	
	for each Xls2 as comobject in Xlb.WorkSheets
		msgbox Xls2.Name
	next

	xlapp.DisplayAlerts = FALSE
	msgbox "click to continue..."

	xlapp.quit

End Sub