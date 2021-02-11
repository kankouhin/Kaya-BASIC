//-----------------------------------------------------------------------------
// Copyright (c) 2000-04 Mike Morearty <mike@morearty.com>
// Original source and docs: http://www.morearty.com/code/dispatch
//
// CDispatchPtr helper class
//
// Usage of this class:
//
// CDispatchPtr is a wrapper for an IDispatch pointer.  It inherits from, and
// thus shares capabilities with, the C runtime's IDispatchPtr class.
//
// What CDispatchPtr adds is member functions to make it very easy to get/set
// properties and invoke methods via IDispatch.  Some examples:
//
//		CDispatchPtr htmlDoc; // assume this points to an IE HTML document
//
//		_bstr_t title = htmlDoc.Get("title");
//		htmlDoc.Set("title", "new title");
//		htmldoc.Get("body").Get("firstChild").Invoke(
//						"insertAdjacentText", "afterBegin", "hello world");
//		_bstr_t html = htmldoc.Get("body").Get("innerHTML");
//		long height = htmldoc.Get("body").Get("clientHeight");
//		CDispatchPtr body = htmlDoc.Get("body");
//-----------------------------------------------------------------------------

#include "comutil.h"

class CDispatchVariant : public _variant_t
{
public:
	using _variant_t::_variant_t;
	
	CDispatchVariant(string strSrc) : _variant_t( strSrc.c_str() ) { }

	void CreateObject(LPCOLESTR szProgId)
	{
		IDispatch *ppDisp;
		CLSID clsid;
	
		HRESULT hr = CLSIDFromProgID(szProgId, &clsid);
		_com_util::CheckError(hr);
		
		hr = CoCreateInstance(
		    		clsid, NULL,
		    		CLSCTX_LOCAL_SERVER|CLSCTX_INPROC_SERVER,
		    		IID_IDispatch, (LPVOID*)&ppDisp);
		_com_util::CheckError(hr);
		
		*this = ppDisp;
		ppDisp->Release();
	}
	
	void GetObject(LPCOLESTR szProgId)
	{
		IDispatch *ppDisp;
		CLSID clsid;
		IUnknown * pUnk = NULL;

		HRESULT hr = CLSIDFromProgID(szProgId, &clsid);
		_com_util::CheckError(hr);
		hr = ::GetActiveObject(clsid, NULL, &pUnk);
		_com_util::CheckError(hr);

		hr = pUnk->QueryInterface(IID_IDispatch, (LPVOID*)&ppDisp);
		_com_util::CheckError(hr);

		*this = ppDisp;
		ppDisp->Release();
	}
	
public:
	template <class DispatchItem>
	CDispatchVariant Get(DispatchItem property);

	template <class DispatchItem>
	CDispatchVariant Get(DispatchItem property,
							const CDispatchVariant& arg1);

	template <class DispatchItem>
	CDispatchVariant Get(DispatchItem property,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2);

	// Set: set a property's value
	template <class DispatchItem>
	void Set(DispatchItem property, const CDispatchVariant& value);

	// SetRef: set a reference to a property's value
	template <class DispatchItem>
	void SetRef(DispatchItem property, const CDispatchVariant& value);

	// Invoke: invoke a method
	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4,
							const CDispatchVariant& arg5);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4,
							const CDispatchVariant& arg5,
							const CDispatchVariant& arg6);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4,
							const CDispatchVariant& arg5,
							const CDispatchVariant& arg6,
							const CDispatchVariant& arg7);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4,
							const CDispatchVariant& arg5,
							const CDispatchVariant& arg6,
							const CDispatchVariant& arg7,
							const CDispatchVariant& arg8);

	template <class DispatchItem>
	CDispatchVariant Invoke(DispatchItem method,
							const CDispatchVariant& arg1,
							const CDispatchVariant& arg2,
							const CDispatchVariant& arg3,
							const CDispatchVariant& arg4,
							const CDispatchVariant& arg5,
							const CDispatchVariant& arg6,
							const CDispatchVariant& arg7,
							const CDispatchVariant& arg8,
							const CDispatchVariant& arg9);


