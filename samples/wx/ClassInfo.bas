Option Explicit

Const wxHelpPath As String = "C:\\DataMigration\\FreeBasic\\KayaBASIC\\wxWidgets-3.1.3-docs-html\\"

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
	
	s = s.Replace( "virtual ", "" )	
	s = s.Replace( "const ", "" )
	s = s.Replace( "&amp;", "& " )
	s = s.Replace( "&#160;", " " )
	s = s.Replace( "&lt;", "<" )
	s = s.Replace( "&gt;", "<" )
	
	s = s.Replace( "(", "( " )
	s = s.Replace( ")", " )" )
	
	Return s.Trim
End Function

Sub loadClassInfo( fileName As String )
	
	Open fileName For Input As #1
	Defer Close #1
	
	Dim sLine As String
	Dim className As String
	Dim incFile As String
	
	Dim col As String Collection
	While Not Eof(1)
		
		Line Input #1, sLine
		sLine = sLine.Trim
		
		If sLine.StartsWith( "<title>" ) Then
			Dim ar() As String = sLine.Split( " " )
			className = ar(1)
			col.Add( className )
		End If
		
		If incFile.Len = 0 AndAlso sLine.StartsWith( "<p><code>" ) Then
			Dim ar() As String = sLine.Split( ";" )
			incFile = ar(1)
			ar = incFile.Split("&")
			incFile = "<" + ar(0) + ">"
			col.Add( incFile )
		End If
		
		If sLine.StartsWith( "<tr class=\"memitem:" ) Then
			Dim func As String = getText( sLine )
			Dim ar() As String = func.Split( " " )
			
			Dim fn As String
			Dim isPtr As Boolean
			Dim isStatic As Boolean
			
			Dim idx As Integer
			For each idx, s As String in ar
				If s = "(" Then
					idx -= 1
					fn = ar(idx)
					Exit For
				End If
			Next

			If fn.Len > 0 AndAlso idx > 0 Then
				isStatic = ( ar(0) = "static" )
				isPtr = ( ar(idx-1) = "*" )
				
				Dim rt As String
				If isPtr Then
					rt = ar(idx-2)
				Else
					rt = ar(idx-1)
				End If 
		
				col.Add( className + "::" + fn + "," + isStatic.Str + "," + isPtr.Str + "," + rt + "\t\t\t\t\t\t" + func )
			End If 
		End If
	Wend
	
	Open className For Output As #2
	Defer Close #2
	
	For Each s As String in col
		Print #2, s
	Next
	
End Sub

Sub Main
	Call loadClassInfo( Command(1) )	
End Sub