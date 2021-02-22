
#include "core.h"
#include <stdlib.h>
#include <locale.h>
#include <stdio.h>

#ifdef __BPPWIN__
	#include <windows.h>
#endif

#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif

extern "C" void abort_with_error(const string& s)
{
	string err = "Error: " + s + "\n";
	err += bpp::dbg_callstack();

	wxMessageBox( err );
	exit(-1);
}

void term_func()
{
	string err = "(terminate)Unknown error\n";
	err += bpp::dbg_callstack();

	wxMessageBox( err );
	exit(-1);
}

class BApp : public wxApp
{
public:
    virtual bool OnInit();
};

wxIMPLEMENT_APP(BApp);


namespace bpp::System {
	extern bpp::array<string>  Command;
}

bool BApp::OnInit()
{
	std::set_terminate( term_func );
	
	#ifdef __BPPWIN__
		CoInitialize(NULL);
	#endif

	wxInitAllImageHandlers();
	SetExitOnFrameDelete( TRUE );

	bpp::System::Command.redim(0, argc - 1);
	for ( int i = 0; i < argc; i++ ) {
		bpp::System::Command(i) = argv[i].ToStdString().c_str();
	}

	try
	{
		__init_all();
		Main();
		__final_all();
	}
	catch (string s)
	{
		abort_with_error(s);
	}
	catch (...)
	{
		abort_with_error("Unknown error");
	}

	#ifdef __BPPWIN__
		CoUninitialize();
	#endif

	return true;
}
