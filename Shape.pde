abstract class Shape{
  
  PVector position = new PVector();
  PVector color_fill =  new PVector(200,200,200); 
  PVector color_str = new PVector(0,0,0);
  int detailness = 30;
  
  PVector color_fill_sel =  new PVector(255,0,255); 
  PVector color_str_sel = new PVector(0,255,0);
  Boolean selected = false;
  
  Shape(){}
  
  abstract void Draw();
  abstract Boolean Contains(float x, float y);

}
