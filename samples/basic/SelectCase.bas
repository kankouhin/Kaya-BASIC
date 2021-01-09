Option Explicit

Sub Main
    Dim age As Integer = 50

    Select Case age
        Case 0 To 18
            Print age, " 0-18"
        Case 19 To 65
            Print age, " 19-65"
        Case 66 To 100
            Print age, " 66-100"
    End Select

    Select Case age
        Case 10, 30, 40, 50
            Print age, " in (10, 30, 40, 50)"
    End Select

    Select Case age
        Case Is < 30
            Print age, " < 30"
        Case Is < 40
            Print age, " < 40"
        Case Is < 50
            Print age, " < 50"
        Case Else
            Print age, " >= 50"
    End Select
End Sub
