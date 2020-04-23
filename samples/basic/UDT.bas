Option Explicit

using UDTUsing

Const CC As Integer = 100

Type tagPerson
	Name As String
	Address As String * CC + 156   		' is fixed length char[length]
	ChildrenName(5) As String			' in Type is a static array = C++ String[length]    		!maybe i will change it to BASIC array
	Room(2,3,CC - 96) As Integer		' in Type is a static array = C++ int[len1][len2][len3]		!maybe i will change it to BASIC array
End Type

Sub Main
	
	Dim t1 As tagPerson
	Dim t2 As tagPerson2
	
	t1.Name 	= "Person1"
	t1.Address 	= "Person1 Address"
	
	t2.Name = "Person2"
	t2.Address 	= "Person2 Address"
	
	t1.Name = "Person1" + " Name"
	t2.Name = "Person2" + " Name"

	Print t1.Name
	Print t2.Name

	Print t1.Address, " ", Len(t1.Address)
	Print t2.Address, " ", Len(t1.Address)
	
	Print Ubound(t1.ChildrenName)
	Print Ubound(t1.Room)
	Print Ubound(t1.Room,2)
	Print Ubound(t1.Room,3)
		
End Sub
