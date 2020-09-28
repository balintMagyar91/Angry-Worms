class Catapult extends Shape {
  
  float w = 10;
  float h = 40;
  boolean shot = false;
  
  void Draw(){
    
    fill(165, 42, 42);
    noStroke();
    
    
    beginShape();
    
    vertex(position.x-w/2, position.y);
    vertex(position.x+w/2, position.y);
    vertex(position.x+w/2, position.y-h);
    vertex(position.x+25, position.y-50);
    vertex(position.x+30, position.y-80);
    vertex(position.x+25, position.y-80);
    vertex(position.x+20, position.y-55);
    vertex(position.x+w/2-5, position.y-45);
    vertex(position.x-20, position.y-55);
    vertex(position.x-25, position.y-80);
    vertex(position.x-30, position.y-80);
    vertex(position.x-25, position.y-50);
    vertex(position.x-w/2, position.y-h);
    
    endShape(CLOSE);
  }
  
  Boolean Contains(float x, float y){
  
    return (x>= position.x-w/2 &&  x<= position.x+w/2 &&
            y>= position.y-h/2 &&  y<= position.y+h/2);
  }
}
