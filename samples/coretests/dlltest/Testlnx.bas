
Option Explicit

Declare sub ShowMsg lib "./Dll64_lnx.so"
Declare sub ShowMsg2 lib "./Dll64_lnx.so"(msg as string)

Sub Main
	ShowMsg
	ShowMsg2("ShowMsg2 hello")	
End Sub