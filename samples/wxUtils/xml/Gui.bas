Option Explicit

Dim f As wxFrame Ptr
Dim treeCtrl As wxTreeCtrl Ptr

Sub AddChildren( p As wxTreeItemId, pn As wxXmlNode Ptr )
	
	Dim node As wxXmlNode Ptr = pn.GetChildren
	While node <> Nothing
		Dim parent As wxTreeItemId = treeCtrl.AppendItem( p, node.GetName, 2 )
		Call AddChildren( parent, node )
		node = node.GetNext
	Wend
End Sub

Sub LoadDataFromXml
	Dim doc As wxXmlDocument
	doc.Load( "data.xml" )
	
	Dim node As wxXmlNode Ptr = doc.GetRoot
	Dim p As wxTreeItemId = treeCtrl.AppendItem( Nothing, node.GetName, 0 )

	Call AddChildren( p, node )
	
	' just for test
	' Dim n As wxXmlNode
	' n.GetAttributes.getnext.getname.len
End Sub

Sub Main
	f = New wxFrame( Nothing, wxID_ANY, "xml demo" )

	Dim images As New wxImageList(16, 16)
	images.Add( wxArtProvider.GetIcon(wxART_FOLDER, wxART_OTHER, wxSize(16,16)) )
	images.Add( wxArtProvider.GetIcon(wxART_FOLDER_OPEN, wxART_OTHER, wxSize(16,16)) )
	images.Add( wxArtProvider.GetIcon(wxART_NORMAL_FILE, wxART_OTHER, wxSize(16,16)) )
	
	' just for test
	' wxArtProvider.GetIcon(wxART_NORMAL_FILE, wxART_OTHER, wxSize(16,16)).GetClassInfo.FindClass("wxIcon")

	treeCtrl = New wxTreeCtrl( f )
	treeCtrl.SetImageList( images )

	Call LoadDataFromXml
	
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub