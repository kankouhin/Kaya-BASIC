Option Explicit
Option CallStack On

Sub callStack1
        Print "callStack1"
End Sub

Sub callStack2
        Call callStack1
        Print "callStack2"
End Sub

Sub callStack3
        Try
                Call callStack1
                Call callStack2
                Print "callStack3"
                Throw "callStack3 error1"
        Catch msg As String
                Print Err.Line, " ",  Err.Function, " ",  msg
                Print Err.CallStack
        End Try
        
        Throw 1024
End Sub

Sub callStack4
        Call callStack1
        Call callStack2
        Print "callStack4"
End Sub

Sub callStack5
        Call callStack1
        Call callStack2
        Call callStack3
        Call callStack4
        Print "callStack5"
End Sub

Sub Main
        Call callStack1
        Call callStack2
        Call callStack5
End Sub
