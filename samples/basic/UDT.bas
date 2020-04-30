Option Explicit

using UDTUsing

Const CC As Integer = 100

Type tagPerson
	Name As String = "tagPerson"
	ChildrenName(5) As String
	Room(2,3,CC - 96) As Integer
	Age As Integer = 10
End Type

Sub Main
	
	Dim t1 As tagPerson
	Dim t2 As tagPerson2
	
/*
	t1.Name 	= "Person1"	
	t2.Name = "Person2"
	
	t1.Name = "Person1" + " Name"
	t2.Name = "Person2" + " Name"
*/
	Print t1.Name
	Print t2.Name
	
	Print Ubound(t1.ChildrenName)
	Print Ubound(t1.Room)
	Print Ubound(t1.Room,2)
	Print Ubound(t1.Room,3)

	Print Ubound(t2.ChildrenName)
	Print Ubound(t2.Room)
	Print Ubound(t2.Room,2)
	Print Ubound(t2.Room,3)
	
	t1.ChildrenName(0) = "Child 1"
	t1.Room(0,0,0) = 100
	
	Print t1.ChildrenName(0)
	Print t1.Room(0,0,0)
	
	t2.ChildrenName(0) = "Child 2"
	t2.Room(0,0,0) = 200
	
	Print t2.ChildrenName(0)
	Print t2.Room(0,0,0)	
	
End Sub
