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
	
	s = s.Replace( "&amp;", "& " )
	s = s.Replace( "&#160;", " " )
	s = s.Replace( "&lt;", "<" )
	s = s.Replace( "&gt;", "<" )
	
	Return s.Trim
End Function


Function getTextSpec( htmlText As String, spec As String, beginflag As String, endflag As String ) As String
	Dim s As String
	Dim idx As Integer
	Dim iPos As Integer

	idx = InStr( beginflag + spec, htmlText )
	If idx = 0 Then
		Function = ""
	End If
	
	idx += beginflag.Len
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

		If loadRelationClass Then
			If sLine.StartsWith( "<area shape=\"rect" ) Then 
				Dim s As String = getTextSpec( sLine, "", "href=\"", "\"" )
				Call loadClassInfo( s ,False )
			End If
		End If
		
		If sLine.StartsWith( "<li><span class=\"style" ) Then 
			Dim s As String = getTextSpec( sLine, "wx", ">", "<" )
			colConsts.Add( s )
		End If

		If sLine.StartsWith( "<li><code>" ) Then 
			Dim s As String = getTextSpec( sLine, "wx", ">", "<" )
			colConsts.Add( s )
		End If

		If sLine.StartsWith( "<li><span class=\"event" ) Then 
			Dim s As String = getTextSpec( sLine, "wxEVT_", ">", "<" )
			colConsts.Add( s )
		End If

		' get inherited classes
		If sLine.StartsWith( "<tr class=\"inherit_header pub_methods" ) Then
			Dim base As String = getText( sLine )
			Dim sFrom As String = "inherited from "
			Dim ipos As Integer = sFrom.Instr( base ) + sFrom.Len
			
			base = base.Mid( ipos )
			colInhertedFrom.Add( base )
			
			If loadRelationClass Then
				Dim s As String = getTextSpec( sLine, "", "href=\"", "\"" )
				Call loadClassInfo( s ,False )
			End If			
		End If
		
		If sLine.StartsWith( "<table class=\"memname\">" ) Then
			Dim func As String
			Dim params As Integer = 0
			
			Do 
				Line Input #f1, sLine
				sLine = sLine.Trim
				
				If sLine.StartsWith( "<td class=\"paramtype" ) then
					params++
				End If
				
				func += getText( sLine )
				func += " "
			Loop Until sLine.StartsWith( "</table>" )
					
			func = func.Replace( "virtual", "" )	
			func = func.Replace( "const", "" )
			func = func.Replace( className + "::", "" )	
			func = func.Trim
			
			Dim ar() As String = func.Split( " " )
			
			Remove_If( begin(ar), end(ar), _
					Function(s)
						Return (s.Len = 0)
					End Function )
			
			Dim fn As String
			Dim idx As Integer
			
			For each idx, s As String in ar
				If s = "(" Then
					idx -= 1
					fn = ar(idx)
					Exit For
				End If
			Next
			
			If idx > 0 Then
				Dim isStatic As Boolean = ( ar(0) = "static" )
				Dim rt As String = ar(idx-1)
				Dim isPtr As Boolean = ( rt.Right(1) = "*" )
				
				If isPtr Then
					rt = rt >> 1
				End If

				If rt.Right(1) = "&" Then
					rt = rt >> 1
				End If
				
				func = fn + "," + isStatic.Str + "," + isPtr.Str + "," + params.Str + "," + rt + ",\t\t\t\t\t\t" + func 
				colMembers.Add( func )
			End If
		End If
	Wend
	
	Dim f2 As Integer = FreeFile
	Open className For Output As #f2
	Defer Close #f2
	
	Print #f2, "[CONSTS]"
	For Each s As String in colConsts
		If s.Len Then
			If s.Right(1) = ":" Then
				s = s >> 1
			End If 
		
			Print #f2, s
		End If
	Next
	
	Print #f2, "[METHODS]"
	For Each s As String in colMembers
		If s.Len Then
			Print #f2, s
		End If
	Next
	
	Print #f2, "[INHERITS]"
	For Each s As String in colInhertedFrom
		If s.Len Then
			Print #f2, s
		End If
	Next	
End Sub

Sub Main
	Call loadClassInfo( Command(1) )	
End Sub