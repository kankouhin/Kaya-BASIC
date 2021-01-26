Option Explicit

Sub Main
	'String
	Dim eachs As String = "Hello KayaBASIC"
	
	For Each s As Char in eachs
		Print s
	Next
	
	For Each idx As Integer, s As Char in eachs
		Print idx , " : ", s
	Next

	'Array
	Dim ar() As String
	
	ReDim ar(10)
	For idx As Integer = 0 To Ubound(ar)
		ar(idx) = "Item" + Str(idx)
	Next

	For Each s As String in ar
		Print "> ", s
	Next

	For Each idx As Integer, s As String in ar
		Print "> ", idx, " : ", s
	Next
	
	
	'Collection
	Dim col As String Collection
	
	col.Add("abc")
	col.Add("KayaBASIC")
	col.Add("123")
	col.Add("qwe")
	col.Add("asd")
	
	col.remove(0)
	col.removeitem( "asd" )
	
	col.Insert( "Insert", 1 )
	
	For Each s As String in col
		Print "> ", s
	Next

	For Each s As String Byref in col
		Print "> ", s
	Next

	For Each idx As Integer, s As String in col
		Print "> ", idx, " : ", s
	Next

	For Each idx As Integer, s As String Byref in col
		Print "> ", idx, " : ", s
	Next
	
	'Dictionary
	Dim dict As Integer Dictionary
	dict("abc") = 1
	dict("abc")++
	
	dict("KayaBASIC") = 99
	dict("123") = 100
	dict("qwe") = 200
	dict("asd") = 300
	
	dict.remove( "123" )
	dict.removeitem( 300 )
	
	
	Dim key As String
	Dim value As Integer
	For Each key, value in dict
		Print key , " : ", value
	Next
	
	Print "Contains ", dict.Contains("KayaBASIC")
	
	For Each key1 As String, value in dict
		Print key1 , " : ", value
	Next
	
	For Each key1 As String, value1 As Integer in dict
		Print key1 , " : ", value1
	Next
	
	For Each key1 As String, value1 As Integer Byref in dict
		Print key1 , " : ", value1
		value1++
	Next

	print "--------------------after ++"
	For Each key1 As String, value1 As Integer Byref in dict
		Print key1 , " : ", value1
	Next
	print "-----------------------------"

	For Each key1 As String,, in dict
		Print key1
	Next
	
	For Each ,, value1 As Integer Byref in dict
		Print value1
	Next
	
	For Each key,, in dict
		Print key
	Next
	
	For Each ,, value in dict
		Print value
	Next
End Sub
