Option Explicit

Using LambdaUsing

Type LambdaType
	fn1 As Sub(p As Integer)
	fn2 As Function(p As Integer) As Long
End Type

Class LambdaClass
	Public fn1 As Sub(p As Integer)
	Public fn2 As Function(p As Integer) As Long
End Class

Sub test( fn As Sub(p As Integer), x As Integer )
	fn( x )
End Sub

Sub test2( fn As Function(p As Integer) As Long, x As Integer )
	Dim i As Long = fn( x )
	Print i
End Sub

Sub Main
	Dim fn1 As Sub(p As Integer)
	Dim fn2 As Function(p As Integer) As Long

	Call test( _
				Sub(x As Integer)
					Print x
				End Sub
			, 100 )

	Call test2( _
				Function(x As Integer)
					Print x
					Function = x * x
				End Function
			, 200 )	
			
	Call test3( _
				Sub(x As Integer)
					Print x
				End Sub
			, 300 )

	Call test4( _
				Function(x As Integer)
					Print x
					Function = x * x
				End Function
			, 400 )				
End Sub
