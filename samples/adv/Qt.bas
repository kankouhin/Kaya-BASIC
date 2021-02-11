Option Explicit
Option PlatForm QT
Option m64 On

Option CPP_FLAGS 	" -std=c++17 -IC:/Qt/6.0.1/mingw81_64/include "
Option LD_FLAGS 	" -LC:/Qt/6.0.1/mingw81_64/lib -lQt6Core -lQt6Widgets " 

Using AnyCPP
Using <QtWidgets/QApplication>
Using <QtWidgets/QVBoxLayout>
Using <QtWidgets/QLabel>

Sub Main
        Dim window As QWidget Ptr = new QWidget

        Dim Layout As QVBoxLayout Ptr = new QVBoxLayout
        Dim label1 As QLabel Ptr = new QLabel("你好")
        Dim label2 As QLabel Ptr = new QLabel(" KayaBASIC")

        Layout.addWidget(label1)
        Layout.addWidget(label2)

        window.setLayout(Layout)        
        window.show()
End Sub