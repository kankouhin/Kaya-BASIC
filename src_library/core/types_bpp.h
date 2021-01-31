#ifndef __BPP_TYPES_H
#define __BPP_TYPES_H

typedef char			Char;
typedef unsigned char	Byte;

typedef short			Short;
typedef unsigned short	UShort;

typedef int				Integer;
typedef unsigned int	UInteger;

#if defined(__x86_64)
	typedef long long			Long;
	typedef unsigned long long	ULong;
#else
	typedef long			Long;
	typedef unsigned long	ULong;
#endif

typedef float			Single;
typedef double			Double;
typedef long double		Decimal;
typedef bool			Boolean;

typedef void*			Any;

#endif