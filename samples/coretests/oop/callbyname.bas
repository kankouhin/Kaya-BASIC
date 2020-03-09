Option Console

class cbn
	public sub greet(msg as integer)
	public sub greet2(msg as long)
	public sub greet21(msg as integer,var2 as long)
	
	public function greet23(msg as integer,var2 as long) as integer
	public function greet24(msg as integer,var2 as integer) as long
	public function greet25 as string
	
	public sub greet3
	public sub greet4
	
	public property name as string
	public property name2 as string readonly
	
	public name3 as string
	public name4 as integer
	
	private _name as string
end class

function cbn.greet23
	print  "hi, callbyname23"
end function

function cbn.greet24
	print  "hi, callbyname24"
end function

function cbn.greet25
	print  "hi, callbyname25"
end function

sub cbn.greet
	print  "hi, callbyname " + str(msg)
end sub

property get cbn.name
	value = _name
end property get

property get cbn.name2
	value = _name
end property get

property set cbn.name
	_name = value 
end property set

sub cbn.greet2
	print  "hi, callbyname2 " + str(msg)
end sub

sub cbn.greet21
	print  "hi, callbyname21 " + str(msg)
end sub

sub cbn.greet3
	print  "hi, callbyname3"
end sub

sub cbn.greet4
	print  "hi, callbyname4"
end sub

sub main
	dim d as new cbn
	dim fn as string = command(1)
	dim v as string = command(2)
	dim i as integer = 1
	dim l as long

	callbyname(d, fn, set, v)
	
	callbyname(d, "name", get, v)
	callbyname(d, "name3", get, v)
	
	callbyname(d, "name4", set, i)
	callbyname(d, "name4", get, i)
	
	callbyname(d, "greet", call)(i)
	callbyname(d, "greet21", call)(i,clng(i))
	callbyname(d, "greet3", call)
	
	callbyname(d, "greet24", call,l)(i,i)
	callbyname(d, "greet25", call,v)
	
	print d.name
	print v
	
end sub
