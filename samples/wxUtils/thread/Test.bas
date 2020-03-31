Option Explicit

Dim f As wxFrame Ptr
Dim btnStart As wxButton Ptr
Dim btnStart2 As wxButton Ptr
Dim btnStop As wxButton Ptr

Dim thread As wxThreadJoinable Ptr
Dim cnt As Integer

Dim ar(3) As String
Dim mux As wxMutex

Dim bStop As BOOLEAN
Dim bMutex As BOOLEAN

Sub ThreadProc
	Do
		If bMutex Then
			mux.Lock()
		End If
	
		cnt++
		For idx As Integer = 0 To UBound(ar)
			wxMilliSleep(1)
			ar(idx) = Str(cnt)
		Next
		
		If bMutex Then
			mux.Unlock()
		End If

	Loop Until( bStop )
	
End Sub

Sub OnStartClick(ByRef ev As wxCommandEvent)

	btnStart.Disable()
	btnStart2.Disable()
	btnStop.Enable()

	bMutex = ev.GetId() - 100
	bStop = FALSE
	
	thread = New wxThreadJoinable
	thread.OnRun = AddressOf ThreadProc
	thread.Run()
	
	Do
		If bMutex Then
			mux.Lock()
		End If
		
		cnt++
		wxMilliSleep(1)
		
		Dim s As String = Join(ar, ",")
		f.SetTitle( s )
		f.Refresh()
		
		If bMutex Then
			mux.Unlock()
		End If
		
		DoEvents
		
	Loop Until( bStop )
End Sub

Sub OnStopClick(ByRef ev As wxCommandEvent)

	btnStop.Disable()
	
	bStop = True
	Do While ( thread.IsRunning() )
		DoEvents
	Loop
	
	wxDELETE(thread)
	btnStart.Enable()
	btnStart2.Enable()
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "Thread Sample" )
	f.SetClientSize(wxSize(500,100))
	
	Dim p As New wxPanel(f, wxID_ANY)
	btnStart = New wxButton(p, 100, "Start(NO Mutex)", wxPoint(100,20))
	btnStart.Bind( wxEVT_BUTTON, Addressof OnStartClick )
	btnStart2 = New wxButton(p, 101, "Start(WITH Mutex)", wxPoint(280,20))
	btnStart2.Bind( wxEVT_BUTTON, Addressof OnStartClick )	

	btnStop = New wxButton(p, 102, "Stop", wxPoint(100,60))
	btnStop.Bind( wxEVT_BUTTON, Addressof OnStopClick )
	btnStop.Disable()
    
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub

