Option Explicit

Dim mtx As Mutex

Sub	print_block( n As Integer, c As CHAR )
	mtx.lock()
	
	For i As Integer = 1 To n
		cout << c
	Next
	
	cout << "\n"
	mtx.unlock()
End Sub

Sub Main
	Dim th1 As Thread( AddressOf print_block, 50, Asc("*") )
	Dim th2 As Thread( AddressOf print_block, 50, Asc("$") )
	
	th1.join()
	th2.join()
End Sub
