
Dim ss as String = "Hello KayaBASIC"

Sub test
        ss += "test"
End Sub

Sub Main
        Dim idx As Integer = 1

        Do While idx < 10
                ss += Str(idx)
                idx++
        Loop

        Do
                idx++
                ss += Str(idx)
        Loop While idx < 20

        While idx < 30
                ss += Str(idx)
                idx++
        Wend

        For idx = 30 To 40
                ss += Str(idx)
        Next

        Call test

        Dim s As String
        For Each s In ss
                Print s
        Next

        With ss
               Print .Len
        End With

        If ss.Len > 10 Then
                Print "Len > 10"
        End If
End Sub