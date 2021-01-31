#if !defined(__BPP_VERSION)
#define __BPP_VERSION 010501
#define _RWSTD_NO_EXCEPTIONS

#include <typeinfo>

#ifdef __BPPWIN__
	#include "types_bpp.h"
#else
	#include "types_bpp_lnx.h"
#endif // __BPPWIN__

#include <cstdlib>
#include <cstdio>
#include <cmath>
#include <cstdarg>
#include <cstddef>
#include <cstring>
#include <ctime>
#include <algorithm>

#include <string>
#include <vector>
#include <list>
#include <unordered_map>

#include <iostream>
#include <fstream>
#include <sstream>

#include <thread>
#include <mutex>
#include <chrono>

#include <functional>

using namespace std;

#define __BPPCALL
#ifdef __BPPWIN__
	#define __CALLBACK __stdcall
#else
	#define __CALLBACK
#endif // __BPPWIN__

class Defer
{
public:
	Defer(const function<void()> &deferfn) : DeferFn(std::move(deferfn)) {}
	~Defer() { if (DeferFn) DeferFn(); }
private:
	function<void()> DeferFn;
};

#define TypeName(v) typeid(v).name()

namespace bpp
{
	namespace System
	{
		void __BPPCALL FileOpen(string filename, ios_base::openmode mode, Integer fn);
		void __BPPCALL FileClose(Integer fn);
		fstream *__BPPCALL FileGetObject(Integer fn);
	} // namespace System

	void nullify(void *, int);
	void loadlib(const string &);
	void unloadlibs();
	void *getlibhandle(const string &);
	void *getprocaddr(void *, const string &);

	//DEBUG functions
	int dbg_getline();
	string dbg_getfunc();
	void dbg_line(int n);
	void dbg_func(const string &s);
	void dbg_endfunc();
	int dbg_savefunc();
	void dbg_unwind(int n);

	class variant;
	class object;

	template <class T>
	class ref
	{
	public:
		T *ptr;

		
		ref() { ptr = 0; me = false; }
		ref(const ref<T> &x)
		{
			me = false;
			ptr = (T *)x.ptr;
			addref();
#if defined(__BPP_DEBUG)
			check_class();
#endif
		}

		ref(void *x, bool me = false) : me(me)
		{
			ptr = (T *)x;
			if (!me)
				addref();
#if defined(__BPP_DEBUG)
			check_class();
#endif
		}

		template <class U>
		ref(ref<U> x)
		{
			me = false;
			ptr = x.ptr;
			addref();
		}

		~ref() { if (!me) release(); }

		void operator=(ref<T> x)
		{
			release();
			ptr = (T *)x.ptr;
			addref();
#if defined(__BPP_DEBUG)
			check_class();
#endif
		}

		template <class U>
		void operator=(ref<U> x)
		{
			release();
			(void *)ptr = x.ptr;
			addref();
#if defined(__BPP_DEBUG)
			check_class();
#endif
		}

		T *operator*() { return ptr; }

		template <class cls>
		ref<T> operator+(cls arg) { return ptr->operator+(arg); }
		template <class cls>
		ref<T> operator-(cls arg) { return ptr->operator-(arg); }
		template <class cls>
		ref<T> operator*(cls arg) { return ptr->operator*(arg); }
		template <class cls>
		ref<T> operator/(cls arg) { return ptr->operator/(arg); }

		template <class cls>
		ref<T> operator+=(cls arg) { return ptr->operator+=(arg); }
		template <class cls>
		ref<T> operator-=(cls arg) { return ptr->operator-=(arg); }
		template <class cls>
		ref<T> operator*=(cls arg) { return ptr->operator*=(arg); }
		template <class cls>
		ref<T> operator/=(cls arg) { return ptr->operator/=(arg); }

		template <class cls>
		ref<T> operator<<(cls arg) { return ptr->operator<<(arg); }
		template <class cls>
		ref<T> operator>>(cls arg) { return ptr->operator>>(arg); }

		T *operator->()
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
		rtti *next;
	};

	class classlist
	{
	public:
		static void add(rtti *cl)
		{
			rtti *old = list;
			list = cl;
			cl->next = old;
		}

		static rtti *find(const string &name)
		{
			rtti *cl = list;
			while (cl)
				if (cl->name() == name)
					return cl;
				else
					cl = cl->next;
			return 0;
		}

