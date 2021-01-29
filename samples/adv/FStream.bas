Option Explicit
' http://www.cplusplus.com/reference/fstream/

Using StdCPP

Sub Main
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
