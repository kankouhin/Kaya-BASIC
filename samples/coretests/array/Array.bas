Option Explicit

Sub ArrayTest(ByRef arrrr() As String)
	Print UBound(arrrr,1)
End Sub

Sub Main

	Dim ar(2, 6, 8, 10) As Integer
	Dim iv As Integer
	
	iv = 0
	For i1 As Integer = 0 To 2
		For i2 As Integer = 0 To 6
			For i3 As Integer = 0 To 8
				For i4 As Integer = 0 To 10
					iv++
					ar(i1,i2,i3,i4) = iv
				Next
			Next
		Next
	Next
	
	ReDim Preserve ar( UBound(ar)-1 )
	
	For i1 As Integer = 0 To UBound(ar)
		For i2 As Integer = 0 To 6
			For i3 As Integer = 0 To 8
				For i4 As Integer = 0 To 10
					Print str0(i1,2),",", str0(i2,2),",", str0(i3,2),",", str0(i4,2), "=", ar(i1,i2,i3,i4)
				Next
			Next
		Next
	Next
	
	

	Dim aaa() As String
	
	ReDim aaa(10)
	Print "ubound aaa ", UBound(aaa)
	For idx As Integer = LBound(aaa) To UBound(aaa)
		aaa(idx) = String( 5,str0(idx,2)  )
	Next
	Print aaa(10)
	
	Print Join( aaa, "," )
	
	Print "Test Split1"
	Dim src As String = "qwe,123,ert,xxx,1,2,3"
	dim sar() As String = Split( src, "," )
	Print "Split ", Ubound( sar )
	
	For idx As Integer = LBound(sar) To Ubound(sar)
		Print sar(idx)
	Next

	Print "Test Split2"
	src = "qwe,123,ert,xxx,1,2,3,,,,1,"
	sar = Split( src, "," )
	Print "Split ", Ubound( sar )
	
	For idx As Integer = LBound(sar) To Ubound(sar)
		Print sar(idx)
	Next

	Print "Test Split3"
	src = ",qwe,123,ert,xxx,1,2,3,,,,1,1111"
	sar = Split( src, "," )
	Print "Split ", Ubound( sar )
	
	For idx As Integer = LBound(sar) To Ubound(sar)
		Print sar(idx)
	Next
	
	ArrayTest( aaa )
	
	ReDim Preserve aaa( UBound(aaa) - 6 )
	Print "redim preserve ubound aaa ", UBound(aaa)
	Print aaa(4)
	
	ReDim aaa(4)
	Print "redim ubound aaa ", UBound(aaa)
	Print aaa(4)

End Sub