Option Explicit

Sub Main
	'Experimental Features
	'NOW: only support variant
	'	s.Trim  OK
	'	" Hello KayaBASIC ".Trim  X
	
	Dim s As String = "  Hello KayaBASIC  "
	Print s.Trim  			' = Trim(s)
	Print s.Instr("Hel")	' = Instr( s, "Hel" )
	
End Sub
