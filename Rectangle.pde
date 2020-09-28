class Rectangle extends Shape{
  
  float w = 100;
  float h = 40;
  
  void Draw(){
    
    if (selected)
    {
      fill(color_fill_sel.x, color_fill_sel.y, color_fill_sel.z);
      stroke(color_str_sel.x, color_str_sel.y, color_str_sel.z);
    }
    else
    {
      fill(color_fill.x, color_fill.y, color_fill.z);
      stroke(color_str.x, color_str.y, color_str.z);
    }
    
    beginShape();
    
    vertex(position.x-w/2, position.y+h/2); 
    vertex(position.x+w/2, position.y+h/2); 
    vertex(position.x+w/2, position.y-h/2); 
    vertex(position.x-w/2, position.y-h/2); 
    
    endShape(CLOSE);
    
  }
  
  Boolean Contains(float x, float y){
  
    return (x>= position.x-w/2 &&  x<= position.x+w/2 &&
            y>= position.y-h/2 &&  y<= position.y+h/2);
  }
}
