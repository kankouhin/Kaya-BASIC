Option Explicit

Sub Main
	Print Like( "abc", "abc" )
	Print Like( "abc", "ab?c" )
	Print Like( "ac", "ab?c" )
	Print Like( "abbc", "ab?c" )		' <--- is False Only
	Print Like( "abc", "a.c" )
	Print Like( "abcdef", "a.*f" )
	
	Print Like( "abc", "ab*c" )
	Print Like( "ac", "ab*c" )
	Print Like( "abbc", "ab*c" )
	Print Like( "abbbbc", "ab*c" )
	
	if  "abbbbc" Like  "ab*c"  then
		print "done"
	end if

End Sub
