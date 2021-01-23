Option Explicit

Version Windows
	Const BPP As String 		= "bpp"
	Const NUL As String 		= "nul"
	Const EXT As String		= "32_msw.exe"
	Const DEL As String		= "del"
End Version

Version Linux
	Const BPP As String 		= "bpp_lnx"
	Const NUL As String	 	= "/dev/null"
	Const EXT As String		= "64_lnx.exe"
	Const DEL As String		= "rm"
End Version

Version macOS
	Const BPP As String 		= "bpp_mac"
	Const NUL As String 		= "/dev/null"
	Const EXT As String		= "64_mac.exe"
	Const DEL As String		= "rm"
End Version

Dim cmds As String

Sub compileBas(path as string, fn as string, options as string)
	If cmds <> "clean" Then
		Call Shell( "cd " + path +" && " + BPP + " -r " + options + fn + " > " + NUL )
	End If

	If FileExists( path + "/" + fn + EXT ) Then
		If fn.Len >= 8 Then
			Print fn, "\t OK"
		Else
			Print fn, "\t\t OK"
		End If

		If cmds.Len > 0 Then
			Call Shell( "cd " + path +" && " + DEL + " " + fn + EXT )
		End If
	Else
		Print fn, "\t\t\t NG"
	End If
End Sub

Sub compilePath(path as string, options as string)
	If cmds <> "clean" Then
		Call Shell( "cd " + path + " && " + DEL + " *.bpm" )
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
		Call Shell( "cd " + path +" && " + DEL + " *.bpm && " + DEL + " *.a && " + DEL + " *.cpp" )
	End If
End Sub

Sub Main
	If Ubound( Command ) > 0 Then
		cmds = Command(1)
	End If

	Version Windows
		Call compilePath("..\\wxGUI\\bppgui", " -w " )
		Call compilePath("..\\coretests\\comole", " -w -c " )
		Call compilePath("..\\coretests\\OOP", " -w " )
		Call compilePath("..\\coretests\\fileio", " " )
		Call compilePath( "..\\adv", " -pro " )
		Call compilePath( ".", " -pro " )
	End Version

	Version Not Windows
		Call compilePath("../wxGUI/bppgui", " -w " )
		Call compilePath("../coretests/OOP", " -w " )
		Call compilePath( "../adv", " -pro " )
		Call compilePath( ".", " -pro " )		
	End Version	

End Sub