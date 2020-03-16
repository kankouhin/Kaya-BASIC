Option Console

//Dim words As Integer dictionary
Dim words{} As Integer

Sub main
	Dim filename As String

	If UBound(Command) = 1 Then	' yes,
		filename = Command(1)
	Else
		filename = "dict.bas"
	End If
	
	Print "filename: ", filename
	
	Dim file As New file
	If Not file.open(filename, fmopenread) Then
		Print "file not found: ", filename
		End
	End If
	
	Dim w As String
	Dim c As String = LCase(file.readstring(1))
	Do
		If c >= "a" And c <= "z" Then
			w = ""
			Do	
				w = w + c
				c = LCase(file.readstring(1))
			Loop While (c >= "a" And c <= "z") Or (c >= "0" And c <= "9")
			incr words(w)
		Else
			c = LCase(file.readstring(1))
		End If
	Loop Until file.eof
	file.close

	Print "file statistics:"
	Dim count As Integer, i As Integer = 0

	For each w, count in words
		If i Mod 20 = 0 Then
			Print ""
			Print "word                 count"
			Print "===============      ====="
		End If
		
		Print padr(w, 21), padl(count, 5)
		incr i

		If i Mod 20 = 0 Then
			Print "--- press any key to continue ---"
			Do: Loop Until instat
			Inkey
		End If
	Next
	
End Sub