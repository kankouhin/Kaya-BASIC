Option Explicit
' http://www.cplusplus.com/reference/regex/regex_search/

Sub Main
	Dim s As String = "this subject has a submarine as a subsequence"
	Dim m As SMatch
	Dim e As RegEx("\\b(sub)([^ ]*)")
	
	cout << "Target sequence: " << s << endl
	cout << "Regular expression: /\\b(sub)([^ ]*)/" << endl
	cout << "The following matches and submatches were found:" << endl

	While Regex_Search(s,m,e)
		For each x As String in m
			cout << x << " "
		Next
 	
		cout << endl
		s = m.suffix().str()
	Wend
End Sub
