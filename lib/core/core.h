#if !defined(__BPP_VERSION)
#define __BPP_VERSION 010501
#define _RWSTD_NO_EXCEPTIONS

#include <typeinfo>

#ifdef __BPPWIN__
    #include "types_bpp.h"
#else
    #include "types_bpp_lnx.h"
#endif // __BPPWIN__

#include <stdlib.h>
//#include <string.h>
//using namespace std;


#define UBOUND1(x) sizeof(x) / sizeof(x[0])
#define UBOUND2(x) sizeof(x[0]) / sizeof(x[0][0])
#define UBOUND3(x) sizeof(x[0][0]) / sizeof(x[0][0][0])
#define UBOUND4(x) sizeof(x[0][0][0]) / sizeof(x[0][0][0][0])


#define BPP_FILEGETOBJECT(fn) ( (System::File*)System::FileGetObject(fn) )
#define __BPPCALL

#ifdef __BPPWIN__
    #define __CALLBACK __stdcall
#else
    #define __CALLBACK
#endif // __BPPWIN__

namespace bpp
{

class variant;
class string;

void nullify(void*, int);
void loadlib(const string&);
void unloadlibs();
void* getlibhandle(const string&);
void* getprocaddr(void*, const string&);


//DEBUG functions
int dbg_getline();
string dbg_getfunc();
void dbg_line(int n);
void dbg_func(const string& s);
void dbg_endfunc();
int dbg_savefunc();
void dbg_unwind(int n);



class string
{
public:
	string();
	string(const char*);
	string(const string&);
	~string() { release(); }
	string* ptr() { return this; }
	char* cstr() { return dyn >= (string_t*)0x10000 ? dyn->data : (char*)dyn; }
	const char* cstr() const { return dyn >= (string_t*)0x10000 ? dyn->data : (char*)dyn; }
	void alloc(int);
	int length() const;
	int cmp(const string&) const;
	char* operator& () { return cstr(); }
	string& operator= (const string&);
	string& operator+= (const string&);
	string& operator-= (const string&);
	string& operator*= (const string&);
	string& operator/= (const string&);
	string& operator= (const variant&);
	string& operator+= (const variant&);
	string& operator-= (const variant&);
	string& operator*= (const variant&);
	string& operator/= (const variant&);
	string operator+ (const string&) const;
	string operator+ (double) const;
	bool operator== (const string&) const;
	bool operator!= (const string&) const;
	bool operator< (const string&) const;
	bool operator> (const string&) const;
	bool operator<= (const string&) const;
	bool operator>= (const string&) const;
	bool operator! () const { return dyn >= (string_t*)0x10000 ? length() == 0 : false; }
	string& operator++ ();
	string& operator-- ();
	operator void* () const { return dyn >= (string_t*)0x10000 ? (void*)(length() != 0) : 0; }

private:
	struct string_t
	{
		int count;
		int len;
		char data[0];
	} *dyn;

	string(string_t* s) { dyn = s; }
	void release();
};


template <int length>
class flstring
{
public:
	flstring()
	{
		*this = string("");
	}

	flstring(const string& s)
	{
		*this = s;
	}

	string str() const
	{
		char buffer[length + 1], *p = buffer;
		const char *q = data;
		for (int i = 0; i < length; i++, p++, q++)
			*p = *q;
		buffer[length] = 0;
		return string(buffer);
	}

	void operator= (string s)
	{
		int i;
		char *p = data, *q = s.cstr();
		for (i = 0; i < length; i++, p++, q++)
		{
			if (!*q)
				break;
			else
				*p = *q;
		}
		for (int j = i ; j < length; j++, p++)
			*p = 32;
	}

	void operator= (const variant& v)
	{
		*this = string(v);
	}

