#ifndef __PLATFORM_WX_H__
#define __PLATFORM_WX_H__

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
	#include <wx/wx.h>
#endif

#include <wxIcons.h>

#include <wx/sstream.h>
#include <wx/protocol/http.h>
#include <wx/xml/xml.h>
#include <wx/zipstrm.h>
#include <wx/wfstream.h>

#include <wx/jsonval.h>
#include <wx/jsonreader.h>
#include <wx/jsonwriter.h>

#include <wx/wxsqlite3.h>

#include <wxThreadEx.h>


namespace bpp 
{
	inline string conv(string* ptr, wxString x)
	{
	    return x.ToStdString();
	}

	inline wxString conv(wxString* ptr, string x)
	{
	    return wxString( x );
	}

	namespace System
	{
		inline void DoEvents()
		{
			wxYield();
		}

		inline Integer MsgBox(string prompt, Integer button, string title, Integer icon)
		{
		    return wxMessageBox( prompt, title, button );
		}
	}
}

#endif