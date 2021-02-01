
Public Function IIF<T>(condition as Boolean, a As T, b As T) As T
        If condition Then
                Function = a
        Else
                Function = b
        End If
End Function