	void operator+= (const variant& v) { *this = *this + string(v); }
	void operator-= (const variant& v) { *this = *this - string(v); }
	void operator*= (const variant& v) { *this = *this * string(v); }
	void operator/= (const variant& v) { *this = *this / string(v); }
	void operator++ () { ++(*this); }
	void operator-- () { --(*this); }

private:
	char data[length];
};


class apistring
{
public:
	apistring() { data = new char[1]; data[0] = 0; }
	apistring(const char* s);
	apistring(const apistring& s);
	apistring(const string& s);
	~apistring() { if (data >= (char*)0x10000) delete[] data; }
	string str() const { return string(data); }
	int length() const;
	void alloc(int n);
	void operator= (const apistring& s);
	void operator= (const string& s);
	void operator= (const variant& v);
	void operator+= (const variant& v);
	void operator-= (const variant& v);
	void operator*= (const variant& v);
	void operator/= (const variant& v);
	void operator++ ();
	void operator-- ();
	char* operator& () { return data; }

private:
	char* data;
};


template <class T>
inline void swap(T& a, T& b) { T c = a; a = b; b = c; }


template <class T>
class array
{
private:
	T* data;
	struct { int lo, hi, d; } dim[5];

	void check(int i1)
	{
#if defined(__BPP_DEBUG)
		if (i1 < dim[1].lo || i1 > dim[1].hi)
			throw string("array index out of bounds");
#endif
	}

	void check(int i1, int i2)
	{
#if defined(__BPP_DEBUG)
		check(i1);
		if (i2 < dim[2].lo || i2 > dim[2].hi)
			throw string("array index out of bounds");
#endif
	}

	void check(int i1, int i2, int i3)
	{
#if defined(__BPP_DEBUG)
		check(i1, i2);
		if (i3 < dim[3].lo || i3 > dim[3].hi)
			throw string("array index out of bounds");
#endif
	}

	void check(int i1, int i2, int i3, int i4)
	{
#if defined(__BPP_DEBUG)
		check(i1, i2, i3);
		if (i4 < dim[4].lo || i4 > dim[4].hi)
			throw string("array index out of bounds");
#endif
	}

public:
	array() { data = 0; preserve = 0; redim(0,1); }
	array(int l1, int h1) { data = 0; preserve = 0; redim(l1, h1); }
	array(int l1, int h1, int l2, int h2) { data = 0; preserve = 0; redim(l1, h1, l2, h2); }
	array(int l1, int h1, int l2, int h2, int l3, int h3) { data = 0; preserve = 0; redim(l1, h1, l2, h2, l3, h3); }
	array(int l1, int h1, int l2, int h2, int l3, int h3, int l4, int h4) { data = 0; preserve = 0; redim(l1, h1, l2, h2, l3, h3, l4, h4); }
	~array(){ if (data) free(data); data = 0; }

	void redim()
	{
		if ( data && preserve )
		{
			data = (T*)realloc( (void*)data, this->size() * sizeof(T) );
			return;
		}

		if (data) free(data); data = 0;
		data = (T*)calloc( this->size(), sizeof(T) );
	}

	int lbound(int d = 1) { return dim[d].lo; }
	int ubound(int d = 1) { return dim[d].hi; }

	void redim(int l1, int h1)
	{
		if (h1 < l1)
			swap(l1, h1);

		dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;

		if ( !(data && preserve) )
		{
			dim[2].lo = dim[3].lo = dim[4].lo = 0;
			dim[2].hi = dim[3].hi = dim[4].hi = 0;
			dim[2].d = dim[3].d = dim[4].d = 0;
		}

		redim();
	}

	void redim(int l1, int h1, int l2, int h2)
	{
		if (h1 < l1)
			swap(l1, h1);
		if (h2 < l2)
			swap(l2, h2);

		if ( data && preserve )
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
		}
		else
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
			dim[2].lo = l2; dim[2].hi = h2; dim[2].d = h2 - l2 + 1;
		}

		dim[3].lo = dim[4].lo = 0;
		dim[3].hi = dim[4].hi = 0;
		dim[3].d = dim[4].d = 0;

