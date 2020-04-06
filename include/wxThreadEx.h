
#ifndef __wxThreadJoinable_H__
#define __wxThreadJoinable_H__

typedef void (*pwxThreadProc)();

class wxThreadJoinable : public wxThread
{
public:
//	wxThreadJoinable()
    wxThreadJoinable(pwxThreadProc onentry, pwxThreadProc onexit = NULL);

    // thread execution starts here
    virtual void* Entry() wxOVERRIDE;

    // called when the thread exits - whether it terminates normally or is
    // stopped with Delete() (but not when it is Kill()ed!)
    virtual void OnExit() wxOVERRIDE;

private:
	pwxThreadProc OnEntry;
	pwxThreadProc OnQuit;
};

/*
inline wxThreadJoinable::wxThreadJoinable()
        : wxThread(wxTHREAD_JOINABLE)
{
}
*/

inline wxThreadJoinable::wxThreadJoinable(pwxThreadProc onentry, pwxThreadProc onexit)
        : wxThread(wxTHREAD_JOINABLE)
{
	OnEntry = onentry;
	OnQuit  = onexit;
}

inline void wxThreadJoinable::OnExit()
{
	if (OnQuit)
		OnQuit();
}

inline void* wxThreadJoinable::Entry()
{
	if (OnEntry)
		OnEntry();

    return NULL;
}

#endif