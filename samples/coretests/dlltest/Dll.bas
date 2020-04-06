Option DLL ON

public export sub ShowMsg
	print "hello world"
end sub

public export sub ShowMsg2(msg as String)
	dim s as string
	s = msg
	print s
end sub

public export function ShowMsg3 As String
	function = "hello world3"
end function

public export function ShowMsg4 As Integer
	function = 100
end function

public export sub ShowMsg5(byref msg as String)
	msg = "get msg from dll"
end sub

public export sub ShowMsg6(byref msg() as String)
	Redim msg(5)
	For idx as integer = 0 to Ubound(msg)
		msg(idx) = "Msg" + Str(idx)
	Next	
end sub
