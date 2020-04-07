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
	
	Dim l1 As Long ' x86 = Integer(32bit), on x64 platform Long is 64bit
	Dim l2 As ULong
	
	Dim b As Byte
	
	Dim ar() As String
	Dim dic As Integer Dictionary
	Dim col As String Collection
	

	Dim x,y As Single = 3.14 ' both x and y are Single type
	
End Sub
