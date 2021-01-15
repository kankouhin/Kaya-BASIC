Option Explicit

Sub compilieBas(fn as string)
	
	Call Shell( "bpp -r -pro " + fn + " >> nul" )

	If FileExists( fn + "32_msw.exe" ) Then
		Print fn, "\t\t OK"
	Else
		Print fn, "\t\t NG"
	End If
End Sub

Sub Main
	Call Shell( "del *.bpm" )
	Call Shell( "del *.a" )

	Dim ss As String =  Dir( "." )
	Do While ss <> ""
		If ss.Len > 5 AndAlso ss.EndsWith(".bas") Then

			ss = ss >> 4
			If Not ( ss.EndsWith("Using") OrElse ss.EndsWith("Lib") ) Then
				Call compilieBas( ss )
			End If

		End If
		
		ss = Dir
	Loop
	
	CloseDir
End Sub