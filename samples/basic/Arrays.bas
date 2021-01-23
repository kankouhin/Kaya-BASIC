Option Explicit

Sub showArr(ar() As Integer)
	Dim s As String = "UBound:" + UBound(ar) + " {"
	
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
	
	Dim ar1() As Integer = {0, 1, 2, 3, 4, 3, 2 ,1, 0}
	Dim arDel() As Integer = {2, 4}
	
	ar1 >> 0		' delele all items(value is 0) from array
	Call showArr( ar1 )
	ar1 >> arDel	' delele all items in arDel
	Call showArr( ar1 )
	
	Print "Array op:"
	Print "ar1 * 2:"	
	ar1 *= 2
	Call showArr( ar1 )
	Call showArr( ar1 * 2 )

	Print "ar1 / 2:"
	ar1 /= 2
	Call showArr( ar1 )
	Call showArr( ar1 / 2 )
	
	Print "ar1 append ar2:"
	Dim ar2() As Integer = ar1
	ar2 *= 2
	ar1 << ar2	' << : append all items in ar2
	Call showArr( ar1 )
	
	Print "Array op Array:"
	Dim ar3() As Integer = {1,2,3,4,5}
	Dim ar4() As Integer = {2,3,4,5,6,7,8}

	Call showArr( ar3 + ar4 )	
	ar3 += ar4
	Call showArr( ar3 )
	
	Call showArr( ar3 - ar4 )
	ar3 -= ar4
	Call showArr( ar3 )
	
	Call showArr( ar3 * ar4 )
	ar3 *= ar4
	Call showArr( ar3 )
	
	Call showArr( ar3 / ar4 )
	ar3 /= ar4
	Call showArr( ar3 )
	
	Dim ar5() As Integer = { {1,2,3}, {4,5,6}, {7,8,9}, {10,11,12} } ' NOTE: {} NOT support >= 3-dimensional array
	Dim ar6() As Integer = ar5
	
	ar6 *= ar3
	Call showArr( ar6 )
	Print ar6(1,1), ",", ar6(1,2), ",", ar6(3,0), ",", ar6(3,2)
	Call showArr( ar5 )
	
End Sub