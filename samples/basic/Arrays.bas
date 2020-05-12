Option Explicit

Sub showArr(ar() As Integer)
	Dim s As String = "{"
	
	For each it As Integer in ar
		s += it.Str + ", "
	Next
	
	s = s >> 2
	s += "}"
	Print s
End Sub


Sub Main
	Dim s As String = "this subject has a submarine as a subsequence"
	Dim ar() As String = s.Split(" ")
	
	For each it As String in ar
		Print it
	Next
	
	Print UBound(ar) 	'UBound and LBound can't call by UFCS
	ar << "KayaBASIC"	' << : append a item
	Print UBound(ar)
	Print ar.Join("_")
	
	Dim ar1() As Integer = {0, 1, 2, 3, 4, 3, 2 ,1, 0} ' NOTE: {} NOT support multi-dimensional array
	Dim arDel() As Integer = {2, 4}
	
	ar1 >> 0		' delele all items(value is 0) from array
	Call showArr( ar1 )
	ar1 >> arDel	' delele all items in arDel
	Call showArr( ar1 )

	Print UBound( ar1 )
	Print "ar1 * 2:"	
	ar1 *= 2
	Call showArr( ar1 )

	Print "ar1 / 2:"
	ar1 /= 2
	Call showArr( ar1 )
	
	Print "ar1 append ar2:"
	Dim ar2() As Integer = ar1
	ar2 *= 2
	ar1 << ar2	' << : append all items in ar2
	Call showArr( ar1 )
	
	
	Dim ar3() As Integer = {1,2,3,4,5}
	Dim ar4() As Integer = {2,3,4,5,6}
	
	ar3 += ar4
	Call showArr( ar3 )
	
	ar3 -= ar4
	Call showArr( ar3 )
	
	ar3 *= ar4
	Call showArr( ar3 )

	ar3 /= ar4
	Call showArr( ar3 )
End Sub
