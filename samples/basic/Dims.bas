Option Explicit

Sub Main
	
	Dim i As Integer = 100
	
	Dim ByRef ref As Integer = i
	Dim ref2 As Integer ByRef = i
		
	ref  = 500
	ref2 = 50
	Print i
	
	Dim i1 As Integer
	Dim i2 As UInteger
	
	Dim i3 As Short
	Dim i4 As UShort
	
	Dim s1 As Single
	Dim s2 As Double
	
	
	/*
	About Long
		Windows		: x86:32bit, x64: 64bit
		Linux/macOS	: x86:32bit, x64: 32bit
	*/
	Dim l1 As Long
	Dim l2 As ULong
	
	Dim b As Byte
	
	Dim ar() As String
	Dim dic As Integer Dictionary
	Dim col As String Collection
	

	Dim x,y As Single = 3.14 ' both x and y are Single type and also init value are 3.14
	
End Sub
