Option Explicit
' this another sample shows how to use c/c++ library(libcurl)
'
' 1. include header file
' 2. link the libraries
' 3. write codes directly. 
'    NOTE: because nothing(sub/function/const,etc...) defined like wxWidgets classes,
'          you need write codes as same as c/c++: need () after sub name, and also Case-Sensitive.
'
Option CPP_FLAGS 	" -include curl/curl.h "
Option LD_FLAGS		" -lcurl.dll " ' NOTE: the official static library for windows CAN NOT link.

' download links(header files, libs, dlls)
' https://curl.haxx.se/windows/  [Windows 32 bit]

Dim errorBuffer[CURL_ERROR_SIZE] As Char
Dim buffer As String

Function writer( data As char Ptr, size As size_t, nmemb As size_t, writerData As String Ptr ) As Integer
	If writerData = NULL Then
    	Return 0
	End If
		
	*writerData += data

	Return size * nmemb
End Function

Function init(ByRef conn As CURL Ptr, url As String) As Boolean
	Dim code As CURLcode
	
	conn = curl_easy_init()
	
	If conn = NULL Then 
		fprintf(stderr, "Failed to create CURL connection\n")
		c_Exit(EXIT_FAILURE)
	End If 
	
	code = curl_easy_setopt(conn, CURLOPT_ERRORBUFFER, errorBuffer)
	If code <> CURLE_OK Then 
		fprintf(stderr, "Failed to set error buffer [%d]\n", code)
		Return false
	End If
  
	code = curl_easy_setopt(conn, CURLOPT_URL, CStr(url))
	If (code <> CURLE_OK) Then
		fprintf(stderr, "Failed to set URL [%s]\n", errorBuffer)
		Return False
	End If
	
	code = curl_easy_setopt(conn, CURLOPT_FOLLOWLOCATION, 1L)
	If (code <> CURLE_OK) Then 
		fprintf(stderr, "Failed to set redirect option [%s]\n", errorBuffer)
		Return False
	End If 
	
	code = curl_easy_setopt(conn, CURLOPT_WRITEFUNCTION, AddressOf writer)
	If(code <> CURLE_OK) Then 
		fprintf(stderr, "Failed to set writer [%s]\n", errorBuffer)
		Return False
	End If 
	
	code = curl_easy_setopt(conn, CURLOPT_WRITEDATA, @buffer)
	If(code <> CURLE_OK) Then 
		fprintf(stderr, "Failed to set write data [%s]\n", errorBuffer)
		Return False
	End If 
	
	Return true
End Function

Sub Main
	Dim conn As CURL Ptr
	Dim code As CURLcode
	Dim title As String
	
	curl_global_init(CURL_GLOBAL_DEFAULT)
	
	If Not init( conn, command(1) ) Then 
		fprintf(stderr, "Connection initializion failed\n")
		c_Exit(EXIT_FAILURE)
	End If
	
	code = curl_easy_perform(conn)
	curl_easy_cleanup(conn)
	
	If code <> CURLE_OK Then 
		fprintf(stderr, "Failed: [%s]\n", errorBuffer)
		c_Exit(EXIT_FAILURE)
	End If	
	
	Print buffer
End Sub
