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

Sub Main
	Dim i As Integer = atoi( "123" )
	Dim s As String = Format( "this is a string format by sprintf %d %s ", 100, "KayaBASIC" ) ' sprintf
	
	Print Format( ";  %s  ;", CStr(s) )
	Print i
	Print SizeOf(i)
	Print s
	Printf( "Wellcom to %s!!!\n", "KayaBASIC" )
	
	' std::sort
	Dim ar() As Integer = { 4,7,9,3,6,1,5 }
	Sort ( begin(ar), end(ar), AddressOf compare )
	Call showArr(ar)
	Sort ( begin(ar), end(ar) )	
	Call showArr(ar)
	
	' fstream
	Dim ofs As ofstream
	ofs.open ("test.txt", ofstream::out Or ofstream::app)
	ofs << " more lorem ipsum"
	ofs.close()
	
	Dim ifs As ifstream
	ifs.open ("test.txt", ifstream::in)
	
	Dim c As Char = ifs.get()
	While ifs.good()
		cout << c
		c = ifs.get()
	Wend
	ifs.close()
	
End Sub
