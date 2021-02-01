Option Explicit

Using wxWidgets         ' load wxWidges classes infomation from bin/builtin/wx* files
Using StdCPP            ' load identifiers and datatypes from bin/builtin/StdCPP file
Using AnyCPP            ' can use any identifiers and datatypes
Using ComObject         ' using Windows COM/ActiveX technology
Using c_math              ' #include math.h
Using c_stdio             ' #include stdio.h
' Using ModuleName	' NOTE: ModuleName Case-Sensitive

using namespace std       ' as same as c++ using namespace

Option Console On

Sub Main
	Dim o as ComObject
	Dim s as String

	Print hypot(3.0, 4.0) 
	printf( "%s %d", "abc", 100 )
End Sub