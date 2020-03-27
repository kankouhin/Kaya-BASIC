Option Explicit

Sub Main

	Dim ii As Integer
	Open "filetest.txt" For Output As #1
	
	ii = 11
	write #1, "write1", ii, "write2"
	Print #1, "abcdefg"
	Print #1, "hijklmn";
	Print #1, "opqrstu"
	Close #1
	
	Dim fn As Integer = FreeFile
	Dim s1, s2 As String, ll As Integer
	
	Print "fileno ", fn
	Open "filetest.txt" For Input As #fn
	
	Input #fn, s1, ll, s2
	Print "s1 ", s1
	Print "ll ", ll
	Print "s2 ", s2
	
	Print "EOL", FileLen(fn)
	Line Input #fn, s1
	Print "EOF", EOF(fn)
	Line Input #fn, s2
	Print "EOF", EOF(fn)
	
	Print s1
	Print s2
	
	Close #fn
	
	Open "filetest.txt" For Append As #1
	Print #1, "append line"
	Close #1
	
End Sub