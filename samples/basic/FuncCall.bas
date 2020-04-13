Option Explicit

Sub Main
	'Experimental Features
	' ONLY support call function which return simple data type(Integer, String, etc...)
	' ONLY support call by variant
	'
	'	OK s.Trim
	'	X  " Hello KayaBASIC ".Trim
	
	Dim s As String = "  Hello KayaBASIC  "
	Print s.Trim
	Print s.Trim.Left(5)
	
	Dim i As Integer = 2000
	Print i.Str.Left(2)
	Print i.Str.Left(2).Val
	
	Dim filename As String = "  KayaBASIC.bas  "
	Print filename.Trim.Right(3).UCase
	Print UCase( filename.Trim.Right(3) )
	
	If "." + filename.Trim.Right(3).UCase = ".BAS" Then
		Print "got it"
	End If

	If "." + UCase( filename.Trim.Right(3) ) = ".BAS" Then
		Print "got it"
	End If
	
End Sub
