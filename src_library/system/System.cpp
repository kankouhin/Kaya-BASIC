#include "../core/core.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdlib.h>

#include <math.h>
#include <time.h>
#include <ctype.h>

#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>


#include <regex>

#ifdef __BPPWIN__
    #include <conio.h>
#else
    #include <termios.h>
    #include <fcntl.h>

    int kbhit(void){
        struct termios oldt, newt;
        int ch;
        int oldf;

        tcgetattr(STDIN_FILENO, &oldt);
        newt = oldt;
        newt.c_lflag &= ~(ICANON | ECHO);
        tcsetattr(STDIN_FILENO, TCSANOW, &newt);
        oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
        fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

        ch = getchar();

        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
        fcntl(STDIN_FILENO, F_SETFL, oldf);

        if (ch != EOF) {
            ungetc(ch, stdin);
            return 1;
        }

        return 0;
    }
#endif // __BPPWIN__

//#undef RGB
//#undef EOF

namespace bpp
{

#include "System.h"

namespace System
{



static char copyright[] =
	"RunTime Library versiont 1.3";

array<string> Command;

const Long MAX_DIR_LEVEL = 1024;
Long dirIndex = -1;

struct _tagDirLevel {
	DIR* pdir;
} tagDirLevel[MAX_DIR_LEVEL];

const Integer MAX_OPEN_FILES = 512;
fstream* OpenFiles[MAX_OPEN_FILES] = {0};


double __BPPCALL Abs(double n)
{
	return n < 0 ? -n : n;
}


unsigned char __BPPCALL Asc(string s)
{
	return s.at(0);
}


double __BPPCALL Ceil(double n)
{
	return ceil(n);
}


void __BPPCALL ChDir(string dir)
{
	chdir(dir.c_str());
}


string __BPPCALL Chr(unsigned char n)
{
	string str(1, n);
	return str;
}

Long __BPPCALL CLng(double n)
{
	return n;
}

double __BPPCALL Cos(double n)
{
	return cos(n);
}

ref<object> __BPPCALL CreateObject(string classname)
{
	rtti* cl = classlist::find(classname);
	if (cl)
		return cl->create();
	else
		return 0;
}

string __BPPCALL NewLine()
{
#ifdef __BPPWIN__
	return "\r\n";
#else
	return "\n";
#endif
}


string __BPPCALL Date()
{
	char buf[9];
	time_t tmr = time(NULL);
	tm* dt = localtime(&tmr);
	sprintf(buf, "%02d/%02d/%02d", dt->tm_year % 100, ++dt->tm_mon, dt->tm_mday);
	return buf;
}


string __BPPCALL Delete(string s, Long start, Long length)
{
	s.erase( start - 1, length);
	return s;
}

string __BPPCALL PathSep()
{
    #ifdef __BPPWIN__
        return "\\";
    #else
        return "/";
    #endif // __BPPWIN__
}

string __BPPCALL RunAs()
{
	string result;

    #ifdef __BPPWIN__
        result = "Windows";
    #else
		#ifdef __BPPMAC__
        	result = "Mac";
		#else
			result = "Linux";
		#endif
    #endif

	#if defined(__x86_64)
		result += "64";
	#else
		result += "32";
	#endif

	return result;
}

string __BPPCALL Dir(string path)
{
    string result;
    dirent* pDirEnt = NULL;

	if (Len(path))
	{
		dirIndex++;
		tagDirLevel[dirIndex].pdir = opendir( path.c_str() );

		if ( !tagDirLevel[dirIndex].pdir ) {
			dirIndex--;
			return "";
		}
	}

	pDirEnt = readdir( tagDirLevel[dirIndex].pdir );
    result = ( !pDirEnt ? "" : pDirEnt->d_name );

	return result;
}

void __BPPCALL CloseDir(Boolean closeAll)
{
	if ( dirIndex < 0 ) return;

    closedir( tagDirLevel[dirIndex].pdir );
	tagDirLevel[dirIndex].pdir = NULL;
	dirIndex--;

	if ( closeAll )
	{
		while (dirIndex >= 0 )
		{
			CloseDir(false);
		}
	}
}

Long __BPPCALL IsDIR(string path)
{
    struct stat info;
    stat ( path.c_str(), &info );

    return S_ISDIR( info.st_mode );
}

Long __BPPCALL IsFIFO(string path)
{
    struct stat info;
    stat ( path.c_str(), &info );

    return S_ISFIFO( info.st_mode );
}

Long __BPPCALL IsCHR(string path)
{
    struct stat info;
    stat ( path.c_str(), &info );

    return S_ISCHR( info.st_mode );
}

Long __BPPCALL IsBLK(string path)
{
    struct stat info;
    stat ( path.c_str(), &info );

    return S_ISBLK( info.st_mode );
}

Long __BPPCALL IsREG(string path)
{
    struct stat info;
    stat ( path.c_str(), &info );

    return S_ISREG( info.st_mode );
}

bool __BPPCALL FileExists(string filename)
{
	FILE* f = fopen(filename.c_str(), "rb");
	if (f)
		fclose(f);
	return f;
}

bool __BPPCALL DirExists(string dir)
{
    DIR* pDir = opendir( dir.c_str() );
    if ( !pDir ) return false;
    closedir( pDir );
	return true;
}

string __BPPCALL Environ(string var)
{
	return getenv(var.c_str());
}


double __BPPCALL Exp(double n)
{
	return exp(n);
}

double __BPPCALL Fix(double n)
{
	return Long(n);
}


double __BPPCALL Floor(double n)
{
	return floor(n);
}


double __BPPCALL Frac(double n)
{
	return n - Fix(n);
}


string __BPPCALL FullDate()
{
	char buf[11];
	time_t tmr = time(NULL);
	tm* dt = localtime(&tmr);
	sprintf(buf, "%04d/%02d/%02d", 1900 + dt->tm_year, ++dt->tm_mon, dt->tm_mday);
	return buf;
}


string __BPPCALL Hex(UInteger n)
{
	char buf[32];
	sprintf(buf, "%X", n);
	return buf;
}


variant __BPPCALL IIf(bool cond, variant ontrue, variant onfalse)
{
	return cond ? ontrue : onfalse;
}

string __BPPCALL Insert(string s, string sub, Long pos)
{
	s.insert(pos - 1, sub);
	return s;
}

bool __BPPCALL InStat()
{
	return kbhit();
}

string __BPPCALL InKey()
{
	if (!kbhit())
		return "";

#ifdef __BPPWIN__
	int ch = getch();
#else
	int ch = getchar();
#endif
	return string(ch,1);
}

Long __BPPCALL InStr(variant vstart, string substr, string s)
{
	Long start, pos;
	if (!s.length())
	{
		s = substr;
		substr = string(vstart);
		pos = s.find( substr );
	}
	else
	{
		start = vstart;
		pos = s.find( substr, start - 1 );
	}

	return pos + 1;
}

Long __BPPCALL InStrAny(variant vstart, string substr, string s)
{
	Long start,pos;
	if (!s.length())
	{
		s = substr;
		substr = string(vstart);
		pos = s.find_first_of( substr );
	}
	else
	{
		start = vstart;
		pos = s.find_first_of( substr, start - 1 );
	}

	return pos + 1;
}

Long __BPPCALL InStrRev(string sub, string s, Long start)
{
	Long pos;
	if ( start < 1 )
		pos = s.rfind( sub );
	else
		pos = s.rfind( sub, start - 1 );

	return pos + 1;
}

Long __BPPCALL InStrRevAny(string sub, string s, Long start)
{
	Long pos;
	if ( start < 1 )
		pos = s.find_last_of ( sub );
	else
		pos = s.find_last_of ( sub, start - 1 );

	return pos + 1;
}


int __BPPCALL Int(double n)
{
	return n;
}


void __BPPCALL Kill(string filename)
{
	remove(filename.c_str());
}


string __BPPCALL LCase(string s)
{
	string result = s + "";
	for ( int i = 0; i < result.length(); i++)
         result[i] = tolower( result[i] );

	return result;
}

string __BPPCALL UCase(string s)
{
	string result = s + "";
	for ( int i = 0; i < result.length(); i++)
         result[i] = toupper( result[i] );

	return result;
}

string __BPPCALL Left(string s, Long count)
{
	string result;
	if (count > s.length())
		count = s.length();

	result = s.substr( 0, count );
	return result;
}


Long __BPPCALL Len(string s)
{
	return s.length();
}

double __BPPCALL Log(double n)
{
	return log(n);
}


string __BPPCALL LTrim(string s)
{
	const char* p = s.c_str();
	while (*p == 32 || *p == 9 || *p == 10 || *p == 13)
		p++;
	return p;
}

Long __BPPCALL MemCmp(Long p1, Long p2, Long size)
{
	return memcmp((void*)p1, (void*)p2, size);
}


void __BPPCALL MemCpy(Long p1, Long p2, Long count)
{
	memcpy((void*)p1, (void*)p2, count);
}


void __BPPCALL MemSet(Long dest, unsigned char ch, Long count)
{
	memset((void*)dest, ch, count);
}


string __BPPCALL Mid(string s, Long start, Long count)
{
	Long len = Len(s);
	if (start < 1 || start > len)
		return "";

	string result = s.substr( start - 1, count );
	return result;
}


void __BPPCALL MkDir(string dir)	// not ANSI C++
{
    #ifdef __BPPWIN__
        mkdir(dir.c_str());
    #else
        mkdir(dir.c_str(), 0777);
    #endif // __BPPWIN__
}


string __BPPCALL NullString()
{
	return string((char*)0);
}

string __BPPCALL PadC(string s, Long len, string c)
{
	Long l = Len(s);
	if (len < l)
		return s;
	string pad = String((len - l) / 2, c);
	string result = pad + s + pad;
	if ((len - l) % 2)
		result += c;
	return result;
}


string __BPPCALL PadL(string s, Long len, string c)
{
	Long l = Len(s);
	if (len < l)
		return s;
	else
		return String(len - l, c) + s;
}


string __BPPCALL PadR(string s, Long len, string c)
{
	Long l = Len(s);
	if (len < l)
		return s;
	else
		return s + String(len - l, c);
}


double __BPPCALL Pow(double n, double p)
{
	return pow(n, p);
}


void __BPPCALL Randomize(Long seed)
{
	srand(seed);
}


void __BPPCALL Rename(string oldname, string newname)
{
	rename(oldname.c_str(), newname.c_str());
}

string __BPPCALL Replace(string strSource, string strOld, string strNew)
{
	Long intStart;
	string strLeft;
	string strRight;

	intStart = InStr(1, strOld, strSource );
	while ( intStart > 0 )
	{
		strLeft = Left(strSource, intStart - 1);
		strRight = Mid(strSource, Len(strOld) + intStart, -1);
		strSource = strLeft + strNew + strRight;

		intStart = InStr(intStart + strNew.length(), strOld, strSource);
    }

	return strSource;
}

string __BPPCALL ReplaceEx(string text, string pattern, string NewStr)
{
    std::regex re( pattern );
    string result = std::regex_replace( text, re, NewStr );
    return result;
}

string __BPPCALL SearchEx(string text, string pattern)
{
    std::regex re( pattern );
    std::smatch m;
    std::regex_search( text, m, re );

    return m.str();
}

array<string> __BPPCALL SearchAllEx(string text, string pattern)
{
    array<string> result(0, 1024);
	std::regex re (pattern);   // matches words beginning by "sub"

	std::regex_iterator<std::string::iterator> rit ( text.begin(), text.end(), re );
	std::regex_iterator<std::string::iterator> rend;

	int idx = 0;
	while (rit!=rend) {
		result(idx++) = rit->str();
		++rit;
	}

    result.preserve = true;
    result.redim(0, idx - 1);
    return result;
}

string __BPPCALL Reverse(string s)
{
	string result = s + "";
	Long len = s.length();

	for (Long i = 0; i < len; i++)
		result[i] = s[len - i - 1];
	return result;
}


Integer __BPPCALL Rgb(unsigned char r, unsigned char g, unsigned char b)
{
	return b + (g << 8) + (r << 16);
}


string __BPPCALL Right(string s, Long count)
{
    Long len = Len(s);
	string result;
	if (count > len)
		count = len;

	result = s.substr( len - count, count );
	return result;
}

void __BPPCALL RmDir(string dir)
{
	rmdir(dir.c_str());
}


double __BPPCALL Rnd(Long max)
{
	if (max)
		return rand() * max / RAND_MAX;
	else
		return double(rand()) / RAND_MAX;
}


Long __BPPCALL Round(double n)
{
	if (Frac(n) < 0.5)
		return Floor(n);
	else
		return Ceil(n);
}


string __BPPCALL RTrim(string s)
{
	string result;
    string::size_type right = s.find_last_not_of("\t\r\n ");
    if (right != string::npos)
    {
        result = s.substr(0, right + 1);
    }

    return result;
}


Long __BPPCALL Sgn(double n)
{
	return n ? n / fabs(n) : 0;
}


void __BPPCALL Shell(string cmd)
{
	system(cmd.c_str());
}


double __BPPCALL Sin(double n)
{
	return sin(n);
}


string __BPPCALL Space(Long count)
{
	string result(count, 32);
	return result;
}


double __BPPCALL Sqr(double n)
{
	return sqrt(n);
}


string __BPPCALL Str(double n)
{
	char tmp[256];
	sprintf(tmp, "%.16g", n);
	return tmp;
}

string __BPPCALL Str0(double n, Long len, Long frac)
{
	char tmp[256];
	string fmt = string("%0") + Str(len) + string(".") + Str(frac) + "g";
	sprintf(tmp, fmt.c_str(), n);
	return tmp;
}


string __BPPCALL String(Long count, string s)
{
	string result = "";
	result.reserve( s.length() * count + 1 );

	for ( Long i = 0; i < count; i++ )
		result += s;

	return result;
}


Long __BPPCALL Tally(string s, string sub)
{
	Long result = 0;
	Long n = s.length() - sub.length() + 1;
	const char* p = s.c_str();
	while (n--)
		if (!memcmp(p++, sub.c_str(), sub.length()))
			result++;
	return result;
}


double __BPPCALL Tan(double n)
{
	return tan(n);
}


string __BPPCALL Time()
{
	char buf[9];
	time_t tmr = time(NULL);
	tm* dt = localtime(&tmr);
	sprintf(buf, "%02d:%02d:%02d", dt->tm_hour, dt->tm_min, dt->tm_sec);
	return buf;
}


double __BPPCALL Timer()
{
	return (double)clock() / CLOCKS_PER_SEC;
}

string __BPPCALL Trim(string s)
{
    string strOut = s + "";

    strOut = LTrim(s);
    strOut = RTrim(strOut);

    return strOut.c_str();
}

double __BPPCALL Val(string s)
{
	return variant(s);
}


Long __BPPCALL VarPtr(void* var)
{
	Long ret = *((Long*)(&var));
	return ret;//(Long)var;
}

double __BPPCALL VarPtr_DOUBLE(Long ptr)
{
	return (double)ptr;
}

string __BPPCALL VarPtr_STRING(Long ptr)
{
	return string((char*)ptr);
}

Long __BPPCALL VarType(variant& v)
{
	return v.vartype;
}

string __BPPCALL Format(double Num,string Mask)
{
  Long Spaces = 0;
  Long CntDec = 0;
  Long Decimals = 0;
  Long Dollar = 0;
  char sRetVar [512]={0};
  char Buf_1[512]={0};
  const char* p = Mask.c_str();
  char* r;
  Long  len;



  while (*p)
  {
    if (*p == 36) Dollar++;
    if (*p == 32) Spaces++;
    if ((*p == 32 || *p == 35)&& CntDec) Decimals++;
    if (*p == 46) CntDec = 1;
    p++;
  }
  sprintf(Buf_1,"%1.*f",Decimals,Num);

  len = strlen(Buf_1)-Decimals-(Decimals>0?1:0);
  r = sRetVar+Dollar+Spaces;
  p = Buf_1;
  while (*p)
   {
     *r++ = *p++;
     if (--len>2 && *(p-1) != '-' && len % 3 == 0)
       {
         *r++ = ',';
       }
   }
  if(Dollar) sRetVar[Spaces]=36;
  if(Spaces) memset(sRetVar,32,Spaces);

  return sRetVar;
}

double __BPPCALL Acosh(double n)
{
  if(n < 1) return 1e308;
  return(log(n+sqrt(n*n-1)));
}

double __BPPCALL Asinh(double n)
{
        return(log(n+sqrt(n*n+1)));
}

double __BPPCALL Atanh(double n)
{
  if(n<=-1) return 1e308;
  if(n>= 1) return 1e308;
  return(log((1+n/(1-n))/2));
}

Long __BPPCALL MemoryCreate(Long count)
{
	//memcpy((void*)p1, (void*)p2, count);
	return VarPtr( malloc(count) );
}

void __BPPCALL MemoryFree(Long p1)
{
        free((void*)p1);
}

Long __BPPCALL MemoryResize(Long p1, Long newsize)
{
	return VarPtr( realloc( (void *)p1, newsize ) );
}


void __BPPCALL FileOpen(string filename, ios_base::openmode mode, Integer fn)
{
	fstream *f = new fstream( filename.c_str(), mode );
	if ( f->fail() )
		throw "can not open the file:" + filename;
	
	if ( fn <= 0 )
		throw "invalid file no";
	
	OpenFiles[fn] = f;
}

void __BPPCALL FileClose(Integer fn)
{
	if ( fn == 0 ) // close all opened files
	{
		for ( Integer fn = 1; fn < MAX_OPEN_FILES; fn++ )
			if ( OpenFiles[fn] != 0 )
				FileClose(fn);

		return;
	}

	fstream *f = OpenFiles[fn];
	f->close();
	delete f;

	OpenFiles[fn] = 0;
}

fstream* __BPPCALL FileGetObject(Integer fn)
{
	fstream *f = OpenFiles[fn];
	return f;
}

Boolean __BPPCALL Eof(Integer fn)
{
	fstream *f = OpenFiles[fn];
	return f->eof();
}

Long __BPPCALL FileLen(Integer fn)
{
	fstream *is = OpenFiles[fn];
	is->seekg (0, is->end);
    int length = is->tellg();
    is->seekg(0, is->beg);
	
	return length;
}

Integer __BPPCALL FreeFile()
{
	for ( Integer fn = 1; fn < MAX_OPEN_FILES; fn++ )
		if ( OpenFiles[fn] == 0 )
			return fn;

	return 0;
}

void __BPPCALL Sleep(Integer sec)
{
	sleep( sec );
}


array<string> Split(string src, string sep)
{
	string item = src;
	Integer idx = -1;
	Integer iPos = InStr( sep, item, "");

	array<string> dest(1024,0);

	while ( iPos > 0)
	{
		idx++;
		if ( iPos == 1 )
		{
			dest(idx) = string("");
		}
		else
		{
			string ti = Left( item, iPos - 1 );
			dest(idx) = ti;
		}

		item = Mid( item, iPos + Len(sep), Len(item) );
		iPos = InStr( sep, item, "");
	}

	idx++;
	dest(idx) = item;

	dest.preserve = 1;
	dest.redim(idx,0);
	return dest;
}

array<string> SplitAny(string src, string sep)
{
	string item = src;
	Integer idx = -1;
	Integer iPos = InStrAny( sep, item, "");

	array<string> dest(1024,0);

	while ( iPos > 0)
	{
		idx++;
		if ( iPos == 1 )
		{
			dest(idx) = string("");
		}
		else
		{
			string ti = Left( item, iPos - 1 );
			dest(idx) = ti;
		}

		item = Mid( item, iPos + 1, Len(item) );
		iPos = InStrAny( sep, item, "");
	}

	idx++;
	dest(idx) = item;

	dest.preserve = 1;
	dest.redim(idx,0);
	return dest;
}

string Join(array<string>& dest, string sep )
{
	string result;
	result.reserve( dest.size() * 256 );
	for ( int idx = dest.lbound(); idx <= dest.ubound(); idx++  )
	{
		if ( idx > 0 )
			result += sep;

		result += dest(idx);
	}

	return result;
}

bool StartsWith(string s, string chk )
{
	if ( s.length() < chk.length() )
		return false;
	
	return s.substr(0, chk.length()) == chk;
}

bool EndsWith(string s, string chk )
{
	if ( s.length() < chk.length() )
		return false;
	
	return s.substr(s.length() - chk.length()) == chk;
}

Boolean Like(string target, string pattern)
{
	regex re( pattern );
	return regex_match( target, re );
}


initialization::initialization()
{
}


finalization::~finalization()
{
	copyright[0] = 0;
}


}
}