	private:
		static rtti *list;
	};

	class object
	{
	public:
		int __refcnt;
		object(bool = false) { __refcnt = 0; }
		// RTTI
		bool __isa(const std::type_info &ti) { return typeid(*this) == ti; }
		virtual bool __isbase(const std::type_info &ti) { return typeid(object) == ti; }
		virtual string ClassName() { return "OBJECT"; }
		// persistence
		virtual void SaveToStream(ref<object>) {}
		virtual void LoadFromStream(ref<object>) {}

	protected:
		template <class T>
		friend class ref;

		virtual void Initialize() {}
		virtual void Terminate() {}
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
			((object *)ptr)->Terminate();
			delete ptr;
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
		enum vartypes
		{
			num,
			str
		} vartype;

		variant(double = 0);
		variant(const string &);
		variant(const char *);

		template <class T>
		variant(ref<T> p) { *this = (Long)p.ptr; }
		variant &operator=(const variant &);
		variant &operator+=(const variant &v) { return *this = *this + v; }
		variant &operator-=(const variant &v) { return *this = *this - v; }
		variant &operator*=(const variant &v) { return *this = *this * v; }
		variant &operator/=(const variant &v) { return *this = *this / v; }
		// operations with variants
		variant operator+(const variant &) const;
		variant operator-(const variant &) const;
		variant operator*(const variant &) const;
		variant operator/(const variant &) const;
		variant operator%(const variant &) const;
		bool operator&&(const variant &) const;
		bool operator||(const variant &) const;
		variant operator^(const variant &) const;
		bool operator==(const variant &) const;
		bool operator!=(const variant &) const;
		bool operator<(const variant &) const;
		bool operator>(const variant &) const;
		bool operator<=(const variant &) const;
		bool operator>=(const variant &) const;

		// operations with numbers
		variant operator+(double) const;
		variant operator-(double) const;
		variant operator*(double) const;
		variant operator/(double) const;
		variant operator%(double) const;
		bool operator&&(double) const;
		bool operator||(double) const;
		variant operator^(double) const;
		bool operator==(double) const;
		bool operator!=(double) const;
		bool operator<(double) const;
		bool operator>(double) const;
		bool operator<=(double) const;
		bool operator>=(double) const;

		// operations with strings
		variant operator+(const string &) const;
		variant operator-(const string &) const;
		variant operator*(const string &) const;
		variant operator/(const string &) const;
		variant operator%(const string &) const;
		bool operator&&(const string &) const;
		bool operator||(const string &) const;
		variant operator^(const string &) const;
		bool operator==(const string &) const;
		bool operator!=(const string &) const;
		bool operator<(const string &) const;
		bool operator>(const string &) const;
		bool operator<=(const string &) const;
		bool operator>=(const string &) const;

		// generic operations
		variant &operator++() { return *this += 1; }
		variant &operator--() { return *this -= 1; }
		bool operator!() const;
		void *operator&();
		operator double() const;
		operator string() const;

		template <class T>
		operator ref<T>() const { return (void *)Long(n); }

	private:
		double n;
		string s;
	};

//=========================================================================================================
// ARRAY CORE
#define ARRAY_OPERATOR(op)                                                            \
	template <class U, typename = std::enable_if_t<std::is_arithmetic<U>::value>> \
	array<U> operator op(const array<U> &ar, const U &n)                          \
	{                                                                             \
		array<U> ret = ar;                                                    \
		for (auto &i : ret)                                                   \
			i = i op n;                                                   \
		return ret;                                                           \
	}

#define ARRAY_OPERATOR_ARRAY(op)                                                                        \
	template <class U, typename = std::enable_if_t<std::is_arithmetic<U>::value>>                   \
	array<U> operator op(const array<U> &ar1, const array<U> &ar2)                                  \
	{                                                                                               \
		array<U> ret = ar1;                                                                     \
		int idx = 0;                                                                            \
		for (auto i = ar1.begin(), n = ar2.begin(); i != ar1.end() && n != ar2.end(); i++, n++) \
		{                                                                                       \
			ret[idx++] = *i op * n;                                                         \
		}                                                                                       \
		return ret;                                                                             \
	}

#define ARRAY_OPERATOR_THIS(op)                                                       \
	template <class U, typename = std::enable_if_t<std::is_arithmetic<U>::value>> \
	array<T> &operator op(const U &n)                                             \
	{                                                                             \
		for (auto &i : *this)                                                 \
			i op n;                                                       \
		return *this;                                                         \
	}

#define ARRAY_OPERATOR_ARRAY_THIS(op)                                                                     \
	template <class U, typename = std::enable_if_t<std::is_arithmetic<U>::value>>                     \
	array<T> &operator op(array<U> &ar)                                                               \
	{                                                                                                 \
		for (auto i = this->begin(), n = ar.begin(); i != this->end() && n != ar.end(); i++, n++) \
			*i op *n;                                                                         \
		return *this;                                                                             \
	}

