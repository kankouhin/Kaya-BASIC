Option Explicit
Option PlatForm QT
Option m64 On

Option CPP_FLAGS 	" -std=c++17 -IC:/Qt/6.0.1/mingw81_64/include "
Option LD_FLAGS 	" -LC:/Qt/6.0.1/mingw81_64/lib -lQt6Core -lQt6Widgets " 

Using AnyCPP
Using <QtWidgets/QApplication>
Using <QtWidgets/QVBoxLayout>
Using <QtWidgets/QLabel>
Using <QtWidgets/QPushButton>

Using ComObject

Dim label2 As QLabel Ptr

Sub Button_OnClick
	Dim app As ComObject
	app.GetObject("Excel.Application")

	Dim s As String = app.Workbooks(1).Worksheets(1).Name
        Dim qs = QString::fromStdString( "Sheet name:" + s)
        label2.setText( qs )
End Sub

Sub Main
        Dim window As QWidget Ptr = new QWidget

        Dim Layout As QVBoxLayout Ptr = new QVBoxLayout
        Dim label1 As QLabel Ptr = new QLabel("你好")
        Dim button As QPushButton Ptr = new QPushButton("Get Excel Sheet name")

        label2 = new QLabel("KayaBASIC")
        QObject::connect(button,  AddressOf QPushButton::clicked, AddressOf Button_OnClick )
        
        Layout.addWidget(label1)
        Layout.addWidget(label2)
        Layout.addWidget(button)

        window.setLayout(Layout)        
        window.show()
End Sub