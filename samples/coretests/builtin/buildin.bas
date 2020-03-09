Option Explicit
Option Console

Declare Sub showdir(sDir As String, mask As String )

Sub Main

	Dim  ii As Integer = 100, s As String * 100
	s = "hello flstring"
	s = s + "world"
	Print s

	Dim i As Integer
	Dim ar(100) As char
	
'	i = 100/0

	Print "\\r\\n \\v \\t \"

	Dim ss As String = " Hello world  "
	Print "left ", Left(ss,5)
	Print "right ", Right(ss,5)
	Print "ltrim ", LTrim(ss)
	Print "rtrim ", RTrim(ss)
	
	Print "delete ", Delete(ss, 1,3)
	Print "replace ", replace(ss, "Hel","ssssHel")
	
	Print "str ", Str(Val("2329.1232134"))
	Print "string ", String(10,Chr(65))
	Print "padl ", padl(ss,20) + "aa"
	Print "padr ", padr(ss,30) + "aa"
	Print "mid ", Mid(ss, 2,7)
	
	Print Str(Abs(-1100))
	Print Str(Asc("A"))
	
	Print Str(Ceil(1.2323))
	
	Print "dir","“ú–{Œê"
	showdir( "C:\DataMigration\FreeBasic\bpp\samples\coretests\buildinfunc", "*.*")
	
	Print "FileExists ", FileExists("buildin.bpp")
	Print "Date ", Date
	
	Print "DirExists ", DirExists("C:\DataMigration\FreeBasic\bpp\samples\system\edd")
	Print "Environ ", Environ("MINGW32")
	
	Print "Fix ", Fix(12.67)
	Print "FullDate ", FullDate
	
	Print "Hex ", Hex(125)
	
	Print "IIF ", IIf(1,"false","true")
	Print "iif2 ", IIf(1,100,200)
	
	Print "instr ", InStr("abcdefg","e")
	Print "instrrev ", InStrRev("abcdefg","e")
	
	Kill("Buildin3221.exe")
	
	Print "lcase ", LCase("Hello World")
	Print "ucase ", UCase("Hello World")
	Print "len ", Len("Hello World")
	
	'MkDir( "test" )
	// c comments
	Print "reverse ", Reverse("Hello World")
	
	Print RInStr("abcdefg","e")
	
	'Shell( "notepad.exe" )
	
	Print Time
	
End Sub

'sub showdir(sDir as string, mask as string )
Sub showdir
	Dim ss As String
	ss =  Dir(sDir + "\" + mask)
	Do While ss <> ""
		Print sDir + "\" + ss
		
		If ss <> "." And  ss <> ".." Then
			If GetAttr Or FileAttrDirectory Then
				Call showdir( sDir + "\" + ss, mask )
			End If
		End If
		
		ss = Dir
	Loop
End Sub
