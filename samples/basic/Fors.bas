Option Explicit

Sub Main
	For idx As Integer = 1 To 5
		Print idx
	Next

	Print ""
	For idx As Integer = 1 To 5 Step 2 ' support + - * / << >>
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

	For idx As Single = -10 To -1 Step *0.5
		Print idx
	Next
	
	For Dim idx = 10 To 0 Step -2
		Print idx
	Next
	
	For idx As Integer = 128 To 1 Step >>1
		Print idx
	Next
	
	Const PI As Double = 3.1415926
	For Dim i = 0 To 2*PI Step (2*PI)/12 ' support expressions
		Print Cos(i), " ", Sin(i)
	Next
	
	Dim st = (2*PI)/12
	For Dim i = 0 To 2*PI Step st 
		Print i
	Next
End Sub
