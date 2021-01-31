
%MINGW32%\bin\g++ -c -w -D__BPPWIN__ core.cpp -o core32_msw.o
%MINGW32%\bin\g++ -c -w -D__BPPWIN__ stc.cpp  -o stc32_msw.o
%MINGW32%\bin\g++ -D__BPPWIN__ -D__GNUWIN32__ -D__WXMSW__ -w -IC:\wxWidgets-3.1.3\include -IC:\wxWidgets-3.1.3\lib\gcc810_dll\mswu -c stw.cpp  -o stw32_msw.o
%MINGW32%\bin\windres  -IC:\wxWidgets-3.1.3\include -J rc -O coff -i core.rc -o core_res32_msw.o