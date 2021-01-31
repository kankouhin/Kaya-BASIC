#! /bin/sh
g++ -w -c -fPIC core.cpp -o core64_mac.o
g++ -w -c -fPIC stc.cpp -o stc64_mac.o
g++ -w -c -fPIC `wx-config --cppflags` stw.cpp -o stw64_mac.o
