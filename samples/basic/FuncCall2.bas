Option Explicit

Overloads Function in(s As String, ss As String ) As Boolean
	Return s.Instr(ss) > 0
End Function

Overloads Function in(s As String, ByRef ar() As String ) As Boolean
	For each ss As String in ar
		If ss = s Then
			Return TRUE 
		End If
	Next
	
	Return FALSE
End Function

Overloads Function in(s As String, ByRef list As String Collection ) As Boolean
	For each ss As String in list
		If ss = s Then
			Return TRUE 
		End If
	Next
	
	Return FALSE
End Function

Overloads Function in(s As String, ByRef list As String Dictionary ) As Boolean
	For each ,,ss As String in list
		If ss = s Then
			Return TRUE 
		End If
	Next
	
	Return FALSE
End Function

Sub Main
	' Call Function As A Keyword
	If Like( "abbbbc", "ab*c" ) Then
		Print "done like1"
	End If
	
	If  "abbbbc" Like  "ab*c"  Then
		Print "done like2"
	Else
		Print "Error like"
	End If
	
	Dim s As String = "He"
	If (s + "llo") In s + "llo KayaBASIC".Left(100) + Str(1000) + 65.Chr Then
		Print "done instr"
	Else
		Print "Error instr"
	End If
	
	Dim ar(5) As String
	Dim list As String Collection
	Dim dict As String Dictionary
	
	For idx As Integer = 0 To 5
		ar(idx) = "array" + Str(idx)
		list.add( "list" + Str(idx) )
		dict( "dict" + Str(idx) ) = "dict" + Str(idx)
	Next

	If  "array" + Str(1) In ar Then
		Print "done array"
	Else
		Print "Error InArr"
	End If

	If  "list1" In list Then
		Print "done list"
	Else
		Print "Error InList"
	End If

	If  "dict1" In dict Then
		Print "done dict"
	Else
		Print "Error InDict"
	End If
End Sub
