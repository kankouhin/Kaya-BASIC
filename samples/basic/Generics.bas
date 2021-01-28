Option Explicit

Class GenericClass<U>
        Public Sub normalSub
        Public Sub genericSub<T>(arg As T)
        Private Prop As U
End Class

Sub GenericClass.normalSub
        Print "GenericClass.normalSub", Me.Prop
End Sub

Sub GenericClass.genericSub
        Print "GenericClass.genericSub", arg, Me.Prop
End Sub

Function Max<T>(a As T, b As T) As T
        If a < b Then
                Function = b
        Else
                Function = a
        End If
End Function

Function Min<T>(a As T, b As T) As T
        If a < b Then
                Function = a
        Else
                Function = b
        End If
End Function

Function IIF<T>(condition as Boolean, a As T, b As T) As T
        If condition Then
                Function = a
        Else
                Function = b
        End If
End Function

Sub Main
        Print Max(10,5)
        Print Max(10.0,5.3)
        Print Min(10,5)
        Print Min(10.0,5.3)

        Print IIF(true, 1, 2), " ", IIF(false, 1, 2)

        Dim gc as new GenericClass<Integer>
        gc.normalSub
        gc.genericSub(10.5) 
End Sub