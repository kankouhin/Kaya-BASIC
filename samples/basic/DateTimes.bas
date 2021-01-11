
'need compile with -pro option

Option Explicit

Class DateTime
        Public Static Function Now As DateTime
        Public Function DateSerial(iYear As Integer, iMonth As Integer, iDay As Integer) As DateTime
        
        Public Function Operator += (days As Integer) As DateTime

        Public Property Year As Integer
        Public Property Month As Integer
        Public Property Day As Integer

        Private  timeStruct As tm
End Class

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

Function DateTime.Operator +=
        timeStruct.tm_mday += days
        mktime( AddressOf timeStruct )
        Function = Me
End Function

Function DateTime.DateSerial
        timeStruct = {0}
        timeStruct.tm_year = iYear - 1900
        timeStruct.tm_mon  = iMonth - 1
        me.Day = iDay

        Function = Me
End Function

Function DateTime.Now
        Dim ret As New DateTime

        Dim n As time_t = c_time(Nothing)
        Dim ltm As tm Ptr = localtime( AddressOf n )

        ret.timeStruct = *ltm
        Function = ret
End Function


Sub printDate( dt As DateTime )
        Print " Year:", dt.Year, " Month:", dt.Month, " Day:", dt.Day
End Sub

Sub Main
        Dim dt As DateTime = DateTime.Now
        printDate dt

        dt.DateSerial( 2021,1, 60 )
        printDate dt

        Dim i As Integer = 1
        dt += i
        printDate dt

End Sub