		redim();
	}

	void redim(int l1, int h1, int l2, int h2, int l3, int h3)
	{
		if (h1 < l1)
			swap(l1, h1);
		if (h2 < l2)
			swap(l2, h2);
		if (h3 < l3)
			swap(l3, h3);

		if ( data && preserve )
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
		}
		else
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
			dim[2].lo = l2; dim[2].hi = h2; dim[2].d = h2 - l2 + 1;
			dim[3].lo = l3; dim[3].hi = h3; dim[3].d = h3 - l3 + 1;
		}

		dim[4].lo = 0;  dim[4].hi = 0;
		dim[4].d = 0;
		redim();
	}

	void redim(int l1, int h1, int l2, int h2, int l3, int h3, int l4, int h4)
	{
		if (h1 < l1)
			swap(l1, h1);
		if (h2 < l2)
			swap(l2, h2);
		if (h3 < l3)
			swap(l3, h3);
		if (h4 < l4)
			swap(l4, h4);

		if ( data && preserve )
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
		}
		else
		{
			dim[1].lo = l1; dim[1].hi = h1; dim[1].d = h1 - l1 + 1;
			dim[2].lo = l2; dim[2].hi = h2; dim[2].d = h2 - l2 + 1;
			dim[3].lo = l3; dim[3].hi = h3; dim[3].d = h3 - l3 + 1;
			dim[4].lo = l4; dim[4].hi = h4; dim[4].d = h4 - l4 + 1;
		}

		redim();
	}

	int size()
	{
		int ret = dim[1].d;

		if ( dim[2].d )
			ret *= dim[2].d;
		if ( dim[3].d )
			ret *= dim[3].d;
		if ( dim[4].d )
			ret *= dim[4].d;

		return ret;
	}

	array<T>& operator() () { return *this; }
	T* operator& () { return data; }

	T& operator() (int i1)
	{
		check(i1);
		return data[i1 - dim[1].lo];
	}

	T& operator() (int i1, int i2)
	{
		check(i1, i2);
/*
		return data[
			(i1 - dim[1].lo) * dim[1].d +
			(i2 - dim[2].lo)];
*/
		return data[
			(i1 - dim[1].lo) * dim[2].d +
			(i2 - dim[2].lo)];
	}

	T& operator() (int i1, int i2, int i3)
	{
		check(i1, i2, i3);
/*
		return data[
			(i1 - dim[1].lo) * dim[1].d * dim[2].d +
			(i2 - dim[2].lo) * dim[2].d +
			(i3 - dim[3].lo)];
*/
		return data[
			(i1 - dim[1].lo) * dim[2].d * dim[3].d +
			(i2 - dim[2].lo) * dim[3].d +
			(i3 - dim[3].lo)];
	}

	T& operator() (int i1, int i2, int i3, int i4)
	{
		check(i1, i2, i3, i4);
/*
		return data[
			(i1 - dim[1].lo) * dim[1].d * dim[2].d * dim[3].d +
			(i2 - dim[2].lo) * dim[2].d * dim[3].d +
			(i3 - dim[3].lo) * dim[3].d +
			(i4 - dim[4].lo)];
*/
		return data[
			(i1 - dim[1].lo) * dim[2].d * dim[3].d * dim[4].d +
			(i2 - dim[2].lo) * dim[3].d * dim[4].d +
			(i3 - dim[3].lo) * dim[4].d +
			(i4 - dim[4].lo)];
	}

	int preserve;
};


class object;

template <class T>
class ref
{
public:
	T* ptr;

	ref() { ptr = 0; me = false; }

	ref(const ref<T>& x)
	{
		me = false;
		ptr = (T*)x.ptr;
		addref();
#if defined(__BPP_DEBUG)
		check_class();
#endif
	}

	ref(void* x, bool me = false): me(me)
	{
		ptr =(T*) x;
		if (!me) addref();
#if defined(__BPP_DEBUG)
		check_class();
#endif
	}

	template <class U>
	ref(ref<U> x) { me = false; ptr = x.ptr; addref(); }

	~ref() { if (!me) release(); }

	void operator= (ref<T> x)
	{
		release();
		ptr = (T*)x.ptr;
		addref();
#if defined(__BPP_DEBUG)
		check_class();
#endif
	}

	template <class U>
	void operator= (ref<U> x)
	{
		release();
		(void*)ptr = x.ptr;
		addref();
#if defined(__BPP_DEBUG)
		check_class();
#endif
	}

	void operator= (const variant& v)
	{
		//release();
		(void*)ptr = (void*)Long(v);
#if defined(__BPP_DEBUG)
		check_class();
#endif
	}

