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

		inline Integer MsgBox(string prompt, Integer button, string title)
		{
			QString qprompt = QString::fromStdString(prompt);
			QString qtitle = QString::fromStdString(title);
			QMessageBox::StandardButton qbutton = (QMessageBox::StandardButton)button;
			
			if ( button & QMessageBox::Question )
				return QMessageBox::question(NULL, qtitle, qprompt, qbutton);
			else if ( button & QMessageBox::Information )
				return QMessageBox::information(NULL, qtitle, qprompt, qbutton);
			else if ( button & QMessageBox::Warning )
				return QMessageBox::warning(NULL, qtitle, qprompt, qbutton);
			else if ( button & QMessageBox::Critical )
				return QMessageBox::critical(NULL, qtitle, qprompt, qbutton);
			else
				return QMessageBox::information(NULL, qtitle, qprompt, qbutton);
			
		}
	}
}

#endif