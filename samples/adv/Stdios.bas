Option Explicit
' http://www.cplusplus.com/reference/cstdio/
' because FILE and EOF are defined in KayaBASIC, using the prefix c_[NAME]. 

Sub Main
	Dim f As c_FILE Ptr
	
	f = fopen ("myfile.txt","w")
	If f <> NULL Then
		
		fputs( "\tWellcome to KayaBASIC\n", f )
		fputs( "Multi-platform BASIC compiler, supports Windows, Linux and macOS", f )

		fclose( f )
	End If
	
	rename( "myfile.txt", "stdios.txt" )
	f = fopen ("stdios.txt","r")
	
	While Not feof(f)
		
		Dim s As String
		Dim c As Char
		
		c = fgetc(f)
		While c <> 10 AndAlso c <> 13 AndAlso c <> c_EOF
			s += Chr(c)
			c = fgetc(f)
		Wend
		
		cout << s << endl
	Wend
	
	fclose( f )
End Sub