	ref& operator+= (const variant& v) { ptr += int(v); return *this; }
	ref& operator-= (const variant& v) { ptr -= int(v); return *this; }
	ref& operator*= (const variant& v) { ptr = int(ptr) * int(v); return *this; }
	ref& operator/= (const variant& v) { ptr = int(ptr) / int(v); return *this; }
	bool operator! () const { return ptr; }
	ref& operator++ () { return *this += 1; }
	ref& operator-- () { return *this -= 1; }
	T* operator* () { return ptr; }

	T* operator-> ()
	{
#if defined(__BPP_DEBUG)
		if (!ptr)
			throw string("attempt to access class member through a null reference");
#endif
		return ptr;
	}

private:
	bool me;

	void addref();
	void release();
#if defined(__BPP_DEBUG)
	void check_class();
#endif
};


struct rtti
{
	virtual string name() = 0;
	virtual ref<object> create() = 0;
	rtti* next;
};


class classlist
{
public:
	static void add(rtti* cl)
	{
		rtti* old = list;
		list = cl;
		cl->next = old;
	}

	static rtti* find(const string& name)
	{
		rtti* cl = list;
		while (cl)
			if (cl->name() == name)
				return cl;
			else
				cl = cl->next;
		return 0;
	}

private:
	static rtti* list;
};


class object
{
public:
	int __refcnt;
	object(bool = false) { __refcnt = 0; }
	// RTTI
	bool __isa(const std::type_info& ti) { return typeid(*this) == ti; }
	virtual bool __isbase(const std::type_info &ti) { return typeid(object) == ti; }
	virtual string ClassName() { return "OBJECT"; }
	// persistence
	virtual void SaveToStream(ref<object>) { }
	virtual void LoadFromStream(ref<object>) { }

protected:
	template<class T> friend class ref;

	virtual void Initialize() { }
	virtual void Terminate() { }
};


template <class T>
inline void ref<T>::addref()
{
	if (!ptr)
		return;
	ptr->__refcnt++;
}

template <class T>
inline void ref<T>::release()
{
	if (!ptr)
		return;
	ptr->__refcnt--;
	if (!ptr->__refcnt)
	{
		((object*)ptr)->Terminate();
		delete ptr;
		//MessageBox(0, "Delete", "release", 0);
		ptr = 0;
	}
}

#if defined(__BPP_DEBUG)

template <class T>
inline void ref<T>::check_class()
{
	try
	{
		if (ptr)
		{
			if (!ptr->__isbase(typeid(T)))
			{
				ptr = 0;
				throw string("illegal typecast");
			}
		}
	}
	catch (...)
	{
		throw;
	}
}

#endif



class variant
{
public:
	enum vartypes { num, str } vartype;