	template <class T>
	class array : public vector<T>
	{
	public:
		typedef typename vector<T>::reference reference;
		bool preserve;

	public:
		array()
		{
			preserve = false;
			redim(0, 1);
		}
		array(int l1, int h1)
		{
			preserve = false;
			redim(l1, h1);
		}
		array(int l1, int h1, int l2, int h2)
		{
			preserve = false;
			redim(l1, h1, l2, h2);
		}
		array(int l1, int h1, int l2, int h2, int l3, int h3)
		{
			preserve = false;
			redim(l1, h1, l2, h2, l3, h3);
		}
		array(int l1, int h1, int l2, int h2, int l3, int h3, int l4, int h4)
		{
			preserve = false;
			redim(l1, h1, l2, h2, l3, h3, l4, h4);
		}

		array(initializer_list<T> args)
		{
			preserve = false;
			redim(0, args.size() - 1);

			int n = 0;
			for (T x : args)
			{
				this->at(n++) = x;
			}
		}

		array(initializer_list<initializer_list<T>> args)
		{
			preserve = false;
			auto i = args.begin();

			int ROW = args.size();
			int COL = i->size();

			redim(0, ROW - 1, 0, COL - 1);

			int r = 0;
			for (auto it : args)
			{
				int c = 0;
				for (T x : it)
				{
					this->at(r * COL + c) = x;
					c++;
				}

				r++;
			}
		}

		~array() { this->clear(); }

		void redim()
		{
			if (preserve)
			{
				this->resize(this->Size());
				return;
			}

			this->clear();
			this->resize(this->Size());
		}

		int lbound(int d = 1) { return dim[d].lo; }
		int ubound(int d = 1) { return dim[d].hi; }

		void redim(int l1, int h1)
		{
			if (h1 < l1)
				swap(l1, h1);

			dim[1].lo = l1;
			dim[1].hi = h1;
			dim[1].d = h1 - l1 + 1;

			if (preserve == false)
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

			if (preserve)
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
			}
			else
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
				dim[2].lo = l2;
				dim[2].hi = h2;
				dim[2].d = h2 - l2 + 1;
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

