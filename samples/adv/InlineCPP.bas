
' inline C/C++ codes directly 
' multi-line codes inside ### 
###
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
###


Sub Main
	' multi-line codes inside ### 
	################################################
	Rectangle rect;
	rect.set_values (3,4);
	################################################
	
	' single line begins with #
	#cout << "area: " << rect.area();
End Sub
