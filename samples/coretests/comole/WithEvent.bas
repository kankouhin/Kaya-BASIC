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
const Worksheet_PivotTableBeforeCommitChanges As Long = &Hb4c

const IID_WorkbookEvents As IID = {&H00024412, &H0000, &H0000, {&HC0, &H00, &H00, &H00, &H00, &H00, &H00, &H46}}
const Workbook_SheetChange As Long = &H61C
const Workbook_SheetSelectionChange As Long = &H616
const Workbook_BeforeClose As Long = &H60A

Dim f As wxFrame Ptr
Dim app As ComObject

Dim WithEvents wb As ComObject Handles IID_WorkbookEvents
DIm WithEvents ws As ComObject Handles IID_WorksheetEvents

Sub wb.Workbook_BeforeClose(Byref Cancel As Boolean)
	If MsgBox("Do not close workbook?", wxYES_NO Or wxICON_INFORMATION) = wxYES Then
		Cancel = True
	End If
End Sub

Sub wb.Workbook_SheetSelectionChange(Sh As ComObject, Target As ComObject)
	Try
		Dim s As String = Sh.Name
		s += " "
 
		Dim v As String = Target.Value
		s += v

		f.SetTitle( s )
	Catch msg As String
		MsgBox msg
	Catch
		MsgBox "Unknown Error occured."		
	End Try	
End Sub

Sub wb.Workbook_SheetChange(Sh As ComObject, Target As ComObject)
	Try
		Dim s As String = Sh.Name
		s += " "

		Dim v As String = Target.Value
		s += v

		f.SetTitle( s )
	Catch msg As String
		MsgBox msg
	End Try
End Sub

Sub ws.Worksheet_Change(Target As ComObject)
	Try
		Dim s As String = Target.Value
		f.SetTitle( s )
	Catch msg As String
		MsgBox msg
	End Try	
End Sub

Sub ws.Worksheet_PivotTableBeforeCommitChanges(TargetPivotTable As ComObject, ValueChangeStart As Long, ValueChangeEnd As Long, Byref Cancel As Boolean)
	MsgBox Str(ValueChangeStart) + " " + Str(ValueChangeEnd)
End Sub

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	Try
		app.GetObject("Excel.Application") ' open excel first
		Set wb = app.Workbooks(1)
		Set ws = wb.Worksheets(1)
	Catch msg As String
		MsgBox msg
	Catch
		MsgBox "Unknown Error occured."
	End Try
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