protected:
	HRESULT InvokeHelper(DISPID dispatchItem,
					  const VARIANT* params,
					  int cParams,
					  WORD invokeType,
					  VARIANT* result)
	{
		IDispatch* disp = (IDispatch*)(*this);
		DISPPARAMS dispparams = { const_cast<VARIANT*>(params), 0, (UINT)cParams, 0 };
		HRESULT hr;
		DISPID dispidSet;
		EXCEPINFO excepInfo;
		SecureZeroMemory(&excepInfo, sizeof(EXCEPINFO));

		if (invokeType == DISPATCH_PROPERTYPUT ||
			invokeType == DISPATCH_PROPERTYPUTREF)
		{
			dispidSet = DISPID_PROPERTYPUT;

			dispparams.cNamedArgs = 1;
			dispparams.rgdispidNamedArgs = &dispidSet;
		}

		// A hard-coded assumption that "result" does NOT already
		// contain a valid variant!
		if (result)
			V_VT(result) = VT_EMPTY;

		hr = disp->Invoke(dispatchItem, IID_NULL, LOCALE_SYSTEM_DEFAULT,
			invokeType, &dispparams, result, &excepInfo, NULL);
			
		return hr;
	}

	// dispatchItem is (wchar_t*) -- convert it to a DISPID
	void InvokeHelper(string dispatchItem,
					  const VARIANT* params,
					  int cParams,
					  WORD invokeType,
					  VARIANT* result)
	{
		
		InvokeHelper( dispatchItem.c_str(), params, cParams, invokeType, result );
	}
	
	// dispatchItem is (wchar_t*) -- convert it to a DISPID
	void InvokeHelper(LPCOLESTR dispatchItem,
					  const VARIANT* params,
					  int cParams,
					  WORD invokeType,
					  VARIANT* result)
	{
		IDispatch* disp = (IDispatch*)(*this);


		DISPID dispid;
		HRESULT hr = disp->GetIDsOfNames(IID_NULL, const_cast<LPOLESTR*>(&dispatchItem), 1,
			LOCALE_SYSTEM_DEFAULT, &dispid);
		_com_util::CheckError(hr);
		
		// call the DISPID overload of InvokeHelper()
		hr = InvokeHelper(dispid, params, cParams, invokeType, result);
		_com_util::CheckError(hr);
	}

	// dispatchItem is an Ansi LPSTR  -- convert it to an LPOLESTR
	void InvokeHelper(LPCSTR dispatchItem,
					  const VARIANT* params,
					  int cParams,
					  WORD invokeType,
					  VARIANT* result)
	{
		OLECHAR nameBuff[256]; // try to avoid doing an allocation
		LPOLESTR wideName;

		int cch = strlen(dispatchItem) + 1;
		if (cch <= sizeof(nameBuff) / sizeof(OLECHAR))
			wideName = nameBuff;
		else
		{
			// dispatch item name is longer than our fixed-size buffer; allocate.
			// Do NOT use alloca() [or ATL's A2W(), which uses alloca()], because
			// this is function may be inlined (although that's not likely), and
			// that could cause a stack overflow if this function is called from
			// within a loop

			wideName = new OLECHAR[cch]; // cch may be just a bit bigger than necessary
			if (wideName == NULL)
				_com_util::CheckError(0);
		}

		wideName[0] = '\0';
		MultiByteToWideChar(CP_ACP, 0, dispatchItem, -1, wideName, cch);

		// call the LPOLESTR overload of InvokeHelper()
		InvokeHelper(wideName, params, cParams, invokeType, result);

		if (wideName != nameBuff)
			delete[] wideName;
	}
};


