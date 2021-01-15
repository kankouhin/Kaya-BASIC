Option Explicit

Public Class OverloadClassLib
        Public Function normalfunc As Integer

        Public Overloads Function overfunc As Integer
        Public Overloads Function overfunc(arg As Long) As Integer
        Public Overloads Function overfunc(arg As Long, arg2 As Long) As Integer

        Public Function normalfunc2(arg As Long, arg2 As Long) As Integer
End Class

Function OverloadClassLib.normalfunc
        Print "OverloadClassLib.normalfunc"
        Function = 0
End Function

Function OverloadClassLib.overfunc
        Print "OverloadClassLib.Function1"
        Function = 0
End Function

Function OverloadClassLib.overfunc
        Print "OverloadClassLib.Function2"
        Function = 0
End Function

Function OverloadClassLib.normalfunc2
        Print "OverloadClassLib.normalfunc2"
        Function = 0
End Function

Function OverloadClassLib.overfunc
        Print "OverloadClassLib.Function3"
        Function = 0
End Function


'==================================================================

Public Overloads Function overfuncLib As Integer
        Print "OverloadsLib.Function1"
        Function = 0
End Function

Public Overloads Function overfuncLib(arg As Long) As Integer
        Print "OverloadsLib.Function2"
        Function = 0
End Function

Public Overloads Function overfuncLib(arg As Long, arg2 As Long) As Integer
        Print "OverloadsLib.Function3"
        Function = 0
End Function
