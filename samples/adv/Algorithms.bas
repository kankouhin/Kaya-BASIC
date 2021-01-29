Option Explicit
' http://www.cplusplus.com/reference/algorithm/

Using StdCPP

Sub showArr(ar() As Integer)
	Dim s As String = "UBound:" + UBound(ar) + " {"
	
	For each it As Integer in ar
		s += it.Str + ", "
	Next
	
	s = s >> 2
	s += "}"
	Print s
End Sub

Function compare( i As Integer, j As Integer ) As Boolean
	Function = ( i > j )
End Function

Function fn( i As Integer ) As Integer
	Function = ( i >= 6 )
End Function

Sub Main
	Dim ar() As Integer = { 4,7,9,3,6,1,5,2,6,7,7,3,7 }

	' std::sort
	Sort ( begin(ar), end(ar), AddressOf compare )
	Call showArr(ar)
	Sort ( begin(ar), end(ar) )	
	Call showArr(ar)
	
	' std::find_first_of
	Dim arFind() As Integer = {9,7,6}
	Dim p As Integer Ptr = CData(arFind)
	Dim it As Auto = find_first_of ( begin(ar), end(ar), p, p + 3)
	Print "find_first_of: ", (*it)
	
	' std::count and std::count_if
	Print Count( begin(ar), end(ar), 3)
	Print Count( begin(ar), end(ar), 7)
	Dim cnt As Integer = Count_if( begin(ar), end(ar), AddressOf fn )
	
	' std::copy_if
	Dim arTo( cnt - 1) As Integer
	Copy_if( begin(ar), end(ar), begin(arTo), AddressOf fn )
	Call showArr(arTo)
	
	' std::transform
	ReDim arTo( UBound(ar) )
	Transform( begin(ar), end(ar), begin(arTo), _
				Function( i As Integer )
					Return i * i
				End Function 
			)
	Call showArr(arTo)
	
	' lower_bound and upper_bound 
	Dim lo As Auto = lower_bound( begin(ar), end(ar), 7)
	Dim hi As Auto = upper_bound( begin(ar), end(ar), 7)
	cout << "lower_bound at position " << (lo - begin(ar)) << endl
	cout << "upper_bound at position " << (hi - begin(ar)) << endl
	
End Sub
