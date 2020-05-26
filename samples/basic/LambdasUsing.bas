Option Explicit

Public Type LambdaType2
	fn1 As Sub(p As Integer)
	fn2 As Function(p As Integer) As Long
End Type

Public Class LambdaClass2
	Public fn1 As Sub(p As Integer)
	Public fn2 As Function(p As Integer) As Long
End Class

Public Sub test3( fn As Sub(p As Integer), x As Integer )
	fn( x )
End Sub

Public Sub test4( fn As Function(p As Integer) As Long, x As Integer )
	Dim i As Long = fn( x )
	Print i
End Sub
