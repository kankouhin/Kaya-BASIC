
Option Explicit

USING globalVar
USING globalUse


Sub Main
	
	changeGlobal2
	print "Global var: ", varGlobal
	varGlobal += varGlobal
	print "Global var: ", varGlobal
	
	
	changeGlobal
	print "Global var: ", varGlobal
	
End Sub