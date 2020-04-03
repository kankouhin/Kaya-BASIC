
#ifndef __wxThreadJoinable_H__
#define __wxThreadJoinable_H__

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

inline wxThreadJoinable::wxThreadJoinable()
        : wxThread(wxTHREAD_JOINABLE)
{
}

inline void wxThreadJoinable::OnExit()
{
}

inline wxThread::ExitCode wxThreadJoinable::Entry()
{
	if (OnRun)
		OnRun();

    return NULL;
}

#endif