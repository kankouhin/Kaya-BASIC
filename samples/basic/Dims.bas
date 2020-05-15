Option Explicit

Type Person
	name As String 	= "KayaBASIC"
	age As Integer	= 1
End Type

Sub Main
	
	Dim i0 As Integer 	= 100
	Dim i1 As Integer	= &HFE		'Hex
	Dim i2 As UInteger	= &O17		'Octal O is not zero is alpha O/o
	Dim i3 As UShort	= 017		'Octal 0 is zero
	Dim i4 As Short		= &B110010	'Binary
	
	Dim s1 As Single
	Dim s2 As Double
	Dim s3 As Decimal
	
	Dim bln As Boolean
	
	Print i0
	Print i1
	Print i2
	Print i3
	Print i4

	/*
	About Long
		Windows		: x86:32bit, x64: 64bit
		Linux/macOS	: x86:32bit, x64: 32bit
	*/
	Dim l1 As Long
	Dim l2 As ULong
	
	Dim b As Byte
	
	Dim ar1() As String
	Dim ar2(5) As String
	Dim ar3(1 To 5) As String
	
	Dim dic As Integer Dictionary
	Dim col As String Collection
	

	Dim x,y As Single = 3.14 ' both x and y are Single type and also init value are 3.14
	
	
	dim p1 as Person
	p1.name = "KayaBASIC"
	p1.age = 1
	
	dim p2 as Person
	
	p2 = p1
	
	Print p2.name, " ", p2.age
End Sub
