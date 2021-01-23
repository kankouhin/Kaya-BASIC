Option Explicit
' binary is default mode

Sub Main
	Dim ii As Integer
	Open "filetest.txt" For Output As #1
	
	ii = 11
	Write #1, "Hello World", ii, "Hello KayaBASIC "
	Print #1, "Line1"
	Print #1, "Line2 part1";
	Print #1, "Line2 part2"
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
	
	Open "filetest.txt" For Output Append As #1
	Print #1, "append line"
	Close #1
End Sub