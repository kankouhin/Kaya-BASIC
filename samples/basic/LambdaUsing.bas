Option Explicit

Public Sub test3( fn As Sub(p As Integer), x As Integer )
	fn( x )
End Sub

Public Sub test4( fn As Function(p As Integer) As Long, x As Integer )
	Dim i As Long = fn( x )
	Print i
End Sub
