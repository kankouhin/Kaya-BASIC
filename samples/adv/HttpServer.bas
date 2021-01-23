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
	Dim svr As Server
	
	svr.Get( "/hi", _
				Sub( Const ByRef req As Request, ByRef res As Response )
					res.set_content("Hello World!", "text/plain")
				End Sub
			 )
			 
	svr.Get( "(/numbers/(\\d+))", _
				Sub(ByRef req As Request Const, ByRef res As Response)
					Dim numbers As Auto = req.matches[1]
					res.set_content(numbers, "text/plain")
				End Sub
			)

	svr.listen("localhost", 1234)
	
	' compile and running this sample, use bellowing urls to see the result or HttpClient.bas sample
	' http://localhost:1234/hi
	' http://localhost:1234/numbers/100
End Sub
