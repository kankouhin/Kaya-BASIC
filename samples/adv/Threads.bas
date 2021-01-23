Option Explicit
' http://www.cplusplus.com/reference/mutex/mutex/

Dim mtx As Mutex

Sub print_block( n As Integer, c As String )
	mtx.Lock
	
	For i As Integer = 1 To n
		cout << c
	Next
	
	cout << "\n"
	mtx.Unlock()
End Sub

Sub Main
	Dim th1 As Thread( AddressOf print_block, 50, "*" )
	Dim th2 As Thread( AddressOf print_block, 50, "$" )

	th1.Join
	th2.Join
End Sub
