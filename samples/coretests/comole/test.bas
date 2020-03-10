Option Explicit

Using MsgBoxDoEvents

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
		
		Dim v As String = "Test value 4"
		.Value = @v
		MsgBox .Value
	End With
	
	Rng = Xls.Range("A1:A5")
	Rng.Font.Size = 14

	Rng = Xls.Range("A2:A5")
	
	Dim clr As Integer = 36
	Rng.Interior.ColorIndex = clr
	Rng.EntireColumn.Autofit

	xlapp.DisplayAlerts = FALSE
	Msgbox "Click to continue..."

	xlapp.Quit

End Sub