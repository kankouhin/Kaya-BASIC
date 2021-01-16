Option Explicit

Sub compileBas(path as string, fn as string, options as string)
	Call Shell( "cd " + path +" & bpp -r " + options + fn + " > nul" )

	If FileExists( path + "\\" + fn + "32_msw.exe" ) Then
		If fn.Len >= 8 Then
			Print fn, "\t OK"
		Else
			Print fn, "\t\t OK"
		End If
		
		Call Shell( "cd " + path +" & del " + fn + "32_msw.exe" )
	Else
		Print fn, "\t\t NG"
	End If

	'Call Shell( "cd " + path +" & del /Q *.bpm & del /Q *.a" )
End Sub

Sub compilePath(path as string, options as string)
	Call Shell( "cd " + path + " & del *.bpm" )

	Dim ss As String =  Dir( path )
	Do While ss <> ""
		If ss.Len > 5 AndAlso ss.EndsWith(".bas") Then

			ss = ss >> 4
			If Not ( ss.EndsWith("Using") OrElse ss.EndsWith("Lib") ) Then
				Call compileBas( path, ss, options )
			End If

		End If
		ss = Dir
	Loop
	CloseDir
End Sub

Sub Main
	Call compilePath("..\\wxGUI\\bppgui", " -w " )
	Call compilePath("..\\coretests\\comole", " -w -c " )
	Call compilePath("..\\coretests\\OOP", " -w " )
	Call compilePath( ".", " -pro " )
End Sub