			if (preserve)
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
			}
			else
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
				dim[2].lo = l2;
				dim[2].hi = h2;
				dim[2].d = h2 - l2 + 1;
				dim[3].lo = l3;
				dim[3].hi = h3;
				dim[3].d = h3 - l3 + 1;
			}

			dim[4].lo = 0;
			dim[4].hi = 0;
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

			if (preserve)
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
			}
			else
			{
				dim[1].lo = l1;
				dim[1].hi = h1;
				dim[1].d = h1 - l1 + 1;
				dim[2].lo = l2;
				dim[2].hi = h2;
				dim[2].d = h2 - l2 + 1;
				dim[3].lo = l3;
				dim[3].hi = h3;
				dim[3].d = h3 - l3 + 1;
				dim[4].lo = l4;
				dim[4].hi = h4;
				dim[4].d = h4 - l4 + 1;
			}

			redim();
		}

		int Size()
		{
			int ret = dim[1].d;

			if (dim[2].d)
				ret *= dim[2].d;
			if (dim[3].d)
				ret *= dim[3].d;
			if (dim[4].d)
				ret *= dim[4].d;

			return ret;
		}

		array<T> &operator<<(const T &item)
		{
			if (dim[2].d)
				throw string("not support <<");

			dim[1].d++;
			dim[1].hi++;

			this->push_back(item);

			return *this;
		}

		array<T> &operator<<(const array<T> &ar)
		{
			if (dim[2].d)
				throw string("not support <<");

			for (auto i : ar)
				*this << i;

			return *this;
		}

		array<T> &operator>>(const T &item)
		{
			if (dim[2].d)
				throw string("not support >>");

			typename vector<T>::iterator it;
			for (it = this->end() - 1; it >= this->begin(); it--)
			{
				if ((*it) == item)
				{
					dim[1].d--;
					dim[1].hi--;
					this->erase(it);
				}
			}

			return *this;
		}

		array<T> &operator>>(const array<T> &ar)
		{
			if (dim[2].d)
				throw string("not support >>");

			for (auto i : ar)
				*this >> i;

			return *this;
		}

		ARRAY_OPERATOR_THIS(*=)
		ARRAY_OPERATOR_THIS(+=)
		ARRAY_OPERATOR_THIS(-=)
		ARRAY_OPERATOR_THIS(/=)

		ARRAY_OPERATOR_ARRAY_THIS(*=)
		ARRAY_OPERATOR_ARRAY_THIS(+=)
		ARRAY_OPERATOR_ARRAY_THIS(-=)
		ARRAY_OPERATOR_ARRAY_THIS(/=)

		reference operator()(int i1)
		{
			return this->at(i1 - dim[1].lo);
		}

		reference operator()(int i1, int i2)
		{
			return this->at(
			    (i1 - dim[1].lo) * dim[2].d +
			    (i2 - dim[2].lo));
		}

		reference operator()(int i1, int i2, int i3)
		{
			return this->at(
			    (i1 - dim[1].lo) * dim[2].d * dim[3].d +
			    (i2 - dim[2].lo) * dim[3].d +
			    (i3 - dim[3].lo));
		}

		reference operator()(int i1, int i2, int i3, int i4)
		{
			return this->at(
			    (i1 - dim[1].lo) * dim[2].d * dim[3].d * dim[4].d +
			    (i2 - dim[2].lo) * dim[3].d * dim[4].d +
			    (i3 - dim[3].lo) * dim[4].d +
			    (i4 - dim[4].lo));
		}

	private:
		struct
		{
			int lo, hi, d;
		} dim[5];
	};

	ARRAY_OPERATOR(*)
	ARRAY_OPERATOR(+)
	ARRAY_OPERATOR(-)
	ARRAY_OPERATOR(/)

	ARRAY_OPERATOR_ARRAY(*)
	ARRAY_OPERATOR_ARRAY(+)
	ARRAY_OPERATOR_ARRAY(-)
	ARRAY_OPERATOR_ARRAY(/)

	#define CData(ar) ar.data()

	// ARRAY CORE
	//=========================================================================================================

	//=========================================================================================================
	// COLLECTION CORE

	template <class T>
	class collection : public list<T>
	{
	public:
		using list<T>::list;

		typedef typename list<T>::iterator iterator;

		collection() {}
		~collection() { this->clear(); }

		void add(const T &x)
		{
			this->push_back(x);
		}

		void add(const T &x, int index)
		{
			iterator i = this->begin();
			int n = index;
			while (n-- && i != this->end())
				i++;

			if (n != -1)
				throw "index error.";

			this->insert(i, x);
		}

		void removeitem(const T &x)
		{
			iterator i = this->begin();
			while (i != this->end() && *i != x)
				i++;

			if (i == this->end())
				return;

			this->erase(i);
		}

		void remove(int n)
		{
			iterator i = this->begin();
			while (n-- && i != this->end())
				i++;

			if (n != -1)
				throw "index error.";

			this->erase(i);
		}

		int length() { return this->size(); }

		collection<T> &operator<<(const T &item)
		{
			this->add(item);
			return *this;
		}

		collection<T> &operator<<(const collection<T> &col)
		{
			for (auto i : col)
				this->add(i);

			return *this;
		}

		collection<T> &operator>>(const T &item)
		{
			this->removeitem(item);
			return *this;
		}

		collection<T> &operator>>(const collection<T> &col)
		{
			for (auto i : col)
				this->removeitem(i);
			return *this;
		}

		T &operator()(int n)
		{
			iterator i = this->begin();
			while (n-- && i != this->end())
				i++;

			if (n != -1)
				throw "index error.";

			return *i;
		}
	};

	// COLLECTION CORE
	//=========================================================================================================

	template <class T>
	class dictionary : public unordered_map<string, T>
	{
	public:
		using unordered_map<string, T>::unordered_map;

		typedef typename unordered_map<string, T>::iterator iterator;
		typedef typename unordered_map<string, T>::mapped_type mapped_type;

		dictionary() {}
		~dictionary() {}

		mapped_type &operator()(string key)
		{
			return unordered_map<string, T>::operator[](key);
		}

		void removeitem(const T &x)
		{
			iterator i;
			for (i = this->begin(); i != this->end(); i++)
			{
				std::pair<string, T> p = *i;
				if (p.second == x)
				{
					this->erase(i);
					break;
				}
			}
		}

		void remove(string key)
		{
			this->erase(key);
		}

		bool contains(string key)
		{
			iterator i = this->find(key);
			return (i != this->end());
		}

		int length()
		{
			return this->size();
		}
	};

	class Print
	{
	public:
		Print &operator<<(variant);
		Print &operator<<(string);
		Print &operator<<(const char *);
	} extern print;

	class Input
	{
	public:
		Input &line(string &);
		Input &operator>>(variant &);
		Input &operator>>(unsigned char &);
		Input &operator>>(unsigned short &);
		Input &operator>>(unsigned long &);
		Input &operator>>(short &);
		Input &operator>>(int &);
		Input &operator>>(float &);
		Input &operator>>(double &);
		Input &operator>>(long double &);
		Input &operator>>(bool &);
		Input &operator>>(string &);
	} extern input;

	struct quit
	{
	};

