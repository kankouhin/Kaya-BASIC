Option Explicit
Option Console

Sub Main

	DIM Xlb, Xls, Rng ,xlapp As ComObject

	xlapp.CreateObject("Excel.Application")
	xlapp.Visible = TRUE

	Xlb = xlapp.Workbooks.Add
	Xls = Xlb.WorkSheets(1)

	with Xls.Cells(1, 1)
		.Value = "Name"
		
		with .Font
			.Bold = TRUE
			.ColorIndex = 2
		end with
		.Interior.ColorIndex = 30
		.Value = "Test value 1"
		.Value = "Test value 2"
		.Value = "Tets value 3"
		.Value = "Test value 4"
	end with
	
	Rng = Xls.Range("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	Rng.Interior.ColorIndex = 36
	Rng.EntireColumn.Autofit

	xlapp.DisplayAlerts = FALSE
	//msgbox "click to continue..."

	xlapp.quit



End Sub