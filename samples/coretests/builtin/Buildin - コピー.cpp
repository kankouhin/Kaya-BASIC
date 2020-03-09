#include "C:\DataMigration\FreeBasic\bpp\bin\bpp.exe\..\..\lib_gcc/core/core.h"
#undef RGB

namespace bpp
{
namespace Buildin
{


}

namespace System
{

struct initialization { initialization(); };
struct finalization { ~finalization(); };

class ComObject;
class GenericEvent;
class Stream;
class File;

class GenericEvent: public object
{
public: GenericEvent(bool init = true): object(false) { if (init) { __refcnt++; Initialize(); __refcnt--; } }
virtual bool __isbase(const std::type_info& ti) { return (typeid(System::GenericEvent) == ti) || object::__isbase(ti); }
virtual bpp::string ClassName() { return "System.GenericEvent"; }
bpp::ref<class object> Sender;
};

class Stream: public object
{
public: Stream(bool init = true): object(false) { if (init) { __refcnt++; Initialize(); __refcnt--; } }
virtual bool __isbase(const std::type_info& ti) { return (typeid(System::Stream) == ti) || object::__isbase(ti); }
virtual bpp::string ClassName() { return "System.Stream"; }

			virtual bool EOF();

			virtual long Position();
			virtual void Position(long);

