Option Explicit

Function func As Integer
	Function = True	' NOTE!!! = Return True
	Print "never run"
End Function

Sub sub1
	Print "sub1"
	Exit Sub ' = Return
	Print func
End Sub

Class Cls
	Public Property Height As Integer ReadOnly
End Class

Property Get Cls.Height
	Property = 100 ' NOTE!!! = Return 100
	Print "never run"
End Property 

Sub Main
	Dim c As New Cls
	
	Print c.Height
	Print func
	Call sub1
End Sub
