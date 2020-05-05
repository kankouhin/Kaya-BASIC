Option Explicit

Function inarr(s As String, ByRef ar() As String ) As BOOLEAN
	For each ss As String in ar
		If ss = s Then
			Return TRUE 
		End If
	Next
	
	Return FALSE
End Function

Function inlist(s As String, ByRef list As String Collection ) As BOOLEAN
	For each ss As String in list
		If ss = s Then
			Return TRUE 
		End If
	Next
	
	Return FALSE
End Function

Function indict(s As String, ByRef list As String Dictionary ) As BOOLEAN
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
	If  (s + "llo") InStr s + "llo KayaBASIC" Then  ' NOT support function in expression
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
	
	If  "array1" InArr ar Then
		Print "done array"
	Else
		Print "Error InArr"
	End If

	
	If  "list1" InList list Then
		Print "done list"
	Else
		Print "Error InList"
	End If

	If  "dict1" InDict dict Then
		Print "done dict"
	Else
		Print "Error InDict"
	End If
End Sub
