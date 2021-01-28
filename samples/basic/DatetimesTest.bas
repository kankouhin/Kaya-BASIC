
Option Explicit

Using DateTimesLib

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

        Print dt.Format( "%Y-%m-%d" )

        dt.DateValue("2021/02/28")
        Print dt.Format( "%Y-%m-%d" ) 

        dt.DateValue("2021/02/28 08:30")
        Print dt.Format( "%Y-%m-%d %H:%M" ) 
 
        dt.DateValue("2021/03/02 08:30:15")
        Print dt.Format( "%Y-%m-%d %H:%M:%S" )
        print dt.Weekday

        dt.DateValue("2020/01/28 10:40")  
        If dt.Weekday = DateTime.dtSunday Then
                Print dt.Format( "%Y-%m-%d" ), " Is Sunday"
        End If
 
        Dim dt2 As DateTime = DateTime.Now
        Dim dt3 As DateTime = dt2 - dt
        Print "DateDiff:", dt3.Year, " ", dt3.Month, " ", dt3.Day, " ", dt3.Hour, " ", dt3.Minute, " ", dt3.Second
End Sub
