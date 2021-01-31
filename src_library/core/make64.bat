
%MINGW64%\bin\g++ -c -w -D__BPPWIN__ core.cpp -o core64_msw.o
%MINGW64%\bin\g++ -c -w -D__BPPWIN__ stc.cpp  -o stc64_msw.o
%MINGW64%\bin\g++ -D__BPPWIN__ -D__GNUWIN32__ -D__WXMSW__ -w -IC:\wxWidgets-3.1.3\include -IC:\wxWidgets-3.1.3\lib\gcc810_x64_dll\mswu -c stw.cpp  -o stw64_msw.o
%MINGW64%\bin\windres  -IC:\wxWidgets-3.1.3\include -J rc -O coff -i core.rc -o core_res64_msw.o
pause