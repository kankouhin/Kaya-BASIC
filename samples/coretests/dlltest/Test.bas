
Option Explicit

Declare sub ShowMsg lib "Dll32_msw.dll"
Declare sub ShowMsg2 lib "Dll32_msw.dll"(msg as string)
Declare function ShowMsg3 lib "Dll32_msw.dll" As String

Sub Main

	ShowMsg
	ShowMsg2("ShowMsg2 hello")
	
	print ShowMsg3
	
End Sub