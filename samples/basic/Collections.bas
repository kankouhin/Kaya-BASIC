Option Explicit

Sub showList(list As Integer Collection)
	Dim s As String = list.Count + " {"
	
	For each it As Integer in list
		s += it.Str + ", "
	Next
	
	s = s >> 2
	s += "}"
	Print s
End Sub

Sub Main
	Dim list As Integer Collection = {1,2,3,4,5,6}
	Dim list2 As Integer Collection = {10,20,30,40,50,60}
	
	list.Add(7)
	list.Remove(1)		' delete 2nd item. NOTE: index is from 0
	list.RemoveItem(4)	' delete a item(value is 4). ONLY DELETE ONE ITEM, NOT ALL!!!
	
	list << 8 << 9		' = add 8 and 9
	list >> 6 >> 7		' = removeitem 7 and 8
	
	Print "Count ", list.Count
	list.Insert( 2, 2 )	' insert to 3rd item
	Print "Count ", list.Count
	
	Call showList( list )
	list << list2
	Call showList( list )
	list >> list2
	Call showList( list )
	
	Print "Item 0:", list(0)	' access by index
	list.Clear
	Print "Count ", list.Count


	' Dictionary
	Dim dict As Integer Dictionary = { {"Osaka",100}, {"China",200} }
	dict("Tokyo") 	 = 300
	dict("New York") = 400
	dict("Bei Jing") = 500
	dict("Dalian") 	 = 600
	
	Print ""
	For each k As String, v As Integer in dict
		Print k, " : ", v
	Next
	
	Print dict("China")
	Print dict.Contains("China")
	
	dict.Remove("New York")
	Print dict.Contains("New York")
	dict.RemoveItem(600)
	Print dict.Contains("Dalian")

	Print dict.Count
	dict.Clear
	Print dict.Count
End Sub
