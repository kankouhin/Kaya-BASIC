Option Explicit

Const cs As String = "  Hello KayaBASIC const "
	
Sub Main
	'Universal Function Call Syntax
	' ONLY support call function which return simple data type(Integer, String, etc...)
	
	Dim s As String = "  Hello KayaBASIC  "
	Print s.Trim
	Print s.Trim.Left(5)
	
	Print "  Hello KayaBASIC  ".Trim
	Print 2000.Str.Left(3)
	Print 3.1415926.Str.Left(3)
	Print cs.Trim
	
	Dim i As Integer = 2000
	Print i.Str.Left(2)
	Print i.Str.Left(2).Val
	
	Dim filename As String = "  KayaBASIC.bas  "
	Print filename.Trim.Right(3).UCase
	Print UCase( filename.Trim.Right(3) )
	Print UCase( filename.Right( Len(filename) - (".bas" Instr filename) ).Trim ) + 1.Str + Str(1)
	
	If "." + filename.Trim.Right(3).UCase = ".BAS" Then
		Print "got it"
	End If

	If "." + UCase( filename.Trim.Right(3) ) = ".BAS" Then
		Print "got it"
	End If
	
	i = 3
	If filename.Trim.Right(3).UCase.Len = i.Str.Val.Cint Then
		Print "got it"
	End If
	
End Sub
