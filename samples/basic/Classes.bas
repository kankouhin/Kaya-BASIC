Option Explicit

Class Shape
	Public Function Area As Double Interface
	Public Sub Draw Interface
	
	Public Property Height As Single
	Public Property Width As Single

	Private m_Height As Single = 3
	Private m_Width As Single = 4
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



Class Rect Extends Shape
	Public Function Area
	Public Sub Draw
End Class

Function Rect.Area
	Function = Me.Height * Me.Width
End Function

Sub Rect.Draw
	Print "Rect Height: " + Str(Me.Height) + " Width: " + Str(Me.Width)
End Sub

Class Triangle Extends Shape
	Public Function Area
	Public Sub Draw
End Class

Function Triangle.Area
	Function = Me.Height * Me.Width / 2
End Function

Sub Triangle.Draw
	Print "Triangle Height: " + Str(Me.Height) + " Width: " + Str(Me.Width)
End Sub

Sub Main
    Dim s As Shape

    s = New Rect

    s.Height = 8
    s.Width = 10
    s.Draw

    If s Is Shape Then
        Print "s Is a Shape"
    Else
        Print "s Is not a Shape"
    End If

    s = New Triangle
    s.Draw

    If s Is Triangle Then
        Print "s Is a Triangle"
    Else
        print "s Is not a Triangle"
    End If

    s = CreateObject("Classes.Rect") ' new a object by name
    s.Draw

End Sub
