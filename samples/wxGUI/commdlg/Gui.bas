Option Explicit

Using MsgBoxDoEvents

Dim f As wxFrame Ptr
Dim btnOpen 	As wxButton Ptr
Dim btnSave 	As wxButton Ptr
Dim btnColor 	As wxButton Ptr
Dim btnPrint 	As wxButton Ptr
Dim btnDir 		As wxButton Ptr
Dim btnFont 	As wxButton Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	
	Dim id As Integer = ev.GetId()
	
	doevents
	
	Select Case id
	Case 100
 		Dim dlg As wxFileDialog(f, "Open XYZ file", "", "", _
                "XYZ files (*.xyz)|*.xyz", wxFD_OPEN Or wxFD_FILE_MUST_EXIST)
        
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetPath()
        	msgbox s
        End If
	Case 200
 		Dim dlg As wxFileDialog(f, "Save XYZ file", "", "", _
                "XYZ files (*.xyz)|*.xyz", wxFD_SAVE Or wxFD_OVERWRITE_PROMPT)
        
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetPath()
        	MsgBox(s)
        End If	
	Case 300
		Dim dlg As wxColourDialog(f)
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetColourData().GetColour().GetAsString()
        	MsgBox(s)
        End If	
	Case 400
		Dim dlg As wxPrintDialog(f)
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetPrintDialogData().GetFromPage()
        	MsgBox(s)
        End If	
	Case 500
		Dim dlg As wxDirDialog(f)
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetPath()
        	MsgBox(s)
        End If
	Case 600
		Dim dlg As wxFontDialog(f)
        If (dlg.ShowModal() <> wxID_CANCEL) Then
        	Dim s As String = dlg.GetFontData().GetChosenFont().GetFaceName()
        	MsgBox(s)
        End If	
	End Select
	
End Sub

Sub Main

	f = New wxFrame( NULL, wxID_ANY, "listctrl" )
	f.SetClientSize(wxSize(435,382))

	Dim p As New wxPanel(f, wxID_ANY)

	btnOpen = New wxButton(p, 100, "Open...", wxPoint(100,20))
	btnOpen.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	btnSave = New wxButton(p, 200, "Save...", wxPoint(100,60))
	btnSave.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	btnColor = New wxButton(p, 300, "Color...", wxPoint(100,100))
	btnColor.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	btnPrint = New wxButton(p, 400, "Print...", wxPoint(100,140))
	btnPrint.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	btnDir = New wxButton(p, 500, "Dir...", wxPoint(100,180))
	btnDir.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	btnFont = New wxButton(p, 600, "Font...", wxPoint(100,220))
	btnFont.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	f.Show(TRUE)
End Sub