#include "../lib/core/core.h"
#include <windows.h>

namespace bpp
{

#include "Utils.h"

namespace Utils
{

	Integer __BPPCALL MsgBox(string Prompt, Integer Buttons, string Title)
	{
		return MessageBox(GetActiveWindow(), Prompt.c_str(), Title.c_str(), Buttons);
	}

	
	
initialization::initialization()
{
}

finalization::~finalization()
{
}

}
}
