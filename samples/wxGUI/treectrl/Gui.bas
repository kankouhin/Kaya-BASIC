Option Explicit

Dim f As wxFrame Ptr
Dim m_treeCtrl As wxTreeCtrl Ptr

Sub OnItemSelectChanging(ByRef event As wxTreeEvent)
	Dim item As wxTreeItemId = event.GetItem ' event.getitem also OK, because wxTreeEvent class defined.
	f.SetTitle( "treectrl demo " + m_treeCtrl.GetItemText( item ) )
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "treectrl demo" )

	Dim images As New wxImageList(16, 16)
	images.Add( wxArtProvider.GetIcon(wxART_FOLDER, wxART_OTHER, wxSize(16,16)) )
	images.Add( wxArtProvider.GetIcon(wxART_FOLDER_OPEN, wxART_OTHER, wxSize(16,16)) )
	images.Add( wxArtProvider.GetIcon(wxART_NORMAL_FILE, wxART_OTHER, wxSize(16,16)) )

	images.Add( wxArtProvider.GetIcon(wxART_CUT, wxART_OTHER, wxSize(16,16)) )

	m_treeCtrl = New wxTreeCtrl( f )
	m_treeCtrl.SetImageList( images )

	Dim root As wxTreeItemId = m_treeCtrl.AppendItem( NULL, "root", 0, 1 )
	m_treeCtrl.Appenditem( root, "item1", 2 )
	m_treeCtrl.AppendItem( root, "item2", 2 )
	m_treeCtrl.AppendItem( root, "item3", 2 )
	m_treeCtrl.AppendItem( root, "item4", 2 )
	m_treeCtrl.AppendItem( root, "item5", 3 )

	m_treeCtrl.Bind( wxEVT_TREE_SEL_CHANGING, AddressOf OnItemSelectChanging )

	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub