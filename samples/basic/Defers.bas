Option Explicit

Sub Main
	Defer ( 
		Print "auto closed file1."
		If True Then ' Just for test
			Print "auto closed file2."
		End If
	)
	
	Print "defer sampleíÜçë"

	Open "Defers.txt" For Input As #1
	Defer Close #1
	
	Dim s As String
	While Not EOF( 1 )
		Line Input #1, s
		Print s
	Wend
End Sub
