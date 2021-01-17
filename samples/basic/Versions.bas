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
End Sub