Option Explicit
' this sample shows how to use c/c++ libaray
'
' 1. include header file
' 2. link the libraries
' 3. write codes directly. 
'    NOTE: because nothing(sub/function/const,etc...) defined like wxWidgets classes,
'          you need write codes as same as c/c++: need () after sub name, and also Case-Sensitive.
'
Option CPP_FLAGS 	" -include SDL2-2.0.12/i686-w64-mingw32/include/SDL2/SDL.h "
Option LD_FLAGS		" -LC:/DataMigration/FreeBasic/KayaBASIC/include/SDL2-2.0.12/i686-w64-mingw32/Lib -lSDL2 -lwinmm -limm32 -lSetupapi "

Sub Main
	Dim scancode As Integer = 0 'SDL_Scancode
	SDL_LogSetPriority(SDL_LOG_CATEGORY_APPLICATION, SDL_LOG_PRIORITY_INFO)
	
	If SDL_Init(SDL_INIT_VIDEO) < 0 Then
		SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't initialize SDL: %s\n", SDL_GetError())
		c_exit(1)
	End If
	
	While scancode < SDL_NUM_SCANCODES
		++scancode
		SDL_Log("Scancode #%d, \"%s\"\n", scancode, SDL_GetScancodeName( Cast(SDL_Scancode,scancode)  ))
	Wend
	
	SDL_Quit()
End Sub
