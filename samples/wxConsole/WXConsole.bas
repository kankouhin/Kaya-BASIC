Option Explicit
Option Console On

Sub Main
	
	Dim initializer As wxInitializer
	If Not initializer Then
		fprintf(stderr, "Failed to initialize the wxWidgets library, aborting.")
		Return
	End If

	Dim s As wxString
	s.printf( "%s", "Welcome to the wxWidgets 'console' sample!\n" )
	
	wxPrintf( s )
End Sub
