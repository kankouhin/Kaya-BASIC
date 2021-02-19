#ifndef __BPP_COMSINK_H
#define __BPP_COMSINK_H

class CEventSink : public IDispatch
{
public:
	STDMETHODIMP_(ULONG) AddRef();
	STDMETHODIMP_(ULONG) Release();

	STDMETHODIMP GetTypeInfoCount(UINT *pctinfo);
	STDMETHODIMP GetTypeInfo(UINT iTInfo, LCID lcid, ITypeInfo **ppTInfo);
	STDMETHODIMP GetIDsOfNames(REFIID riid, LPOLESTR *rgszNames, UINT cNames, LCID lcid, DISPID *rgDispId);

	HRESULT connect(IConnectionPoint *pConnectionPoint)
	{
		m_pConnectionPoint = pConnectionPoint;
		return m_pConnectionPoint->Advise(this, &m_dwCookie);
	}

	CEventSink();
	~CEventSink()
	{
		m_pConnectionPoint->Unadvise(m_dwCookie);
		m_pConnectionPoint->Release();
	};

private:
	IConnectionPoint *m_pConnectionPoint;
	LONG m_cRef;
	DWORD m_dwCookie;
};

CEventSink::CEventSink()
{
	m_cRef = 1;
}

STDMETHODIMP_(ULONG)
CEventSink::AddRef()
{
	return InterlockedIncrement(&m_cRef);
}

STDMETHODIMP_(ULONG)
CEventSink::Release()
{
	if (InterlockedDecrement(&m_cRef) == 0)
	{
		delete this;
		return 0;
	}

	return m_cRef;
}

STDMETHODIMP CEventSink::GetTypeInfoCount(UINT *pctinfo)
{
	*pctinfo = 0;
	return S_OK;
}

STDMETHODIMP CEventSink::GetTypeInfo(UINT iTInfo, LCID lcid, ITypeInfo **ppTInfo)
{
	return E_NOTIMPL;
}

STDMETHODIMP CEventSink::GetIDsOfNames(REFIID riid, LPOLESTR *rgszNames, UINT cNames, LCID lcid, DISPID *rgDispId)
{
	return E_NOTIMPL;
}

#define COM_EVENTS_CONNECT(comobject, IID_events)                                                                          \
	{                                                                                                                  \
		IDispatch *pUnknown = (IDispatch *)comobject;                                                              \
		IConnectionPointContainer *pConnectionPointContainer;                                                      \
		IConnectionPoint *pConnectionPoint;                                                                        \
                                                                                                                           \
		HRESULT hr = pUnknown->QueryInterface(IID_IConnectionPointContainer, (void **)&pConnectionPointContainer); \
		hr = pConnectionPointContainer->FindConnectionPoint(IID_events, &pConnectionPoint);                        \
		pConnectionPointContainer->Release();                                                                      \
                                                                                                                           \
		comobject##ComEventHandler.reset(new comobject##CComEventSink);                                            \
		hr = comobject##ComEventHandler->connect(pConnectionPoint);                                                \
	}

#define DECLARE_COM_WITH_EVENTS(comobject) \
	std::shared_ptr<CEventSink> comobject##ComEventHandler;

#define DECLARE_COM_EVENT_SINK(comobject, IID_Events)                                                                                                                              \
	class comobject##CComEventSink : public CEventSink                                                                                                                         \
	{                                                                                                                                                                          \
	public:                                                                                                                                                                    \
		STDMETHODIMP QueryInterface(REFIID riid, void **ppvObject)                                                                                                         \
		{                                                                                                                                                                  \
			*ppvObject = NULL;                                                                                                                                         \
			if (IsEqualIID(riid, IID_IUnknown) || IsEqualIID(riid, IID_IDispatch) || IsEqualIID(riid, IID_Events )) 					           \
					*ppvObject = static_cast<IDispatch *>(this);                                                                                               \
			else                                                                                                                                                       \
				return E_NOINTERFACE;                                                                                                                              \
                                                                                                                                                                                   \
			AddRef();                                                                                                                                                  \
                                                                                                                                                                                   \
			return S_OK;                                                                                                                                               \
		}                                                                                                                                                                  \
		STDMETHODIMP Invoke(DISPID dispIdMember, REFIID riid, LCID lcid, WORD wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, UINT *puArgErr) \
		{

#define DECLARE_COM_EVENT_SINK_END 	\
			return S_OK;    \
		}			\
	};

#endif