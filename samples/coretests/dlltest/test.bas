
Option Explicit

Declare sub ShowMsg lib "Dll32.dll"
Declare sub ShowMsg2 lib "Dll32.dll"(msg as string)
Declare function ShowMsg3 lib "Dll32.dll" As String

Sub Main

	ShowMsg
	ShowMsg2("ShowMsg2 hello")
	
	print ShowMsg3
	
End Sub