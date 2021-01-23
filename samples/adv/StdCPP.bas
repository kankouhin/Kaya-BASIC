Option Explicit

Version Windows
	Option CPP_FLAGS 	" -include windows.h -include httplib.h "
	Option LD_FLAGS 	" -lWs2_32 " ' link Ws2_32.lib for windows
End Version

Version Not Windows
	Option CPP_FLAGS 	" -include httplib.h "
End Version

' download link
' https://github.com/yhirose/cpp-httplib

Const PUB_MEMBERS As String = "Public member functions"
Const PUB_INHERIT As String = "Public member functions inherited from"

using namespace httplib
Dim cli As Client("www.cplusplus.com", 80)

Function getText( htmlText As String ) As String
	Dim c,s As String
	Dim cnt As Integer = 0

	For each c in htmlText
		If c = "<" Then
			cnt += 1
		End If

		If cnt = 0 Then
			s += c
		End If
		
		If c = ">" Then
			cnt -= 1
		End If
	Next
	
	s = s.Replace( "&amp;", "& " )
	s = s.Replace( "&#160;", " " )
	s = s.Replace( "&lt;", "<" )
	s = s.Replace( "&gt;", "<" )
	
	Return s.Trim
End Function

Function getTextSpec( htmlText As String, spec As String, beginflag As String, endflag As String ) As String
	Dim s As String
	Dim idx As Integer
	Dim iPos As Integer

	idx = InStr( beginflag + spec, htmlText )
	If idx = 0 Then
		Function = ""
	End If
	
	idx += beginflag.Len
	iPos = InStr( idx + 1, endflag, htmlText )
	
	s = htmlText.Mid( idx, iPos - idx )	
	Return s.Trim
End Function

Sub getClassInfo(uri As String)
	Dim res = cli.Get( CStr(uri) )

        Dim context As String
	If ( res AndAlso res->status = 200 ) Then
		context = res->body
        Else
                Print "can not open :", uri
                Exit Sub
	End If

        Dim ar() As String = context.SplitAny("\r\n")
        Dim isPubMembers As Boolean

        For Each line As String ByRef In ar
                If PUB_INHERIT.InStr(line) > 0 Then
                        isPubMembers = False
                        Dim base As String = getTextSpec( line, "", "href=\"", "\"" )
                        Print base
                        Call getClassInfo( base + base )
                End If

                If isPubMembers Then
                        Print getTextSpec( line, "", "href= \"", "\"" )
                End If
                
                If PUB_MEMBERS.InStr(line) > 0 And PUB_INHERIT.InStr(line) = 0 Then
                        isPubMembers = True
                End If
        Next
End Sub

Sub Main
        Call getClassInfo( "/reference/fstream/ifstream/" )
End Sub
