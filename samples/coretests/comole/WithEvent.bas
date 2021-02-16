Option Explicit

Using wxWidgets
Using ComObject

/*
copy from oleview.exe
[
  uuid(00024411-0000-0000-C000-000000000046),
  helpcontext(0x0007a938),
  hidden
]
dispinterface DocEvents {
        [id(0x00000609), helpcontext(0x0007a93f)]
        void Change([in] Range* Target);
}
*/
const IID_WorksheetEvents As IID = {&H00024411, &H0000, &H0000, {&HC0, &H00, &H00, &H00, &H00, &H00, &H00, &H46}}
const Worksheet_Change As Long = &H609

Dim f As wxFrame Ptr
Dim app, wb As ComObject
Dim WithEvents ws As ComObject

Sub ws.Worksheet_Change(Target As ComObject)
	Dim s As String = Target.Value

	MsgBox "Worksheet_Change " + s
End Sub

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	app.GetObject("Excel.Application") ' open excel first
	Set wb = app.Workbooks(1)
	Set ws = wb.Worksheets(1)

	WithEvents ws To IID_WorksheetEvents
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "COM WithEvents Sample" )
	f.SetClientSize(wxSize(350,100))

	Dim p As New wxPanel(f, wxID_ANY)
	Dim btnTest As New wxButton(p, 100, "WithEvents", wxPoint(100,20))
	btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub