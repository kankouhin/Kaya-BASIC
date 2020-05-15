Option Explicit

Sub Main
	Dim i As Integer = atoi( "123" )
	Dim s As String = Format( "this is a string format by sprintf %d %s ", 100, "KayaBASIC" ) ' sprintf
	
	Print Format( ";  %s  ;", CStr(s) )
	Print i
	Print SizeOf(i)
	Print s
	Printf( "Wellcom to %s!!!\n", "KayaBASIC" )
	
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
