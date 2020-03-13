Option Explicit

Using MsgBoxDoEvents

Dim f As wxFrame Ptr
Dim treeCtrl As wxTreeCtrl Ptr

Sub AddChildren( p As wxTreeItemId, pn As wxXmlNode )
	
	Dim node As wxXmlNode Ptr = pn.GetChildren()
	While node
		Dim parent As wxTreeItemId = treeCtrl.AppendItem( p, node.GetName(), 2 )
		Call AddChildren( parent, *node )
		node = node.GetNext()
	Wend
	
End Sub

Sub LoadDataFromXml
	
	Dim doc As wxXmlDocument
	doc.Load( "data.xml" )
	
	Dim node As wxXmlNode Ptr
	
	node = doc.GetRoot()
	Dim p As wxTreeItemId = treeCtrl.AppendItem( NULL, node.GetName(), 0 )

	Call AddChildren( p, *node )
	
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "treectrl demo" )

	Dim images As New wxImageList(16, 16)
	images.Add( wxICON(wxICON_SMALL_CLOSED_FOLDER) )
	images.Add( wxICON(wxICON_SMALL_OPEN_FOLDER) )
	images.Add( wxICON(wxICON_SMALL_FILE) )

	treeCtrl = New wxTreeCtrl( f )
	treeCtrl.SetImageList( images )

	Call LoadDataFromXml

	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)

End Sub