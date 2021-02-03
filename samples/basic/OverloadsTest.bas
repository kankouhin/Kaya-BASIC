Option Explicit

Option Preserve

Using OverloadsLib

Class OverloadClass
        Public Function normalfunc As Integer

        Public Overloads Function overfunc As Integer
        Public Overloads Function overfunc(arg As Long) As Integer
        Public Overloads Function overfunc(arg As Long, arg2 As Long) As Integer

        Public Function normalfunc2(arg As Long, arg2 As Long) As Integer
End Class

Function OverloadClass.normalfunc
        Print "OverloadClass.normalfunc"
        Function = 0
End Function

Function OverloadClass.overfunc
        Print "OverloadClass.Function1"
        Function = 0
End Function

Function OverloadClass.overfunc
        Print "OverloadClass.Function2"
        Function = 0
End Function

Function OverloadClass.normalfunc2
        Print "OverloadClass.normalfunc2"
        Function = 0
End Function

Function OverloadClass.overfunc
        Print "OverloadClass.Function3"
        Function = 0
End Function


'==================================================================

Overloads Function overfunc As Integer
        Print "Function1"
        Function = 0
End Function

Overloads Function overfunc(arg As Long) As Integer
        Print "Function2"
        Function = 0
End Function

Overloads Function overfunc(arg As Long, arg2 As Long) As Integer
        Print "Function3"
        Function = 0
End Function

Sub Main
        Dim cls As New OverloadClass
        Dim clsLib As New OverloadClassLib

        cls.overfunc
        cls.overfunc(1,1)
        cls.overfunc(1)
        
        clsLib.overfunc(1,1)
        clsLib.overfunc
        clsLib.overfunc(1)

        overfunc(1,1)
        overfunc
        overfunc(1)

        overfuncLib(1,1)
        overfuncLib
        overfuncLib(1)        
End Sub
