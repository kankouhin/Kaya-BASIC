Option Explicit

Using ComObject

Sub Main
	Dim app As ComObject
	app.GetObject("Excel.Application")

	Dim s As String = app.Workbooks(1).Worksheets(1).Name
	Print s
End Sub

