# Kaya-BASIC
Base on B++ complier( https://sourceforge.net/projects/b-plus-plus/ ). Now windows only.

# Features
 - Compiles with Mingw-w64(both 32bit and 64bit)
 - OOP, supports CreateObject by name and call function/sub/property by name)
 - Creates GUI(using wxWidgets), console or DLL applications.
 - Easy calls windows comole like VB.
 
# Install
 1. download mingw-w64 8.1.0
    - 32bit: i686-8.1.0-posix-sjlj-rt_v6-rev0  (must sjlj, because wxWidgets development files complied by this.)
    - 64bit: x86_64-8.1.0-posix-seh-rt_v6-rev0 
 2. download wxWidgets 3.1.3 (https://www.wxwidgets.org/downloads/  windows binaries ) Mingw-w64 8.1
     -  Header Files
     - 32-Bit (x86)
         - Development Files
     - 64-Bit (x86_64)
         - Development Files
  3. modify the config[XXX] file under Bin folder
     - change the MINGW path and wxWidgets Include and Lib paths.
  
  4. Add belowing paths to PATH environment.
     - [Kaya-BASIC]/bin
     - [MINGW]/bin 
     - [wxWidgets]/lib/gcc810_dll
     - [wxWidgets]/lib/gcc810_x64_dll 
  
  5. try to build samples.

# Sample 
 Easy create the GUI and easy call windows comole like this.
 - https://github.com/kankouhin/Kaya-BASIC/blob/master/samples/wxGUI/gui%26comole/gui.bas
