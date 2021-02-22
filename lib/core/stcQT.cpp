#include "core.h"
#include <stdlib.h>
#include <locale.h>
#include <iostream>

#ifdef __BPPWIN__
	#include <windows.h>
#endif

#include <QtCore/QCoreApplication>

extern "C" void abort_with_error(const string& s)
{
	std::cout << "Error: " << s << std::endl;
	std::cout << bpp::dbg_callstack() << std::endl;
	exit(-1);
}

void term_func()
{
	std::cout << "(terminate)Unknown error" << std::endl;
	std::cout << bpp::dbg_callstack() << std::endl;
	exit(-1);
}

namespace bpp::System {
	extern bpp::array<string> Command;
}

int main(int argc, char* argv[])
{
	std::set_terminate( term_func );
	
	#ifdef __BPPWIN__
		CoInitialize(NULL);
	#endif
	
	//setlocale(LC_ALL, "");
	QCoreApplication app(argc, argv);
	
	bpp::System::Command.redim(0, argc -1 );
	for ( int i = 0; i < argc; i++ ) {
		bpp::System::Command(i) = argv[i];
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
	
	return 0;
}