// Get: get a property's value
template <class DispatchItem>
CDispatchVariant CDispatchVariant::Get(DispatchItem property)
{
	VARIANT result;
	InvokeHelper(property, NULL, 0, DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Get(DispatchItem property,
						const CDispatchVariant& arg1)
{
	VARIANT result;
	InvokeHelper(property, &arg1, 1, DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Get(DispatchItem property,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2)
{
	VARIANT result;
	VARIANT args[2];

	args[0] = arg2;
	args[1] = arg1;
	InvokeHelper(property, args, 2, DISPATCH_PROPERTYGET, &result);
	return result;
}

// Set: set a property's value
template <class DispatchItem>
void CDispatchVariant::Set(DispatchItem property, const CDispatchVariant& value)
{
	InvokeHelper(property, &value, 1, DISPATCH_PROPERTYPUT, NULL);
}

// SetRef: set a reference to a property's value
template <class DispatchItem>
void CDispatchVariant::SetRef(DispatchItem property, const CDispatchVariant& value)
{
	InvokeHelper(property, &value, 1, DISPATCH_PROPERTYPUTREF, NULL);
}

// Invoke: invoke a method
template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method)
{
	VARIANT result;
	InvokeHelper(method, NULL, 0, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1)
{
	VARIANT result;
	InvokeHelper(method, &arg1, 1, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2)
{
	VARIANT result;
	VARIANT args[2];

	args[0] = arg2;
	args[1] = arg1;

	InvokeHelper(method, args, 2, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3)
{
	VARIANT result;
	VARIANT args[3];

	args[0] = arg3;
	args[1] = arg2;
	args[2] = arg1;

	InvokeHelper(method, args, 3, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4)
{
	VARIANT result;
	VARIANT args[4];

	args[0] = arg4;
	args[1] = arg3;
	args[2] = arg2;
	args[3] = arg1;

	InvokeHelper(method, args, 4, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4,
						const CDispatchVariant& arg5)
{
	VARIANT result;
	VARIANT args[5];

	args[0] = arg5;
	args[1] = arg4;
	args[2] = arg3;
	args[3] = arg2;
	args[4] = arg1;

	InvokeHelper(method, args, 5, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4,
						const CDispatchVariant& arg5,
						const CDispatchVariant& arg6)
{
	VARIANT result;
	VARIANT args[6];

	args[0] = arg6;
	args[1] = arg5;
	args[2] = arg4;
	args[3] = arg3;
	args[4] = arg2;
	args[5] = arg1;

	InvokeHelper(method, args, 6, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4,
						const CDispatchVariant& arg5,
						const CDispatchVariant& arg6,
						const CDispatchVariant& arg7)
{
	VARIANT result;
	VARIANT args[7];

	args[0] = arg7;
	args[1] = arg6;
	args[2] = arg5;
	args[3] = arg4;
	args[4] = arg3;
	args[5] = arg2;
	args[6] = arg1;

	InvokeHelper(method, args, 7, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4,
						const CDispatchVariant& arg5,
						const CDispatchVariant& arg6,
						const CDispatchVariant& arg7,
						const CDispatchVariant& arg8)
{
	VARIANT result;
	VARIANT args[8];
	
	args[0] = arg8;
	args[1] = arg7;
	args[2] = arg6;
	args[3] = arg5;
	args[4] = arg4;
	args[5] = arg3;
	args[6] = arg2;
	args[7] = arg1;

	InvokeHelper(method, args, 8, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

template <class DispatchItem>
CDispatchVariant CDispatchVariant::Invoke(DispatchItem method,
						const CDispatchVariant& arg1,
						const CDispatchVariant& arg2,
						const CDispatchVariant& arg3,
						const CDispatchVariant& arg4,
						const CDispatchVariant& arg5,
						const CDispatchVariant& arg6,
						const CDispatchVariant& arg7,
						const CDispatchVariant& arg8,
						const CDispatchVariant& arg9)
{
	VARIANT result;
	VARIANT args[9];

	args[0] = arg9;
	args[1] = arg8;
	args[2] = arg7;
	args[3] = arg6;
	args[4] = arg5;
	args[5] = arg4;
	args[6] = arg3;
	args[7] = arg2;
	args[8] = arg1;

	InvokeHelper(method, args, 9, DISPATCH_METHOD | DISPATCH_PROPERTYGET, &result);
	return result;
}

namespace bpp
{

template<class T>
inline T conv(T* ptr, CDispatchVariant x)
{
	return x;
}

inline string conv(string* ptr, CDispatchVariant x)
{
	_bstr_t val = x;
	string ret(val);
	return ret;
}

inline CDispatchVariant conv(CDispatchVariant* ptr, string x)
{
	CDispatchVariant ret(x);
	return ret;
}


typedef CDispatchVariant ComObject;

} //namespace bpp