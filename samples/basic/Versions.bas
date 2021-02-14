Option Explicit

Sub Main
        ' Only supports Not,And,Or
        ' NOT support Version nest
        Version Windows
                Print "Windows"
        End Version

	Version Windows And 64Bit
                Print "Windows.64bit"
        End Version

	Version Windows And 32Bit
                Print "Windows.32bit"
        End Version
        
        Version macOS
                Print "macOS"
        End Version

        Version Not macOS
                Print "not macOS"
        End Version

        Version Linux
                Print "Linux"
        End Version

        Version Linux Or Windows Or macOS
                Print "Common OS"
        End Version

        Version Debug
                Print "this code can not run if compiled with option -r(Release mode)"
        End Version
End Sub