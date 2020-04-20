Option Explicit

Enum lstIntegerType
	dtByte 		= 1
	dtShort
	dtInteger 	= 5
	dtLong
End Enum

Enum lstFloatType As Byte Step 2
	dtSingle
	dtDouble	= 10
	dtDecimal
	dtReal
End Enum

Enum lstFloatType2 As Single Step 0.5
	dtSingle2
	dtDouble2	= 10
	dtDecimal2
	dtReal2
End Enum

Sub Main
	Print dtByte
	Print dtShort
	Print dtInteger
	Print dtLong
	
	Print dtSingle
	Print dtDouble
	Print dtDecimal
	Print dtReal

	Print dtSingle2
	Print dtDouble2
	Print dtDecimal2
	Print dtReal2
End Sub
