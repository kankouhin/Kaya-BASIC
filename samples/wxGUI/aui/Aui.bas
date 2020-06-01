Option Explicit

Dim f As wxFrame Ptr
Dim mgr As wxAuiManager Ptr

Sub OnClose(ByRef ev As wxCloseEvent)
	mgr.UnInit
	wxDELETE( mgr )
	f.Destroy
End Sub

Sub Main	
	f = New wxFrame(NULL, -1, "wxAUI Test", _
                    wxDefaultPosition, wxSize(800,600), _
                    wxDEFAULT_FRAME_STYLE)
	
	mgr = New wxAuiManager
	mgr.SetManagedWindow(f)
	
	Dim text1 As New wxTextCtrl(f, -1, "Pane 1 - sample text", _
        wxDefaultPosition, wxSize(200,150), _
        wxNO_BORDER Or wxTE_MULTILINE)
        
    Dim text2 As new wxTextCtrl(f, -1, "Pane 2 - sample text", _
        wxDefaultPosition, wxSize(200,150), _
        wxNO_BORDER Or wxTE_MULTILINE)
	
	Dim text3 As new wxTextCtrl(f, -1, "Main content window", _
        wxDefaultPosition, wxSize(200,150), _
        wxNO_BORDER Or wxTE_MULTILINE)
    
	' add the panes to the manager
	mgr.AddPane( text1, wxLEFT, wxT("Pane Number One") )
	mgr.AddPane( text2, wxBOTTOM, wxT("Pane Number Two") )
	mgr.AddPane( text3, wxCENTER )
	
	f.Bind( wxEVT_CLOSE_WINDOW, AddressOf OnClose )
	
	mgr.Update
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub

