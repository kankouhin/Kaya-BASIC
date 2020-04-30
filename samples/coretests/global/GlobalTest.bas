Option Explicit

Using GlobalVar
Using GlobalUse

Sub Main
	
	changeGlobal2
	print "Global var: ", varGlobal
	varGlobal += varGlobal
	print "Global var: ", varGlobal
	
	
	changeGlobal
	print "Global var: ", varGlobal
	
	arGlobal(1,1,1) = 100
	print Ubound(arGlobal,1)
	print Ubound(arGlobal,2)
	print Ubound(arGlobal,3)
	print arGlobal(1,1,1)
	
End Sub