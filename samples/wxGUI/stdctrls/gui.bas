Option Explicit

Dim f As wxFrame Ptr

Dim txt 	As wxTextCtrl Ptr
Dim btn 	As wxButton Ptr
Dim cbo 	As wxChoice Ptr
Dim chk 	As wxCheckBox Ptr
Dim rdo1 	As wxRadioButton Ptr
Dim rdo2 	As wxRadioButton Ptr
Dim lst 	As wxListBox Ptr
Dim pgr 	As wxGauge Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	
	Static v As Integer = 0
	If v >= 100 Then
		v = 0
	End If
	v += 10

	pgr.SetValue( v )
	
	Dim s As String = Str(v) + "/100"
	txt.SetLabel( s )
	
End Sub

Sub Main

	Dim s as String = "Standard Controls"
	f = New wxFrame( NULL, wxID_ANY, s )
	f.SetClientSize(wxSize(435,382))

	Dim p As New wxPanel(f, wxID_ANY)

	chk = New wxCheckBox(p, wxID_ANY, "CheckBox", wxPoint(8,96), wxSize(160,14)) 
	cbo = New wxChoice(p, wxID_ANY, wxPoint(8,56))
	cbo.Append("wxChoice1")
	cbo.Append("wxChoice2")
	cbo.Append("wxChoice3")
	cbo.Append("wxChoice4")

	btn = New wxButton(p, wxID_ANY, "Progress...", wxPoint(320,304))
	btn.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	pgr = New wxGauge(p, wxID_ANY, 100, wxPoint(8,208), wxSize(200,28))
	Dim link As New wxHyperlinkCtrl(p, wxID_ANY, "https://github.com/kankouhin/Kaya-BASIC", wxEmptyString, wxPoint(8,176))

	lst = New wxListBox(p, wxID_ANY, wxPoint(256,8), wxSize(132,152))
	lst.Append("wxListBox1")
	lst.Append("wxListBox2")
	lst.Append("wxListBox3")
	lst.Append("wxListBox4")
	lst.Append("wxListBox5")

	Dim lbl As New wxStaticText(p, wxID_ANY, "Wellcom to wxWidgets 3.1.3", wxPoint(8,8))
	Dim box As New wxStaticBox(p, wxID_ANY, "options", wxPoint(256,176), wxSize(132,88))

	rdo1 = New wxRadioButton(p, wxID_ANY, "radio1", wxPoint(288,208))
	rdo2 = New wxRadioButton(p, wxID_ANY, "radio2", wxPoint(288,232))

	Dim sp As New wxSpinCtrl(p, wxID_ANY, "0", wxPoint(8,144), wxDefaultSize, 0, 0, 100, 0)
	Dim Line As New wxStaticLine(p, wxID_ANY, wxPoint(0,296), wxSize(500,-1), wxLI_HORIZONTAL)
	txt = New wxTextCtrl(p, wxID_ANY, "Text box ", wxPoint(8,256))

	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub