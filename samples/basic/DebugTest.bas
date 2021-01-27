
Dim ss as String = "Hello KayaBASIC"

Sub test
        ss += "test"
End Sub

Sub Main
        Dim idx As Integer = 1

        Select Case idx
                Case 2,3,4
                        Print idx
                Case Else

                        If idx > 1 Then
                                print idx
                        Else
                                print idx
                        End If   
        End Select

        Do While idx < 5
                ss += Str(idx)
                idx++
        Loop

        Do
                If idx < 10 Then
                        For i As Integer = idx To idx
                                ss += Str(idx)       
                        Next
                Else
                        Exit Do
                End If
                idx++    
        Loop

        Do
                ss += Str(idx)
                idx++
        Loop While idx < 15

        Do
                ss += Str(idx)
                idx++
        Loop Until idx = 20  

        While idx < 25
                For i As Integer = idx To idx + 2
                        ss += Str(idx)       
                Next
                idx++
        Wend

        For i As Integer = idx To idx + 5
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