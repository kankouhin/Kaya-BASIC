Option Explicit

Public Const CC2 As Integer = 100

Public Type tagPerson2
	Name As String
	Address As String * CC2 + 156
	ChildrenName(5) As String
	Room(2, 3, CC2 - 96) As Integer
End Type
