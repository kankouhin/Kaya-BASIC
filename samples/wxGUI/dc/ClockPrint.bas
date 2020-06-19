Option Explicit

const PI As Double = 3.1415927 
Dim f As wxFrame Ptr

' draw a hand on the clock 
sub drawHand(theDC As wxDC Ptr, halfX As Double, halfY As Double, _
		theTime As Integer, theUnit As Integer, theLength As Double )
		    
	' offset the time by 1/4 of the unit (ie: rotate by 90 degrees) so up is zero 
	Dim theOffset = theUnit / 4.0
	
	' convert the unit into radians 
	Dim rad = 2*pi*((theTime-theOffset)/theUnit) 
	
	' calculate the position of x and y on a unit circle 
	Dim x = (cos(rad) ) 
	Dim y = (sin( rad ) ) 
	
	' scale the positions by the size of the clock face and the length of the hand 
	x = x * halfX * theLength 
	y = y * halfY * theLength 
	
	' draw the clock hand starting from the center of the window 
	theDC.DrawLine( halfX, halfY, x+halfX, y+halfY ) 
end sub 

' draw the face of the clock 
sub PrintPage(dc As wxDC Ptr, page As Integer) 

	' get half the size of the window 
	Dim dx = 500 / 2.0
	Dim dy = 500 / 2.0 
	
	' get the current hour, minute and second 	
	Dim theTime = Time 
	Dim theHour = val( mid( theTime, 1, 2 ) ) 
	Dim theMinute = val( mid( theTime, 4, 2 ) ) 
	Dim theSecond = val( mid( theTime, 7, 2 ) ) 
	
	' erase the prior clock 
	' dc.Clear
	
	' draw 12 ticks around the face 
	Dim i = 0.0
	While i <= 2*PI
		Dim x = cos( i ) * dx * 0.95 
		Dim y = sin( i ) * dy * 0.95 
		dc.drawRectangle( dx + x - 2, dy + y - 2, 4, 4 ) 
		
		i += (2*PI)/12
	Wend
	
	' draw each hand of the clock 
	drawHand( dc, dx, dy, theHour, 12, 0.6 ) 
	drawHand( dc, dx, dy, theMinute, 60, 0.8 ) 
	drawHand( dc, dx, dy, theSecond, 60, 0.9 )    
end Sub

##################################################################################################################################
class Printout: public wxPrintout
{
public:
    Printout(int maxPage)
        : _maxPage(maxPage) { }

    virtual bool OnPrintPage(int page) wxOVERRIDE;
    virtual bool HasPage(int page) wxOVERRIDE;
    virtual bool OnBeginDocument(int startPage, int endPage) wxOVERRIDE;
    virtual void GetPageInfo(int *minPage, int *maxPage, int *selPageFrom, int *selPageTo) wxOVERRIDE;
    
private:
	int _maxPage;
};

bool Printout::OnPrintPage(int page)
{
    wxDC *dc = GetDC();
    if (dc)
    {
     	PrintPage(dc, page);
        return true;
    }
    else
        return false;
}

bool Printout::OnBeginDocument(int startPage, int endPage)
{
    if (!wxPrintout::OnBeginDocument(startPage, endPage))
        return false;

    return true;
}

void Printout::GetPageInfo(int *minPage, int *maxPage, int *selPageFrom, int *selPageTo)
{
    *minPage = 1;
    *maxPage = _maxPage;
    *selPageFrom = 1;
    *selPageTo = _maxPage;
}

bool Printout::HasPage(int pageNum)
{
    return (pageNum >= 1 && pageNum <= _maxPage);
}

##################################################################################################################################

Sub OnPrintClick(ByRef ev As wxCommandEvent)
	
	Dim printer As wxPrinter
	Dim cp As Printout( 1 )
	
	printer.Print( f, @cp, True)
End Sub


Sub Main
	f = New wxFrame(Nothing,-1,"Clock Print",wxPoint(250,150),wxSize(300,300))
	Dim p As New wxPanel(f)
	Dim btn As New wxButton(p, wxID_ANY, "Print", wxPoint(80,80), wxSize(80,32))

	btn.Bind( wxEVT_BUTTON, AddressOf OnPrintClick )
	
	f.SetIcon( wxIcon(sample_xpm) )
	f.Show(TRUE)
End Sub