Option Explicit

Dim words As Integer Dictionary

Sub Main
	Dim filename As String

	If UBound(Command) = 1 Then
		filename = Command(1)
	Else
		filename = "Dict.bas"
	End If
	Print "filename: ", filename
	
	Open filename For Input As #1
	
	Dim w As String
	Do While Not Eof(1)
		
		Dim s As String
		Line Input #1, s
		
		If Len(s) = 0 Then
			Continue
		End If
		
		w = ""
		s = Trim(LCase(s))
		For i  As Integer = 1 To Len(s)
			
			Dim c As String = Mid(s, i, 1)
			If c >= "a" AndAlso c <= "z" Then
				w = w + c
			Else
				If Len(w) Then
					Print w
					Incr words(w)
				End If
				w = ""
			End If
		Next
		
		If Len(w) Then
			Print w
			Incr words(w)
		End If
	Loop
	Close #1
	
	Print "file statistics:"
	Dim count As Integer, i As Integer = 0

	For Each w, count in words
		If i Mod 20 = 0 Then
			Print ""
			Print "word                 count"
			Print "===============      ====="
		End If
		
		Print padr(w, 21), padl(count, 5)
		Incr i

		If i Mod 20 = 0 Then
			Print "--- press any key to continue ---"
			Do: Loop Until InStat
			InKey
		End If
	Next
End Sub
