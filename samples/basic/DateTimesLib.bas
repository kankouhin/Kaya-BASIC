'need compile with -pro option
Option Explicit

Public Class DateTime
        Public Static Function Now As DateTime

        Public Function DateSerial(iYear As Integer, iMonth As Integer, iDay As Integer) As DateTime
        Public Function Operator += (days As Integer) As DateTime

        Public Property Year As Integer
        Public Property Month As Integer
        Public Property Day As Integer

        Private  timeStruct As tm

        Public Static kbMonday  As Integer = 1
        Public Static kbTuesday As Integer = 2
        Public Static kbWednesday As Integer = 3
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

