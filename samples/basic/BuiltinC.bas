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

Function compare( i As Integer, j As Integer ) As Boolean
	Function = ( i > j )
End Function

Function copyiffn( i As Integer ) As Boolean
	Function = ( i >= 6 )
End Function

Sub Main
	Dim i As Integer = atoi( "123" )
	Dim s As String = Format( "this is a string format by sprintf %d %s ", 100, "KayaBASIC" ) ' sprintf
	
	Print Format( ";  %s  ;", CStr(s) )
	Print i
	Print SizeOf(i)
	Print s
	Printf( "Wellcom to %s!!!\n", "KayaBASIC" )
	
	' std::sort
	Dim ar() As Integer = { 4,7,9,3,6,1,5,2,6,7,7,3,7 }
	Sort ( begin(ar), end(ar), AddressOf compare )
	Call showArr(ar)
	Sort ( begin(ar), end(ar) )	
	Call showArr(ar)
	
	' std::count
	Print Count( begin(ar), end(ar), 3)
	Print Count( begin(ar), end(ar), 7)
	
	' std::count_if and std::copy_if
	Dim cnt As Integer = count_if( begin(ar), end(ar), AddressOf copyiffn )
	Dim arTo( cnt - 1) As Integer
	copy_if( begin(ar), end(ar), begin(arTo), AddressOf copyiffn )
	Call showArr(arTo)
	
	' fstream
	Dim ofs As OFStream
	ofs.open ("test.txt", OFStream::out Or OFStream::app)
	ofs << " more lorem ipsum"
	ofs.close()
	
	Dim ifs As IFStream
	ifs.open ("test.txt", IFStream::in)
	
	Dim c As Char = ifs.get()
	While ifs.good()
		cout << c
		c = ifs.get()
	Wend
	ifs.close()
	
End Sub
