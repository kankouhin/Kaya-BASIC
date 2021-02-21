Option Explicit
Option Verbose
Option PlatForm QT
Option 64Bit On
Option Console OFF

Using QtWidgets.QApplication
Using QtWidgets.QVBoxLayout
Using QtWidgets.QLabel
Using QtWidgets.QPushButton
Using QtWidgets.QMessageBox

Using ComObject

Sub Button_OnClick
        Try
                Dim app As ComObject
                app.GetObject("Excel.Application")

                Dim s As String = app.Workbooks(1).Worksheets(1).Name
                Dim qs = QString.fromStdString(s)

                Dim msgbox As QMessageBox
                msgbox.setText("The Worksheet's name is " + qs)
                Dim ret As Integer = msgbox.exec()
        Catch msg As String
                Dim msgbox As QMessageBox
                msgbox.setText(QString.fromStdString(msg))
                msgbox.exec()
        End Try
End Sub

Sub Main
        Dim window As QWidget Ptr = new QWidget

        Dim Layout As QVBoxLayout Ptr = new QVBoxLayout
        Dim label1 As QLabel Ptr = new QLabel("你好")
        Dim label2 As QLabel Ptr = new QLabel("KayaBASIC")

        Dim button As QPushButton Ptr = new QPushButton("Get Excel Sheet name")
        QObject.connect(button,  AddressOf QPushButton.clicked, AddressOf Button_OnClick )
        
        Layout.addWidget(label1)
        Layout.addWidget(label2)
        Layout.addWidget(button)

        window.setLayout(Layout)
        window.show()
End Sub