Option Explicit

Dim f As wxFrame Ptr

Sub LoadDataFromWeb
	Dim http As wxHTTP
	Dim httpStream As wxInputStream Ptr
	
	http.SetHeader( "Content-type", "text/html; charset=utf-8" )
	http.SetTimeout(10)
	
	While Not http.Connect( "www.google.com" )
		wxSleep(5)
	Wend
	
	httpStream = http.GetInputStream( "/intl/en/about.html" )
	If (http.GetError() = wxPROTO_NOERR) Then
		Dim res As wxString
		Dim out_stream As wxStringOutputStream( AddressOf res )
		httpStream.Read(out_stream)

		MsgBox res
	Else
		MsgBox "Unable to connect!"
	End If
	
	wxDELETE(httpStream)
	http.Close()
End Sub

Sub Main
	f = New wxFrame( Nothing, wxID_ANY, "http demo" )	
	Call LoadDataFromWeb
	f.Show(TRUE)
End Sub