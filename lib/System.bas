INTERFACE NOSKIP

Public Declare BUILTIN Char
Public Declare BUILTIN Byte
Public Declare BUILTIN Short
Public Declare BUILTIN UShort
Public Declare BUILTIN Integer
Public Declare BUILTIN UInteger
Public Declare BUILTIN Long
Public Declare BUILTIN ULong

Public Declare BUILTIN Single
Public Declare BUILTIN Double
Public Declare BUILTIN Decimal

Public Declare BUILTIN Boolean
Public Declare BUILTIN String
Public Declare BUILTIN Variant

Public Declare BUILTIN Function
Public Declare BUILTIN Tuple

Public Declare BUILTIN ANY
Public Declare BUILTIN CLASS Object


Public Const Nothing As Integer = 0
Public Const False 	As Integer	= 0
Public Const True	As Integer	= 1


Public Enum VariantType
	vtNumber,
	vtString
End Enum


Public Command() As String

'Strings---------------------------------------------------------------------------------------------------
Public Declare Function InStr(Start As Variant, substr As String, s As String = "") As Long
Public Declare Function InStrAny(Start As Variant, substr As String, s As String = "") As Long
Public Declare Function InStrRev(substr As String, s As String, Start As Long = -1) As Long
Public Declare Function InStrRevAny(substr As String, s As String, Start As Long = -1) As Long

Public Declare Function Insert(s As String, ss As String, Pos As Long) As String
Public Declare Function Delete(s As String, Start As Long, Length As Long) As String
Public Declare Function Left(s As String, Count As Long) As String
Public Declare Function Mid(s As String, Start As Long, Count As Long = -1) As String
Public Declare Function Right(s As String, Count As Long) As String

Public Declare Function LCase(s As String) As String
Public Declare Function UCase(s As String) As String
Public Declare Function LTrim(s As String) As String
Public Declare Function RTrim(s As String) As String
Public Declare Function Trim(s As String) As String

Public Declare Function Len(s As String) As Long
Public Declare Function NullString As String
Public Declare Function	NewLine As String

Public Declare Function PadC(s As String, Length As Long, Char As String = " ") As String
Public Declare Function PadL(s As String, Length As Long, Char As String = " ") As String
Public Declare Function PadR(s As String, Length As Long, Char As String = " ") As String

Public Declare Function Replace(s As String, OldStr As String, NewStr As String) As String
Public Declare Function Reverse(s As String) As String

Public Declare Function Space(Count As Long) As String
Public Declare Function String(Count As Long, Str As String) As String

Public Declare Function Str(n As Double) As String
Public Declare Function Str0(n As Double, Count As Long, Frac As Long = 16) As String
Public Declare Function Tally(s As String, ss As String) As Long
Public Declare Function Asc(s As String) As Byte
Public Declare Function Chr(n As Byte) As String

Public Declare Function Split(src As String, sep As String) As String()
Public Declare Function SplitAny(src As String, sep As String) As String()
Public Declare Function Join(ByRef dest() As String, sep As String) As String

Public Declare Function StartsWith(s As String, chk As String) As Boolean
Public Declare Function EndsWith(s As String, chk As String) As Boolean

'Strings RegEx---------------------------------------------------------------------------------------------------
Public Declare Function Like(target As String, pattern As String) As Boolean
Public Declare Function ReplaceEx(text As String, pattern As String, NewStr As String) As String
Public Declare Function SearchEx(text As String, pattern As String) As String
Public Declare Function SearchAllEx(text As String, pattern As String) As String()
'Strings RegEx---------------------------------------------------------------------------------------------------
'Strings---------------------------------------------------------------------------------------------------


'Maths---------------------------------------------------------------------------------------------------
Public Declare Function Abs(n As Double) As Double
Public Declare Function Ceil(n As Double) As Double
Public Declare Function CLng(n As Double) As Long
Public Declare Function Cos(n As Double) As Double
Public Declare Function Exp(n As Double) As Double
Public Declare Function Fix(n As Double) As Double
Public Declare Function Floor(n As Double) As Double
Public Declare Function Frac(n As Double) As Double
Public Declare Function Hex(n As UInteger) As String
Public Declare Function Int(n As Double) As Integer
Public Declare Function Log(n As Double) As Double
Public Declare Function	Pow(n As Double, p As Double) As Double

