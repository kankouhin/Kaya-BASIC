Option Explicit

Sub test( fn As Sub(p As Integer), x As Integer )
	fn( x )
End Sub

Sub test2( fn As Function(p As Integer) As Long, x As Integer )
	Dim i As Long = fn( x )
	Print i
End Sub

Sub Main
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
End Sub
