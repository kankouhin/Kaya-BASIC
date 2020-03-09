# Kaya-BASIC
Base on B++ complier( https://sourceforge.net/projects/b-plus-plus/ ). Now windows only.

Compile with mingw-w64(i686-8.1.0-posix-#sjlj-rt_v6-rev0  and x86_64-8.1.0-posix-#seh-rt_v6-rev0  )
and GUI with wxWidgets 3.x.x

# Compile with mingw-64(both 32bit and 64bit)
# Easy call windows com/ole like VB
# creates GUI(using wxWidgets), console or DLL applications

# Install
 1. download mingw-w64 8.1.0
    32bit: i686-8.1.0-posix-sjlj-rt_v6-rev0  (must sjlj )
    64bit: x86_64-8.1.0-posix-seh-rt_v6-rev0 
 2. download wxWidgets 3.1.3 (https://www.wxwidgets.org/downloads/  windows binaries )
     Mingw-w64 8.1
        Header Files
        32-Bit (x86)
          Development Files
          Release DLLs
        64-Bit (x86_64)
          Development Files
          Release DLLs
  3. modify the config[XXX] file under Bin folder
     change the MINGW path and wxWidgets Include and Lib paths.
  
  4. Add [BPP]/bin and [MINGW]/bin [wxWidgets]/lib/gcc810_dll, [wxWidgets]/lib/gcc810_x64_dll to PATH environment.
  
  4. try to build samples.


