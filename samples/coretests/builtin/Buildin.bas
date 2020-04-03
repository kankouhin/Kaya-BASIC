Option Explicit

Declare Sub showdir(sDir As String)

Sub Main

	Dim ss As String = " Hello world  "
	Print "Left :", Left(ss,5), ";"
	Print "Right :", Right(ss,5), ";"
	Print "LTrim :", LTrim(ss), ";"
	Print "RTrim :", RTrim(ss), ";"
	Print "Tally :", Tally(ss,"l"), ";"
	
	Print "Delete :", Delete(ss, 1,3), ";"
	Print "Replace :", Replace(ss, "Hel","ssssHel"), ";"
	
	Print "Str :", Str(Val("2329.1232134")), ";"
	Print "String :", String(10,Chr(65)), ";"
	Print "String2 :", String(10,"ABC"), ";"
	Print "Space :", Space(10), ";"
	
	Print "PadL :", PadL(ss,30), ";"
	Print "PadR :", PadR(ss,30), ";"
	Print "Mid :", Mid(ss, 2,7), ";"
	
	Print "Abs :", Str(Abs(-1100)), ";"
	Print "Asc :", Str(Asc("A")), ";"
	
	Print "Ceil :", Str(Ceil(1.2323)), ";"
	
	showdir( "../../../samples")
	
	Print "FileExists :", FileExists("Buildin.bas")
	Print "FileExists :", FileExists("Buildin.bpp")
	
	Print "Time :", Time
	Print "Date :", Date
	
	Print "DirExists :", DirExists("../builtin")
	Print "DirExists :", DirExists("../builtin1")
	Print "Environ :", Environ("PATH")
	
	Print "Fix :", Fix(12.67)
	Print "FullDate :", FullDate
	
	Print "Hex :", Hex(125)
	
	Print "IIf :", IIf(1,"false","true")
	Print "IIf2 :", IIf(1,100,200)
	
	Print "InStr :", InStr("abcdefg","e")
	Print "InStrRev :", InStrRev("abcdefg","e")
	
	Kill("Buildin32_msw.exe")
	
	Print "LCase :", LCase(" Hello World "), ";"
	Print "UCase :", UCase(" Hello World "), ";"
	Print "Len :", Len("Hello World"), ";"
	
	Print "Reverse :", Reverse("Hello World"), ";"
	
	Print "PathSep :", PathSep
	Print "RunAs :", RunAs
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
	
	CloseDir
End Sub
