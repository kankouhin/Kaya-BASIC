Option Explicit
' this another sample shows how to use c/c++ library
'
' 1. include header file
' 2. link the libraries
' 3. write codes directly. 
'    NOTE: because nothing(sub/function/const,etc...) defined like wxWidgets classes,
'          you need write codes as same as c/c++: need () after sub name, and also Case-Sensitive.
'
Version Windows
	Option CPP_FLAGS 	" -include windows.h -include httplib.h "
	Option LD_FLAGS 	" -lWs2_32 " ' link Ws2_32.lib for windows
End Version

Version Not Windows
	Option CPP_FLAGS 	" -include httplib.h "
End Version

' download link
' https://github.com/yhirose/cpp-httplib

Sub Main
	#using namespace httplib; // uses # to write C/C++ codes directly
	
	Dim cli As Client("localhost", 1234)
	Dim res = cli.Get("/hi")
	
	If (res AndAlso res->status = 200) Then
		cout << res->body << endl
	End If
End Sub
