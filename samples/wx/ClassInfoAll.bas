Option Explicit

Const wxHelpPath As String = "C:\\DataMigration\\FreeBasic\\KayaBASIC\\wxWidgets-3.1.3-docs-html\\"

Sub Main
	Dim wx As String = Dir( wxHelpPath ) 
	Defer CloseDir
	
	Dim cnt As Integer = 0
	Do While wx.Len > 0
		
		If ( wx Like "classwx_.*.html")  AndAlso _
			Not ( wx Like "classwx_.*members.html" )  Then
			
			Print "Loading ", wx, "..."
			Call Shell( "ClassInfo32_msw.exe " + wx )
	
			cnt++
		End If
		
		wx = Dir
	Loop
	
	Print cnt, " classes loaded."
End Sub