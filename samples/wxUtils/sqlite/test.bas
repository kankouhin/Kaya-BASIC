Option Explicit

Using MsgBoxDoEvents
Dim f As wxFrame Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)

	Dim testDBName As wxString = wxGetCwd() + wxS("/test2.db")
	If wxFileExists(testDBName) Then 
		wxRemoveFile(testDBName)
	End If
	
	Dim db As wxSQLite3Database
	db.Open(testDBName)
	db.ExecuteUpdate( wxS("CREATE TABLE test (col1 INTEGER)") )
	
	Dim t As wxSQLite3Transaction( AddressOf db )
	db.ExecuteUpdate( wxS("INSERT INTO test (col1) VALUES (1)") )
	db.ExecuteUpdate( wxS("INSERT INTO test (col1) VALUES (2)") )
	db.ExecuteUpdate( wxS("INSERT INTO test (col1) VALUES (3)") )
	t.Commit()
	
	Dim rs As wxSQLite3ResultSet = db.ExecuteQuery( wxS("SELECT * FROM test") )
	
	Do While (rs.NextRow())
		Dim s As wxString = rs.GetAsString(0)
		Msgbox s
	Loop 
	
	rs.Finalize()
End Sub

Sub Main
	wxSQLite3Database::InitializeSQLite()
	
	f = New wxFrame( NULL, wxID_ANY, "SQLite Sample" )
	f.SetClientSize(wxSize(300,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
	Dim btnTest As New wxButton(p, 100, "test", wxPoint(100,20))
	btnTest.Bind( wxEVT_BUTTON, Addressof OnButtonClick )
    
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub

