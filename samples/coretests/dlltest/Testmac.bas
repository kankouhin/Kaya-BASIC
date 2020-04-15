Option Explicit

Declare sub ShowMsg lib "./Dll64_mac.dylib"
Declare sub ShowMsg2 lib "./Dll64_mac.dylib"(msg as string)
Declare function ShowMsg3 lib "./Dll64_mac.dylib" As String
Declare function ShowMsg4 lib "./Dll64_mac.dylib" As Integer
Declare sub ShowMsg5 lib "./Dll64_mac.dylib"(byref msg as string)
Declare sub ShowMsg6 lib "./Dll64_mac.dylib"(byref msg() as string)

Sub Main
	ShowMsg
	ShowMsg2("ShowMsg2 hello")
	
	print ShowMsg3
	print ShowMsg4
	
	dim msg as string
	ShowMsg5 ( msg )
	print msg

	dim ar() as string
	ShowMsg6 ( ar )
	For idx as integer = 0 to Ubound(ar)
		Print ar(idx)
	Next
End Sub