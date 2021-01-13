
Option Explicit

Using DateTimes

Sub printDate( dt As DateTime )
        Print " Year:", dt.Year, " Month:", dt.Month, " Day:", dt.Day
End Sub

Sub Main
        Dim dt As DateTime = DateTime.Now
        printDate dt

        dt.DateSerial( 2021, 2, 28 )
        printDate dt

        Dim i As Integer = 1
        dt += i
        printDate dt

        dt.DateSerial( 2000, 2, 28 )
        printDate dt  

        dt += 1
        printDate dt     

        Print DateTime.kbMonday
End Sub
