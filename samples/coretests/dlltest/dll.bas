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

