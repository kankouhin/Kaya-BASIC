Option Explicit

Sub Main
	For idx As Integer = 1 To 5
		Print idx
	Next

	Print ""
	For idx As Integer = 1 To 5 Step 2 ' only support +-*/
		Print idx
	Next

	Print ""
	For idx As Integer = 5 To 1 Step -1
		Print idx
	Next
	
	Print ""	
	For idx As Integer = 5 To 1 Step -2
		Print idx
	Next
	
	Print ""
	For idx As Single = 1 To 10 Step *2
		Print idx
	Next
	
	Print ""	
	For idx As Single = 10 To 1 Step /2
		Print idx
	Next
	
	Print ""	
	For idx As Single = 1 To 10 Step /0.5
		Print idx
	Next
	
	Print ""	
	For idx As Single = 10 To 1 Step *0.5
		Print idx
	Next
End Sub
