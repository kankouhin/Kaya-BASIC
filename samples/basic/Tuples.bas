Option Explicit

Function test(s As String, p As Integer) As [String, Integer]
	Return [ s, p ] 
End Function

Sub Main	
	Dim s As String
	Dim i As Integer
	
	[ s, i ] = test( "Kaya", 100)
	Print s
	Print i
	
	[ ,, i ] = test("Hello",200)
	Print i
	[ s,, ] = test("BASIC",300)
	Print s
End Sub


