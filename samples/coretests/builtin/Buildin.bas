Option Explicit

Declare Sub showdir(sDir As String)

Sub Main

	Dim ss As String = " Hello world  "
	Print "Left ", Left(ss,5)
	Print "Right ", Right(ss,5)
	Print "LTrim ", LTrim(ss)
	Print "RTrim ", RTrim(ss)
	
	Print "Delete ", Delete(ss, 1,3)
	Print "Replace ", replace(ss, "Hel","ssssHel")
	
	Print "Str ", Str(Val("2329.1232134"))
	Print "String ", String(10,Chr(65))
	Print "PadL ", padl(ss,20) + "aa"
	Print "PadR ", padr(ss,30) + "aa"
	Print "Mid ", Mid(ss, 2,7)
	
	Print "Abs ", Str(Abs(-1100))
	Print "Asc ", Str(Asc("A"))
	
	Print "Ceil ", Str(Ceil(1.2323))
	
	showdir( ".." + PathSep + "builtin")
	
	Print "FileExists ", FileExists("Buildin.bas")
	Print "FileExists ", FileExists("Buildin.bpp")
	
	Print "Time ", Time
	Print "Date ", Date
	
	Print "DirExists ", DirExists("../builtin")
	Print "DirExists ", DirExists("../builtin1")
	Print "Environ ", Environ("PATH")
	
	Print "Fix ", Fix(12.67)
	Print "FullDate ", FullDate
	
	Print "Hex ", Hex(125)
	
	Print "IIf ", IIf(1,"false","true")
	Print "IIf2 ", IIf(1,100,200)
	
	Print "InStr ", InStr("abcdefg","e")
	Print "InStrRev ", InStrRev("abcdefg","e")
	
	Kill("Buildin32_msw.exe")
	
	Print "LCase ", LCase(" Hello World ")
	Print "UCase ", UCase(" Hello World ")
	Print "Len ", Len("Hello World")
	
	Print "Reverse ", Reverse("Hello World")
	
	Print "RInStr ", RInStr("abcdefg","e")
	
End Sub

'sub showdir(sDir as string)
Sub showdir
	Dim ss As String
	ss =  Dir( sDir )
	Do While ss <> ""
		Print sDir + PathSep + ss
		
		If ss <> "." And  ss <> ".." Then
			ss = sDir + PathSep + ss
			If IsDir(ss) Then
				Call showdir( ss )
			End If
		End If
		
		ss = Dir
	Loop
End Sub
