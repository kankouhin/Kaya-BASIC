
' inline C/C++ codes directly 
' multi-line codes inside CPP ... End CPP block 
CPP
	class Rectangle {
		int width, height;
	public:
		void set_values (int,int);
		int area() {return width*height;}
	};

	void Rectangle::set_values (int x, int y) {
		width = x;
		height = y;
	}
End CPP

Sub Main
	' multi-line codes inside CPP ... End CPP block 
	CPP
		Rectangle rect;
		rect.set_values (3,4);
	End CPP
	
	' single line begins with #
	#cout << "area: " << rect.area();
End Sub
