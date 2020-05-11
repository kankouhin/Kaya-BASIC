Option Explicit

Sub Main
	Dim s As String = " Hello KayaBASIC "
	
	' Raw String BEGIN with '"' + newline and END with newline + '"' + newline 
	Dim rs As String = "
===============================================================================

		Wellcome to KayaBASIC

KayaBAISC is a Multi-platform BASIC compiler, supports Windows, Linux and macOS.

Features:
Compiles with g++(need support C++11)
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
	Print "Kaya".Instr(s)
	Print s.Delete(1,2)
	Print s.Insert("insert", 1)
	Print s.Len
	
	Print ";", s.PadC(30), ";"
	Print ";", s.PadL(30), ";"
	Print ";", s.PadR(30), ";"
	
	Print s.Replace("Hello", "Wellcome to")
	Print s.Replace("a", "A")
	Print s.ReplaceEx("Well", 2)
	
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
	
	Print (s >> 2) ' delete 2 chars from the end
	Print (s << 2) ' delete 2 chars from the begin
	
	Print rs
	Print s
	Print s(2)
	Print s(2, 5)
	Print s(2, -1)
	
	Dim ar() As String = Split(s, " ")
	For each s As String in ar
		Print s
	Next
	Print Join(ar, "_")

	ar = SplitAny("a+c*2-1/4", "+-*/")
	For each s As String in ar
		Print s
	Next
	Print Join(ar, "_")
	
/*
	For each c As String in s
		Print c
	Next
	
	For each c As Integer in s
		Print c
	Next
*/
End Sub
