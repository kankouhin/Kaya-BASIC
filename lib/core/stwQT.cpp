#include "core.h"
#include <stdlib.h>
#include <locale.h>
#include <iostream>

#ifdef __BPPWIN__
	#include <windows.h>
#endif

#include <QtWidgets/QApplication>
#include <QtWidgets/QMessageBox>

extern "C" void abort_with_error(const string& s)
{
	string err = "Error: " + s + "\n";
	err += bpp::dbg_callstack();

	QMessageBox msgbox;
	msgbox.setText(QString::fromStdString(err));
	msgbox.setIcon(QMessageBox::Critical);
	msgbox.exec();
	
	exit(-1);
}

void term_func()
{
	string err = "(terminate)Unknown error\n";
	err += bpp::dbg_callstack();

	QMessageBox msgbox;
	msgbox.setText(QString::fromStdString(err));
	msgbox.setIcon(QMessageBox::Critical);
	msgbox.exec();
	
	exit(-1);
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
	std::set_terminate( term_func );

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

	auto ret = app.exec();
	
	#ifdef __BPPWIN__
		CoUninitialize();
	#endif
	
	return ret;
}
