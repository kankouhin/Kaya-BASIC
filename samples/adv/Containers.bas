Option Explicit

Using StdCPP

Class Shape
        Public Sub Draw
End Class

Sub Shape.Draw
        Print "Shape.Draw"
End Sub

Class Rect Extends Shape
        Public Sub Draw
End Class

Sub Rect.Draw
        Print "Rect.Draw"
End Sub

Type Recordset
        No As Integer
        Name As String
End Type

Sub Main
        Dim vec As Vector<Integer> = {2, 16, 77, 34, 50}
        vec.push_back(100)

        For Each it As Integer In vec
                Print it
        Next


        Dim lst As List<Integer> = {75, 23, 65, 42, 13}
        For Each it As Integer In lst
                Print it
        Next


        Dim dic As Map<Integer, Integer>
        dic[300] = 100
        dic[100] = 200
        dic[200] = 300

        For Each it As Auto In dic
                Print it.first, " -> ", it.second
        Next


        Dim dic2 As Map<Integer, Shape>
        dic2[100] = new Shape
        dic2[200] = new Rect

        For Each it As Auto In dic2
                Print it.first, " -> ";
                it.second->Draw()
        Next


        Dim dic3 As Map<Integer, Recordset>
        Dim rs1 As Recordset = {100, "ABC"}
        Dim rs2 As Recordset = {200, "XYZ"}
        
        dic3[10] = rs1
        dic3[20] = rs2

        For Each it As Auto In dic3
                Print it.first, " -> {", it.second.No, " , ", it.second.Name, "}" 
        Next
End Sub