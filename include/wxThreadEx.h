

class wxThreadJoinable : public wxThread
{
public:
    wxThreadJoinable();

    // thread execution starts here
    virtual void *Entry() wxOVERRIDE;

    // called when the thread exits - whether it terminates normally or is
    // stopped with Delete() (but not when it is Kill()ed!)
    virtual void OnExit() wxOVERRIDE;

public:
	
	void (*OnRun)();
};

wxThreadJoinable::wxThreadJoinable()
        : wxThread(wxTHREAD_JOINABLE)
{
}

void wxThreadJoinable::OnExit()
{
}

wxThread::ExitCode wxThreadJoinable::Entry()
{
	//wxMutexGuiEnter();
	
	if (OnRun)
		OnRun();
	
	//wxMutexGuiLeave();
	
    return NULL;
}