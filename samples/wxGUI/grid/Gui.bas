Option Explicit

Dim f As wxFrame Ptr
Dim grid As wxGrid Ptr

Sub Main
	f = New wxFrame(Nothing, wxID_ANY, "wxGrid Sample", wxPoint(25, 25), wxSize(350, 250))
	grid = New wxGrid(f, wxID_ANY)
	
	grid.CreateGrid(10, 8)
	grid.SetColSize(3, 200)
	grid.SetRowSize(4, 45)
	grid.SetCellValue(0, 0, "First cell")
	grid.SetCellValue(1, 1, "Another cell")
	grid.SetCellValue(2, 2, "Yet another cell")
	grid.SetCellFont(0, 0, wxFont(10, wxROMAN, wxITALIC, wxNORMAL))
	grid.SetCellTextColour(1, 1, *wxRED)
	grid.SetCellBackgroundColour(2, 2, *wxCYAN)
	
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(True)
End Sub