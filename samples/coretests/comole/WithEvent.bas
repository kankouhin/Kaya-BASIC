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

const IID_WorkbookEvents As IID = {&H00024412, &H0000, &H0000, {&HC0, &H00, &H00, &H00, &H00, &H00, &H00, &H46}}
const Workbook_SheetChange As Long = &H61C
const Workbook_SheetSelectionChange As Long = &H616
const Workbook_BeforeClose As Long = &H60A

Dim f As wxFrame Ptr
Dim app As ComObject
Dim WithEvents wb, ws As ComObject

Sub wb.Workbook_BeforeClose(Byref Cancel As Boolean)
	If MsgBox("Do not close workbook?", wxYES_NO Or wxICON_INFORMATION) = wxYES Then
		Cancel = True
	End If
End Sub

Sub wb.Workbook_SheetSelectionChange(Sh As ComObject, Target As ComObject)
	Dim s As String = Sh.Name
	s += " "
	Dim v As String = Target.Value
	s += v
	MsgBox s
End Sub

Sub wb.Workbook_SheetChange(Sh As ComObject, Target As ComObject)
	Dim s As String = Sh.Name
	s += " "
	Dim v As String = Target.Value
	s += v
	MsgBox s
End Sub

Sub ws.Worksheet_Change(Target As ComObject)
	Dim s As String = Target.Value
	MsgBox "Worksheet_Change " + s
End Sub

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	app.GetObject("Excel.Application") ' open excel first
	Set wb = app.Workbooks(1)
	Set ws = wb.Worksheets(1)

	WithEvents ws To IID_WorksheetEvents
	WithEvents wb To IID_WorkbookEvents
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