//===================================================================================================
// Strings
	#define CStr(s) s.c_str()

	inline string Format(string fmt, ...)
	{
		char buffer[1024];
		va_list args;
		va_start(args, fmt);
		vsprintf(buffer, fmt.c_str(), args);
		va_end(args);

		return buffer;
	}

	template <class T, typename = std::enable_if_t<std::is_integral<T>::value>>
	string operator*(const string &s, T n)
	{
		if (n < 0)
			throw string("n < 0");
		string ret(s);
		for (int i = 1; i < n; i++)
			ret += s;

		return ret;
	}

	template <class T, typename = std::enable_if_t<std::is_integral<T>::value>>
	string operator/(const string &s, T n)
	{
		if (n < 1)
			throw string("n < 1");
		string ret = s.substr(0, (int)(s.length() / n));
		return ret;
	}

	template <class T, typename = std::enable_if_t<std::is_integral<T>::value>>
	string operator>>(const string &s, T n)
	{
		if (n < 1)
			throw string("n < 1");
		string ret = s.substr(0, s.length() - n);
		return ret;
	}

	template <class T, typename = std::enable_if_t<std::is_integral<T>::value>>
	string operator<<(const string &s, T n)
	{
		if (n < 1)
			throw string("n < 1");
		string ret = s.substr(n);
		return ret;
	}

	template <class T, typename = std::enable_if_t<std::is_arithmetic<T>::value>>
	string operator+(const string &s, T n)
	{
		char tmp[256];
		sprintf(tmp, "%.16g", (double)n);

		string ret;
		ret += s;
		ret += tmp;
		return ret;
	}

	template <class T, typename = std::enable_if_t<std::is_arithmetic<T>::value>>
	string operator+(T n, const string &s)
	{
		char tmp[256];
		sprintf(tmp, "%.16g", (double)n);

		string ret;
		ret += tmp;
		ret += s;
		return ret;
	}
	// Strings
	//===================================================================================================

	template <class T>
	inline void swap(T &a, T &b)
	{
		T c = a;
		a = b;
		b = c;
	}

	template <class T, class U>
	inline ref<T> conv(ref<T> *ptr, const ref<U> &x)
	{
		return ref<T>(x.ptr);
	}

	template <class T>
	inline T conv(T *ptr, T x)
	{
		return x;
	}

	template <class U, class T>
	inline U conv(U *ptr, T x)
	{
		return variant(x);
	}

	inline string conv(string *ptr, const Char *x)
	{
		return string(x);
	}

	template <class T>
	inline int lbound(array<T> &x, int d = 1) { return x.lbound(d); }

	template <class T>
	inline int ubound(array<T> &x, int d = 1) { return x.ubound(d); }

	template <class T>
	inline void *ptr(T &x) { return &x; }

} // namespace bpp

extern "C"
{
	void __init_all();
	void __final_all();
	void abort_with_error(const string &s);
	void Main();
}

#endif // __BPP_VERSION
