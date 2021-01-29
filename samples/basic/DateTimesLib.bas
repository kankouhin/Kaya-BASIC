Option Explicit

Using StdCPP

Public Class DateTime
        Public Static Function Now As DateTime

        Public Function DateSerial(iYear As Integer, iMonth As Integer, iDay As Integer) As DateTime
        Public Function DateValue(date As String) As DateTime
        Public Function Format(s As String) As String

        Public Function Operator += (days As Integer) As DateTime
        Public Function Operator -= (days As Integer) As DateTime
        Public Function Operator + (days As Integer) As DateTime

        Public Overloads Function Operator - (date As DateTime) As DateTime
        Public Overloads Function Operator - (days As Integer) As DateTime

        Public Property Year As Integer
        Public Property Month As Integer
        Public Property Day As Integer

        Public Property Hour As Integer
        Public Property Minute As Integer
        Public Property Second As Integer
        Public Property Weekday As Integer ReadOnly

        Public timeStruct As tm
        
        Public Static dtSunday  As Integer = 0
        Public Static dtMonday  As Integer = 1
        Public Static dtTuesday As Integer = 2
        Public Static dtWednesday As Integer = 3
        Public Static dtThursday  As Integer = 4
        Public Static dtFriday As Integer = 5
        Public Static dtSaturday As Integer = 6
End Class

Property Get DateTime.Weekday
        Value = timeStruct.tm_wday
End Property

Property Get DateTime.Year
        Value = timeStruct.tm_year + 1900
End Property
Property Set DateTime.Year
        timeStruct.tm_year = Value - 1900
        mktime( AddressOf timeStruct )
End Property

Property Get DateTime.Month
        Value = timeStruct.tm_mon + 1
End Property
Property Set DateTime.Month
        timeStruct.tm_mon = Value - 1
        mktime( AddressOf timeStruct )
End Property

Property Get DateTime.Day
        Value = timeStruct.tm_mday
End Property
Property Set DateTime.Day
        timeStruct.tm_mday = Value
        mktime( AddressOf timeStruct )
End Property


Property Get DateTime.Hour
        Value = timeStruct.tm_hour
End Property
Property Set DateTime.Hour
        timeStruct.tm_hour = Value
        mktime( AddressOf timeStruct )
End Property

Property Get DateTime.Minute
        Value = timeStruct.tm_min
End Property
Property Set DateTime.Minute
        timeStruct.tm_min = Value
        mktime( AddressOf timeStruct )
End Property

Property Get DateTime.Second
        Value = timeStruct.tm_sec
End Property
Property Set DateTime.Second
        timeStruct.tm_sec = Value
        mktime( AddressOf timeStruct )
End Property


Function DateTime.Operator +=
        timeStruct.tm_mday += days
        mktime( AddressOf timeStruct )
        Function = Me
End Function

Function DateTime.Operator -=
        Me += -1 * days
        Function = Me
End Function

Function DateTime.Operator +
        Dim ret As New DateTime
        ret.timeStruct = Me.timeStruct
        ret += days
        Function = ret
End Function

Function DateTime.Operator -
        Dim t1 As time_t = mktime( AddressOf timeStruct )
        Dim t2 As time_t = mktime( AddressOf date.timeStruct )

        Dim t As time_t = Cast(time_t, Abs(difftime(t1, t2)))
        
        ' 1970/1/1 00:00:00
        Dim ret As New DateTime
        Dim ptm As tm Ptr = gmtime( AddressOf t )

        ret.timeStruct = ValueOf ptm
        ret.timeStruct.tm_year -= 1970
        ret.timeStruct.tm_mon -= 1
        ret.timeStruct.tm_mday -= 1
        Function = ret
End Function

Function DateTime.Operator -
        Dim ret As New DateTime
        ret.timeStruct = Me.timeStruct
        ret += -1 * days
        Function = ret
End Function

Function DateTime.DateSerial
        timeStruct = {0}
        timeStruct.tm_year = iYear - 1900
        timeStruct.tm_mon  = iMonth - 1
        me.Day = iDay

        Function = Me
End Function

Function DateTime.DateValue
        timeStruct = {0}
        'yyyy/mm/dd HH:MM:SS
        If date.Len = 10 Then 'yyyy/mm/dd
                sscanf( CStr(date), "%d/%d/%d", _
                        AddressOf timeStruct.tm_year, _
                        AddressOf timeStruct.tm_mon, _
                        AddressOf timeStruct.tm_mday _
                         )
        ElseIf date.Len = 16 Then 'yyyy/mm/dd HH:MM
                sscanf( CStr(date), "%d/%d/%d %d:%d", _
                        AddressOf timeStruct.tm_year, _
                        AddressOf timeStruct.tm_mon, _
                        AddressOf timeStruct.tm_mday, _
                        AddressOf timeStruct.tm_hour, _
                        AddressOf timeStruct.tm_min _
                         )
        ElseIf date.Len = 19 Then 'yyyy/mm/dd HH:MM:SS
                sscanf( CStr(date), "%d/%d/%d %d:%d:%d", _
                        AddressOf timeStruct.tm_year, _
                        AddressOf timeStruct.tm_mon, _
                        AddressOf timeStruct.tm_mday, _
                        AddressOf timeStruct.tm_hour, _
                        AddressOf timeStruct.tm_min, _
                        AddressOf timeStruct.tm_sec _
                         )
        Else
                Throw "datetime format: 'yyyy/mm/dd HH:MM:SS'."
        End If    

        timeStruct.tm_year -= 1900
        timeStruct.tm_mon -= 1
        me.Day = timeStruct.tm_mday

        Function = Me
End Function

Function DateTime.Format
        Dim buf[256] As Char
        strftime( buf, 256, CStr(s), AddressOf timeStruct )
        Function = buf
End Function

Function DateTime.Now
        Dim ret As New DateTime

        Dim n As time_t = c_time(Nothing)
        Dim ptm As tm Ptr = localtime( AddressOf n )

        ret.timeStruct = ValueOf ptm
        Function = ret
End Function
