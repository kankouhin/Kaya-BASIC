@echo off
del *64.exe

..\..\..\bin\bpp -m64 -n -k buildin
pause
