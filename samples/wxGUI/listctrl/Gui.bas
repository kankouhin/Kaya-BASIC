Option Explicit
Using MsgBoxDoEvents

Dim f As wxFrame Ptr
Dim listctrl As wxListCtrl Ptr

Dim colSort As Integer
Dim arSort(1) As Integer

Callback Function myCompareFunction(item1 As Long, item2 As Long, sortData As Long) As Integer

	Dim row1,row2 As Long
	
	row1 = listctrl.FindItem( -1, item1 )
	row2 = listctrl.FindItem( -1, item2 )

	If row1 = -1 Or row2 = -1 Then
		Return 0
	End If

	Dim str1 As wxString = listctrl.GetItemText( row1, colSort )
	Dim str2 As wxString = listctrl.GetItemText( row2, colSort )

 	Dim ret As Integer = 0
 	If str1 > str2 Then
 		ret = 1
 	ElseIf str1 < str2 Then
 		ret = -1
 	End If
 	
 	If arSort(colSort) > 0 Then
 		ret *= -1
 	End If
 	
    Function = ret
End Function

Sub OnItemSelected(ByRef ev As wxListEvent)
	f.SetTitle( ev.GetText() )
End Sub

Sub OnColumnClick(ByRef ev As wxListEvent)
	colSort = ev.GetColumn()
	arSort(colSort) *= -1
	listctrl.SortItems( AddressOf myCompareFunction, 0 )
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "listctrl" )
	listctrl = New wxListCtrl( f, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxLC_REPORT )

	listctrl.InsertColumn(0, "Column1")
	listctrl.InsertColumn(1, "Column2")

	Dim ret As Long
	
	ret = listctrl.InsertItem(0,"Item 1")
	listctrl.SetItemData( ret, ret )
	ret = listctrl.InsertItem(1,"Item 3")
	listctrl.SetItemData( ret, ret )
	ret = listctrl.InsertItem(2,"Item 2")
	listctrl.SetItemData( ret, ret )
	
	listctrl.SetItem(0,1,"Item 9")
	listctrl.SetItem(1,1,"Item 7")
	listctrl.SetItem(2,1,"Item 8")
	
	listctrl.Bind ( wxEVT_LIST_ITEM_SELECTED , AddressOf OnItemSelected )
	listctrl.Bind ( wxEVT_LIST_COL_CLICK , AddressOf OnColumnClick )
	
	arSort(0) = 1
	arSort(1) = 1

	f.Show(TRUE)
End Sub