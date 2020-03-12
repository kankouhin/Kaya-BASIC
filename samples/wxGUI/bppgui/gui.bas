Option Explicit

Dim f As wxFrame Ptr

Dim txtSourcePath 	As wxTextCtrl Ptr
Dim txtLogs			As wxTextCtrl Ptr
Dim btnBrowse 		As wxButton Ptr
Dim btnCompile		As wxButton Ptr
Dim btnExit			As wxButton Ptr

Dim chkStaticLink 	As wxCheckBox Ptr
Dim chkLibrary 		As wxCheckBox Ptr
Dim chkGenHeader 	As wxCheckBox Ptr
Dim chkOutputCPP	As wxCheckBox Ptr
Dim chkComSupport	As wxCheckBox Ptr
Dim chkDebugBPP		As wxCheckBox Ptr
Dim chkCompress		As wxCheckBox Ptr
Dim chkGUI			As wxCheckBox Ptr

Dim rdo32bit		As wxRadioButton Ptr
Dim rdo64bit 		As wxRadioButton Ptr

Const CTRLID_OPTIONS_TEXTBOX 	= 100
Const CTRLID_OPTIONS_BUTTON 	= 200
Const CTRLID_OPTIONS_CHECKBOX 	= 300

Dim txtMinGW32		As wxTextCtrl Ptr
Dim txtMinGW64		As wxTextCtrl Ptr
Dim txtwxInclude	As wxTextCtrl Ptr
Dim txtwxLib32		As wxTextCtrl Ptr
Dim txtwxLib64		As wxTextCtrl Ptr
Dim txtBppPath		As wxTextCtrl Ptr

Dim btnBrowse10		As wxButton Ptr
Dim btnBrowse11		As wxButton Ptr
Dim btnBrowse12		As wxButton Ptr
Dim btnBrowse13		As wxButton Ptr
Dim btnBrowse14		As wxButton Ptr
Dim btnBrowse15		As wxButton Ptr

Dim bppPath As String

