Option Explicit

Using TuplesUsing

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
	
	Dim t As [String, Integer]
	t = test("Hello World",500)
	Print t(0), " ", t(1)
	
	t = test2("Hello World2",500)
	Print t(0), " ", t(1)	
	
	t = [ "KayaBASIC", 600 ]
	Print t(0), " ", t(1)
End Sub


