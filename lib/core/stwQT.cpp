#include "core.h"
#include <stdlib.h>
#include <locale.h>
#include <iostream>

#ifdef __BPPWIN__
	#include <windows.h>
#endif

#include <QtWidgets/QApplication>
#include <QtWidgets/QMessageBox>

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

	QMessageBox msgbox;
	msgbox.setText(QString::fromStdString(err));
	msgbox.setIcon(QMessageBox::Critical);
	msgbox.exec();
	
	exit(0);
}

namespace bpp::System {
	extern bpp::array<string> Command;
}

int main(int argc, char* argv[])
{
	#ifdef __BPPWIN__
		CoInitialize(NULL);
	#endif
	
	//setlocale(LC_ALL, "");
	QApplication app(argc, argv);
	
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
		abort_with_error("");
	}
	
	auto ret = app.exec();
	
	#ifdef __BPPWIN__
		CoUninitialize();
	#endif
	
	return ret;
}
