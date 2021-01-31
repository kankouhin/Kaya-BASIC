
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


using namespace bpp;

extern "C" void abort_with_error(const string& s)
{
	string err = "Error: " + s + "\r\n";

	while (true)
	{
		static bool first = true;
		int line = dbg_getline();
		string func = dbg_getfunc();
		if (!line)
			break;
		if (first)
		{
			err = err + "    raised";
			first = false;
		}
		else
			err = err + ",\r\n    called";

        char buf[20] = {0};
        sprintf(buf, "%d", line);
		err = err + " by " + func + "() at line #" + buf;
	}
	err = err + "\r\n";

	wxMessageBox( err );
	exit(0);
}

class BApp : public wxApp
{
public:
    virtual bool OnInit();
};

wxIMPLEMENT_APP(BApp);


namespace bpp {
	namespace System {
		extern bpp::array<string>  Command;
	}
}


bool BApp::OnInit()
{
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
	catch (const string& s)
	{
		abort_with_error(s);
	}
	catch (...)
	{
		abort_with_error("");
	}

	#ifdef __BPPWIN__
		CoUninitialize();
	#endif

    return true;
}
