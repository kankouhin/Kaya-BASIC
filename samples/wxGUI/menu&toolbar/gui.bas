Option Explicit
Option Resource "toolbar.rc"

Dim f 			As wxFrame Ptr
Dim menu_bar 	As wxMenuBar Ptr
Dim sbr 		As wxStatusBar Ptr
Dim tbr 		As wxToolBar Ptr

Sub OnAbout(ByRef event As wxCommandEvent)
	wxMessageBox( "Wellcome to wxWidgets 3.1.3 World." )
End Sub

Sub OnExit(ByRef event As wxCommandEvent)
	f.Close()
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "xxxBar demo" )
	menu_bar = New wxMenuBar
	
	Dim file_menu As New wxMenu

    file_menu.Append(100, "&About")
    file_menu.AppendSeparator()
    file_menu.Append(101, "E&xit\\tCtrl-X")
	
    menu_bar.Append(file_menu, "&File")
    f.SetMenuBar(menu_bar)
    
    tbr = f.CreateToolBar()
    sbr = f.CreateStatusBar()
    
    f.SetStatusText("Hello, wxWidgets")
    
    Dim toolBarBitmaps(7) As wxBitmap
    
    toolBarBitmaps(0) = wxBITMAP(tnew)
    toolBarBitmaps(1) = wxBITMAP(topen)
    toolBarBitmaps(2) = wxBITMAP(tsave)
    toolBarBitmaps(3) = wxBITMAP(tcopy)
    toolBarBitmaps(4) = wxBITMAP(tcut)
    toolBarBitmaps(5) = wxBITMAP(tpaste)
    toolBarBitmaps(6) = wxBITMAP(tprint)
    toolBarBitmaps(7) = wxBITMAP(thelp)
    
    tbr.AddTool(wxID_NEW, "New", _
                     toolBarBitmaps(0), wxNullBitmap, wxITEM_DROPDOWN, _
                     "New file", "This is help for new file tool")

    Dim menu As New wxMenu
    menu.Append(wxID_ANY, "&First dummy item")
    menu.Append(wxID_ANY, "&Second dummy item")
    menu.AppendSeparator()
    menu.Append(wxID_EXIT, "Exit")
    tbr.SetDropdownMenu(wxID_NEW, menu)
    
    tbr.AddTool(wxID_OPEN, "Open", _
                     toolBarBitmaps(1), wxNullBitmap, wxITEM_NORMAL, _
                     "Open file", "This is help for open file tool")

    Dim combo As New wxComboBox(tbr, wxID_ANY, wxEmptyString, wxDefaultPosition, f.FromDIP(wxSize(100,-1)) )
	combo.Append("This")
	combo.Append("is a")
	combo.Append("combobox with extremely, extremely, extremely, extremely long label")
	combo.Append("in a")
	combo.Append("toolbar")
	tbr.AddControl(combo, "Combo Label")
    
    tbr.AddTool(wxID_SAVE, "Save", toolBarBitmaps(2), "Toggle button 1", wxITEM_CHECK)

    tbr.AddSeparator()
    tbr.AddTool(wxID_COPY, "Copy", toolBarBitmaps(3), "Toggle button 2", wxITEM_CHECK)
    tbr.AddTool(wxID_CUT, "Cut", toolBarBitmaps(4), "Toggle/Untoggle help button")
    tbr.AddTool(wxID_PASTE, "Paste", toolBarBitmaps(5), "Paste")
    tbr.AddSeparator()
    
    tbr.AddTool(wxID_PRINT, "Print", toolBarBitmaps(6), _
                         "Delete this tool. This is a very long tooltip to test whether it does the right thing when the tooltip is more than Windows can cope with.")

    tbr.AddStretchableSpace()
    tbr.AddTool(wxID_HELP, "Help", toolBarBitmaps(7), "Help button", wxITEM_CHECK)
    
    tbr.Realize()
    
	menu_bar.Bind( wxEVT_MENU, AddressOf OnAbout, 100 )
	menu_bar.Bind( wxEVT_MENU, AddressOf OnExit , 101 )
	
	f.Show(TRUE)

End Sub