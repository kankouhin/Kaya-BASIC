Option Explicit
' http://www.cplusplus.com/reference/cmath/

Const PI As Double = 3.14159265

Sub Main
	' Trigonometric functions
	Print cos ( 60 * PI / 180.0 )
	Print sin ( 30 * PI / 180.0 )
	Print tan ( 45 * PI / 180.0 )
	Print acos (0.5) * 180.0 / PI
	Print asin (0.5) * 180.0 / PI
	Print atan (1.0) * 180 / PI
	Print atan2 (10.0,-10.0) * 180 / PI
	
	' Hyperbolic functions
	Print cosh ( log(2.0) )
	Print sinh ( log(2.0) )
	Print tanh ( log(2.0) )
	Print acosh ( exp(2) - sinh(2) )
	Print asinh ( exp(2) - cosh(2) )
	Print atanh ( tanh(1) )
	
	' Exponential and logarithmic functions
	Print exp (5.0)
	Dim n As Integer
	Print frexp( 8.0, @n );
	Print " ", n 
	Print ldexp ( 0.95, 4 )
	Print Log ( 5.5 )
	Print log10 ( 1000.0 )
	
	Dim f As Double
	Print modf ( PI, @f );
	Print " ", f 
	
	Print exp2 ( 8 )
	Print expm1 ( 1.0 )
	Print ilogb ( 10.0 )
	Print log1p ( 1.0 )
	Print log2 ( 1024.0 )
	Print logb ( 1024.0 )
	Print scalbn ( 1.5, 4 )
	Print scalbln ( 1.5, 4 )
	
	' Power functions
	Print pow ( 7.0, 3.0 )
	Print sqrt ( 1024 )
	Print cbrt ( 27.0 )
	Print hypot ( 3.0, 4.0 )
	
	' etc...
End Sub