			virtual long Size();
			virtual void Read(bpp::string& x);
			virtual void Read(bpp::apistring& x);
			virtual void Read(ref<bpp::object>& x);
			template<class T> void Read(bpp::ref<T>& x) { bpp::ref<bpp::object> y = x; Read(y); }
			template<class T> void Read(T& x) { Read(&x, sizeof(T)); }
			virtual void Read(void*, int);
virtual long ReadBlock(void*, long);
virtual string ReadLine();
virtual bpp::ref<class object> ReadObject();
virtual string ReadStr(long);
virtual long Seek(long, long);
			virtual void Write(bpp::string& x);
			virtual void Write(bpp::apistring& x);
			virtual void Write(ref<bpp::object>& x);
			template<class T> void Write(bpp::ref<T>& x) { bpp::ref<bpp::object> y = x; Write(y); }
			template<class T> void Write(T& x) { Write(&x, sizeof(T)); }
			virtual void Write(void*, int);
virtual long WriteBlock(void*, long);
virtual void WriteLine(string);
virtual void WriteObject(bpp::ref<class object>);
virtual void WriteStr(string);
};

class File: public System::Stream
{
public: File(bool init = true): System::Stream(false) { if (init) { __refcnt++; Initialize(); __refcnt--; } }
virtual bool __isbase(const std::type_info& ti) { return (typeid(System::File) == ti) || System::Stream::__isbase(ti); }
virtual bpp::string ClassName() { return "System.File"; }
void* CID;
virtual void Close();
virtual bool Open(string, long);
virtual long ReadBlock(void*, long);
virtual long Seek(long, long);
virtual long WriteBlock(void*, long);
virtual void Initialize();
virtual void Terminate();
};
extern "C" void __stdcall Main();
const long Nothing = 0;
const long False = 0;
const long True = 1;
const long DirAttrNormal = 0;
const long DirAttrReadOnly = 1;
const long DirAttrHidden = 2;
const long DirAttrSystem = 4;
const long DirAttrDirectory = 16;
const long DirAttrArchive = 32;
const long soFromStart = 0;
const long soFromBeginning = 0;
const long soFromCurrent = 1;
const long soFromEnd = 2;
const long fmOpenRead = 0;
const long fmOpenReadWrite = 1;
const long fmCreateWrite = 2;
const long fmCreateReadWrite = 3;
const long fmCreate = 3;
const long vtNumber = 0;
const long vtString = 1;
extern bpp::array<string>  Command;
double __stdcall Abs(double);
unsigned char __stdcall Asc(string);
string __stdcall ANSIToOem(string);
double __stdcall Ceil(double);
void __stdcall ChDir(string);
string __stdcall Chr(unsigned char);
long __stdcall CLng(double);
void __stdcall Cls();
void __stdcall Color(long, long);
double __stdcall Cos(double);
bpp::ref<class object> __stdcall CreateObject(string);
string __stdcall CrLf();
void __stdcall Cursor(bool);
string __stdcall Date();
string __stdcall Delete(string, long, long);
string __stdcall Dir(string, bool);
long __stdcall GetAttr(string);
bool __stdcall DirExists(string);
string __stdcall Environ(string);
double __stdcall Exp(double);
bool __stdcall ExtractResource(string, variant, string);
bool __stdcall FileExists(string);
double __stdcall Fix(double);
double __stdcall Floor(double);
double __stdcall Frac(double);
string __stdcall FullDate();
string __stdcall Hex(unsigned long);
variant __stdcall IIf(bool, variant, variant);
string __stdcall InKey();
string __stdcall Input_STRING(long);
string __stdcall Insert(string, string, long);
bool __stdcall InStat();
long __stdcall InStr(variant, string, string);
long __stdcall InStrRev(string, string, long);
long __stdcall Int(double);
void __stdcall Kill(string);
string __stdcall LCase(string);
string __stdcall Left(string, long);
long __stdcall Len(string);
void __stdcall Locate(long, long);
double __stdcall Log(double);
string __stdcall LTrim(string);
string __stdcall MakeIntResource(unsigned short);
long __stdcall MemCmp(long, long, long);
void __stdcall MemCpy(long, long, long);
void __stdcall MemSet(long, unsigned char, long);
string __stdcall Mid(string, long, long);
void __stdcall MkDir(string);
string __stdcall NullStr();
string __stdcall OemToANSI(string);
string __stdcall PadC(string, long, string);
string __stdcall PadL(string, long, string);
string __stdcall PadR(string, long, string);
double __stdcall Pow(double, double);
void __stdcall Randomize(long);
void __stdcall Rename(string, string);
string __stdcall ReplaceEx(string, string, long);
string __stdcall Replace(string, string, string);
string __stdcall Reverse(string);
long __stdcall RGB(unsigned char, unsigned char, unsigned char);
string __stdcall Right(string, long);
long __stdcall RInStr(variant, string, string);
void __stdcall RmDir(string);
double __stdcall Rnd(long);
long __stdcall Round(double);
string __stdcall RTrim(string);
long __stdcall Sgn(double);
void __stdcall Shell(string);
double __stdcall Sin(double);
void __stdcall Sleep(double);
string __stdcall Space(long);
double __stdcall Sqr(double);
string __stdcall Str(double);
string __stdcall Str0(double, long, long);
string __stdcall String(long, variant);
long __stdcall Tally(string, string);
double __stdcall Tan(double);
string __stdcall Time();
double __stdcall Timer();
string __stdcall Trim(string);
string __stdcall UCase(string);
double __stdcall Val(string);
long __stdcall VarPtr(void*);
string __stdcall VarPtr_STRING(long);
long __stdcall VarType(variant&);
void __stdcall Width(long, long);
void __stdcall Window(long, long, long, long);
long __stdcall MsgBox(string, long, string);
void __stdcall DoEvents();

}

namespace Buildin
{


static void __stdcall showdir(string sDir, string mask);

extern "C" void Main()
{
	string assss; assss.alloc(100);
	string ss = bpp::conv((string*)0, string(" Hello world  ")); 
	print << System::Left(bpp::conv((string*)0, ss), bpp::conv((long*)0, 5)) << string("\r\n"); 
	print << System::Right(bpp::conv((string*)0, ss), bpp::conv((long*)0, 5)) << string("\r\n"); 
	print << System::LTrim(bpp::conv((string*)0, ss)) << string("\r\n"); 
	print << System::RTrim(bpp::conv((string*)0, ss)) << string("\r\n"); 
	print << System::Str(bpp::conv((double*)0, System::Val(bpp::conv((string*)0, string("2329.1232134"))))) << string("\r\n"); 
	print << System::PadL(bpp::conv((string*)0, ss), bpp::conv((long*)0, 20), string(" ")) + string("aa") << string("\r\n"); 
	print << System::PadR(bpp::conv((string*)0, ss), bpp::conv((long*)0, 30), string(" ")) + string("aa") << string("\r\n"); 
	print << System::Mid(bpp::conv((string*)0, ss), bpp::conv((long*)0, 2), bpp::conv((long*)0, 7)) << string("\r\n"); 
	print << System::Str(bpp::conv((double*)0, System::Abs(bpp::conv((double*)0, -1100)))) << string("\r\n"); 
	print << System::Str(bpp::conv((double*)0, System::Asc(bpp::conv((string*)0, string("A"))))) << string("\r\n"); 
	print << System::Str(bpp::conv((double*)0, System::Ceil(bpp::conv((double*)0, 1.2323)))) << string("\r\n"); 
	print << string("dir") << string("\r\n"); 
	showdir(bpp::conv((string*)0, string("C:\\DataMigration\\FreeBasic\\bpp\\samples\\buildin")), bpp::conv((string*)0, string("*.*")));
	print << System::FileExists(bpp::conv((string*)0, string("buildin.bpp"))) << string("\r\n"); 
	print << System::Date() << string("\r\n"); 
	print << System::DirExists(bpp::conv((string*)0, string("C:\\DataMigration\\FreeBasic\\bpp\\samples\\system\\edd"))) << string("\r\n"); 
	print << System::Environ(bpp::conv((string*)0, string("MINGW"))) << string("\r\n"); 
	print << System::Fix(bpp::conv((double*)0, 12.67)) << string("\r\n"); 
	print << System::FullDate() << string("\r\n"); 
	print << System::Hex(bpp::conv((unsigned long*)0, 125)) << string("\r\n"); 
	print << System::IIf(bpp::conv((bool*)0, 1), bpp::conv((variant*)0, string("false")), bpp::conv((variant*)0, string("true"))) << string("\r\n"); 
	print << System::IIf(bpp::conv((bool*)0, 1), bpp::conv((variant*)0, 100), bpp::conv((variant*)0, 200)) << string("\r\n"); 
	print << System::InStr(bpp::conv((variant*)0, string("abcdefg")), bpp::conv((string*)0, string("e")), string("")) << string("\r\n"); 
	print << System::InStrRev(bpp::conv((string*)0, string("abcdefg")), bpp::conv((string*)0, string("e")), -1) << string("\r\n"); 
	System::Kill(bpp::conv((string*)0, string("Buildin3221.exe")));
	print << System::LCase(bpp::conv((string*)0, string("Hello World"))) << string("\r\n"); 
	print << System::Len(bpp::conv((string*)0, string("Hello World"))) << string("\r\n"); 
	print << System::Reverse(bpp::conv((string*)0, string("Hello World"))) << string("\r\n"); 
	print << System::RInStr(bpp::conv((variant*)0, string("abcdefg")), bpp::conv((string*)0, string("e")), string("")) << string("\r\n"); 
	print << System::Time() << string("\r\n"); 
	return;
}


static void __stdcall showdir(string sDir, string mask)
{
	string ss; 
	ss = (bpp::conv((string*)0, System::Dir(bpp::conv((string*)0, sDir + string("\\") + mask), 0) ));
	while ( ( ss != string("") ) )
	{
		print << sDir + string("\\") + ss << string("\r\n"); 
		if ( ss != string(".") && ss != string("..") )
		{
			if ( System::GetAttr(string("")) | 16 )
			{
				showdir(bpp::conv((string*)0, sDir + string("\\") + ss), bpp::conv((string*)0, mask));
				
			}
			
		}
		ss = (bpp::conv((string*)0, System::Dir(string(""), 0) ));
		
	}
	return;
}


struct initialization { initialization(); };
initialization::initialization()
// DLL loader
{
	
}


struct finalization { ~finalization(); };
finalization::~finalization()
/* DLL unloader */ { bpp::unloadlibs(); }



struct __init_and_final
{
	Buildin::initialization __init_Buildin;
	Buildin::finalization __final_Buildin;
	System::initialization __init_System;
	System::finalization __final_System;
} *__init_and_final_ptr;

extern "C" void __init_all() { __init_and_final_ptr = new __init_and_final; }
extern "C" void __final_all() { delete __init_and_final_ptr; }


}
}