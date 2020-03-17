#include "../core/core.h"
#include <windows.h>

namespace bpp
{

#include "Utils.h"

namespace Utils
{

	Integer __BPPCALL MsgBox(string Prompt, Integer Buttons, string Title)
	{
		return MessageBox(GetActiveWindow(), Prompt.cstr(), Title.cstr(), Buttons);
	}

	
	
initialization::initialization()
{
}

finalization::~finalization()
{
}

}
}