
//Dim strings As String collection
Dim strings[] As String

Sub main
	Dim s As String
	Print "enter a couple of lines (blank one to end):"
	Do
		Line Input s
		strings.add(s)
	Loop Until s = ""
	
	strings.remove(strings.count - 1)
	
	Print "you entered:"
	For each s in strings
		Print "> ", s
	Next
End Sub
