Option Explicit

Import GenericsLib
Import Generics2Lib

Class GenericClass<U>
        Public Sub normalSub
        Public Sub genericSub<T>(arg As T)
        Public Prop As U
End Class

Sub GenericClass.normalSub
        Print "GenericClass.normalSub", Me.Prop
End Sub

Sub GenericClass.genericSub
        Print "GenericClass.genericSub", arg, Me.Prop
End Sub

Public Function Operator < <T>( a As GenericClass<T>, b As GenericClass<T> ) As Boolean
        Function = a.Prop < b.Prop
End Function

Sub Main
        Print Max(10,5)
        Print Max(10.0,5.3)
        Print Min(10,5)
        Print Min(10.0,5.3)

        Print IIf(true, 1, 2), " ", IIf(false, 1, 2)

        Dim gc as new GenericClass<Integer>
        gc.Prop = 10
        gc.normalSub
        gc.genericSub(10.5)

        Dim gc2 as new GenericClass<Integer>
        gc2.Prop = 20

        Print Min( gc, gc2 ) As GenericClass.Prop
        Print Min( gc, gc2 ).Prop
End Sub