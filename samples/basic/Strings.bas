Option Explicit

Sub Main
	Dim s As String = " Hello KayaBASIC "
	
	' Raw String BEGIN with '"' + newline and END with newline + '"' + newline 
	Dim rs As String = "
===============================================================================

		Wellcome to KayaBASIC

KayaBASIC is a Multi-platform BASIC compiler, supports Windows, Linux and macOS.

Features:
Compiles with g++(need support C++14)
OOP, supports CreateObject by name and call function/sub/property by name)
Creates GUI(using wxWidgets), console or DLL applications.
Easy calls Windows COM like VB.

===============================================================================
"
	Print s.Trim.Left(6) ' = Left( Trim(s), 6 )	
	Print s.Trim
	Print s.LTrim
	Print s.RTrim
	
	Print s.Ucase
	Print s.Lcase
	Print s.Right(6)
	Print s.Reverse
	
	Print "Hel".Instr(s)
	Print "123wer".InstrAny(s)
	
	Print s.Mid(7)
	Print s.Mid(8,4)
	Print s.Delete(1,2)
	Print s.Insert("insert", 1)
	Print s.Len
	
	Print ";", s.PadC(30), ";"
	Print ";", s.PadL(30), ";"
	Print ";", s.PadR(30), ";"
	
	Print s.Replace("Hello", "Wellcome to")
	Print s.Replace("a", "A")
	
	Print s.Trim.StartsWith("Hello")
	Print s.Trim.StartsWith(" Hello")
	Print s.Trim.EndsWith("BASIC ")
	Print s.Trim.EndsWith("BASIC")
	
	Print (s * 2)
	Print ("abc" * 2)
	Print (s / 2)
	
	Print (s + 2)
	Print (s + 2.5)
	Print (3 + s + 3)
	Print (3.5 + s + 3.5)
	
	Print (s >> 2) ' delete last 2 chars
	Print (s << 2) ' delete first 2 chars
	
	Print rs
	Print s
	Print s(2)		' = s.Mid(2,1)
	Print s(2, 5)	' = s.Mid(2,5)
	Print s(2, -1)	' = s.Mid(2)
	
	Dim ar() As String = s.Split(" ")
	For each s As String in ar
		Print s
	Next
	Print Join(ar, "_")

	ar = "a+c*2-1/4".SplitAny("+-*/")
	For each s As String in ar
		Print s
	Next
	Print Join(ar, "_")

	'RegEx Functions
	s = "this subject has a submarine as a subsequence"
	Dim pattern As String = "\\b(sub)([^ ]*)"
	
	Print s.ReplaceEx("sub", "Sub")
	Print s.ReplaceEx(pattern, "_____")
	Print s.SearchEx(pattern)
	
	ar = s.SearchAllEx(pattern)
	For each s As String in ar
		Print s
	Next
	
	s = Format( "this a string formatted by sprintf: %s %s %d", "Hello", "KayaBASIC", 100 )
	Print s
	s = Format( ";  %s  ;", CStr(s) ) ' CStr: convert s to C String(const char*)
	Print s
End Sub
