
Using MsgBoxDoEvents

Public Class Shape
	Public Function Area As Double Interface
	Public Sub Draw Interface
	
	Public Property Height As Single
	Public Property Width As Single

	Private m_Height As Single
	Private m_Width As Single
	
	Public Test1 As Double
	Public Test2 As Single
End Class

Property Get Shape.Height
	Value = m_Height
End Property

Property Set Shape.Height
	m_Height = Value
End Property

Property Get Shape.Width
	Value = m_Width
End Property

Property Set Shape.Width
	m_Width = Value
End Property



Public Class Rect Extends Shape
	Public Function Area
	Public Sub Draw
End Class

Function Rect.Area
	Function = Me.Height * Me.Width
End Function

Sub Rect.Draw
	MsgBox "Rect Height: " + Str(Me.Height) + " Width: " + Str(Me.Width)
End Sub



Public Class Triangle Extends Shape
	Public Function Area
	Public Sub Draw
End Class

Function Triangle.Area
	Function = Me.Height * Me.Width / 2
End Function

Sub Triangle.Draw
	MsgBox "Triangle Height: " + Str(Me.Height) + " Width: " + Str(Me.Width)
End Sub



