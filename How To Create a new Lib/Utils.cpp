#include "../core/core.h"
#include <windows.h>

namespace bpp
{

#include "Utils.h"

namespace Utils
{

	Long __BPPCALL MsgBox(string Prompt, Long Buttons, string Title)
	{
		return MessageBox(GetActiveWindow(), Prompt.cstr(), Title.cstr(), Buttons);
	}

}
}