namespace System
{

struct initialization { initialization(); };
struct finalization { ~finalization(); };

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
			virtual void Read(bpp::string& x);
			virtual void Read(bpp::apistring& x);
			virtual void Read(ref<bpp::object>& x);
			template<class T> void Read(bpp::ref<T>& x) { bpp::ref<bpp::object> y = x; Read(y); }
			template<class T> void Read(T& x) { Read((void*)(&x), sizeof(T)); }
			virtual void Read(void*, Long);
virtual Long ReadBlock(Any, Long);
virtual string ReadLine();
virtual bpp::ref<class object> ReadObject();
virtual string ReadString(Long);
virtual Long Seek(Long, Long);
			virtual void Write(bpp::string& x);
			virtual void Write(bpp::apistring& x);
			virtual void Write(ref<bpp::object>& x);
			template<class T> void Write(bpp::ref<T>& x) { bpp::ref<bpp::object> y = x; Write(y); }
			template<class T> void Write(T& x) { Write((void*)(&x), sizeof(T)); }
			virtual void Write(void*, Long);
virtual Long WriteBlock(Any, Long);
virtual void WriteLine(string);
virtual void WriteObject(bpp::ref<class object>);
virtual void WriteString(string);

virtual Boolean EOF();

virtual Long Position();
virtual void Position(Long);


virtual Long Size();
};

class File: public System::Stream
{
public: File(bool init = true): System::Stream(false) { if (init) { __refcnt++; Initialize(); __refcnt--; } }
virtual bool __isbase(const std::type_info& ti) { return (typeid(System::File) == ti) || System::Stream::__isbase(ti); }
virtual bpp::string ClassName() { return "System.File"; }
virtual void Close();
virtual Boolean Open(string, string);
virtual Long ReadBlock(Any, Long);
virtual Long Seek(Long, Long);
virtual Long WriteBlock(Any, Long);
virtual void Initialize();
virtual void Terminate();
Any CID;
};
extern "C" void __BPPCALL Main();
const Integer Nothing = 0;
const Integer False = 0;
const Integer True = 1;
const Integer FileAttrNormal = 0;
const Integer FileAttrReadOnly = 1;
const Integer FileAttrHidden = 2;
const Integer FileAttrSystem = 4;
const Integer FileAttrDirectory = 16;
const Integer FileAttrArchive = 32;
const Integer soFromStart = 0;
const Integer soFromBeginning = 0;
const Integer soFromCurrent = 1;
const Integer soFromEnd = 2;
const string fmOpenRead = "r";
const string fmOpenReadWrite = "rb+";
const string fmCreateWrite = "w";
const string fmCreateReadWrite = "wb+";
const Integer vtNumber = 0;
const Integer vtString = 1;
extern bpp::array<string>  Command;
Double __BPPCALL Abs(Double);
Byte __BPPCALL Asc(string);
Double __BPPCALL Ceil(Double);
void __BPPCALL ChDir(string);
string __BPPCALL Chr(Byte);
Long __BPPCALL CLng(Double);
Double __BPPCALL Cos(Double);
bpp::ref<class object> __BPPCALL CreateObject(string);
string __BPPCALL CrLf();
string __BPPCALL Date();
string __BPPCALL Delete(string, Long, Long);
string __BPPCALL Dir(string, Boolean);
Long __BPPCALL GetAttr(string);
Boolean __BPPCALL DirExists(string);
string __BPPCALL Environ(string);
Double __BPPCALL Exp(Double);
Boolean __BPPCALL FileExists(string);
Double __BPPCALL Fix(Double);
Double __BPPCALL Floor(Double);
Double __BPPCALL Frac(Double);
string __BPPCALL FullDate();
string __BPPCALL Hex(UInteger);
variant __BPPCALL IIf(Boolean, variant, variant);
string __BPPCALL InKey();
string __BPPCALL Insert(string, string, Long);
Boolean __BPPCALL InStat();
Long __BPPCALL InStr(variant, string, string);
Long __BPPCALL InStrRev(string, string, Long);
Integer __BPPCALL Int(Double);
void __BPPCALL Kill(string);
string __BPPCALL LCase(string);
string __BPPCALL Left(string, Long);
Long __BPPCALL Len(string);
Double __BPPCALL Log(Double);
string __BPPCALL LTrim(string);
Long __BPPCALL MemCmp(Long, Long, Long);
void __BPPCALL MemCpy(Long, Long, Long);
void __BPPCALL MemSet(Long, Byte, Long);
string __BPPCALL Mid(string, Long, Long);
void __BPPCALL MkDir(string);
string __BPPCALL NullString();
string __BPPCALL PadC(string, Long, string);
string __BPPCALL PadL(string, Long, string);
string __BPPCALL PadR(string, Long, string);
Double __BPPCALL Pow(Double, Double);
void __BPPCALL Randomize(Long);
void __BPPCALL Rename(string, string);
string __BPPCALL ReplaceEx(string, string, Long);
string __BPPCALL Replace(string, string, string);
string __BPPCALL Reverse(string);
Integer __BPPCALL RGB(Byte, Byte, Byte);
string __BPPCALL Right(string, Long);
Long __BPPCALL RInStr(variant, string, string);
void __BPPCALL RmDir(string);
Double __BPPCALL Rnd(Long);
Long __BPPCALL Round(Double);
string __BPPCALL RTrim(string);
Long __BPPCALL Sgn(Double);
void __BPPCALL Shell(string);
Double __BPPCALL Sin(Double);
string __BPPCALL Space(Long);
Double __BPPCALL Sqr(Double);
string __BPPCALL Str(Double);
string __BPPCALL Str0(Double, Long, Long);
string __BPPCALL String(Long, variant);
Long __BPPCALL Tally(string, string);
Double __BPPCALL Tan(Double);
string __BPPCALL Time();
Double __BPPCALL Timer();
string __BPPCALL Trim(string);
string __BPPCALL UCase(string);
Double __BPPCALL Val(string);
Long __BPPCALL VarPtr(Any);
Double __BPPCALL VarPtr_DOUBLE(Long);
string __BPPCALL VarPtr_STRING(Long);
Long __BPPCALL VarType(variant&);
Double __BPPCALL Atanh(Double);
Double __BPPCALL Asinh(Double);
Double __BPPCALL Acosh(Double);
Long __BPPCALL MemoryCreate(Long);
void __BPPCALL MemoryFree(Long);
Long __BPPCALL MemoryResize(Long, Long);
string __BPPCALL Format(Double, string);
Integer __BPPCALL FreeFile();
void __BPPCALL FileOpen(string, string, Integer);
void __BPPCALL FileClose(Integer);
Long __BPPCALL FileGetObject(Integer);
Boolean __BPPCALL EOF(Integer);
Long __BPPCALL EOL(Integer);
void __BPPCALL Sleep(Integer);

}