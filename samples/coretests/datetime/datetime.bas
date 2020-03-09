Option Explicit

Sub Main

	print Now
	print timeserial( 25,24,80 )
	print timeserial( 34,24,80 )
	print timeserial( 34,74,84 )
	
	print dateserial( 2020,2,29 )
	print dateserial( 2020,13,32 )
	
	print Year( now )
	print month( now )
	print day( now )

	print Hour( now )
	print Minute( now )
	print Second( now )
	
	dim dt as double = now
	
	print DateAdd( "d", 10, dt )
	print DateAdd( "m", 11, dt )
	print DateAdd( "y", 6, dt )
	
	print DateAdd( "h", 6, dt )
	print DateAdd( "n", 6, dt )
	print DateAdd( "s", 6, dt )
	
End Sub