Public Declare Sub		Randomize(Seed As Long)
Public Declare Function Rnd(Max As Long = 0) As Double

Public Declare Function Round(n As Double) As Long
Public Declare Function Sgn(n As Double) As Long
Public Declare Function Sin(n As Double) As Double
Public Declare Function Sqr(n As Double) As Double
Public Declare Function Tan(n As Double) As Double
Public Declare Function Val(s As String) As Double
'Maths---------------------------------------------------------------------------------------------------


'FileSystems---------------------------------------------------------------------------------------------------
Public Declare Function PathSep As String
Public Declare Sub		ChDir(Dir As String)

Public Declare Function Dir(path As String = "") As String
Public Declare Sub 		CloseDir(closeAll As Boolean = False)
Public Declare Sub		Kill(FileName As String)

Public Declare Function IsDIR(path As String) 	As Long
Public Declare Function IsFIFO(path As String) 	As Long
Public Declare Function IsCHR(path As String) 	As Long
Public Declare Function IsBLK(path As String) 	As Long
Public Declare Function IsREG(path As String) 	As Long

Public Declare Function DirExists(Dir As String) As Boolean
Public Declare Function FileExists(FileName As String) As Boolean
Public Declare Sub		MkDir(Dir As String)
Public Declare Sub		Rename(OldName As String, FileName As String)
Public Declare Sub		RmDir(Dir As String)

Public Declare Function FreeFile As Integer
Public Declare Function Eof(fn As Integer) As Boolean
Public Declare Function FileLen(fn As Integer) As Long
'FileSystems---------------------------------------------------------------------------------------------------


'OS---------------------------------------------------------------------------------------------------
Public Declare Function Date As String
Public Declare Function FullDate As String
Public Declare Function Time As String
Public Declare Function Timer As Double

Public Declare Function RunAs As String
Public Declare Function Environ(Var As String) As String
Public Declare Function InStat As Boolean
Public Declare Function InKey As String
Public Declare Sub		Shell(Cmd As String)
Public Declare Sub		Sleep(sec As Integer)

'OS---------------------------------------------------------------------------------------------------


'GUI---------------------------------------------------------------------------------------------------
Public Declare Sub DoEvents
Public Declare Function MsgBox(prompt As String, buttons As Integer = 4, title As String = "Information") As Integer
'GUI---------------------------------------------------------------------------------------------------


'Utilities---------------------------------------------------------------------------------------------------
Public Declare Function CreateObject(ClassName As String) As Object
Public Declare Function IIf(Cond As Boolean, OnTrue As Variant, OnFalse As Variant) As Variant
Public Declare Function Rgb(r As Byte, g As Byte, b As Byte) As Integer

Public Declare Function MemCmp(P1 As Long, P2 As Long, Size As Long) As Long
Public Declare Sub		MemCpy(Dest As Long, Src As Long, Count As Long)
Public Declare Sub		MemSet(Dest As Long, Char As Byte, Count As Long)
Public Declare Function VarPtr(Var As ANY) As Long
Public Declare Function VarPtr#(Var As Long) As Double
Public Declare Function VarPtr$(Ptr As Long) As String
Public Declare Function VarType(ByRef Var As Variant) As VariantType

Public Declare Function MemoryCreate(Count As Long) As Long
Public Declare Sub 		MemoryFree(var As Long)
Public Declare Function MemoryResize(var AS Long,Size As Long) As Long
'Utilities---------------------------------------------------------------------------------------------------


Public Declare INITIALIZATION
Public Declare FINALIZATION


Alias Command$	= Command
Alias Chr$		= Chr
Alias CInt		= CLng
Alias Date$		= Date
Alias Delete$	= Delete
Alias Dir$		= Dir
Alias Environ$	= Environ
Alias FullDate$	= FullDate
Alias Hex$		= Hex
Alias Insert$	= Insert
Alias LCase$	= LCase
Alias Left$		= Left
Alias LTrim$	= LTrim
Alias Mid$		= Mid
Alias ReplaceEx$	= ReplaceEx
Alias Replace$  = Replace
Alias Reverse$	= Reverse
Alias Right$	= Right
Alias RTrim$	= RTrim
Alias Space$	= Space
Alias Str$		= Str
Alias String$	= String
Alias Trim$	    = Trim
Alias UCase$	= UCase
Alias InKey$	= InKey
