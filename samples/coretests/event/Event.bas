
USING eventUsed

Declare event sub OnClick(sender as long)
Declare event function OnCreate(sender as long) as long

class cls
	public event function ondblclick(sender as long) as long
	public event sub onsize(sender as long)
	
	public onevent as onclick
end class

sub testevent (fn as OnClick, p as long)
	fn( p )
end sub

sub callfunc1(p as long)
	print "callfunc1 ", p
end sub

sub callfunc2(p as long)
	print "callfunc2 ", p
end sub

sub main

	dim i as integer
	
	i = 100
	
	dim evt as onclick
	dim evt2 as onclick2
	
	set evt =  callfunc1
	set evt2 =  callfunc2

	dim cl as new cls
	set cl.onsize = callfunc2
	set cl.onevent = callfunc1
	
	testevent(  callfunc1, 100  )
	testevent( callfunc1, 200  )

	cl.onsize(111)
	cl.onevent(222)
	evt(333)
	evt2(444)
	
end sub

