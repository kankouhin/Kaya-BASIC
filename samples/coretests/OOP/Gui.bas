Option Explicit

Using wxWidgets
Using ShapesLib

Dim f As wxFrame Ptr

Sub OnButtonClick(ByRef ev As wxCommandEvent)
	Dim id As Integer = ev.GetId()

	Select Case id
		Case 100 'ClassForName
			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")
			s.Height 	= 300.0
			s.Width 	= 400.0
			Call s.Draw
			Msgbox s.Area

			s = CreateObject("ShapesLib.Triangle")
			s.Height 	= 300.0
			s.Width 	= 400.0
			Call s.Draw
			Msgbox s.Area 		

		Case 200 'CallByName Get

			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")
			s.Height 	= 300.0
			s.Width 	= 400.0

			Dim v As Single
			Dim n As String = "Height"
			CallByName( s, n, Get, v )
			Msgbox v

		Case 300 'CallByName Set

			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")
			s.Width 	= 400.0

			Dim v As Single = 100
			Dim n As String = "Height"
			CallByName( s, n, Set, v )
			s.Draw

		Case 400 ' CallByName Call Sub

			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")
			s.Height 	= 200.0
			s.Width 	= 800.0

			Dim n As String = "Draw"
			CallByName( s, n, Call )

		Case 500 'CallByName Call Function

			Dim s As Shape

			s = CreateObject("ShapesLib.Triangle")
			s.Height 	= 200.0
			s.Width 	= 600.0

			Dim v As Double
			Dim n As String = "Area"
			CallByName( s, n, Call, v)

			MsgBox v

		Case 600 ' CallByName Call Sub with params

			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")

			Dim w As Single = 3
			Dim h As Single = 4

			Dim n As String = "setWidthAndHeight"
			CallByName( s, n, Call )(w,h)

			s.Draw

		Case 700 ' CallByName Call Function with params

			Dim s As Shape

			s = CreateObject("ShapesLib.Rect")

			Dim v As Double
			Dim w As Single = 30
			Dim h As Single = 40

			Dim n As String = "getArea"
			CallByName( s, n, Call, v )(w,h)
			Msgbox v 					
	End Select
End Sub

Sub Main
	f = New wxFrame( NULL, wxID_ANY, "OOP demo" )
	f.SetClientSize(wxSize(435,382))

	Dim p As New wxPanel(f, wxID_ANY)

	Dim btn1 As New wxButton(p, 100, "ClassForName", wxPoint(100,20))
	btn1.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	Dim btn2 As New wxButton(p, 200, "CallByName Get", wxPoint(100,60))
	btn2.Bind( wxEVT_BUTTON, Addressof OnButtonClick )

	Dim btn3 As New wxButton(p, 300, "CallByName Set", wxPoint(100,100))
	btn3.Bind( wxEVT_BUTTON, Addressof OnButtonClick )	

	Dim btn4 As New wxButton(p, 400, "CallByName Call Sub", wxPoint(100,140))
	btn4.Bind( wxEVT_BUTTON, Addressof OnButtonClick )	

	Dim btn5 As New wxButton(p, 500, "CallByName Call Function", wxPoint(100,180))
	btn5.Bind( wxEVT_BUTTON, Addressof OnButtonClick )		

	Dim btn6 As New wxButton(p, 600, "CallByName Call Sub with params", wxPoint(100,220))
	btn6.Bind( wxEVT_BUTTON, Addressof OnButtonClick )	

	Dim btn7 As New wxButton(p, 700, "CallByName Call Function with params", wxPoint(100,260))
	btn7.Bind( wxEVT_BUTTON, Addressof OnButtonClick )	

	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub