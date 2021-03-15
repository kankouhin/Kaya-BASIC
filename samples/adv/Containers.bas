Option Explicit

Using stdcpp

Sub Main
        dim ar as vector<integer> = {2, 16, 77, 34, 50}
        ar.push_back(100)

        for each it as integer in ar
                print it
        next for


        dim lst as list<integer> = {75, 23, 65, 42, 13}
        for each it as integer in lst
                print it
        next for        


        dim dic as map<integer, integer>
        dic[300] = 100
        dic[100] = 200
        dic[200] = 300

        for each it as auto in dic
                print it.first, " -> ", it.second
        next for
End Sub