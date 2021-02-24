#ifndef __PLATFORM_QT_H__
#define __PLATFORM_QT_H__

#include <QtCore/QCoreApplication>
#include <QtWidgets/QMessageBox>

namespace bpp 
{
	inline string conv(string* ptr, QString x)
	{
	    return x.toStdString();
	}

	inline QString conv(QString* ptr, string x)
	{
	    return QString::fromStdString( x );
	}

	namespace System
	{
		inline void DoEvents()
		{
			QCoreApplication::processEvents();
		}

		inline Integer MsgBox(string prompt, Integer button, string title, Integer icon)
		{
			QString qtitle = QString::fromStdString( title );
			QString qprompt = QString::fromStdString( prompt );
			
			if ( icon == QMessageBox::Information )
				return QMessageBox::information(NULL, qtitle, qprompt, button, 0);
			else if ( icon == QMessageBox::Question )
				return QMessageBox::question(NULL, qtitle, qprompt, button, 0);
			else if ( icon == QMessageBox::Warning )
				return QMessageBox::warning(NULL, qtitle, qprompt, button, 0);
			else if ( icon == QMessageBox::Critical )
				return QMessageBox::critical(NULL, qtitle, qprompt, button, 0);
			else
				return QMessageBox::information(NULL, qtitle, qprompt, button, 0);
		}
	}
}

#endif
