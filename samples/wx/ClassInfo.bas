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


Function getTextSpec( htmlText As String, spec As String, beginflag As String, endflag As String ) As String
	Dim s As String
	Dim idx As Integer
	Dim iPos As Integer

	idx = InStr( beginflag + spec, htmlText ) + beginflag.Len
	iPos = InStr( idx + 1, endflag, htmlText )
	
	s = htmlText.Mid( idx, iPos - idx )	
	Return s.Trim
End Function

Sub loadClassInfo( fileName As String, loadRelationClass As Boolean = True )
	Dim f1 As Integer = FreeFile
	
	fileName = wxHelpPath + fileName
	Open fileName For Input As #f1
	Defer Close #f1
	
	Dim sLine As String
	Dim className As String
	Dim incFile As String
	
	Dim colMembers As String Collection
	Dim colConsts As String Collection
	Dim colInhertedFrom As String Collection
	Dim IsBaseClass As Boolean = False
	
	While Not Eof(f1)
		
		Line Input #f1, sLine
		sLine = sLine.Trim
		
		If sLine.StartsWith( "<title>" ) Then
			Dim ar() As String = sLine.Split( " " )
			className = ar(1)
			
			If FileExists( className ) Then
				Exit Sub
			End If
		End If
		
		If incFile.Len = 0 AndAlso sLine.StartsWith( "<p><code>" ) Then
			Dim ar() As String = sLine.Split( ";" )
			incFile = ar(1)
			ar = incFile.Split("&")
			incFile = "<" + ar(0) + ">"
			colMembers.Add( incFile )
		End If
		
		If sLine.StartsWith( "<li><span class=\"style" ) Then 
			Dim s As String = getTextSpec( sLine, "wx", ">", "<" )
			colConsts.Add( s )
		End If
		
		If loadRelationClass Then
			If sLine.StartsWith( "<area shape=\"rect" ) Then 
				Dim s As String = getTextSpec( sLine, "", "href=\"", "\"" )
				Call loadClassInfo( s ,False )
			End If
		End If
		
		If sLine.StartsWith( "<li><span class=\"event" ) Then 
			Dim s As String = getTextSpec( sLine, "wxEVT_", ">", "<" )
			
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

			If fn.Len > 0 Then  
				If idx > 0 Then
					If IsBaseClass = False Then 
						isStatic = ( ar(0) = "static" )
						isPtr = ( ar(idx-1) = "*" )
						
						Dim rt As String
						If isPtr Then
							rt = ar(idx-2)
						Else
							rt = ar(idx-1)
						End If 
				
						colMembers.Add( fn + "," + isStatic.Str + "," + isPtr.Str + "," + rt + "\t\t\t\t\t\t" + func )
					End If
				Else
					If fn <> className Then
						IsBaseClass = True 
						colInhertedFrom.Add( fn )
					End If
				End if
			End If 
		End If
	Wend
	
	Dim f2 As Integer = FreeFile
	Open className For Output As #f2
	Defer Close #f2
	
	For Each s As String in colConsts
		If s.Len Then
			Print #f2, s
		End If
	Next
	
	For Each s As String in colInhertedFrom
		If s.Len Then
			Print #f2, s
		End If
	Next
	
	For Each s As String in colMembers
		If s.Len Then
			Print #f2, s
		End If
	Next
	
End Sub

Sub Main
	Call loadClassInfo( Command(1) )	
End Sub