Sub saveOptions

	Dim id As Integer
	Open "config" For Output As #1
	
	For id = CTRLID_OPTIONS_TEXTBOX To CTRLID_OPTIONS_TEXTBOX + 6
		Dim txt As wxTextCtrl Ptr = Cast( wxTextCtrl Ptr, f.FindWindow(id) )
		Dim s As String = txt.GetLabel()
		Print #1, s
	Next
	
	For id = CTRLID_OPTIONS_CHECKBOX To CTRLID_OPTIONS_CHECKBOX + 7
		Dim chk As wxCheckBox Ptr = Cast( wxCheckBox Ptr, f.FindWindow(id) )
		Dim s As Integer = chk.GetValue()
		Print #1, Str(s)
	Next
	
	Dim s As String = txtBppPath.GetLabel()
	bppPath = Left( s, InStrRev(s, "\") )
	
	Close #1
End Sub

Sub readOptions

	If Not FileExists("config") Then
		Exit Sub
	End If

	Dim id As Integer
	Open "config" For Input As #1
	
	For id = CTRLID_OPTIONS_TEXTBOX To CTRLID_OPTIONS_TEXTBOX + 6
		Dim s As String
		Line Input #1, s
		Dim txt As wxTextCtrl Ptr = Cast( wxTextCtrl Ptr,  f.FindWindow(id) )
		txt.SetLabel( s )
	Next
	
	For id = CTRLID_OPTIONS_CHECKBOX To CTRLID_OPTIONS_CHECKBOX + 7
		Dim s As String
		Line Input #1, s
		Dim chk As wxCheckBox Ptr = Cast( wxCheckBox Ptr,  f.FindWindow(id) )
		chk.SetValue( CInt(s) )
	Next
	
	Close #1
End Sub

Sub OnExit(ByRef ev As wxCommandEvent)
	f.Close(TRUE)
End Sub

Sub OnCompile(ByRef ev As wxCommandEvent)

	Dim org As String = wxGetCwd()
	Call saveOptions
	
 	Dim s As String = txtSourcePath.GetLabel()
 	
 	Dim ipos As Integer = InStrRev(s, "\")
 	Dim cwd As String 	= Left( s, ipos - 1 )
 	Dim src As String 	= Mid( s, ipos + 1 )
 	
 	src = Left( src, InStr(src, ".") - 1 )
 	wxSetWorkingDirectory( cwd )
 	
 	Dim params As String
	For id As Integer = CTRLID_OPTIONS_CHECKBOX To CTRLID_OPTIONS_CHECKBOX + 7
		Dim chk As wxCheckBox Ptr = Cast( wxCheckBox Ptr,  f.FindWindow(id) )
		If chk.GetValue() Then
			Dim v As String = chk.GetLabel()
			v = Right(v, 3)
			v = Left(v,2 )
			
			params += v + " "
		End If
	Next
	
	If rdo64bit.GetValue() Then
		params += "-m64 "
	End If
	
	s = bppPath + "bpp.exe " + params + src

	Dim o As wxArrayString
	Dim e As wxArrayString

	wxExecute( s, o, e)
	wxSetWorkingDirectory( org )
	
	Dim cnt As Integer = o.GetCount()
	For idx As Integer = 0 To cnt - 1
		*txtLogs << o.Item( idx ) 
		*txtLogs << wxString("\\n")
	Next
	
	cnt = e.GetCount()
	For idx As Integer = 0 To cnt - 1
		*txtLogs << e.Item( idx )
		*txtLogs << wxString("\\n")
	Next
	
End Sub

Sub OnDropFiles(ByRef ev As wxDropFilesEvent)
	txtSourcePath.SetLabel( "" )
	If ev.GetNumberOfFiles() > 1 Then
		Exit Sub
	End If
	
	Dim files As wxString Ptr = ev.GetFiles()
	Dim src As String = *files
	If UCase(Right(src, 4)) <> ".BAS" Then
		Exit sub
	End If
	
	txtSourcePath.SetLabel( *files )
End Sub

Sub OnBrowweForOptions(ByRef ev As wxCommandEvent)
	
	Dim id As Integer = ev.GetId()
	
	id -= 100
	Dim txt As wxTextCtrl Ptr = Cast( wxTextCtrl Ptr,  f.FindWindow(id) )
	
	If id = (CTRLID_OPTIONS_TEXTBOX + 5) Then
		Dim dlg As wxFileDialog(f, "Select B++ Complier", "", "", _
                "Exe files (*.exe)|*.exe", _
                wxFD_OPEN Or wxFD_FILE_MUST_EXIST)
        
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	txt.SetLabel( dlg.GetPath() )
        
        	Dim s As String = dlg.GetPath()
        	bppPath = Left( s, InStrRev(s, "\") )
        End If
	ElseIf id = (CTRLID_OPTIONS_TEXTBOX + 6) Then
		Dim dlg As wxFileDialog(f, "Select B++ file", "", "", _
                "B++ files (*.bpp)|*.bpp", _
                wxFD_OPEN Or wxFD_FILE_MUST_EXIST)
        
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	txt.SetLabel( dlg.GetPath() )
        End If        
	Else
		Dim dlg As wxDirDialog(f)
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	txt.SetLabel( dlg.GetPath() )
        End If
	End If
	
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "B++ Compiler", wxDefaultPosition, wxDefaultSize, wxMINIMIZE_BOX Or wxCLOSE_BOX Or wxCAPTION Or wxCLIP_CHILDREN)
	f.SetClientSize(wxSize(582,471))
	
	Dim Panel1 As New wxPanel(f, wxID_ANY)
	Dim nb As New wxNotebook(Panel1, wxID_ANY, wxPoint(4,4), wxSize(576,416))
	
    Dim Panel2 As New wxPanel(nb, wxID_ANY, wxDefaultPosition, wxSize(585,389), wxTAB_TRAVERSAL)
    
    Dim StaticBox1 As New wxStaticBox(Panel2, wxID_ANY, "Source File", wxPoint(8,16), wxSize(456,64))
    txtSourcePath = New wxTextCtrl(Panel2, CTRLID_OPTIONS_TEXTBOX + 6, wxEmptyString, wxPoint(24,40), wxSize(424,22))
    btnBrowse = New wxButton(Panel2, CTRLID_OPTIONS_BUTTON + 6, "&Browse...", wxPoint(480,32), wxSize(80,32))
    
    Dim StaticBox2 As New wxStaticBox(Panel2, wxID_ANY, "Compile Options", wxPoint(8,88), wxSize(456,160))
    
    chkStaticLink 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX, "Static link wx libraries(-s)", wxPoint(24,120))
    chkLibrary   	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 1, "Compile library(-l)", wxPoint(24,152))
    chkGenHeader 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 2, "Generate C++ header(-h)", wxPoint(24,184))
    chkOutputCPP 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 3, "Dump C++ only(-p)", wxPoint(200,120))
    chkComSupport 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 4, "Add COM support(-c)", wxPoint(200,152))
    chkComSupport.SetValue(FALSE)
    
    chkCompress 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 5, "Compress exe file(-u)", wxPoint(200,184))
    chkDebugBPP 	= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 6, "Debug B++ Compiler(-d)", wxPoint(24,216))
    chkGUI 			= New wxCheckBox(Panel2, CTRLID_OPTIONS_CHECKBOX + 7, "Using wxWidgets(-w)", wxPoint(200,216))

    chkGUI.SetValue(TRUE)    
    chkDebugBPP.SetValue(FALSE)
    chkCompress.SetValue(FALSE)
    chkOutputCPP.SetValue(FALSE)
    chkGenHeader.SetValue(FALSE)
    chkLibrary.SetValue(FALSE)
    chkStaticLink.SetValue(FALSE)
       
    Dim StaticBox3 As New wxStaticBox(Panel2, wxID_ANY, "Target", wxPoint(352,104), wxSize(96,104))
    rdo32bit = New wxRadioButton(Panel2, wxID_ANY, "32bit", wxPoint(368,136))
    rdo32bit.SetValue(TRUE)
    rdo64bit = New wxRadioButton(Panel2, wxID_ANY, "64bit", wxPoint(368,168))
    
    btnCompile = New wxButton(Panel2, wxID_ANY, "Compile", wxPoint(480,80), wxSize(80,32))
    txtLogs = New wxTextCtrl(Panel2, wxID_ANY, wxEmptyString, wxPoint(8,258), wxSize(456,112), wxTE_MULTILINE)
    
   	// Options TabPage
    Dim Panel3 As New wxPanel(nb, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL)
    Dim StaticBox4 As New wxStaticBox(Panel3, wxID_ANY, "MinGW-w64 (unused)", wxPoint(8,16), wxSize(544,104))
    Dim StaticText1 As New wxStaticText(Panel3, wxID_ANY, "32bit(posix-sjlj) :", wxPoint(24,48))
    Dim StaticText2 As New wxStaticText(Panel3, wxID_ANY, "64bit(posix-seh) :", wxPoint(24,80))
    
    txtMinGW32 	= New wxTextCtrl(Panel3, CTRLID_OPTIONS_TEXTBOX, wxEmptyString, wxPoint(128,40), wxSize(312,22))
    txtMinGW64 	= New wxTextCtrl(Panel3, CTRLID_OPTIONS_TEXTBOX + 1, wxEmptyString, wxPoint(128,72), wxSize(312,22))
    btnBrowse10 = New wxButton(Panel3, CTRLID_OPTIONS_BUTTON, "Browse...", wxPoint(456,40))    
    btnBrowse11 = New wxButton(Panel3, CTRLID_OPTIONS_BUTTON + 1, "Browse...", wxPoint(456,72))
    
    Dim StaticBox5 	As New wxStaticBox(Panel3, wxID_ANY, "wxWidgets (unused)", wxPoint(8,136), wxSize(544,128))
    Dim StaticText3 As New wxStaticText(Panel3, wxID_ANY, "Include :", wxPoint(24,168))
    Dim StaticText4 As New wxStaticText(Panel3, wxID_ANY, "Libs(32bit) :", wxPoint(24,200))
    Dim StaticText6 As New wxStaticText(Panel3, wxID_ANY, "Libs(64bit)", wxPoint(24,232))
    
    txtwxInclude 	= New wxTextCtrl	(Panel3, CTRLID_OPTIONS_TEXTBOX + 2, wxEmptyString, wxPoint(128,160), wxSize(312,22))
    txtwxLib32 		= New wxTextCtrl	(Panel3, CTRLID_OPTIONS_TEXTBOX + 3, wxEmptyString, wxPoint(128,192), wxSize(312,22))
    txtwxLib64 		= New wxTextCtrl	(Panel3, CTRLID_OPTIONS_TEXTBOX + 4, wxEmptyString, wxPoint(128,224), wxSize(312,22))
    btnBrowse12 	= New wxButton		(Panel3, CTRLID_OPTIONS_BUTTON + 2, "Browse...", wxPoint(456,160))
    btnBrowse13 	= New wxButton		(Panel3, CTRLID_OPTIONS_BUTTON + 3, "Browse...", wxPoint(456,192))
    btnBrowse14 	= New wxButton		(Panel3, CTRLID_OPTIONS_BUTTON + 4, "Browse...", wxPoint(456,224))

    Dim StaticBox6 As New wxStaticBox(Panel3, wxID_ANY, "B++ Compiler", wxPoint(8,272), wxSize(544,64))
    Dim StaticText5 As New wxStaticText(Panel3, wxID_ANY, "Path :", wxPoint(24,304))
    txtBppPath = New wxTextCtrl(Panel3, CTRLID_OPTIONS_TEXTBOX + 5, wxEmptyString, wxPoint(128,296), wxSize(312,22))
    btnBrowse15 = New wxButton(Panel3, CTRLID_OPTIONS_BUTTON + 5, "Browse...", wxPoint(456,296))
    
    nb.AddPage(Panel2, "Complie", FALSE)
    nb.AddPage(Panel3, "Options", FALSE)
    
    btnExit = New wxButton(Panel1, wxID_ANY, "Exit", wxPoint(480,424), wxSize(83,32))
    
    btnBrowse.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse10.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse11.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse12.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse13.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse14.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    btnBrowse15.Bind( wxEVT_BUTTON, Addressof OnBrowweForOptions )
    
    btnCompile.Bind	( wxEVT_BUTTON, Addressof OnCompile )
    btnExit.Bind	( wxEVT_BUTTON, Addressof OnExit )
    
    txtSourcePath.DragAcceptFiles(TRUE)
    txtSourcePath.Bind( wxEVT_DROP_FILES, Addressof OnDropFiles )
    
    Call readOptions
    
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub