Option Explicit

Sub Main

	Dim Xlb, Xls, Rng ,xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xls = Xlb.WorkSheets(1)

	' test with
	With Xls.Cells(1, 1)
		.Value = "Name"
		
		With .Font
			.Bold = TRUE
			.ColorIndex = 2
		End With
		.Interior.ColorIndex = 30
		.Value = "Test value 1"
		.Value = "Test value 2"
		.Value = "Tets value 3"
		.Value = "Test value 4"
	End With
	
	Rng = Xls.Range("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	Rng.Interior.ColorIndex = 36
	Rng.EntireColumn.Autofit

	xlapp.DisplayAlerts = FALSE
	Sleep 5

	xlapp.quit



End Sub