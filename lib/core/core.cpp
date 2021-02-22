#include "core.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#include <iostream>
#include <vector>
#include <map>

#ifdef __BPPWIN__
	#include <windows.h>
#else
	#include <dlfcn.h>
#endif

namespace bpp
{

	Print print;
	Input input;

	struct __rtti_object : rtti
	{
		__rtti_object() { next = 0; }
		string name() { return "OBJECT"; }
		ref<object> create() { return new object; }
	} __rtti_object;

	rtti *classlist::list = &__rtti_object;

	variant::variant(double n)
	{
		vartype = num;
		this->n = n;
		char tmp[256];
		sprintf(tmp, "%.16g", n);
		s = tmp;
	}

	variant::variant(const string &s)
	{
		vartype = str;
		this->s = s;
		this->n = s.length() > 0 ? atof(s.c_str()) : 0;
	}

	variant::variant(const char *s)
	{
		vartype = str;
		this->s = s;
		this->n = atof(s);
	}

	variant &variant::operator=(const variant &v)
	{
		vartype = v.vartype;
		if (vartype == num)
		{
			n = v.n;
			s = "";
		}
		else if (vartype == str)
		{
			n = 0;
			s = v.s;
		}
		return *this;
	}

	variant::operator double() const
	{
		return n;
	}

	variant::operator string() const
	{
		return s;
	}

	Print &Print::operator<<(variant v)
	{
		if (v.vartype == variant::num)
			printf("%.16g", double(v));
		else if (v.vartype == variant::str)
			printf("%s", string(v).c_str());
		return *this;
	}

	Print &Print::operator<<(string v)
	{
		printf("%s", v.c_str());
		return *this;
	}

	Print &Print::operator<<(const char *v)
	{
		printf("%s", v);
		return *this;
	}
	Input &Input::line(string &s)
	{
		char ln[2048] = {0};

		std::cin.getline(ln, 2048);

		s = string(ln);
		return *this;
	}

	Input &Input::operator>>(variant &v)
	{
		char tmp[256];
		scanf("%s", tmp);
		v = string(tmp);
		return *this;
	}

	Input &Input::operator>>(unsigned char &c)
	{
		unsigned int tmp;
		scanf("%u", &tmp);
		c = tmp;
		return *this;
	}

	Input &Input::operator>>(unsigned short &n)
	{
		unsigned int tmp;
		scanf("%u", &tmp);
		n = tmp;
		return *this;
	}

	Input &Input::operator>>(unsigned long &n)
	{
		scanf("%U", &n);
		return *this;
	}

	Input &Input::operator>>(short &n)
	{
		int tmp;
		scanf("%d", &tmp);
		n = tmp;
		return *this;
	}

	Input &Input::operator>>(int &n)
	{
		scanf("%d", &n);
		return *this;
	}

	Input &Input::operator>>(float &n)
	{
		scanf("%g", &n);
		return *this;
	}

	Input &Input::operator>>(double &n)
	{
		float tmp;
		scanf("%g", &tmp);
		n = tmp;
		return *this;
	}

	Input &Input::operator>>(long double &n)
	{
		float tmp;
		scanf("%g", &tmp);
		n = tmp;
		return *this;
	}

	Input &Input::operator>>(bool &n)
	{
		int tmp;
		scanf("%d", &tmp);
		n = tmp;
		return *this;
	}

	Input &Input::operator>>(string &v)
	{
		char tmp[256];
		scanf("%s", tmp);
		v = string(tmp);
		return *this;
	}

	void nullify(void *ptr, int size)
	{
		memset(ptr, 0, size);
	}

#ifndef __BPPWIN__
	#define HINSTANCE void *
	#define DWORD Long
	#define LoadLibrary(x) dlopen(x, RTLD_LAZY)
	#define GetProcAddress(x, y) dlsym(x, y)
	#define FreeLibrary(x) dlclose(x)
#endif
	std::map<string, HINSTANCE> hlib;
	void loadlib(const string &lib)
	{
		HINSTANCE hdr = LoadLibrary(lib.c_str());
		if (!hdr)
			printf("%s %s", "can't load", lib.c_str());
		else
			hlib[lib] = hdr;
	}

	void unloadlibs()
	{
		for ( auto& i : hlib )
		{
			FreeLibrary(i.second);
		}
	}

	void *getlibhandle(const string &lib)
	{
		return hlib.at(lib);
	}

	void *getprocaddr(void *lib, const string &func)
	{
		void *hdr = (void *)GetProcAddress((HINSTANCE)lib, func.c_str());
		if (!hdr)
			printf("%s %s", "can't get proc address of", func.c_str());

		return hdr;
	}

	static std::map<std::thread::id, std::vector<string>> dbg_funcs;
	static std::map<std::thread::id, std::vector<int>> dbg_lines;

	void dbg_line(int n)
	{
		dbg_lines[std::this_thread::get_id()].back() = n;
	}

	int dbg_getline()
	{
		std::thread::id tid = std::this_thread::get_id();
		if (dbg_lines[tid].empty())
			return 0;

		int result = dbg_lines[tid].back();
		return result;
	}

	string dbg_getfunc()
	{
		std::thread::id tid = std::this_thread::get_id();
		if (dbg_funcs[tid].empty())
			return "nothing";

		string result = dbg_funcs[tid].back();
		return result;
	}

	void dbg_func(const string &s)
	{
		std::thread::id tid = std::this_thread::get_id();
		dbg_funcs[tid].push_back(s);
		dbg_lines[tid].push_back(0);
	}

	void dbg_endfunc()
	{
		std::thread::id tid = std::this_thread::get_id();
		dbg_funcs[tid].pop_back();
		dbg_lines[tid].pop_back();
	}
	
	string dbg_callstack()
	{
		string err;
		std::thread::id tid = std::this_thread::get_id();
		
		int size = dbg_funcs[tid].size();
		for ( int idx = size - 1; idx >= 0; idx-- )
		{
			int line = dbg_lines[tid][idx];
			string func = dbg_funcs[tid][idx];
			
			if (idx == size - 1)
			{
				err = err + "    raised";
			}
			else
				err = err + ",\r\n    called";
			
	        char buf[20] = {0};
	        sprintf(buf, "%d", line);
			err = err + " by " + func + "() at line #" + buf;
		}

		return err;
	}	

} // namespace bpp