	variant(double = 0);
	variant(const string&);
	template <int length>
	variant(const flstring<length>& s) { *this = s.str(); }
	variant(const apistring& s) { *this = s.str(); }
	template <class T>
	variant(ref<T> p) { *this = (Long)p.ptr; }
	variant& operator= (const variant&);
	variant& operator+= (const variant& v) { return *this = *this + v; }
	variant& operator-= (const variant& v) { return *this = *this - v; }
	variant& operator*= (const variant& v) { return *this = *this * v; }
	variant& operator/= (const variant& v) { return *this = *this / v; }
	// operations with variants
	variant operator+ (const variant&) const;
	variant operator- (const variant&) const;
	variant operator* (const variant&) const;
	variant operator/ (const variant&) const;
	variant operator% (const variant&) const;
	bool operator&& (const variant&) const;
	bool operator|| (const variant&) const;
	variant operator^ (const variant&) const;
	bool operator== (const variant&) const;
	bool operator!= (const variant&) const;
	bool operator< (const variant&) const;
	bool operator> (const variant&) const;
	bool operator<= (const variant&) const;
	bool operator>= (const variant&) const;
	// operations with numbers
	variant operator+ (double) const;
	variant operator- (double) const;
	variant operator* (double) const;
	variant operator/ (double) const;
	variant operator% (double) const;
	bool operator&& (double) const;
	bool operator|| (double) const;
	variant operator^ (double) const;
	bool operator== (double) const;
	bool operator!= (double) const;
	bool operator< (double) const;
	bool operator> (double) const;
	bool operator<= (double) const;
	bool operator>= (double) const;
	// operations with strings
	variant operator+ (const string&) const;
	variant operator- (const string&) const;
	variant operator* (const string&) const;
	variant operator/ (const string&) const;
	variant operator% (const string&) const;
	bool operator&& (const string&) const;
	bool operator|| (const string&) const;
	variant operator^ (const string&) const;
	bool operator== (const string&) const;
	bool operator!= (const string&) const;
	bool operator< (const string&) const;
	bool operator> (const string&) const;
	bool operator<= (const string&) const;
	bool operator>= (const string&) const;
	// operations with apistrings
	bool operator== (const apistring&) const;
	// generic operations
	variant& operator++ () { return *this += 1; }
	variant& operator-- () { return *this -= 1; }
	bool operator! () const;
	void* operator& ();
	operator double () const;
	operator string () const;
	template <int length>
	operator flstring<length>& () const { return s; }
	operator apistring () const { return s; }
	template <class T>
	operator ref<T> () const { return (void*)Long(n); }
	// numeric friends
/*
	friend variant operator+ (double, const variant&);
	friend variant operator- (double, const variant&);
	friend variant operator* (double, const variant&);
	friend variant operator/ (double, const variant&);
	friend variant operator% (double, const variant&);
	friend bool operator&& (double, const variant&);
	friend bool operator|| (double, const variant&);
	friend variant operator^ (double, const variant&);
	//friend bool operator== (double, const variant&);
	friend bool operator!= (double, const variant&);
	friend bool operator< (double, const variant&);
	friend bool operator> (double, const variant&);
	friend bool operator<= (double, const variant&);
	friend bool operator>= (double, const variant&);
	// string friends
	friend variant operator+ (const string&, const variant&);
	friend variant operator- (const string&, const variant&);
	friend variant operator* (const string&, const variant&);
	friend variant operator/ (const string&, const variant&);
	friend variant operator% (const string&, const variant&);
	friend bool operator&& (const string&, const variant&);
	friend bool operator|| (const string&, const variant&);
	friend variant operator^ (const string&, const variant&);
	friend bool operator== (const string&, const variant&);
	friend bool operator!= (const string&, const variant&);
	friend bool operator< (const string&, const variant&);
	friend bool operator> (const string&, const variant&);
	friend bool operator<= (const string&, const variant&);
	friend bool operator>= (const string&, const variant&);
*/
	// API string friends
	friend variant operator+ (const apistring&, const variant&);
	friend variant operator- (const apistring&, const variant&);
	friend variant operator* (const apistring&, const variant&);
	friend variant operator/ (const apistring&, const variant&);
	friend variant operator% (const apistring&, const variant&);
	friend bool operator&& (const apistring&, const variant&);
	friend bool operator|| (const apistring&, const variant&);
	friend variant operator^ (const apistring&, const variant&);
	//friend bool operator== (const apistring&, const variant&);
	friend bool operator!= (const apistring&, const variant&);
	friend bool operator< (const apistring&, const variant&);
	friend bool operator> (const apistring&, const variant&);
	friend bool operator<= (const apistring&, const variant&);
	friend bool operator>= (const apistring&, const variant&);
	// fixed-length string friends
	template <int length>
	friend variant operator+ (const flstring<length>&, const variant&);
	template <int length>
	friend variant operator- (const flstring<length>&, const variant&);
	template <int length>
	friend variant operator* (const flstring<length>&, const variant&);
	template <int length>
	friend variant operator/ (const flstring<length>&, const variant&);
	template <int length>
	friend variant operator% (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator&& (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator|| (const flstring<length>&, const variant&);
	template <int length>
	friend variant operator^ (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator== (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator!= (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator< (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator> (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator<= (const flstring<length>&, const variant&);
	template <int length>
	friend bool operator>= (const flstring<length>&, const variant&);

private:
	double n;
	string s;
};


class iterator
{
public:
	virtual bool next(void* item) = 0;
	virtual bool next(string& index, void* item) { return false; }
};


template <class T>
class collection
{
public:
	struct item
	{
		T value;
		item* next;
		item(const T& x) { next = 0; value = x; }
		~item() { if (next) delete next; }
	};

	class iterator: public bpp::iterator
	{
	public:
		iterator(collection* owner)
		{
			i = owner->count ? owner->items : 0;
		}

		virtual bool next(void* item)
		{
			if (!i)
				return false;
			*(T*)item = i->value;
			i = i->next;
			return true;
		}

	private:
		collection<T>::item* i;
	};

	collection() { count = 0; }
	~collection() { clear(); }

	void add(const T& x)
	{
		last = count ? (last->next = new item(x)) : (items = new item(x));
		count++;
	}

	void add(const T& x, int index)
	{
		item* i = items;
		if (index)
		{
			while (--index)
			{
				i = i->next;
#if defined(__BPP_DEBUG)
				if (!i)
					throw string("collection index out of bounds");
#endif
			}
			item* k = new item(x);
			k->next = i->next;
			i->next = k;
			if (!k->next)
				last = k;
		}
		else
		{
			item* k = items;
			items = new item(x);
			items->next = k;
			if (!k)
				last = items;
		}
		count++;
	}

	void clear()
	{
		if (count)
			delete items;
	}

	void removeitem(const T& x)
	{
		item* i = items;
		if (!i)
			return;
		else if (i->value == x)
		{
			items = i->next;
			i->next = 0;
			delete i;
			count--;
		}
		else
		{
			while (i->next && i->next->value != x)
				i = i->next;
			if (item* k = i->next)
			{
				i->next = k->next;
				if (!i->next)
					last = i;
				k->next = 0;
				delete k;
				count--;
			}
		}
	}

	void remove(int n)
	{
		if (n)
		{
			item* i = items;
			while (--n)
			{
				i = i->next;
#if defined(__BPP_DEBUG)
				if (!i)
					throw string("collection index out of bounds");
#endif
			}
			item* k = i->next;
			i->next = k->next;
			if (!i->next)
				last = i;
			k->next = 0;
			delete k;
			count--;
		}
		else
		{
#if defined(__BPP_DEBUG)
			if (!items)
				throw string("collection index out of bounds");
#endif
			item* k = items->next;
			items->next = 0;
			delete items;
			items = k;
			count--;
		}
	}

	int length() { return count; }

	iterator* iterate() { return new iterator(this); }

	T& operator() (int n)
	{
		item* i = items;
		while (n--)
			i = i->next;
#if defined(__BPP_DEBUG)
		if (!i)
			throw string("collection index out of bounds");
#endif
		return i->value;
	}

private:
	friend class iterator;
	item *items, *last;
	int count;
};


template <class T>
class dictionary
{
public:
	struct item
	{
		string key;
		T value;
		item* next;

		item(const string& key)
		{
			this->key = key;
			nullify(&value, sizeof(value));
			next = 0;
		}
	};

	class iterator: public bpp::iterator
	{
	public:
		iterator(dictionary* owner)
		{
			j = *(i = owner->table);
			end = i + owner->maxhash - 1;
		}

		virtual bool next(void* item)
		{
			if (i == end && !j)
				return false;
			if (j)
			{
				*(T*)item = j->value;
				j = j->next;
			}
			else
			{
				do
					j = *(++i);
				while (!j && i != end);
				if (!j)
					return false;
				else
				{
					*(T*)item = j->value;
					j = j->next;
				}
			}
			return true;
		}

		virtual bool next(string& index, void* item)
		{
			if (i == end && !j)
				return false;
			if (j)
			{
				index = j->key;
				*(T*)item = j->value;
				j = j->next;
			}
			else
			{
				do
					j = *(++i);
				while (!j && i != end);
				if (!j)
					return false;
				else
				{
					index = j->key;
					*(T*)item = j->value;
					j = j->next;
				}
			}
			return true;
		}

	private:
		item **i, **end, *j;
	};

	dictionary()
	{
		count = 0;
		table = new item*[maxhash = 64];
		nullify(table, maxhash * sizeof(item*));
	}

	~dictionary()
	{
		clear();
		delete table;
	}

	void clear()
	{
		for (int i = 0; i < maxhash; i++)
			if (table[i])
			{
				item* j = table[i];
				while (j)
				{
					item* tmp = j;
					j = j->next;
					delete tmp;
				}
			}
	}

	void removeitem(const T& x)
	{
	}

	void remove(string key)
	{
		unsigned int h = hash(key) % maxhash;
		item* i = table[h];
		if (!i)
			return;
		else if (i->key == key)
		{
			table[h] = i->next;
			delete i;
			return;
		}
		else
		{
			while (i->next)
			{
				if (i->next->key == key)
				{
					item* tmp = i->next;
					i->next = tmp->next;
					delete tmp;
				}
				else
					i = i->next;
			}
		}
	}

	bool contains(string key)
	{
		item* i = table[hash(key) % maxhash];
		while (i)
		{
			if (i->key == key)
				return true;
			i = i->next;
		}
		return false;
	}

	void rehash()
	{
		if (maxhash >= 10000)
			return;
		item** old = table;
		int oldcnt = maxhash;
		table = new item*[maxhash = count];
		nullify(table, maxhash * sizeof(item*));
		count = 0;
		for (int n = 0; n < oldcnt; n++)
		{
			item* i = old[n];
			while (i)
			{
				(*this)(i->key) = i->value;
				item* tmp = i;
				i = i->next;
				delete tmp;
			}
		}
		delete old;
	}

	int length()
	{
		return count;
	}

	iterator* iterate() { return new iterator(this); }

	T& operator() (string key)
	{
		if (count >= maxhash * 3)
			rehash();
		unsigned int h = hash(key) % maxhash;
		item* i = table[h];
		if (!i)
		{
			count++;
			return (table[h] = new item(key))->value;
		}
		else if (i->key == key)
			return i->value;
		else
		{
			while (i->next)
			{
				if (i->next->key == key)
					return i->next->value;
				i = i->next;
			}
			count++;
			i->next = new item(key);
			return i->next->value;
		}
	}

private:
	friend class iterator;
	item** table;
	int count, maxhash;

	static unsigned int hash(const string& key)
	{
		return key.length();
		unsigned int hash = 0;
		unsigned int len = key.length();
		const char* s = key.cstr();
		while (true)
		{
			switch (len)
			{
			case 0:
				return hash;

			case 1:
				hash *= 9;
				hash += *(unsigned char*)s;
				return hash;

			case 2:
				hash *= 9;
				hash += *(unsigned short*)s;
				return hash;

			case 3:
				hash *= 9;
				hash += (*(unsigned short*)s << 8) + ((unsigned char*)s)[2];
				return hash;

			default:
				hash *= 9;
				hash += *(unsigned int*)s;
				s += 4;
				len -= 4;
			}
		}
	}
};


class Print
{
public:
	Print& operator<< (variant);
} extern print;


class Input
{
public:
	Input& line(string&);
	Input& operator>> (variant&);
	Input& operator>> (unsigned char&);
	Input& operator>> (unsigned short&);
	Input& operator>> (unsigned long&);
	Input& operator>> (short&);
	Input& operator>> (int&);
	Input& operator>> (float&);
	Input& operator>> (double&);
	Input& operator>> (long double&);
	Input& operator>> (bool&);
	Input& operator>> (string&);

	template <int length>
	Input& line(flstring<length>& s)
	{
		string t;
		line(t);
		s = t;
		return *this;
	}

	Input& line(apistring& s)
	{
		string t;
		line(t);
		s = t;
		return *this;
	}

	template <int length>
	Input& operator>> (flstring<length>& s)
	{
		variant v;
		*this >> v;
		s = v;
		return *this;
	}

	Input& operator>> (apistring& s)
	{
		variant v;
		*this >> v;
		s = v;
		return *this;
	}

	template <class T>
	Input& operator>> (ref<T>& r)
	{
		int p;
		*this >> p;
		r = (void*)p;
		return *this;
	}
} extern input;


struct end { };


template <int length>
variant operator+ (const flstring<length>& s, const variant& v)
{
	return variant(s) + v;
}


template <int length>
variant operator- (const flstring<length>& s, const variant& v)
{
	return variant(s) - v;
}


template <int length>
variant operator* (const flstring<length>& s, const variant& v)
{
	return variant(s) * v;
}


template <int length>
variant operator/ (const flstring<length>& s, const variant& v)
{
	return variant(s) / v;
}


template <int length>
variant operator% (const flstring<length>& s, const variant& v)
{
	return variant(s) % v;
}


template <int length>
bool operator&& (const flstring<length>& s, const variant& v)
{
	return variant(s) && v;
}


template <int length>
bool operator|| (const flstring<length>& s, const variant& v)
{
	return variant(s) || v;
}


template <int length>
variant operator^ (const flstring<length>& s, const variant& v)
{
	return variant(s) ^ v;
}


template <int length>
bool operator== (const flstring<length>& s, const variant& v)
{
	return variant(s) == v;
}


template <int length>
bool operator!= (const flstring<length>& s, const variant& v)
{
	return variant(s) != v;
}


template <int length>
bool operator< (const flstring<length>& s, const variant& v)
{
	return variant(s) < v;
}


template <int length>
bool operator> (const flstring<length>& s, const variant& v)
{
	return variant(s) > v;
}


template <int length>
bool operator<= (const flstring<length>& s, const variant& v)
{
	return variant(s) <= v;
}


template <int length>
bool operator>= (const flstring<length>& s, const variant& v)
{
	return variant(s) >= v;
}


inline variant operator+ (const apistring& s, const variant& v)
{
	return variant(s) + v;
}


inline variant operator- (const apistring& s, const variant& v)
{
	return variant(s) - v;
}


inline variant operator* (const apistring& s, const variant& v)
{
	return variant(s) * v;
}


inline variant operator/ (const apistring& s, const variant& v)
{
	return variant(s) / v;
}


inline variant operator% (const apistring& s, const variant& v)
{
	return variant(s) % v;
}


inline bool operator&& (const apistring& s, const variant& v)
{
	return variant(s) && v;
}


inline bool operator|| (const apistring& s, const variant& v)
{
	return variant(s) || v;
}


inline variant operator^ (const apistring& s, const variant& v)
{
	return variant(s) ^ v;
}

/*
inline bool operator== (const apistring& s, const variant& v)
{
	return variant(s) == v;
}
*/

inline bool operator!= (const apistring& s, const variant& v)
{
	return variant(s) != v;
}


inline bool operator< (const apistring& s, const variant& v)
{
	return variant(s) < v;
}


inline bool operator> (const apistring& s, const variant& v)
{
	return variant(s) > v;
}


inline bool operator<= (const apistring& s, const variant& v)
{
	return variant(s) <= v;
}


inline bool operator>= (const apistring& s, const variant& v)
{
	return variant(s) >= v;
}

inline void apistring::operator= (const variant& v) { *this = string(v); }
inline void apistring::operator+= (const variant& v) { *this = *this + string(v); }
inline void apistring::operator-= (const variant& v) { *this = *this - string(v); }
inline void apistring::operator*= (const variant& v) { *this = *this * string(v); }
inline void apistring::operator/= (const variant& v) { *this = *this / string(v); }
inline void apistring::operator++ () { *this = double(variant(*this)) + 1; }
inline void apistring::operator-- () { *this = double(variant(*this)) - 1; }


template<class T, class U>
inline ref<T> conv(ref<T>* ptr, const ref<U>& x)
{
	return ref<T>(x.ptr);
}


template <class T>
inline T conv(T* ptr, T x)
{
	return x;
}


template <class U, class T>
inline U conv(U* ptr, T x)
{
	return variant(x);
}

inline string conv(string* ptr, const Char* x)
{
	return string(x);
}

template <class T>
inline int lbound(array<T>& x, int d = 1) { return x.lbound(d); }

template <class T>
inline int ubound (array<T>& x, int d = 1) { return x.ubound(d); }

template <class T>
inline void* ptr(T& x) { return &x; }

inline void* ptr(string& s) { return s.ptr(); }



}

extern "C"
{
	void __init_all();
	void __final_all();
	void abort_with_error(const bpp::string& s);
	void Main();
}


#endif	// __BPP_VERSION
