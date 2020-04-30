Option Explicit

' Function with Array, Collection, Dictionary, Class, Type

Type Person 
	Name As String
	Age As Integer
	Address As String
End Type

Class CPerson
	Public Name As String
	Public Age As Integer
	Public Address As String
End Class

Sub testArray( ByRef ar() As String )
	For Each s As String in ar
		Print s
	Next
End Sub

Sub testList( ByRef ar As String Collection )
	For Each s As String in ar
		Print s
	Next
End Sub

Sub testTable( ByRef ar As String Dictionary )
	For Each k As String, v As String in ar
		Print "Key:", k, " Value:", v
	Next
End Sub

Sub testType( ByRef t As Person )
	Print "Name:", t.Name, " Age:", t.Age, " Address:", t.Address
End Sub

Sub testClass( ByRef t As CPerson )
	Print "Name:", t.Name, " Age:", t.Age, " Address:", t.Address
End Sub

Function funcArray As String()
	Dim ar(5) As String
	For idx As Integer = 0 To 5
		Dim s As String = "funcArray" + Str(idx)
		ar(idx) = s
	Next
	
	Return ar ' MUST use return keyword
End Function

Function funcList As String Collection
	Dim list As String Collection
	For idx As Integer = 0 To 5
		Dim s As String = "funcList" + Str(idx)
		list.add( s )
	Next
	
	Return list ' MUST use return keyword
End Function

Function funcTable As String Dictionary
	Dim dict As String Dictionary
	For idx As Integer = 0 To 5
		Dim s As String = "funcTable" + Str(idx)
		dict(s) = s + " Value" + Str(idx)
	Next
	
	Return dict ' MUST use return keyword
End Function

Sub Main
	Dim ar(5) As String
	Dim list As String Collection
	Dim dict As String Dictionary
	Dim per As Person
	Dim cper As New CPerson
	
	per.Name 	= "KayaBASIC"
	per.Age 	= 1
	per.Address = "China"

	cper.Name 	= "KayaBASIC"
	cper.Age 	= 1
	cper.Address = "China"
		
	For idx As Integer = 0 To 5
		Dim s As String = "Item" + Str(idx)
		ar(idx) = s
		list.add( s + " in List")
		dict(s) = s + " Value" + Str(idx)
	Next
	
	Call testArray( ar )
	Call testList( list )
	Call testTable( dict )
	Call testType( per )
	Call testClass( cper )
	
	
	Dim per2 As Person
	Dim cper2 As CPerson
		
	cper2 = cper
	per2 = per

	Call testType( per2 )
	Call testClass( cper2 )
	
	For each s As String in funcArray
		Print s
	Next	
 
	For each s As String in funcList
		Print s
	Next

	Dim table As String Dictionary = funcTable ' MUST dim a dictionary variable 
	For Each k As String, v As String in table
		Print "Key:", k, " Value:", v
	Next
End Sub
