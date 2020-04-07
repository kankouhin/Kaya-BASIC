Option Explicit

Sub Main
	Dim col As Integer Collection
	Dim i As Integer = 0
	
	col.Add(1)
	col.Add(2)
	col.Add(3)
	
	Print "Start"
	
	Print "Break..."
	While True
		Print 10
		Do
			Print 20
			Do
				Print 30
				Do While True
					Print 40
					For dix As Integer = 0 To 100
						Print 50
						For Each ii As Integer In col
							Print 60
							If i = 0 Then
								i = 1
								Print "Exit To 2"
								Exit To 2
							Else
								Exit All
							End If
							Print 61
						Next
						Print 51
					Next
					Print 41
				Loop
				Print 31
			Loop While True
			Print 21
		Loop Until False
		Print 11
	Wend
	
	
	Print "Continue..."
	i = 0
	For Each ii As Integer In col
		Print 10
		Do
			Print 20
			Do
				Print 30
				Do While True
					Print 40
					For dix As Integer = 0 To 100
						Print 50
						While True
							Print 60
							If i = 0 Then
								i = 1
								Print "Continue To 2"
								Continue To 2
							Else
								Exit All
							End If
							Print 61
						Wend
						Print 51
					Next
					Print 41
				Loop
				Print 31
			Loop While True
			Print 21
		Loop Until False
		Print 11
	Next
	
	Print "End"
	
End Sub