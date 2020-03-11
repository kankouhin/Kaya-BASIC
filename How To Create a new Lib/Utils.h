namespace Utils
{

struct initialization { initialization(); };
struct finalization { ~finalization(); };

extern "C" void __BPPCALL Main();
Integer __BPPCALL MsgBox(string, Integer, string);

}