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
	
	Dim v = "Hello KayaBASIC"
	Dim v1 = 1
	Dim v2 = @v
	Dim v3 = @v1
	Dim v4 = 2.0f
	Dim v5 = 2l
	Dim v6 = 2ll
	Dim v7 = 2ull

	Print TypeName(v)
	Print TypeName(v1)
	Print TypeName(v2)
	Print TypeName(v3)
	Print TypeName(v4)
	Print TypeName(v5)
	Print TypeName(v6)
	Print TypeName(v7)
	
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
	
	Print TypeName(dic)
	Print TypeName(l1)
	Print TypeName(s1)
	Print TypeName(i1)
	
	Dim x,y As Single = 3.14 ' both x and y are Single type and also init value are 3.14
	
	
	dim p1 as Person
	p1.name = "KayaBASIC"
	p1.age = 1
	
	dim p2 as Person
	
	p2 = p1
	
	Print p2.name, " ", p2.age
End Sub


