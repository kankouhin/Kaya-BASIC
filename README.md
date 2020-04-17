# Kaya-BASIC
Multi-platform BASIC compiler, supports Windows, Linux and MacOS. easy extends with C++.(Based on B++ complier)

# Features
 - Compiles with g++(support C++11)
 - OOP, supports CreateObject by name and call function/sub/property by name)
 - Creates GUI(using wxWidgets), console or DLL applications.
 - Easy calls Windows COM like VB.
 
# Install(MacOS64bit, tested on 10.12 and 10.15)
 1. download lastest wxWidgets source code (https://www.wxwidgets.org/downloads/  Source for Linux, macOS, etc )
 2. compile and install wxWidgets on MacOS
    - Setup build environment.
         - $ xcode-select --install
    - Compile wxWidgets
    
	  - $ cd wxWidgets.3.1.x
	  - $ mkdir mac-build
	  - $ cd mac-build/ 
	  - $ ../configure --disable-shared --enable-unicode 
	  - $ make
	  
    - Install wxWidgets
         - $ sudo make install
	 
  3. chmod 777 [Kaya-BASIC]/bin/bpp_mac
  
  4. try to build samples
 
# Install(Ubuntu64bit)
 1. download lastest wxWidgets source code (https://www.wxwidgets.org/downloads/  Source for Linux, macOS, etc )
 2. compile and install wxWidgets on Ubuntu
    - Setup build environment.
         - $ sudo apt-get install libgtk-3-dev build-essential
    - Compile wxWidgets
    
	  - $ cd wxWidgets.3.1.x
	  - $ mkdir gtk-build
	  - $ cd gtk-build/ 
	  - $ ../configure --disable-shared --enable-unicode 
	  - $ make
    - Install wxWidgets
         - $ sudo make install
	 
  3. chmod 777 [Kaya-BASIC]/bin/bpp
  
  4. try to build samples

# Install(Windows)
 1. download mingw-w64 8.1.0
    - 32bit: i686-8.1.0-posix-sjlj-rt_v6-rev0  (must sjlj, because wxWidgets development files complied by this.)
    - 64bit: x86_64-8.1.0-posix-seh-rt_v6-rev0 
 2. download lastest wxWidgets(https://www.wxwidgets.org/downloads/  windows binaries ) Mingw-w64 8.1
     -  Header Files
     - 32-Bit (x86)
         - Development Files
     - 64-Bit (x86_64)
         - Development Files
  3. modify the config[XX] file under Bin folder
     - change the MINGW path and wxWidgets Include and Lib paths.
        - config[XX]_static. ★static link wxWidgets libs.
  4. Add belowing paths to PATH environment.
     - [Kaya-BASIC]/bin
     - [MINGW]/bin 
     - [wxWidgets]/lib/gcc810_dll
     - [wxWidgets]/lib/gcc810_x64_dll 
  
  5. try to build samples.

# Code Sample 
 Easy create GUI and easy call windows COM like this.
```
Option Explicit

Dim f As wxFrame Ptr
Dim listctrl As wxListCtrl Ptr

Sub LoadDataFromExcel
	
	Dim xlApp, xb, xls As ComObject
	Dim path As String
	
	path = wxGetCwd()
	path += "/data.xlsx"
	
	xlApp.CreateObject("Excel.Application")
	Set xb = xlApp.WorkBooks.Open( path )
	Set xls = xb.WorkSheets(1)
	
	For i As Integer = 1 To 4
		Dim s As String = xls.Cells(1, i).Value
		listctrl.InsertColumn( i - 1, s )
	Next
	
	For r As Integer = 2 To 5
		Dim s As String = xls.Cells(r, 1).Value
		listctrl.InsertItem( r - 2 , s )
		For c As Integer = 2 To 4
			s = xls.Cells(r, c).Value
			listctrl.SetItem( r - 2, c - 1, s )
		Next
	Next
	
	xb.Close
	xlApp.Quit
End Sub

Sub Main
	Dim strTitle As String = "listctrl"
	f = New wxFrame( NULL, wxID_ANY, strTitle )
	listctrl = New wxListCtrl( f, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxLC_REPORT )
	
	Call LoadDataFromExcel
	
	f.SetIcon( wxICON(wxICON_AAA) )
	f.Show(TRUE)
End Sub
```

