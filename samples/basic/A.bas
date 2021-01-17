Option Explicit

Dim cmds As String

Sub compileBas(path as string, fn as string, options as string)
	If cmds <> "clean" Then
		Call Shell( "cd " + path +" & bpp -r " + options + fn + " > nul" )
	End If

	If FileExists( path + "\\" + fn + "32_msw.exe" ) Then
		If fn.Len >= 8 Then
			Print fn, "\t OK"
		Else
			Print fn, "\t\t OK"
		End If

		If cmds.Len > 0 Then
			Call Shell( "cd " + path +" & del " + fn + "32_msw.exe" )
		End If
	Else
		Print fn, "\t\t\t NG"
	End If
End Sub

Sub compilePath(path as string, options as string)
	If cmds <> "clean" Then
		Call Shell( "cd " + path + " & del *.bpm" )
	End If
	
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

	If cmds.Len > 0 Then
		Call Shell( "cd " + path +" & del *.bpm & del *.a & del *.cpp" )
	End If
End Sub

Sub Main
	If Ubound( Command ) > 0 Then
		cmds = Command(1)
	End If

	Call compilePath("..\\wxGUI\\bppgui", " -w " )
	Call compilePath("..\\coretests\\comole", " -w -c " )
	Call compilePath("..\\coretests\\OOP", " -w " )
	Call compilePath( "..\\adv", " -pro " )
	Call compilePath( ".", " -pro " )
End Sub