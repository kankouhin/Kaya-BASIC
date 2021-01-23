Option Explicit
' http://www.cplusplus.com/reference/cstdio/
' because FILE ,EOF and RENAME are defined in KayaBASIC, using the prefix c_[NAME]. 

Sub Main
	Dim f As c_FILE Ptr
	
	f = fopen ("myfile.txt","w")
	If f <> NULL Then
		
		fputs( "\tWellcome to KayaBASIC\n", f )
		fputs( "Multi-platform BASIC compiler, supports Windows, Linux and macOS", f )

		fclose( f )
	End If
	
	c_rename( "myfile.txt", "stdios.txt" )
	f = fopen ("stdios.txt","r")
	
	While Not feof(f)
		Dim buf[256] As Char = {0}
		If fgets( buf, 256, f ) <> NULL Then
			puts ( buf )
			
			cout << buf[0] << buf[1] << endl
		End If
	Wend
	
	Dim buf[10][5][2] As char
	buf[0][0][0] = 1
	
	Dim i As Integer = buf[0][0][0]
	Dim v() As Integer Ptr
	
	fclose( f )
End Sub
