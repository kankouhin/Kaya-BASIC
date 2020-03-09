Option Console

class dad extends object
	public sub useless
	public function greet(another as dad) as string
	public property name as string
	protected sub initialize
	protected sub terminate
	private mname as string
end class

class son extends dad
	public sub useless
	protected sub initialize
	protected sub terminate
end class

sub dad.useless
	print "this is a completely useless sub"
end sub

function dad.greet
	function = "hi, " + another.name
end function

property get dad.name
	value = me.mname
end property get

property set dad.name
	me.mname = value
end property set

sub dad.initialize
	print "dad created"
end sub

sub dad.terminate
	print "dad destroyed"
end sub

sub son.useless
	print "i don't want to be useless - let me calculate something:"
	for i = 1 to 10
		print i, " squared equals ", i * i
	next
end sub

sub son.initialize
	print "son created"
end sub

sub son.terminate
	print "son destroyed"
end sub

sub main
	dim dad as dad, son as son
	dad = new dad
	son = new son
	dad.name = "dad"
	son.name = "son"
	dad.useless
	son.useless
	print son.greet(dad)
	
	dad = createobject("Oop.son")
	dad.name = "create object by name"
	print son.greet(dad)
	
	
end sub
