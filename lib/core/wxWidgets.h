
#include <wx/wxprec.h>
#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

#include <wx/treectrl.h>
#include <wx/listctrl.h>
#include <wx/button.h>
#include <wx/checkbox.h>
#include <wx/choice.h>
#include <wx/gauge.h>
#include <wx/hyperlink.h>
#include <wx/listbox.h>
#include <wx/radiobut.h>
#include <wx/spinctrl.h>
#include <wx/statbox.h>
#include <wx/statline.h>
#include <wx/stattext.h>
#include <wx/statusbr.h>
#include <wx/textctrl.h>
#include <wx/dirdlg.h>
#include <wx/filedlg.h>
#include <wx/fontdlg.h>
#include <wx/colordlg.h>
#include <wx/printdlg.h>
#include <wx/artprov.h>
#include <wx/notebook.h>


#include <wx/sstream.h>
#include <wx/protocol/http.h>

namespace bpp 
{
	inline string conv(string* ptr, wxString x)
	{
	    return string( x.ToStdString().c_str() );
	}

	inline wxString conv(wxString* ptr, string x)
	{
	    return wxString( x.cstr() );
	}

	#define DoEvents wxYield

	inline Integer MsgBox(string prompt, Integer button, string title)
	{
	    return wxMessageBox( prompt.cstr(), title.cstr(), button );
	}

}