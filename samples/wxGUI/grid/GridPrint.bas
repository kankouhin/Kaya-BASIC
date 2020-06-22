Option Explicit

Declare Sub PrintPage(dc As wxDC Ptr, page As Integer) 
##include "wxPrintoutEx.h"

Dim f As wxFrame Ptr
Dim grid As wxGrid Ptr

sub PrintPage 
   
   grid.Render( *dc )
   
end Sub

Sub OnPrintClick(ByRef ev As wxCommandEvent)
	Dim printer As wxPrinter
	Dim cp As wxPrintoutEx( 1 )
	
	printer.Print( f, @cp, True)
End Sub

Sub OnPrintPreviewClick(ByRef ev As wxCommandEvent)
	Dim preview As new wxPrintPreview( new wxPrintoutEx(1), new wxPrintoutEx(1) )
	Dim frame As New wxPreviewFrame(preview, f, "Print Preview", wxPoint(100, 100), wxSize(600, 650))
	frame.Centre(wxBOTH)
	frame.Initialize
	frame.Show
End Sub

Sub Main
	f = New wxFrame(Nothing, wxID_ANY, "wxGrid Sample", wxPoint(25, 25), wxSize(650, 450))
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
	
	Dim menu_bar As New wxMenuBar
	Dim file_menu As New wxMenu
	
	file_menu.Append(100, "&Print")
	file_menu.Append(101, "Print Pre&view")
	
	menu_bar.Append(file_menu, "&File")
	f.SetMenuBar(menu_bar)	
	
	menu_bar.Bind( wxEVT_MENU, AddressOf OnPrintClick, 100 )
	menu_bar.Bind( wxEVT_MENU, AddressOf OnPrintPreviewClick , 101 )
	
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(True)
End Sub