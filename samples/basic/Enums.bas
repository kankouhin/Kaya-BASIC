Option Explicit

' Enum = C++ const, so can't call by EnumName.EnumListValue

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

Enum lstFloatType3 As Single Step -0.5
	dtSingle3
	dtDouble3	= 10
	dtDecimal3
	dtReal3
End Enum

Enum lstFloatType4 As Integer Step *2 ' only support +-*/
	dtSingle4 = 1
	dtDouble4
	dtDecimal4
	dtReal4
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

	Print dtSingle3
	Print dtDouble3
	Print dtDecimal3
	Print dtReal3

	Print dtSingle4
	Print dtDouble4
	Print dtDecimal4
	Print dtReal4
End Sub
