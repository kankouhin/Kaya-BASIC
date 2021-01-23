
Dim strings As String Collection

Sub Main
	Dim s As String
	Print "enter a couple of lines (blank one to end):"
	Do
		Line Input s
		strings.add(s)
	Loop Until s = ""
	
	strings.remove(strings.count - 1)
	strings.insert("insert", 1 )
	
	Print "you entered:"
	For each s in strings
		Print "> ", s
	Next
	
	Print strings(1)
	strings(1) = "Hello KayaBASIC"
	Print strings(1)
	
End Sub
