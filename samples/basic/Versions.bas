Option Explicit

Sub Main
        Version Windows
                Print "Windows"
        End Version

        Version macOS
                Print "macOS"
        End Version

        Version Linux
                Print "Linux"
        End Version

        Version Linux Or Windows Or macOS
                Print "Common OS"
        End Version

        Version DEBUG
                Print "this code only run if compiled with option -vDEBUG"
        End Version
End Sub