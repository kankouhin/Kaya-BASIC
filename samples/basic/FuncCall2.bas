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
	' Call function like a BASIC keyword
	
	If Like( "abbbbc", "ab*c" ) Then
		Print "done"
	End If
	
	If  "abbbbc" Like  "ab*c"  Then
		Print "done"
	End If
	
	If  "Hello" InStr  "Hello KayaBASIC"  Then
		Print "done"
	End If
	
	Dim ar(5) As String
	Dim list As String Collection
	Dim dict As String Dictionary
	
	For idx As Integer = 0 To 5
		ar(idx) = Str(idx) + "array"
		list.add( Str(idx) + "list" )
		dict( Str(idx) + "dict" ) = Str(idx) + "dict"
	Next
	
	If  "1array" InArr ar Then
		Print "done array"
	End If

	If  "1list" InList list Then
		Print "done list"
	End If

	If  "1dict" InDict dict Then
		Print "done dict"
	End If
End Sub
